-module(coordinator_serv_SIMPLE).
%-behaviour(gen_server).
-export([start/0, stop/0, sendMsg/2, start_actor/1]).

start() ->
	case whereis(coordinator_serv_SIMPLE) of
		undefined ->
			CoordinatorPid = spawn(fun() ->
								io:format("The coordinator server is running!~n"),
								init()
							end),
			register(coordinator_serv_SIMPLE, CoordinatorPid),
			{ok, CoordinatorPid};
		CoordinatorPid -> {ok, CoordinatorPid}
	end.

stop() ->
	case whereis(coordinator_serv_SIMPLE) of
		undefined -> 
			io:format("Coordinator is not running.~n");
		CoordinatorPid ->
			CoordinatorPid ! stop
		end.

init() -> loop([]).

loop(SdState) ->
	receive
		{ActorFrom, Msg, ActorTo} -> 
			loop([{ActorFrom, Msg, ActorTo}|SdState]),
			ActorTo ! {ActorFrom, Msg},
			io:format("~p~n", [SdState]);
		{read, P} ->
			P ! {read_reply, SdState},
			loop(SdState);
		stop ->
			io:format("Coordinator is shutdown!~n"),
			exit(whereis(coordinator_serv_SIMPLE), normal);
		_ -> 
			io:format("Illegal action!~n"),
			io:format("~p~n", [SdState]),
			loop(SdState)
	end.

start_actor(Name) ->
	ActorPid = spawn(fun() ->
					io:format("~s has been spawned.~n", Name)
				end),
	register(Name, ActorPid),
	{ok, ActorPid}.

sendMsg(ActorTo, Msg) ->
	whereis(coordinator_serv_SIMPLE) ! {self(), Msg, ActorTo},
	hd(read()).

read() -> 
	whereis(coordinator_serv_SIMPLE) ! {read, self()},
	receive
		{read_reply, State} -> State
	end.


