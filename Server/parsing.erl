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
  {ok, File} = file:open(JsonFile,[read]),
  {ok, Txt} = file:read(File,1024 * 1024),
  {JsonObj}=jiffy:decode(Txt),
  {Diagram} = proplists:get_value(<<"diagram">>, JsonObj),
  Node = proplists:get_value(<<"content">>, Diagram),
  [{H}|[{T}|_]] = Node,

  % according to json we got, we have always 2 diagrams in it
  FirstDiagram = proplists:get_value(<<"content">>, H),
  SecondDiagram = proplists:get_value(<<"content">>, T),

  % since nodejs server is restarted we don't need spawn this!
  {ok, S} = gen_tcp:connect("localhost", Port, [binary, {packet, 0}]),

  OriginalDiagram = messages(FirstDiagram, <<"">>),
  ParDiagram = messages(SecondDiagram, <<"par, ">>),
  send(merge(OriginalDiagram, ParDiagram),S).

% parsing json to get messages, and parallell flags as "par"
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
