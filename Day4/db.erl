-module(db).
-behaviour(db_server).
-export([start/0, stop/0, init/1, handle/2, write/2, read/1, delete/1, match/1]).

start() -> db_server:start(db, []).

stop() -> db_server:stop(db).

init(_Args) -> [].

handle({write, [Key, Element]}, DbRef) ->
	{DbRef ++ [{Key, Element}], ok};
handle({read, [Key]}, DbRef) ->
	{DbRef, read_helper(Key, DbRef)};
handle({delete, [Key]}, DbRef) ->
	del_helper(Key, DbRef, []);
handle({match, [Element]}, DbRef) ->
	{DbRef, match_helper(Element, DbRef, [])}.

write(Key, Element) -> db_server:call(db, {write, [Key, Element]}).

read(Key) -> db_server:call(db, {read, [Key]}).

delete(Key) -> db_server:call(db, {delete, [Key]}).

match(Element) -> db_server:call(db, {match, [Element]}).



del_helper(Key, [{K,_} | Rest], NewDbRef) when Key == K ->
	del_helper(Key, Rest, NewDbRef);
del_helper(Key, [{K,V} | Rest], NewDbRef) when Key /= K ->
	del_helper(Key, Rest, [{K,V}] ++ NewDbRef);
del_helper(_, [], NewDbRef) ->
	{NewDbRef, ok}.

read_helper(Key, [{K,V} | _]) when Key == K ->
	{V, ok};
read_helper(Key, [{K,_} | Rest]) when Key /= K ->
	read_helper(Key, Rest);
read_helper(_, []) ->
	{error, instance}.

match_helper(E, [{K,V} | Rest], Result) when E == V ->
	match_helper(E, Rest, [K] ++ Result);
match_helper(E, [{_,V} | Rest], Result) when E /= V ->
	match_helper(E, Rest, Result);
match_helper(_, [], Result) ->
	{Result, ok}.