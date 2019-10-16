-module(shopping_list_tests).
-include_lib("eunit/include/eunit.hrl").

-define(DEFAULT, [{"tofu", 2}, {"apples", 10}, {"lentils", 3}]).

shopping_list_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [fun add_new_item/0,
      fun remove_item/0,
      fun add_quantity/0,
      fun reduce_quantity/0,
      fun reduce_quantity_a_lot/0
     ]
    }.

setup() ->
    ok = file:write_file("/tmp/shopping_list",
                         io_lib:format("~p.", [?DEFAULT])).

cleanup(_) ->
    ok = file:delete("/tmp/shopping_list").

add_new_item() ->
    shopping_list:add("shampoo"),
    Expected = [{"shampoo", 1} | ?DEFAULT],
    Result = shopping_list:read(),
    ?assertEqual(Expected, Result).

remove_item() ->
    shopping_list:remove("apples"),
    Expected = ?DEFAULT -- [{"apples", 10}],
    Result = shopping_list:read(),
    ?assertEqual(Expected, Result).

add_quantity() ->
    shopping_list:add("tofu"),
    Expected = lists:keyreplace("tofu", 1, ?DEFAULT, {"tofu", 3}),
    Result = shopping_list:read(),
    ?assertEqual(Expected, Result).

reduce_quantity() ->
    shopping_list:reduce("lentils"),
    Expected = lists:keyreplace("lentils", 1, ?DEFAULT, {"lentils", 2}),
    Result = shopping_list:read(),
    ?assertEqual(Expected, Result).

reduce_quantity_a_lot() ->
    [shopping_list:reduce("apples") || _ <- lists:seq(1, 1000)],
    Expected = lists:keydelete("apples", 1, ?DEFAULT),
    Result = shopping_list:read(),
    ?assertEqual(Expected, Result).
