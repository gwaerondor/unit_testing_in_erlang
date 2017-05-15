-module(subtraction_tests).
-include_lib("eunit/include/eunit.hrl").

subtraction_test_() ->
    [fun subtract_two_numbers/0,
     fun subtract_three_numbers/0,
     fun subtract_negative_number/0].

subtract_two_numbers() ->
    10 = 100 - 90.

subtract_three_numbers() ->
    89 = 100 - 10 - 1.

subtract_negative_number() ->
    2 = 1 - (-1).
