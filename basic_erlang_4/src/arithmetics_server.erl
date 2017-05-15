-module(arithmetics_server).
-export([start/0]).

start() ->
    spawn(fun() ->
		  register(?MODULE, self()),
		  loop()
	  end).

loop() ->
    receive
	{Pid, Action, Numbers} ->
	    Result = do_action(Action, Numbers),
	    Pid ! Result
    end,
    loop().

do_action(add, Numbers) ->    
    lists:sum(Numbers);
do_action(subtract, Numbers) ->
    lists:foldl(fun(N, Diff) -> Diff - N end, hd(Numbers), tl(Numbers));
do_action(multiply, Numbers) ->
    lists:foldl(fun(N, Prod) -> N * Prod end, hd(Numbers), tl(Numbers));
do_action(divide, [Numerator, Denominator]) ->
    Numerator / Denominator.

