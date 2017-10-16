%% @author Martin Chukaleski

-module(starter).

-export([start_sup_ch/1,start_root/0,loop/1,start/0,read_messages/1,start_chsup_ch/2,spawn_actors/2,test/0,connect/0,send/2]).

connect() ->
	{ok,S} = gen_tcp:connect("localhost",8800,[binary,{packet,0}]),{ok,S}.
send(Socket,Msg) -> gen_tcp:send(Socket, Msg).
	
test () ->
	starter:start_root(),
	starter:start_sup_ch(sd_sup),
	starter:start_chsup_ch(child2,sd_sup).
	% 	Actors = [a1,a2,a3,a4,a5].
	% 	starter:spawn_actors(whereis(child2),Actors).
	

start_root() ->
	%	starter:start_root().
	case whereis(root_sup) of 
		undefined ->	{ok, Pid} = root_sup:start_link(),
						{ok, Pid};
		Pid -> {ok,Pid}
	end.	
	

%% 	starter:start_sup_ch(sd_sup).
start_sup_ch(Name)-> 
	{ok, Child} = supervisor:start_child(whereis(root_sup), []),
	register(Name,Child),
	{ok,Child}.

% 	starter:start_chsup_ch(child2,sd_sup).
start_chsup_ch(Name,SupervisorPID)-> 
	{ok, Child1} = supervisor:start_child(SupervisorPID, []),
	register(Name,Child1),
	{ok,Child1}.
	
	

% Read through a list of messages that are sent from java script to erlang example for testing
%	starter:read_messages([{node1,fwd,node2,msgrequest},{node2,fwd,node3,msgrequest},{node3,fwd,node4,msgrequest},{node4,fwd,node5,msgrequest},{node5,fwd,node6,msgrequest}]).
read_messages([]) ->  no_more_msg;
read_messages([{From,Fwd,To,Msg}|Xs]) ->
		io:format("~p, ~p, ~p, ~p ~n",[From,Fwd,To,Msg]), timer:sleep(700), read_messages(Xs).


server_read_messages(Server,[]) ->  Server ! no_more_msg;
server_read_messages(Server,[{From,Msg,To}|Xs]) -> Server ! {{From,Msg,To},self()},timer:sleep(700),
		receive 
				{{From,Msg,To},Pid} -> {From,Msg,To} % call function to send it back to java script
		end,
   server_read_messages(Server,Xs).		

%%% Pid is the id of the child sd_simulator_OTP
spawn_actors(Pid,[]) -> no_more_actors;
spawn_actors(Pid,[Actor|Ys]) -> sup:start_actor(Pid),spawn_actors(Pid, Ys).
	



%	{ok, RS} = root_sup:start_link().
%	{ok, RSchild1} = supervisor:start_child(RS, []).
%	{ok, RSchild2} = supervisor:start_child(RS, []).
%	{ok, SChild1} = supervisor:start_child(RSchild1, []).
%	{ok, SChild2} = supervisor:start_child(RSchild, []).




