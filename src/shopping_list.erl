-module(shopping_list).
-export([read/0,
         add/1,
         reduce/1,
         remove/1]).

-define(PATH, "/tmp/shopping_list").

read() ->
    {ok, [List]} = file:consult(?PATH),
    List.

add(Item) ->
    Current_list = read(),
    Quantity = proplists:get_value(Item, Current_list, 0),
    Updated = update(Current_list, Item, Quantity + 1),
    write(Updated).

reduce(Item) ->
    Current_list = read(),
    Updated = case proplists:get_value(Item, Current_list) of
                  undefined ->
                      Current_list;
                  Quantity ->
                      update(Current_list, Item, Quantity - 1)
              end,
    write(Updated).

remove(Item) ->
    Current_list = read(),
    Updated = update(Current_list, Item, 0),
    write(Updated).

update(List, Item, 0) ->
    lists:keydelete(Item, 1, List);
update(List, Item, Quantity) ->
    case proplists:is_defined(Item, List) of
        false ->
            [{Item, Quantity} | List];
        true ->
            lists:keyreplace(Item, 1, List, {Item, Quantity})
    end.

write(Shopping_list) ->
    file:write_file(?PATH, io_lib:format("~p.", [Shopping_list])).
