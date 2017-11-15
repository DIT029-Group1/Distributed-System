%%%-------------------------------------------------------------------
%%% @author muratkan
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2017 13:13
%%%-------------------------------------------------------------------
-module(tcp_listen_start).
-author("muratkan").

%% API
-export([tcp_listen_start/0]).

tcp_listen_start() ->
  osCMD:start(),
  Pid = spawn_link(fun() ->
    {ok, LS} = gen_tcp:listen(8081, [{active, true}, binary]),
    spawn(fun() -> acceptState(LS) end),
    timer:sleep(infinity) end),
  {ok, Pid}.

acceptState(LS) ->
  {ok, AS} = gen_tcp:accept(LS),
  spawn(fun() -> acceptState(LS) end),
  handler(AS).

handler(AS) ->
  inet:setopts(AS, [{active, once}]),
  receive
    {tcp, AS, <<"start,", Bin/binary>>} ->
      [Port, Path, JsFile, JsonFile] = binary:split(Bin, <<",">>, [global]),
      osCMD:startNodejs(binary_to_list(Path), binary_to_list(JsFile)),
      timer:sleep(500),
      parsing:parseJson(list_to_integer(binary_to_list(Port)), binary_to_list(Path) ++ binary_to_list(JsonFile)),
      handler(AS)
  end.