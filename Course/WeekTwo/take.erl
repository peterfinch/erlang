-module(take).
-export([take/2,takeC/2]).

%my attempt :(
takeL(N,_,L,C) when C >= N ->
    L;
takeL(N,[X|Xs],L,C) when C < N ->
    takeL(N,Xs,[L|X],C+1).

take(0,_Xs)->
    [];
take(_N,[])->
    [];
take(N,L)->
    takeL(N,L,[],0).

%Correct version
takeC(0,_Xs) ->
    [];
takeC(_N,[]) ->
    [];
takeC(N,[X|Xs]) when N>0 ->
    [X|takeC(N-1,Xs)].


    
