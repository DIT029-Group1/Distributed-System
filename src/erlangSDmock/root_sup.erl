-module(root_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

%ROOT supervisor that supervises all of the  (ChildSupervisors) and they actually present every single client request for SD simulation
start_link() ->
			%using the module name to name this root supervisor
			{ok, Pid} = supervisor:start_link({local, ?MODULE}, ?MODULE, []),
			io:format("Root supervisor is running ~n"),
			{ok, Pid}.
		
   

init(_Args) ->
	%simple one for one strategy meaningn that when the supervisor is started no children are started they are all  added dinamicly 
	% and if one child node crashes only that one is restarted
     RestartStrategy = {simple_one_for_one, 10, 60},
     ChildSpec = {child, {sup, start_link, []},
          permanent, brutal_kill, supervisor, [sup]},
     {ok, {RestartStrategy, [ChildSpec]}}.

%	{ok, RS} = root_sup:start_link().
%	{ok, RSchild1} = supervisor:start_child(RS, []).
%	{ok, RSchild2} = supervisor:start_child(RS, []).
%	{ok, SChild1} = supervisor:start_child(RSchild1, []).
%	{ok, SChild2} = supervisor:start_child(RSchild, []).