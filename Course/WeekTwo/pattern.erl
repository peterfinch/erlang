-module(pattern).
-export([neqe/2,notm/2]).

neqe(X,Y) ->
     X =/= Y .

notm(X,Y) ->
    X  .
