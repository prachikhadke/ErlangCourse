-module(sup).
-behaviour(supervisor).
-export([start_link/0, init/1, stop/0]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_) ->
	{ok, {{simple_one_for_one, 2, 3600},
			[{db, {db, start_link, []},
			permanent, 2000, worker, [db]}]}}.

stop() ->
	exit(whereis(?MODULE), shutdown).