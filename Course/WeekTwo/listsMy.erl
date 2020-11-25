-module(listsMy).
-export([maxL/2,product/2]).

maxL([],M) -> M;
maxL([H|T],M)-> maxL(T, max(H,M)).  

    
product([],P) -> P;
product([H|T],P) -> product(T, H*[]).
 
    
