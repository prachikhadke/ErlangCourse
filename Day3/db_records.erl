-module(db).
-export([new/0, delete/2, destroy/1, write/3, read/2, match/2]).
-record(data, {key, value}).

% new: -> List
% RETURNS: Reference to the database list. 
new() -> [].

% destroy: Anything -> Atom.
% GIVEN: A reference to the Database. The database is garbage collected eventually.
% RETURNS: ok atom
destroy(_) -> ok.

% write: Integer, Atom -> ListReference
% GIVEN: Key to insert, Value for the Key and reference to the database
% RETURNS: Reference to udpated database
write(Key, Element, DbRef) ->
	DbRef ++ [#data{key = Key, value=Element}].

delete(Key, DbRef) ->
	del_helper(Key, DbRef, []).

del_helper(Key, [ DbRec | Rest], NewDbRef) when DbRec#data.key == Key ->
	del_helper(Key, Rest, NewDbRef);
del_helper(Key, [ DbRec | Rest], NewDbRef) when DbRec#data.key /= Key ->
	del_helper(Key, Rest, [DbRec] ++ NewDbRef);
del_helper(_, [], NewDbRef) ->	
	NewDbRef.

read(Key, [ DbRec | _]) when DbRec#data.key == Key ->
	{ok, DbRec#data.value};
read(Key, [ DbRec | Rest]) when DbRec#data.key /= Key ->
	read(Key, Rest);
read(_, []) ->
	{error, instance}.

match(Element, DbRef) ->
	match_helper(Element, DbRef, []).

match_helper(E, [DbRec | Rest], Result) when E == DbRec#data.value ->
	match_helper(E, Rest, [DbRec#data.key] ++ Result);
match_helper(E, [DbRec | Rest], Result) when E /= DbRec#data.value ->
	match_helper(E, Rest, Result);
match_helper(_, [], Result) ->
	Result.