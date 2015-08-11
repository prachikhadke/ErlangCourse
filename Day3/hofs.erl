-module(hofs).
-export([print/1, find_less_than/2, print_even/1, concat_lists/1, sum/1]).

%-import(lists, [seq/2]).

print(N) when N >= 1 ->
	PrintX=fun(X)->X end,
	lists:map(PrintX, lists:seq(1, N)).

find_less_than(Key, L) ->
	LessThan = fun(X) ->
		fun(Y) -> Y < X end
	end,
	lists:filter(LessThan(Key), L).

print_even(N) when N >= 1 ->
	PrintEven=fun(X)-> 
		X rem 2 == 0 
	end,
	lists:filter(PrintEven, lists:seq(1, N));
print_even(_) ->
	[].

concat_lists(L) ->
	lists:foldr(fun(X, Res) -> X ++ Res end, [], L).

sum(L) ->
	lists:foldr(fun(X, Sum) -> X + Sum end, 0, L).	
	