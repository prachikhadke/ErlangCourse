-module(temp).
-export([convert/1]).

% Defining the function clauses
convert({c,X}) ->
	c2f(X);
convert({f,X}) ->
	f2c(X).

% Let's define the functions now

c2f(X) ->
	(9*X)/5+32.

f2c(X) ->
	(5*(X-32))/9.