-module(sd_supersup).
-behaviour(supervisor).
-export([start_link/0, stop/0, start_sd/2, stop_sd/1]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, sd}, ?MODULE, []). % use global instead of local?

stop() ->
	case whereis(sd) of
		P when is_pid(P) ->
			exit(P, kill);
		_ -> ok
	end.

init([]) ->
	MaxRestart = 6,
	MaxTime = 3600,
	{ok, {{one_for_one, MaxRestart, MaxTime}, []}}.

%% Potentially rename to start_actor or start_node.
start_sd(Name, MFA) ->
	ChildSpec = {Name,
				  {sd_sup, start_link, [Name, MFA]},
				   permanent, 10500, supervisor, [sd_sup]},
	supervisor:start_child(node, ChildSpec).

%% Potentially rename to stop_actor or stop_node.
stop_sd(Name) ->
	supervisor:terminate_child(node, Name),
	supervisor:delete_child(node, Name).