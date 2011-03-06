/*
 * Copyright (c) 2011 Aleksey Yeschenko <aleksey@yeschenko.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "erl_nif.h"

#include <uuid/uuid.h>
#include <string.h>

#define GENERATE_DEFAULT 0
#define GENERATE_RANDOM  1
#define GENERATE_TIME    2

#define UNPARSE_DEFAULT 0
#define UNPARSE_UPPER   1
#define UNPARSE_LOWER   2

static ERL_NIF_TERM generate_generic(ErlNifEnv*, const ERL_NIF_TERM[], char);
static ERL_NIF_TERM unparse_generic(ErlNifEnv*, const ERL_NIF_TERM[], char);

static ERL_NIF_TERM
erl_uuid_generate(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return generate_generic(env, argv, GENERATE_DEFAULT);
}

static ERL_NIF_TERM
erl_uuid_generate_random(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return generate_generic(env, argv, GENERATE_RANDOM);
}

static ERL_NIF_TERM
erl_uuid_generate_time(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return generate_generic(env, argv, GENERATE_TIME);
}

static ERL_NIF_TERM
erl_uuid_parse(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    uuid_t uuid;
    char buf[37];
    ErlNifBinary bin16, bin36;

    if (!enif_inspect_binary(env, argv[0], &bin36) || bin36.size != 36) {
        return enif_make_badarg(env);
    }

    memcpy(buf, bin36.data, 36); buf[36] = '\0';

    if (uuid_parse(buf, uuid) != 0)
        return enif_make_badarg(env);

    enif_alloc_binary(16, &bin16);
    memcpy(bin16.data, uuid, 16);

    return enif_make_binary(env, &bin16);
}

static ERL_NIF_TERM
erl_uuid_unparse(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return unparse_generic(env, argv, UNPARSE_DEFAULT);
}

static ERL_NIF_TERM
erl_uuid_unparse_upper(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return unparse_generic(env, argv, UNPARSE_UPPER);
}

static ERL_NIF_TERM
erl_uuid_unparse_lower(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return unparse_generic(env, argv, UNPARSE_LOWER);
}

static ERL_NIF_TERM
generate_generic(ErlNifEnv* env, const ERL_NIF_TERM argv[], char type)
{
    uuid_t uuid;
    ErlNifBinary bin16;

    if (type == GENERATE_DEFAULT)
        uuid_generate(uuid);
    else if (type == GENERATE_RANDOM)
        uuid_generate_random(uuid);
    else if (type == GENERATE_TIME)
        uuid_generate_time(uuid);

    enif_alloc_binary(16, &bin16);
    memcpy(bin16.data, uuid, 16);

    return enif_make_binary(env, &bin16);
}

static ERL_NIF_TERM
unparse_generic(ErlNifEnv* env, const ERL_NIF_TERM argv[], char type)
{
    uuid_t uuid;
    char buf[37];
    ErlNifBinary bin16, bin36;

    if (!enif_inspect_binary(env, argv[0], &bin16) || bin16.size != 16) {
        return enif_make_badarg(env);
    }

    memcpy(uuid, bin16.data, 16);
    
    if (type == UNPARSE_DEFAULT)
        uuid_unparse(uuid, buf);
    else if (type == UNPARSE_UPPER)
        uuid_unparse_upper(uuid, buf);
    else if (type == UNPARSE_LOWER)
        uuid_unparse_lower(uuid, buf);

    enif_alloc_binary(36, &bin36);
    memcpy(bin36.data, buf, 36);

    return enif_make_binary(env, &bin36);
}

static ErlNifFunc nif_funcs[] = {
    {"generate",        0, erl_uuid_generate},
    {"generate_random", 0, erl_uuid_generate_random},
    {"generate_time",   0, erl_uuid_generate_time},
    {"parse",           1, erl_uuid_parse},
    {"unparse",         1, erl_uuid_unparse},
    {"unparse_upper",   1, erl_uuid_unparse_upper},
    {"unparse_lower",   1, erl_uuid_unparse_lower}
};

ERL_NIF_INIT(uuid, nif_funcs, NULL, NULL, NULL, NULL)
