-module(listops).
-export([create/1, reverse_create/1, print/1, even_print/1, filter/2, reverse/1, concatenate/1, flatten/1]).

-import(io, [format/2]).

create(X) when X > 0 ->
	create(X-1) ++ [X];
create(0) -> [];
create(_) -> error.

reverse_create(X) when X > 0 ->
	[X | reverse_create(X-1)];
reverse_create(0) -> [];
reverse_create(_) -> error.

print(N) when N > 1 ->
	print(N-1), io:format("~p~n", [N]);
print(1) ->
	io:format("~p~n", [1]);
print(_) ->
	error.

even_print(N) when N rem 2 == 0, N > 2 ->
	even_print(N-2),io:format("~p~n",[N]);
even_print(N) when N rem 2 == 1, N-1 > 2 ->
	even_print(N-3),io:format("~p~n",[N-1]);
even_print(3) ->
	io:format("~p~n", [2]);
even_print(2) ->
	io:format("~p~n", [2]);
even_print(_) ->
	error.

filter(L, Key) ->
	filter_helper(L, Key, []).

filter_helper([First | Rest], Key, Result) when ((First < Key) or (First == Key)) ->
	filter_helper(Rest, Key, Result ++ [First]);
filter_helper([First | Rest], Key, Result) when First > Key ->
	filter_helper(Rest, Key, Result);
filter_helper([], _, Result) ->
	Result.

reverse(L) ->
	reverse_helper(L, []).

reverse_helper([First | Rest], Result) ->
	reverse_helper(Rest, [First] ++ Result);
reverse_helper([], Result) ->
	Result.

concatenate(L) ->
	concat_helper(L, []).

concat_helper([First | Rest], Result) when is_list(First) == true ->
	concat_helper(Rest, Result ++ First);
concat_helper([First | Rest], Result) when is_list(First) == false ->
	concat_helper(Rest, Result ++ [First]);
concat_helper([], Result) ->
	Result.

flatten([]) -> [];
flatten(L) ->
	Isreq = check_list(L),
	flatten_helper(L, Isreq).

flatten_helper(L, Isreq) when Isreq == false ->
	Res = concatenate(L),
	flatten(Res);
flatten_helper(L, Isreq) when Isreq == true ->
	L.

check_list([First | _]) when is_list(First) == true ->
	false;
check_list([First | Rest]) when is_list(First) == false ->
	check_list(Rest);
check_list([]) ->
	true.