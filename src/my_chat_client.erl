-module(my_chat_client).

-ifdef(TEST).
-compile(export_all).
-endif.

start() ->
    Socket = ?MODULE:connect("localhost", 5060),
    spawn(fun() ->
		  register(?MODULE, self()),
		  client_loop(Socket)
	  end).

connect(Server_IP, Port) ->
    {ok, Socket} = gen_tcp:connect(Server_IP, Port, [binary, {packet, 0}]),
    Socket.

client_loop(Socket) ->
    receive
	{ping, Pid} ->
	    ?MODULE:do_send(Socket, "ping"),
	    Pid ! ?MODULE:get_ping_response(Socket),
	    ?MODULE:client_loop(Socket);
	close ->
	    gen_tcp:close(Socket);
	Message ->
	    ?MODULE:do_send(Socket, Message),
	    ?MODULE:client_loop(Socket)
    end.

do_send(Socket, Message) ->
    gen_tcp:send(Socket, term_to_binary(Message)).

get_ping_response(Socket) ->
    {ok, Bin} = gen_tcp:recv(Socket, []),
    case catch binary_to_term(Bin) of
	pong ->
	    pong;
	_ ->
	    pang
    end.

ping() ->
    ?MODULE ! {ping, self()},
    receive
	pong ->
	    ok;
	pang ->
	    {error, connection_lost}
    end.
