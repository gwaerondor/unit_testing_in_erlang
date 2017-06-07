-module(exercise_1_tests).
-include_lib("eunit/include/eunit.hrl").

%% While this one works, it's taking too long!
%% We still need to run all of them for some reason,
%% and we cannot change the sleep/0 function.
timeout_test_() ->
    [fun sleep/0,
     fun sleep/0,
     fun sleep/0,
     fun sleep/0,
     fun sleep/0,
     fun sleep/0,
     fun sleep/0,
     fun sleep/0].

process_test_() ->
    [fun hi_process/0,
     fun bye_process/0
    ].

%% This one seems to be working fine.
hi_process() ->
    spawn(fun() ->
                  register(?MODULE, self()),
                  loop()
          end),
    ensure_started(?MODULE),
    ?MODULE ! {hello, self()},
    receive hi ->
            ok
    end.

% But this one, that is almost identical to hi_process, is failing!
bye_process() ->
    spawn(fun() ->
                  register(?MODULE, self()),
                  loop()
          end),
    ensure_started(?MODULE),
    ?MODULE ! {goodbye, self()},
    receive bye ->
            ok
    end.

%% This one doesn't work unless we're connected to external nodes!
%% We only need to check the functionality of extracting the hosts,
%% not the functionality of connecting erlang nodes.
get_hostnames_test() ->
    Hosts = exercise_1:get_hostnames_of_all_connected_nodes(),
    Expected = ["esekilvv1337.ericsson.com", "spymatic47.nsa.gov"],
    ?assertEqual(Expected, Hosts).

%% This one takes too long, which completely messes up all
%% testing! Everything after it gets skipped.
%% NOTE: Depending on your machine, this test might already
%%       be passing (CPU speed related). If it does,
%%       please change the Max variable to a higher number.
big_operation_test_() ->
    fun() ->
            Max = 20000,
            Elements = lists:reverse(lists:seq(1, Max)),
            Sorted = bubble_sort(Elements),
            ?assertEqual(lists:seq(1, Max), Sorted)
    end.

%%% -------------------------------------------------------
% The exercise ends here. Help functions are defined below.
%%% -------------------------------------------------------
loop() ->
    receive
        {hello, Pid} ->
            Pid ! hi;
        {goodbye, Pid} ->
            Pid ! bye
    end,
    loop().

ensure_started(Process_name) ->
    case whereis(Process_name) of
        undefined ->
            timer:sleep(10),
            ensure_started(Process_name);
        _ ->
            ok
    end.

sleep() ->
    timer:sleep(1000).

bubble_sort(L) -> bubble_sort(L, [], false).

bubble_sort([A, B | T], Acc, _) when A > B ->
  bubble_sort([A | T], [B | Acc], true);
bubble_sort([A, B | T], Acc, Tainted) ->
  bubble_sort([B | T], [A | Acc], Tainted);
bubble_sort([A | T], Acc, Tainted) ->
  bubble_sort(T, [A | Acc], Tainted);
bubble_sort([], Acc, true) ->
  bubble_sort(lists:reverse(Acc));
bubble_sort([], Acc, false) ->
  lists:reverse(Acc).
