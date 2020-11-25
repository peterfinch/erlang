-module(area_server1).
-export([loop/0, rpc/2]).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
	Response ->
	    Response
    end.

loop() ->
    receive
	{From, rectangle, Width, Ht} ->
	    From ! io:format("Area of rectangle is ~p~n", [Width * Ht]),
	    loop();
	{From, square, Side} ->
	    From ! io:format("Area of square is ~p~n", [Side * Side]),
	    loop();
    {_} ->
		io:format("Try again"),
	    loop()
    end.