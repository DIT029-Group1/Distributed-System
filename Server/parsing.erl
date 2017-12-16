%%%-------------------------------------------------------------------
%%% @author muratkan
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2017 13:14
%%%-------------------------------------------------------------------
-module(parsing).
-author("muratkan").

%% API
-export([parseJson/2]).

parseJson(Port, JsonFile) ->
  % opening and decoding json file
  {ok, File} = file:open(JsonFile,[read]),
  {ok, Txt} = file:read(File,1024 * 1024),
  JsonObj = jiffy:decode(Txt),
  [{Seq}|_] = JsonObj,
  {Diagram} = proplists:get_value(<<"diagram">>, Seq),
  Node = proplists:get_value(<<"content">>, Diagram),
  [{H}|[{T}|_]] = Node,

  % according to json we got, we have always 2 diagrams in it
  FirstDiagram = proplists:get_value(<<"content">>, H),
  SecondDiagram = proplists:get_value(<<"content">>, T),

  % since nodejs server is restarted we don't need spawn this!
  {ok, S} = gen_tcp:connect("localhost", Port, [binary, {packet, 0}]),

  OriginalDiagram = messages(FirstDiagram, <<"">>),
  ParDiagram = messages(SecondDiagram, <<"par, ">>),
  send(merge(OriginalDiagram, ParDiagram),S),
  % stopping smulation after all msgs are sent
  os:cmd("taskkill /T /F /IM cmd.exe /IM node.exe"), ok.

% parsing json to get messages, and parallel flags as "par"
messages([], _P) -> [];
messages([{X}|Xs], P) ->
  From = [P, proplists:get_value(<<"from">>, X), <<", ">>],
  To = [proplists:get_value(<<"to">>, X),  <<", ">>],
  Msg = proplists:get_value(<<"message">>, X),
  [[From, To, parseMsg(Msg)]| messages(Xs, P)].

parseMsg([]) -> [];
parseMsg([H|T]) -> [[H, <<", ">>]| parseMsg(T)].

% merging lists
merge(L1, []) -> L1;
merge([X|Xs], [Y|Ys]) ->
  [[X],[Y] | merge(Xs, Ys)].

% sending one message from original and one message from parallell
% with a delay
send([], _S) -> ok;
send([H|T], S) ->

  if
  % checking if 2. element has <<"par, ">> binary
    hd(hd(hd(hd(T)))) =:= <<"par, ">> ->
      gen_tcp:send(S, H),
      timer:sleep(100),
      gen_tcp:send(S, hd(T)),
      timer:sleep(1500),
      send(tl(T),S);
    true ->
      gen_tcp:send(S, H),
      timer:sleep(1500),
      send(T,S)
  end.
