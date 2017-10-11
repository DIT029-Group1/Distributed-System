-module(sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

%Supervisor that in a way represent the client of the website and it supervises  all of the SD diagram children processes
start_link() ->
			%no name is given to this supervisor since making more than one instace with the same name will result in an error
			{ok, Pid} = supervisor:start_link(?MODULE, []),
			io:format("Supervisor is running ~n"),
			{ok, Pid}.
		
   

init(_Args) ->
	%simple one for one strategy meaningn that when the supervisor is started no children are started they are all  added dinamicly 
	% and if one child node crashes only that one is restarted
     RestartStrategy = {simple_one_for_one, 10, 60},
     ChildSpec = {child, {coordinator_OTP, start_link, []},
          permanent, brutal_kill, worker, [coordinator_OTP]},
     {ok, {RestartStrategy, [ChildSpec]}}.