-module(echo).
-export([start/0, stop/0, print/1, loop/0]).

-import(io, [format/2]).

start() ->
	Pid = spawn(echo, loop, []),
	register(echo, Pid).

stop() ->
	echo ! stop.

print(Term) ->
	echo ! {print, Term}.

loop() ->
	receive
		{print, Term} ->
			io:format("~w~n", [Term]),
		loop();
		stop ->
			ok
	end.