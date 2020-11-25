-module(index).
-export([get_file_contents/1,show_file_contents/1,index/1,allWords/1,wordsInLine/1,firstOccuranceLine/3,getLine/2]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
  

index(Name)->
    %firstOccuranceLine( "ghost"   ,allWords(splitLines(get_file_contents_reverse(Name))) , 0   ).
    %allWordsAppended(splitLines(get_file_contents(Name))).
    lists:flatten(get_file_contents(Name)).

splitLines([])->
    [];
splitLines([X|Xs])->
    [{string:tokens(X, [$\s])}|splitLines(Xs)].

allWords([])->    
    [];    
allWords([X|Xs])->
    [wordsInLine(X)|allWords(Xs)].
    
wordsInLine({[]})->  
    [];
wordsInLine({[X|Xs]})->
   [X|wordsInLine({Xs})].


allWordsAppended(L)-> 
    allWordsAppended(L,[]).

allWordsAppended([],N)-> 
    N;
allWordsAppended([X|Xs],N)-> 
    allWordsAppended(Xs, [getLine(X,N)|N]).

getLine({L},N)->
    getStringsInLine(L,N).

getStringsInLine([],N)->
    N;
getStringsInLine([X|Xs],N)->
    getStringsInLine(Xs,[X|N]).
    
    
%allWordsAppended([],L)->
%    L;
%allWordsAppended([X|Xs],L) ->
%   allWordsAppended(Xs, lists:append(L,X)). 

   

firstOccuranceLine(_,[],_) ->
    -1;
firstOccuranceLine(W,[X|Xs],C) ->
    case lists:member(W,X) of
        true  ->
            C;
        false ->
            firstOccuranceLine(W,Xs,C+1)
    end.




% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.
get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
    lists:reverse(Rev).

get_file_contents_reverse(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
    Rev.

% Auxiliary function for get_file_contents.
% Not exported.
get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
	       Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                get_all_lines(File,[Strip|Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.
show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
show_file_contents([]) ->
    ok.    
     

