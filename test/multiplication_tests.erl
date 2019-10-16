-module(multiplication_tests).
-include_lib("eunit/include/eunit.hrl").

multiplication_test_() ->
    [{"Multiplication should be commutative, meaning "
      "that the order of the factors does not matter",
      fun multiplication_is_commutative/0},
     {"Multiplication of two negative factors "
      "should result in a positive product",
      fun multiplication_of_negatives/0}].

multiplication_is_commutative() ->
    5 * 10 = 10 * 5.

multiplication_of_negatives() ->
    100 = (-10) * (-10).
