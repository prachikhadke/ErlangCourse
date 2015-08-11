-module(db).
-export([new/0, delete/2, destroy/1, write/3, read/2, match/2]).

-import(ets, [new/2, delete/1, delete/2, lookup/2]).

new() -> ets:new(myTable, [set, named_table]).

destroy(TabId) -> ets:delete(TabId).

write(Key, Element, TabId) ->
	ets:insert(TabId, {Key, Element}).

delete(Key, TabId) ->
	ets:delete(TabId, Key).

read(Key, TabId) ->
	ets:lookup(TabId, Key).

match(Element, TabId) ->
	ets:match(TabId, Element).