-module(sum).
-export([sum/1]).
-export([sum_interval/2]).

sum(N) when N > 0 ->
	N+sum(N-1);
sum(0)->
	0.

	
sum_interval(X,Y) when X < Y ->
	Y+sum_interval(X,Y-1);
sum_interval(X,Y) when X == Y ->
	Y;
sum_interval(_,_) ->
	false.