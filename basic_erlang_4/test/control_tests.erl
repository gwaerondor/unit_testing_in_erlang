-module(control_tests).
-include_lib("eunit/include/eunit.hrl").

control_test_() ->
    %% {timeout, 0.5,
    {timeout, 1,
     [{"This test takes 750 ms to run",
       fun() -> timer:sleep(750), ok end}]
    }.

many_slow_actions_test_() ->
    {timeout, 0.5,
     {inparallel,
      [fun() -> timer:sleep(400), ok end,
       fun() -> timer:sleep(400), ok end,
       fun() -> timer:sleep(400), ok end]
     }
    }.
	      
	      
