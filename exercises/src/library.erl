-module(library).
-export([get_other_nodes/0]).

get_other_nodes() ->
    erlang:nodes().
