-module(arithmetics_server_tests).
-include_lib("eunit/include/eunit.hrl").

arithmetics_server_test_() ->
    {setup,
     fun setup/0,
     fun cleanup/1,
     [fun add/0,
      fun subtract/0,
      fun multiply/0,
      fun divide/0]}.

setup() ->
    arithmetics_server:start().

cleanup(_) ->
    exit(whereis(arithmetics_server), kill).

add() ->
    arithmetics_server ! {self(), add, [3, 4]},
    7 = receive_response().

subtract() ->
    arithmetics_server ! {self(), subtract, [10, 1]},
    9 = receive_response().

multiply() ->
    arithmetics_server ! {self(), multiply, [10, 20]},
    200 = receive_response().

divide() ->
    arithmetics_server ! {self(), divide, [5, 2]},
    2.5 = receive_response().

receive_response() ->
    receive
	X ->
	    X
    end.
