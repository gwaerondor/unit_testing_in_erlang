-module(exercise_1).
-export([get_hostnames_of_all_connected_nodes/0]).

get_hostnames_of_all_connected_nodes() ->
    %% A node has the form user@host,
    %% we want to only get the host part.
    Nodes = get_nodes(),
    [remove_user_part(Node) || Node <- Nodes].

remove_user_part(Node) ->
    throw(not_implemented_yet).

get_nodes() ->
    library:get_other_nodes().
