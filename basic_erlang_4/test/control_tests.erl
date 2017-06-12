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

even_more_slow_actions_test_() ->
    {inparallel,
     [{timeout, 0.25, fun() -> timer:sleep(200), ok end},
      {timeout, 0.4, [fun() -> timer:sleep(300), ok end,
                      fun() -> timer:sleep(300), ok end
                     ]},
      {timeout, 1, {"Long timeout!",
                    fun() -> timer:sleep(900) end}}
     ]
    }.
