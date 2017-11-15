%%%-------------------------------------------------------------------
%%% @author muratkan
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2017 18:08
%%%-------------------------------------------------------------------
-module(simulator_client).
-author("muratkan").

%% API
-export([tcp_listen_start/0]).

tcp_listen_start() ->
  simulator_server:tcp_listen_start().