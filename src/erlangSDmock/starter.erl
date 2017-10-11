%% @author Fujitsu
%% @doc @todo Add description to starter.
-module(starter).

-export([start_sup_ch/1,start_root/0,loop/1,start/0]).


start_root() ->
	%	starter:start_root().
	case whereis(root_sup) of
		undefined ->	{ok, Pid} = root_sup:start_link(),
						{ok, Pid};
		Pid -> {ok,Pid}
	end.	
	

% 	starter:start_sup_ch(child1).
start_sup_ch(Name)-> 
	{ok, Child} = supervisor:start_child(whereis(root_sup), []),
	register(Name,Child),
	{ok,Child}.
	
	%whereis(root_sup) ! {start_child,self(),Name},
	%receive
		%{start_child_reply,Pid,ChildName}  -> {ok,ChildName}
	%end.
	

%	{ok, RS} = root_sup:start_link().
%	{ok, RSchild1} = supervisor:start_child(RS, []).
%	{ok, RSchild2} = supervisor:start_child(RS, []).
%	{ok, SChild1} = supervisor:start_child(RSchild1, []).
%	{ok, SChild2} = supervisor:start_child(RSchild, []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS PART IS WORK IN PROGRESS
start() ->
	start_root(),
	case whereis(root_server) of
		undefined ->
			P = spawn(fun () ->
				io:format("The server is running! ~n"),
							loop([])
					  end),
			register(root_server,P),
			{ok,P};
		P -> {ok,P}
	end.

loop(L) ->
	io:format("Current state: ~p~n",[L]),
		receive 
		{start_child,Pid,Name} -> {ok, ChildPid} = supervisor:start_child(whereis(root_sup), []),
								  register(Name,ChildPid),
			Pid ! {start_child_reply,self(),Name},
			loop([Name|L])
		end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




