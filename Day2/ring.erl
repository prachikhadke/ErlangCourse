-module(ring).
-export([main/2, createring/1, create/2, loop/1, send/3]).

-import(io, [format/2]).

main(M, N) when N > 1 ->
	First=spawn(ring, createring, [N]),
	send(First, M, N);
main(_,_) ->
	stop.

createring(N) ->
	create(N-1, self()).
	
create(N, Next) when N > 0 ->
	Pid = spawn(ring, loop, [Next]),
	create(N-1, Pid);
create(N, Next) when N == 0 ->
	loop(Next).

loop(Next) ->
	receive
		{forward, Message, N} when N > 0 ->
			io:format("~w got message ~w~n", [self(), Message]),
			Next ! {forward, Message, N-1},
			loop(Next);
		{forward, Message, 0} ->
			io:format("~w got message ~w~n", [self(), Message]),
			loop(Next);
		stop ->
			Next ! stop,
			ok
	end.

send(First, M, N) when M > 0 ->
	First ! {forward, M, N},
	send(First, M-1, N);
send(First, M, _) when M == 0 ->
	First ! stop.