%% @author Martin Chukaleski

-module(starter).

-export([start_sup_ch/1,start_root/0,loop/1,start/0,read_messages/1]).


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
	
	

% Read through a list of messages that are sent from java script to erlang example for testing
%	starter:read_messages([{node1,msgrequest,node2},{node2,msgrequest,node3},{node3,msgrequest,node4},{node4,msgrequest,node5},{node5,msgrequest,node6}]).
read_messages([]) ->  no_more_msg;
read_messages([{From,Msg,To}|Xs]) ->
		io:format("~p -> ~p -> ~p ~n",[From,Msg,To]), timer:sleep(700), read_messages(Xs).


server_read_messages(Server,[]) ->  Server ! no_more_msg;
server_read_messages(Server,[{From,Msg,To}|Xs]) -> Server ! {{From,Msg,To},self()},timer:sleep(700),
		receive 
				{{From,Msg,To},Pid} -> {From,Msg,To} % call function to send it back to java script
		end,
   server_read_messages(Server,Xs).												 
	



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




