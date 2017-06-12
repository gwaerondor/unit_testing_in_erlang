-module(better_lists_tests).
-include_lib("eunit/include/eunit.hrl").

better_lists_test_() ->
    {setup,
     fun setup/0,
     fun cleanup/1,
     ?_assertEqual([1, 1, 2, 3, 3], better_lists:sort([1, 1, 3, 3, 2]))
    }.

setup() ->
    meck:new(better_lists, [non_strict]),
    meck:expect(better_lists, sort, fun my_qsort/1).

cleanup(_) ->
    meck:unload(better_lists).

my_qsort([]) ->
    [];
my_qsort([Pivot | L]) ->
    my_qsort([X || X <- L, X < Pivot])
        ++ [Pivot]
        ++ my_qsort([X || X <- L, X >= Pivot]).
