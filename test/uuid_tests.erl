-module(uuid_tests).

-include_lib("eunit/include/eunit.hrl").

-define(UUID_RE,
    "^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$").
-define(UUID_RE_UPPER,
    "^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$").
-define(UUID_RE_LOWER,
    "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$").

generate_test() ->
    UUID16 = uuid:generate(),
    ?assert(is_binary(UUID16)),
    ?assertEqual(16, size(UUID16)).

generate_random_test() ->
    UUID16 = uuid:generate_random(),
    ?assert(is_binary(UUID16)),
    ?assertEqual(16, size(UUID16)).

generate_time_test() ->
    UUID16 = uuid:generate_time(),
    ?assert(is_binary(UUID16)),
    ?assertEqual(16, size(UUID16)).

parse_test() ->
    UUID36 = <<"c55139cd-9c17-4b67-b4d4-1913a2d62708">>,
    UUID16 = <<197,81,57,205,156,23,75,103,180,212,25,19,162,214,39,8>>,
    ?assertEqual(UUID16, uuid:parse(UUID36)).

unparse_test() ->
    UUID36 = uuid:unparse(uuid:generate()),
    ?assertMatch({match, [{0, 36}]}, re:run(UUID36, ?UUID_RE)).

unparse_upper_test() ->
    UUID36 = uuid:unparse_upper(uuid:generate()),
    ?assertMatch({match, [{0, 36}]}, re:run(UUID36, ?UUID_RE_UPPER)).

unparse_lower_test() ->
    UUID36 = uuid:unparse_lower(uuid:generate()),
    ?assertMatch({match, [{0, 36}]}, re:run(UUID36, ?UUID_RE_LOWER)).
