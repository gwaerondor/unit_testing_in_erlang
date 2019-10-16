-module(addition_tests).
-include_lib("eunit/include/eunit.hrl").

add_two_numbers_test() ->
    2 = 1 + 1.

add_three_numbers_test() ->
    6 = 1 + 2 + 3.

add_negative_number_test() ->
    1000 = 2000 + (-1000).
