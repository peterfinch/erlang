-module(product).
-export([product/1]).

product(L)->
    productC(L,1).
    
productC([],P)->
    P;
productC([H|T],P) ->
    productC(T, P*H).
    
    
