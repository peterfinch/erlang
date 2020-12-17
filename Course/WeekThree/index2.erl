-module(index2).
-compile(export_all).

getWords(Name) ->
     getWords(get_file_contents(Name),[]).
getWords([H|T], ACC)->
    getWords(T, [string:tokens(H, " ")|ACC]);
getWords([],ACC) ->
    ACC.

%doSomething(Name) ->
%    doSomething(getWords(Name), []).
%doSomething([X|Xs], ACC)->
%    doSomething(Xs, [processWords(X,[])|ACC]);    
%doSomething([], ACC) ->
%    ACC.
   

%processWords([X|Xs], ACC)->
%    processWords(Xs, [string:concat(X, "hello")|ACC]); 
%processWords([],ACC) ->
%    ACC.
 

%findLineOccurances(Word, Name)->
%    findLineOccurances(Word, getWords(Name),[], 1).



get_lines([X|Xs] , lineNumber, word ) ->
    io:format("~p~n",[isMatch(word, X)]),
    get_lines(Xs, lineNumber + 1, word); 
get_lines([], lineNumber, word) ->
    [].

    

isMatch(W, [W|Xs]) ->
    true;  
isMatch(W,[])->
    false;
isMatch(W, [X|Xs]) ->
   %io:format("~p ~p ~n", [W, X]),
   isMatch(W, Xs).



    
 
get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    get_all_lines(File,[]).
    %lists:reverse(Rev).

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
     


