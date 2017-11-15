-module(coordinator_OTP).
-behaviour(gen_server).

%%  Server API
-export([start_link/0, stop/0]).

%% Client API
-export([start_actor/0, send_msg/3, read/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
		code_change/3, terminate/2]).

-define(COORDINATOR, sd_simulator).

%% Record for keeping track of the server state.
-record(state, {actors = [],
				numActors = 0,
				sequence = []}).

%%% SERVER API

%% Must use gen_server:start_link in order to be part of supervision tree.
start_link() ->
	Result = gen_server:start_link({local, ?COORDINATOR}, ?MODULE, [], []),
	io:format("Coordinator server has been started~n"),
	Result.

stop() ->
	gen_server:cast(?COORDINATOR, shutdown).

%%% CLIENT API
read() ->
	gen_server:call(?COORDINATOR, read).

%% CHANGE TO CALL: ActorFrom and ActorTo are stored as "ok" instead as their pids.
start_actor() ->
	gen_server:call(?COORDINATOR, start_actor).

send_msg(ActorFrom, Msg, ActorTo) ->
	gen_server:call(?COORDINATOR, {send_msg, ActorFrom, Msg, ActorTo}).

%%% gen_server CALLBACKS
init([]) ->
	{ok, #state{}}.

handle_call(read, _From, State = #state{sequence=Seq}) ->
	{reply, Seq, State};

handle_call({send_msg, ActorFrom, Msg, ActorTo}, _From, State = #state{sequence=Seq}) ->
	{reply, {ActorFrom, Msg, ActorTo}, State#state{sequence=[{ActorFrom, Msg, ActorTo}|Seq]}};

handle_call(start_actor, _From, State = #state{actors = Actors, numActors = N}) ->
%	{ok, Pid} = supervisor:start_child() ??
	Pid = spawn(fun() -> io:format("Actor ~p has been spawned.~n", [self()]) end),
	NewState = State#state{actors=[Pid|Actors], numActors=N+1},
	{reply, Pid, NewState};

handle_call(_Action, _From, State) ->
	io:format("Unexpected action: ~p~n", [_Action]),
	{noreply, State}.

handle_cast(_Action, State) ->
	io:format("Unexpected action: ~p~n", [_Action]),
	{noreply, State}.


handle_info(_Action, State) ->
	io:format("Unexpected action: ~p~n", [_Action]),
	{noreply, State}.

%% Doe nothing, needed for gen_server.
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

terminate(_Reason, State) ->
	{ok, State}.