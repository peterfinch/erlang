-module(double).
-export([double/1,evens/1,median/1,first/2,palindrome/1,join/1]).


%%nub([])->
%%    [];
%%nub([H|T]) ->
%%     [H | nub(T)].

palindrome(S)->
    S == reverse(S,[]).

reverse([],L) ->
    L;
reverse([H|T],L)->
    reverse(T, [H|L]).


join(L)->
    joinUp(L,"").

joinUp([],S)->
    S;
joinUp([H|T], S) ->
    joinUp(T, S ++ H).
    
    


first(_L,0) ->
    [];
first(L,N)->
    firstN(L,[],N,1).

firstN([],NL,X,X) ->
    %%io:format("~p ~p ~p ~n",[[],X,X]),
    NL;
firstN([H|T],NL,N,C) when C=<N ->
    %%io:format("~p ~p ~p ~n",[H,N,C]),
    firstN(T,[H|NL],N,C+1).



double([])->
    [];
double([H|T])->
    [H*2 | double(T)].

evens([])->
    [];
evens([H|T]) ->
    case H rem 2 of
        0 -> [H|evens(T)];
        _ -> evens(T)
    end.

median([])->
    [];
median(L) ->
     middle(lists:sort(L)).

middle(L) ->
    N = length(L),
    Floored =  lists:nth(floor(N/2),L),
    Rounded =  lists:nth(round(N/2),L),
    io:format("~p ~p ~p ~n", [Floored, Rounded, L]),
    case N rem 2 of
        0 ->  (Floored + Rounded) /2;
	_ ->  Rounded
     end.



		  
		  
 	    

    
    

    

    
    
