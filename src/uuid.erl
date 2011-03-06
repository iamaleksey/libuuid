%%% Copyright (c) 2011 Aleksey Yeschenko <aleksey@yeschenko.com>
%%%
%%% Permission is hereby granted, free of charge, to any person obtaining a copy
%%% of this software and associated documentation files (the "Software"), to deal
%%% in the Software without restriction, including without limitation the rights
%%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%%% copies of the Software, and to permit persons to whom the Software is
%%% furnished to do so, subject to the following conditions:
%%%
%%% The above copyright notice and this permission notice shall be included in
%%% all copies or substantial portions of the Software.
%%%
%%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%%% THE SOFTWARE.

-module(uuid).

-on_load(load_nif/0).

-export([generate/0,
         generate_random/0,
         generate_time/0,
         parse/1,
         unparse/1,
         unparse_upper/1,
         unparse_lower/1]).

%% -------------------------------------------------------------------------
%% API
%% -------------------------------------------------------------------------

-spec generate/0 :: () -> binary().

%% @doc Generates a UUID based on high-quality randomness from
%% /dev/urandom, if available.
%% @spec () -> UUID16::binary()
generate() ->
    erlang:nif_error(not_loaded).

-spec generate_random/0 :: () -> binary().

%% @doc Generates a UUID using the all-random format, even if a high-quality
%% random number generator (i.e., /dev/urandom) is not available.
%% @spec () -> UUID16::binary()
generate_random() ->
    erlang:nif_error(not_loaded).

-spec generate_time/0 :: () -> binary().

%% @doc Generates a UUID using the current time and the local ethernet MAC
%% address (if available).
%% @spec () -> UUID16::binary()
generate_time() ->
    erlang:nif_error(not_loaded).

-spec parse/1 :: (binary()) -> binary().

%% @doc Converts the UUID from a 36-bytes-binary-string into a 16-bytes-binary.
%% @spec (UUID36::binary()) -> UUID16::binary()
parse(_Bin) ->
    erlang:nif_error(not_loaded).

-spec unparse/1 :: (binary()) -> binary().

%% @doc Converts the UUID from a 16-bytes-binary into a 36-bytes-binary-string.
%% May be upper or lower case depending on the system.
%% @spec (UUID16::binary()) -> UUID36::binary()
unparse(_UUID) ->
    erlang:nif_error(not_loaded).

-spec unparse_upper/1 :: (binary()) -> binary().

%% @doc Converts the UUID from a 16-bytes-binary into an uppercase
%% 36-bytes-binary-string.
%% @spec (UUID16::binary()) -> UUID36::binary()
unparse_upper(_UUID) ->
    erlang:nif_error(not_loaded).

-spec unparse_lower/1 :: (binary()) -> binary().

%% @doc Converts the UUID from a 16-bytes-binary into a lowercase
%% 36-bytes-binary-string.
%% @spec (UUID16::binary()) -> UUID36::binary()
unparse_lower(_UUID) ->
    erlang:nif_error(not_loaded).

%% -------------------------------------------------------------------------
%% on_load callback
%% -------------------------------------------------------------------------

load_nif() ->
    erlang:load_nif(filename:join(code:priv_dir(libuuid), "uuid"), 0).
