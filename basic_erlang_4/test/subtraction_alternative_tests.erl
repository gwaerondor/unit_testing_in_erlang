-module(subtraction_alternative_tests).
-include_lib("eunit/include/eunit.hrl").

subtraction_test_() ->
    [?_assertEqual(10, 100 - 90),
     ?_assertEqual(89, 100 - 10 - 1),
     ?_assertEqual(2, 1 - (-1))].

