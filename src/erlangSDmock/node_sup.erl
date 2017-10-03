-module(node_sup).
-behaviour(supervisor).
-export([start_link/1, init/1]).

start_link(MFA = {_,_,_}) ->
	supervisor:start_link(?MODULE, MFA).

init({M,F,A}) ->
	MaxRestart = 5,
	MaxTime = 3600, 
	{ok, {{one_for_all, MaxRestart, MaxTime},
		  [{node, 
		    {M,F,A},
		    temporary, 5000, worker, [M]}]}}.