-module(index2).
-export([index/1]).

%main entry point
index(Name)->
    index(get_file_contents(Name), getWords(Name), []).
index(List, [H|T], Acc) ->
    index(List, T, [get_lines(List, H)|Acc]);
index(_List, [], Acc) ->
    S = sets:from_list(Acc),
    sets:to_list(S).

%Gets a distinct list of words in a list that we can work with
getWords(Name) ->
     getWords(get_file_contents(Name),[]).
getWords([H|T], ACC)->
    getWords(T, [string:strip(string:tokens(H, " "))|ACC]);
getWords([],ACC) ->
    S= sets:from_list(lists:merge(ACC)),
    sets:to_list(S).

% This is were the work is done for getting the occurances
% of the words in question
% Have only been able to show the lines on which the words occur
% not been able to return the occurance range as requested :(
get_lines(List, Word)->
    get_lines(List, Word, [], 1).

get_lines([X|Xs], Word, Occ, Line) ->
    S = string:str(X, Word),
    case S of
        0 -> get_lines(Xs, Word, Occ, Line+1);
        _ -> get_lines(Xs, Word, [Line|Occ], Line+1)
    end;  
get_lines([], WORD, Occ, _Line) ->
    {WORD, lists:reverse(Occ)}.

%Helper
get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
    lists:reverse(Rev).

%Helper
get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                %io:format("~p~n", [Strip]),
                get_all_lines(File,[Strip|Partial])
    end.



