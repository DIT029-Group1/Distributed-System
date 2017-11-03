-module(server).
-export([start/0, send/2]).

start() -> 
	{ok, S} = gen_tcp:connect("localhost", 8080, [binary, {packet, 0}]), 
	send(["u1, fwd, g, msg1", "u3, fwd, g, msg2", "g, fwd, u2, msg1", "g, fwd, u1, msg2"],S).

send([], S) -> gen_tcp:send(S, "u3, mmk, g, status"),
			timer:sleep(1000),
			gen_tcp:send(S, "g, mmk, u3, ok");
send([H|T], S) ->
	gen_tcp:send(S, H),
	timer:sleep(1500),
	send(T,S).
	
