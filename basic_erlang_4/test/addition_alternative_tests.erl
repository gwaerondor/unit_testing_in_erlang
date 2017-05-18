-module(addition_alternative_tests).
-include_lib("eunit/include/eunit.hrl").

add_two_numbers_test() ->
    Result = 1 + 1,
    ?assertEqual(2, Result).

add_three_numbers_test() ->
    Result = 1 + 2 + 3,
    Expected = 6,
    ?assertEqual(Expected, Result).

add_negative_number_test() ->
    ?assertEqual(1000, 2000 + (-1000)).

