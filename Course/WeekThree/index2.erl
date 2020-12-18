-module(index2).
-compile(export_all).

getWords(Name) ->
     getWords(get_file_contents(Name),[]).
getWords([H|T], ACC)->
    getWords(T, [string:strip(string:tokens(H, " "))|ACC]);
getWords([],ACC) ->
    S= sets:from_list(lists:merge(ACC)),
    sets:to_list(S).




doBla(Name)->
    doBla(get_file_contents(Name), getWords(Name), []).
doBla(List, [H|T], Acc) ->
    doBla(List, T, [get_lines(List, H)|Acc]);
doBla(_List, [], Acc) ->
    S = sets:from_list(Acc),
    sets:to_list(S).


get_lines(List, Word)->
    get_lines(List, Word, [], 1).

get_lines([X|Xs], Word, Occ, Line) ->
    S = string:str(X, Word),
    %io:format("~p  ~p ~n",[S, X]),
    case S of
        0 -> get_lines(Xs, Word, Occ, Line+1);
        _ -> get_lines(Xs, Word, [Line|Occ], Line+1)
    end;  
get_lines([], WORD, Occ, _Line) ->
    {WORD, lists:reverse(Occ)}.


get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
    lists:reverse(Rev).

get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                %io:format("~p~n", [Strip]),
                get_all_lines(File,[Strip|Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
    %io:format("~s",[L]),
    show_file_contents(Ls);
 show_file_contents([]) ->
    ok.    
     


