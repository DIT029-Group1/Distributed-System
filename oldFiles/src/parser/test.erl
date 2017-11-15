-module(test).
-export([start/0]).

start() -> 
	{ok, File} = file:open("data.json",[read]),
    {ok, Txt} = file:read(File,1024 * 1024),
    jiffy:decode(Txt).