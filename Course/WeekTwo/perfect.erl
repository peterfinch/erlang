-module(perfect).
-export([perfect/1]).

perfect(N)->
    perfectN(N,0,1).

%%perfectN(N,N,X) ->
%%    false;
perfectN(N,N,_)->
    true;
perfectN(N,ACC,CURR) when ACC =< N ->
    U = N rem CURR,    
    io:format("N:~p ACC:~p CURR:~p U:~p",[N,ACC,CURR,U]),
    _X = if 
        U == 0  ->
	    io:format(" G MOD:~p ~n",[U]),
            perfectN(N, CURR+ACC, CURR+1);
	    
        U > 0 ->
            io:format(" B MOD:~p ~n",[U]),
            perfectN(N, ACC, CURR+1)
    end.

		 

    
