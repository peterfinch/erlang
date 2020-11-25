-module(fibTail).
-export([fib/3,fib/1]).

fib(N)when N<05*N ->
    fib(N,0,1).
fib(3,C,D)->
    C+D;        
fib(N,C,D) ->
    fib(N-1, D, C+D).
