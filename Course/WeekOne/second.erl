-module(second).
-export([hypot/2,perim/2,area/2]).


hypot(X,Y) ->
   math:sqrt(first:square(X) + first:square(Y)).

perim(X,Y) ->
    X+Y+hypot(X,Y).

area(X,Y)->
    0.5*first:mult(X,Y).
