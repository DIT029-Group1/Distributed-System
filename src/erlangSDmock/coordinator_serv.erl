-module(coordinator_serv).
-behaviour(gen_serv).
%% Don't forget to add all functions later!
-export([start/3, start_link/3, run/2, stop/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
		 code_change/3, terminate/2]).

-define(SPEC(MFA),
		{worker_sup,
		{node_sup, start_link, [MFA]},
		permanent,
		10000,
		supervisor,
		[node_sup]}).

%% Keep track of the pid of the supervisor (sup),
%% each worker (actor) from the server with monitors (refs)
%% and all the messages sent kept in a list of tuples of
%% the format {ActorFrom, ActorTo, Msg}.
-record(state, {sup, refs, msgLog=[]}).

start(Name, Sup, MFA) when is_atom(Name) ->
	gen_server:start({local, Name}, ?MODULE, {MFA, Sup}, []).

start_link(Name, Sup, MFA) when is_atom(Name) ->
	gen_server:start({local, Name}, ?MODULE, {MFA, Sup}, []).

run(Name, Args) ->
	gen_server:call(Name, {run, Args}).

stop(Name) ->
	gen_server:call(Name, stop).

init({MFA, Sup}) ->
	self() ! {star_worker_supervisor, Sup, MFA},
	{ok, #state{limit=Limit, refs=gb_sets:empty()}}.

handle_info({start_worker_supervisor, Sup, MFA}, S = #state{}) ->
	{ok, Pid} = supervisor:start_child(Sup, ?SPEC(MFA)),
	{noreply, S#state{sup=Pid}};
handle_info(SomeMsg, State) ->
	io:format("Unkown message: ~p~n", [SomeMsg]),
	{noreply, State}.

handle_call({run, Args}, _From, S=#state{sup=Sup, refs=R}),
	{ok, Pid} = supervisor:start_child(Sup, Args),
	Ref = erlang:monitor(process, Pid),
	{reply, {ok, Pid}, S#state{refs=gb_sets:add(Ref, R)}};

%% TODO
%% Add handle calls for sync operations

handle_call(stop, _From, State) ->
	{stop, normal, ok, State};
handle_call(_Msg, _From, State) ->
	{noreply, State}.

handle_cast(_Msg, State) -> 
	{noreply, State}.

code_change(_OldVsn, State, _Extra) ->
{ok, State}.

terminate(_Reason, _State) ->
ok.
%% Functions for sending messages and logging states