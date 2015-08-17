-module(db_server).
-export([start/2, stop/1, init/2, call/2, reply/2, loop/2]).

start(Mod, Args) ->
	Pid=spawn(db_server,init, [Mod, Args]),
	register(Mod, Pid).

stop(Mod) -> Mod ! stop.

init(Mod, Args) ->
	State = Mod:init(Args),
	loop(Mod, State).

call(Pid, Message) ->
	Pid ! {request, self(), Message},
	receive
		{reply, Reply} -> Reply
	end.

reply(Pid, Message) ->
	Pid ! {reply, Message}.

loop(Mod, State) ->
	receive
		{request, Pid, Msg} ->
			{NewState, Reply} = Mod:handle(Msg, State),
			reply(Pid, Reply),
			loop(Mod, NewState);
		stop -> ok
	end.


