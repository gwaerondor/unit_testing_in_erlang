-module(maths_SUITE).
-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

%%% Test server callbacks
-export([all/0, groups/0, init_per_suite/1, end_per_suite/1]).

%%% Test cases
-export([addition_1/1, addition_2/1, subtraction_1/1, subtraction_2/1]).

groups() ->
    [{addition, [shuffle, sequence], [addition_1, addition_2]},
     {subtraction, [shuffle, sequence], [subtraction_1, subtraction_2]}].

all() ->
    [{group, addition}, {group, subtraction}].

init_per_suite(Config) ->
    Directory = os:cmd("mktemp -d") -- "\n",
    Addition = filename:join(Directory, "addition.txt"),
    Subtraction = filename:join(Directory, "subtraction.txt"),
    ok = file:write_file(Addition, "10 20"),
    ok = file:write_file(Subtraction, "5 2"),
    [{directory, Directory},
     {addition, Addition},
     {subtraction, Subtraction} | Config].

end_per_suite(Config) ->
    Directory = proplists:get_value(directory, Config),
    AdditionFile = proplists:get_value(addition, Config),
    SubtractionFile = proplists:get_value(subtraction, Config),
    ok = file:delete(SubtractionFile),
    ok = file:delete(AdditionFile),
    ok = file:del_dir(Directory).

addition_1(Config) ->
    File = proplists:get_value(addition, Config),
    [Left, Right] = read_terms(File),
    ?assertEqual(30, Left + Right).

addition_2(Config) ->
    File = proplists:get_value(addition, Config),
    [Left, Right] = read_terms(File),
    ?assertEqual(30, Right + Left).

subtraction_1(Config) ->
    File = proplists:get_value(subtraction, Config),
    [Left, Right] = read_terms(File),
    ?assertEqual(3, Left - Right).

subtraction_2(Config) ->
    File = proplists:get_value(subtraction, Config),
    [Left, Right] = read_terms(File),
    ?assertEqual(-3, Right - Left).

read_terms(File) ->
    {ok, Bin} = file:read_file(File),
    Contents = binary_to_list(Bin),
    Terms = string:split(Contents, " "),
    [list_to_integer(Term) || Term <- Terms].
