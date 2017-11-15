%%%-------------------------------------------------------------------
%%% @author muratkan
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2017 18:04
%%%-------------------------------------------------------------------
-module(simulator_server).
-author("muratkan").

-behaviour(gen_server).

%% API
-export([start_link/0, tcp_listen_start/0, stop/0]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

%%%===================================================================
%%% client callbacks
%%%===================================================================

start_link() ->
  gen_server:start_link({global,?MODULE}, ?MODULE, [], []).

stop() ->
  gen_server:cast({global,?MODULE}, stop).

tcp_listen_start() ->
  gen_server:call({global,?MODULE}, tcp_listen_start).


%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
  process_flag(trap_exit, true),
  io:format("~p (~p) starting .... ~n", [{global, ?MODULE}, self()]),
  {ok, []}.

handle_call(tcp_listen_start, _From, State) ->
  {reply, tcp_listen_start:tcp_listen_start(), State};

handle_call(_Request, _From, State) ->
  {reply, i_don_t_know, State}.

handle_cast(Request, State) ->
  {no_reply, State}.

handle_info(Info, State) ->
  {no_reply, Info, State}.

terminate(_reason, _State) ->
  io:format("Terminating ~p~n", [{global, ?MODULE}]),
  ok.

code_change(OldVersion, State, _Extra) ->
  {ok, State}.