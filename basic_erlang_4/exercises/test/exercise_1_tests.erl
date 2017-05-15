-module(exercise_1_tests).
-include_lib("eunit/include/eunit.hrl").

get_hostnames_test() ->
    Hosts = exercise_1:get_hostnames_of_all_connected_nodes(),
    Expected = ["esekilvv1337.ericsson.com", "spymatic47.nsa.gov"],
    ?assertEqual(Expected, Hosts).
