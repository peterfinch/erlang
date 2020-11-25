-module(maxList).
-export([listMax/1]).



listMax(L) ->
    listMaxxer(L,0).

    
listMaxxer([], M) ->
    M;
listMaxxer([X|Xs], M) when M > X ->
    listMaxxer(Xs, M);
listMaxxer([X|Xs], M) when M < X ->
    listMaxxer(Xs, X).


    
    


    
