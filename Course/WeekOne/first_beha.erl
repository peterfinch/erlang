-module(first_beha).
-export([double/1,mult/2,area/3,treble/1,square/1,maxThree/3,howManyEqual/3,testHowManyEqual/0,fib/1,testFib/0,pieces/1,sum/1,fib/3]).
-behaviour(gen_server).
-import(lists, [seq/2]).

mult(X, Y) ->
    X*Y.

double(X) ->
    mult(2,X).

treble(X) ->
    mult(3,X).

area(A,B,C) ->
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).
square(X) ->
    X*X.

maxThree(X,Y,Z) ->
    max(max(X,Y),Z).

howManyEqual(_X,_X,_X) ->
    3;
howManyEqual(_X,_Y,_Y) ->
    2;
howManyEqual(_Y,_Y,_X) ->
    2;
howManyEqual(_X,_Y,_X) ->
    2;
howManyEqual(_,_,_) ->
    0.

testHowManyEqual()->
    true = ((howManyEqual(1,2,3) == 0)),
    true = ((howManyEqual(1,1,0) == 2)),
    true = ((howManyEqual(1,0,1) == 2)),
    true = ((howManyEqual(0,1,1) == 2)),
    true = ((howManyEqual(1,1,1) == 3)),
    ok.


fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N-1)+fib(N-2).  

% fib(4) 
% = fib(3) + fib(2)
% = ((fib(2) + fib(1)) + (fib(1) + fib(0))
% = ((fib(1) + fib(0) + 1) + (1 + 0)
% = ((1 + 0) + 1) + 1
% = 3


testFib()->
    5 = fib(5),
    8 = fib(6),
    ok.

pieces(0)->
   1;
pieces(N)->
   N + (pieces(N-1)).

%% pieces(4)
%% 4 + (pieces(3))
%% 4 + (3 + pieces(2))
%% 4 + (3 + (2 + pieces(1)))
%% 4 + (3 + (2 + (1 + pieces(0))))
%% 4 + (3 + (2 + (1 + 1))))
%% 4 + (3 + (2 + 2))
%% 4 + (3 + 4)
%% 4 + 7
%% 11

sum(0) ->
    0;
sum(1) ->
    1;
sum(N) ->
    N+sum(N-1).

%% sum(4)
%% 4 + sum(3)
%% 4 + (3 + sum(2))
%% 4 + (3 + (2 + sum(1)))
%% 4 + (3 + (2 + 1))
%% 4 + (3 + 3)
%% 4 + 6
%% 10



fib(N,C,D) when D>0 ->
    io:format("~p ~p ~p ~n", [N,C,D]),
    fib(N-1, C+D, N-2).
    
    






    
    
    
