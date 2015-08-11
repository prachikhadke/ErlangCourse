-module(db).
-export([new/0, delete/2, destroy/1, write/3, read/2, match/2]).

-import(io, [format/2]).

new() -> [].

destroy(_) -> ok.

write(Key, Element, DbRef) ->
	DbRef ++ [{Key, Element}].

delete(Key, DbRef) ->
	del_helper(Key, DbRef, []).

del_helper(Key, [{K,_} | Rest], NewDbRef) when Key == K ->
	io:format("updated db is ~w~n", [NewDbRef]),
	del_helper(Key, Rest, NewDbRef);
del_helper(Key, [{K,V} | Rest], NewDbRef) when Key /= K ->
	io:format("updated db is ~w~n", [NewDbRef]),
	del_helper(Key, Rest, [{K,V}] ++ NewDbRef);
del_helper(_, [], NewDbRef) ->
	io:format("updated db is ~w~n", [NewDbRef]),
	NewDbRef.

read(Key, [{K,V} | _]) when Key == K ->
	{ok, V};
read(Key, [{K,_} | Rest]) when Key /= K ->
	read(Key, Rest);
read(_, []) ->
	{error, instance}.

match(Element, DbRef) ->
	match_helper(Element, DbRef, []).

match_helper(E, [{K,V} | Rest], Result) when E == V ->
	match_helper(E, Rest, [K] ++ Result);
match_helper(E, [{_,V} | Rest], Result) when E /= V ->
	match_helper(E, Rest, Result);
match_helper(_, [], Result) ->
	Result.