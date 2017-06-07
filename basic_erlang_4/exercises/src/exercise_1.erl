-module(exercise_1).
-export([get_hostnames_of_all_connected_nodes/0]).

get_hostnames_of_all_connected_nodes() ->
    Nodes = get_nodes(),
    [remove_user_part(Node) || Node <- Nodes].

remove_user_part(Node) ->
    NodeString = atom_to_list(Node),
    [_, Host] = string:tokens(NodeString),
    Host.

get_nodes() ->
    library:get_other_nodes().
