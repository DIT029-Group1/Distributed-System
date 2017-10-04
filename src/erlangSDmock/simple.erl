-module(simple).
%-behaviour(gen_server).
-export([start/0, stop/0, read/0, sendMsg/3, start_actor/1, stop_actor/1]).

%% Starts the coordinator server process.
start() ->
	case whereis(coordinator) of
		undefined ->
			CoordinatorPid = spawn(fun() ->
								io:format("The coordinator server is running!~n"),
								init()
							end),
			register(coordinator, CoordinatorPid),
			{ok, CoordinatorPid};
		CoordinatorPid -> 
			io:format("Coordinator is already running!~n"),
			{ok, CoordinatorPid}
	end.

%% Stops the coordinator server process.
stop() ->
	case whereis(coordinator) of
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
			ActorTo ! {ActorFrom, Msg, ActorTo},
			io:format("~p~n", [SdState]);
		{read, P} ->
			P ! {read_reply, SdState},
			loop(SdState);
		stop ->
			io:format("Coordinator is shutdown!~n"),
			exit(whereis(coordinator), normal),
			unregister(coordinator);
		_ -> 
			io:format("Illegal action!~n"),
			io:format("~p~n", [SdState]),
			loop(SdState)
	end.

%% Checks if actor has already been spawned, if not spawns it.
%% whereis does not return correct value
start_actor(Name) when is_atom(Name) ->
	case whereis(Name) of
		undefined ->
			ActorPid = spawn(fun() ->
						io:format("~p has been spawned.~n", [Name])
					end),
			%% does not register correctly
			register(Name, ActorPid),
			{ok, ActorPid};
		ActorPid -> 
			io:format("~p has already been spawned.~n", [Name]),
			{ok, ActorPid}
	end;
start_actor(_) ->
	io:format("Invalid actor name!~n").

%% Use unregister/1
stop_actor(Name) when is_atom(Name) ->
	case whereis(Name) of
		undefined ->
			io:format("Actor is not running.~n");
		ActorPid ->
			exit(ActorPid, normal),
			unregister(Name)
	end;
stop_actor(_) ->
	io:format("Invalid actor name!~n").

%% Sends a msg to the coordinator from one actor to another
%% through the coordinator.
sendMsg(ActorFrom, Msg, ActorTo) ->
	whereis(coordinator) ! {ActorFrom, Msg, ActorTo},
	hd(read()).

%% Returns the state of the server.
read() -> 
	whereis(coordinator) ! {read, self()},
	receive
		{read_reply, State} -> State
	end.


