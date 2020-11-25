-module(fibP).
-export([fib/1]).

fibP(0) ->
    io:format("N:0~n"),
    {0,1};
fibP(N) ->
    io:format("N:~p ~n",[N]),
    {P,C} = fibP(N-1),
    io:format("N:~p P:~p C:~p ~n",[N,P,C]),
    {C,P+C}.

fib(N) ->
    {P,_} = fibP(N),
    P.
