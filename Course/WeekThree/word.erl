-module(word).
-export([format/2, testGetLine/2]).


%main entry point
format(Name, Length)-> 
    getLine(getWords(Name), 0, Length, []).

%Gets a distinct list of words in a list that we can work with
getWords(Name) ->
     getWords(get_file_contents(Name),[]).
getWords([H|T], ACC)->
    getWords(T, [string:strip(string:tokens(H, " "))|ACC]);
getWords([],ACC) ->
    S= sets:from_list(lists:merge(ACC)),
    sets:to_list(S).

%Helper
get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    get_all_lines(File,[]).

%Helper
get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                get_all_lines(File,[Strip|Partial])
    end.

getLine([H|T], CURRENT, LENGTH, FORMATTED) when CURRENT < LENGTH  ->
    getLine(T, CURRENT + string:len(H), LENGTH, FORMATTED ++ H ++ " ");
getLine(L, CURRENT, LENGTH, FORMATTED) when CURRENT >= LENGTH ->    
    getLine(L, 0, LENGTH, FORMATTED ++ "\n");
getLine([],_,_,FORMATTED) ->
    FORMATTED.

testGetLine(L, LENGTH)->
    getLine(L,0,LENGTH,[]).

