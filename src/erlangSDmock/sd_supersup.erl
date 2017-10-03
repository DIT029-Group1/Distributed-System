-module(sd_supersup).
-behaviour(supervisor).
-export([start_link/0, stop/0, start_pool/3, stop_pool/1]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, sd}, ?MODULE, []). % use global instead of local?