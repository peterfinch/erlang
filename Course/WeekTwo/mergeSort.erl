-module(mergeSort).
-export([mergeSort/1]).

mergeSort([])->
    [];
mergeSort(L)->
    {L1,L2} = lists:split(round(length(L)/2),L),
    sort([],L1,L2).

sort(X,[],R)-> concat([R,X]);
sort([],Y,R)-> concat([R,Y]);
sort(L,[X|Xs]=Left,[Y|Ys]=Right)->
    case X > Y  of
        true ->  sort(concat([L,[Y]]),Ys,Left);
	false -> sort(concat([L,[X]]),Xs,Right)		 
    end.

  
join(L1, L2) when is_list(L1) andalso is_list(L2) ->
  L1 ++ L2.

concat([]) -> [];
concat([H|T]) when is_list(H) andalso is_list(T) ->
  join(H, concat(T)).

    
    
    
