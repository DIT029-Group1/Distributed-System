%%%-------------------------------------------------------------------
%%% @author muratkan
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2017 18:10
%%%-------------------------------------------------------------------
-module(simulator_supervisor).
-author("muratkan").

-behaviour(supervisor).

%% API
-export([start_link/0, start_link_shell/0]).

%% Supervisor callbacks
-export([init/1]).

start_link_shell() ->
  {ok, Pid} = supervisor:start_link({global, ?MODULE}, ?MODULE, []),
  unlink(Pid).

start_link() ->
  supervisor:start_link({global, ?MODULE}, ?MODULE, []).

init([]) ->
  io:format("~p (~p) starting ....", [{global, ?MODULE}, self()]),
  RestartStrategy = one_for_one,
  MaxRestarts = 1000,
  MaxSecondsBetweenRestarts = 3,
  Flags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

  Restart = permanent,
  Shutdown = infinity,
  Type = worker,
  ChildSpecifications = {simulatorServerId, {simulator_server, start_link, []}, Restart, Shutdown, Type, [simulator_server]},

  {ok, {Flags, [ChildSpecifications]}}.
