%% @author Martin Chukaleski
-module(sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).
-export([stop/1,start_actor/1, send_msg/4, read/1]).

%% Supervisor that in a way represents the client of the website and it supervises  all of the SD diagram children processes.
start_link() ->
			%% No name is given to this supervisor since making more than one instace with the same name will result in an error.
			%% Future TODO, do dynamic naming.
			{ok, Pid} = supervisor:start_link(?MODULE, []),
			io:format("Supervisor is running ~n"),
			{ok, Pid}.
		
   

init(_Args) ->
	%% Simple one_for_one strategy meaning that when the supervisor is started no children are started they are all  added dinamically 
	%% and if one child node crashes only that one is restarted.
     RestartStrategy = {simple_one_for_one, 10, 60},
     ChildSpec = {child, {sd_simulator_OTP, start_link, []},
          permanent, brutal_kill, worker, [sd_simulator_OTP]},
     {ok, {RestartStrategy, [ChildSpec]}}.

stop(Pid) ->
	gen_server:cast(Pid, shutdown).

%%% CLIENT API
read(Pid) ->
	gen_server:call(Pid, read).

start_actor(Pid) ->
	gen_server:call(Pid, start_actor).

send_msg(Pid,ActorFrom, Msg, ActorTo) ->
	gen_server:call(Pid, {send_msg, ActorFrom, Msg, ActorTo}).