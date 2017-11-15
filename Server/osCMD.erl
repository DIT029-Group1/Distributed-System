%%%-------------------------------------------------------------------
%%% @author muratkan
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Nov 2017 13:12
%%%-------------------------------------------------------------------
-module(osCMD).
-author("muratkan").

%% API
-export([start/0, startNodejs/2]).

start() ->
	case whereis(sts) of
		undefined ->
		Pid = spawn(fun init/0),
			register(sts, Pid),
			{ok, Pid};
		Pid -> {ok, Pid}
	end.
	
init() -> loop().

loop() ->
	receive
		{startNodejs, Path, JsFile, Pid} ->
			Pid ! {startNodejs_reply, ok},
			os:cmd("taskkill /T /F /IM cmd.exe /IM node.exe"), ok,
			os:cmd("start cmd /k \"cd /d " ++ Path ++ " && nodemon " ++ JsFile ++ "\""),
			loop()
	end.
	
% working on this
startNodejs(Path, JsFile) ->
	killNodejs(),
	sts ! {startNodejs, Path, JsFile, self()},
	receive
		{startNodejs_reply, Msg} -> Msg
	end.

% temporary module to kill all os cmd process
% working on this
killNodejs() ->
	os:cmd("taskkill /T /F /IM cmd.exe /IM node.exe"), ok.
	
