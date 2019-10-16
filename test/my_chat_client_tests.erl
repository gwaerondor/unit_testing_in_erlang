-module(my_chat_client_tests).
-include_lib("eunit/include/eunit.hrl").

pinging_should_return_ok_if_connected_test_() ->
    {setup,
     fun setup_ok_test/0,
     fun unmeck_and_kill/1,
     ?_assertEqual(ok, my_chat_client:ping())
    }.

pinging_should_return_error_if_not_connected_test_() ->
    {setup,
     fun setup_error_test/0,
     fun unmeck_and_kill/1,
     ?_assertEqual({error, connection_lost}, my_chat_client:ping())
    }.

setup_ok_test() ->
    meck_tcp_stuff(),
    meck:expect(my_chat_client,
                get_ping_response,
                fun(_) -> pong end),
    my_chat_client:start().

setup_error_test() ->
    meck_tcp_stuff(),
    meck:expect(my_chat_client, get_ping_response, fun(_) -> pang end),
    my_chat_client:start().

meck_tcp_stuff() ->
    catch meck:new(my_chat_client, [passthrough]),
    meck:expect(my_chat_client, do_send, fun(_, _) -> ok end),
    meck:expect(my_chat_client, connect, fun(_, _) -> dummy end).

unmeck_and_kill(_) ->
    meck:unload(my_chat_client),
    exit(whereis(my_chat_client), kill),
    ensure_killed(my_chat_client),
    timer:sleep(1000).

ensure_killed(Process) ->
    case whereis(Process) of
        undefined ->
            ok;
        _ ->
            timer:sleep(10),
            ensure_killed(Process)
    end.
