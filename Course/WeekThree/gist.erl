-module(gist).
-export([get_file_contents/1,show_file_contents/1, to_index_list/1, strip/1, nopunc/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
  

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
    {ok, File} = file:open(Name, [read]),
    Rev = get_all_lines(File, []),
    lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File, Partial) ->
    case io:get_line(File, "") of
        eof -> 
            file:close(File),
            Partial;
        Line -> 
            {Strip, _} = lists:split(length(Line)-1, Line),
            get_all_lines(File, [Strip|Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
 show_file_contents([]) ->
    ok.    

% produce an index list where each entry 
% consists of a word and a list of the ranges of lines on which it occurs
to_index_list(Name) ->
    Content = get_file_contents(Name),
    Lines = to_words(Content),
    LineMap = to_linemap(Lines),
    IndexList = lists:foldl(fun({K, V}, Acc) -> [{K, to_range(nub(V))}|Acc] end, [], maps:to_list(LineMap)),
    lists:sort(IndexList).

% transfer result from get_file_contents/1 to a list of lines
% where each line is a list of normalized words
to_words(Lines) ->
    lists:map(fun(Line) -> remove_short_words(nocap(nopunc(strip(Line)))) end, Lines).

% produce a map where key is a word and value is a list of line numbers
% that the word appears
to_linemap(Lines) ->
    to_linemap(Lines, 1, #{}).

to_linemap([], _, Acc) ->
    Acc;
to_linemap([L|Ls], Index, Acc) ->
    NewAcc = lists:foldl(
        fun([], Map) -> Map;
            (Word, Map) -> 
            maps:update_with(Word, fun(V) -> V ++ [Index] end, [Index], Map)      
        end, Acc, L),
    to_linemap(Ls, Index+1, NewAcc).

% remove duplicates in a list
nub(L) ->
    lists:reverse(nub(L, [])).

nub([], Acc) ->
    Acc;
nub([X|Xs], Acc) ->
    case lists:member(X, Acc) of
        true -> nub(Xs, Acc);
        false -> nub(Xs, [X|Acc])
    end.

% transfer a sorted list of numbers to a tuple list where
% each entry represent a range
% e.g. [3,4,5,7,11,12,13] -> [{3,5},{7,7},{11,13}]
to_range([]) -> [];
to_range(L) ->
    lists:reverse(to_range(L, [])).

to_range([], Acc) ->
    Acc;
to_range([H2|T], [{H, H1}|Rest]) when H2== H1 + 1 ->
    to_range(T, [{H, H2}|Rest]);
to_range([H|T], Acc) ->
    to_range(T, [{H, H}|Acc]).

% split a line by space
strip([]) ->
    [];
strip(L) ->
    lists:reverse(strip(L, [], [])).

% trailing space
strip([], [], LAcc) ->
    LAcc;
% last word in a line
strip([], WAcc, LAcc) ->
    [lists:reverse(WAcc)|LAcc];
% encounter a space when last char is also a space
strip([H|T], [], LAcc) when H == 32->
    strip(T, [], LAcc);
% encounter a space when last char is end of a word
strip([H|T], WAcc, LAcc) when H == 32->
    strip(T, [], [lists:reverse(WAcc)|LAcc]);
% encounter a non-space char
strip([H|T], WAcc, LAcc) ->
    strip(T, [H|WAcc], LAcc).

% eliminate all punctuations in a stripped line
nopunc(L) ->
   lists:map(fun remove_punc/1, L).

% remove punctuations in a word
remove_punc(Word) ->
    trim_quotes(lists:filter(fun(Char) -> not lists:member(Char, puncs()) end, Word)).

% remove only leading and tailing quotes
trim_quotes(Word) ->
    lists:reverse(trim_quotes(Word, [])).

trim_quotes([], Acc) ->
    Acc;
trim_quotes([$`], Acc) ->
    Acc;
trim_quotes([$\'], Acc) ->
    Acc;
trim_quotes([$\"], Acc) ->
    Acc;
trim_quotes([$`|T], []) ->
    trim_quotes(T, []);
trim_quotes([$\'|T], []) ->
    trim_quotes(T, []);
trim_quotes([$\"|T], []) ->
    trim_quotes(T, []);
trim_quotes([H|T], Acc) ->
    trim_quotes(T, [H|Acc]).

% produce a list of common punctuations
puncs() ->
    [$,, $;, $., "--", $!, $?, $:, $\\, $(, $)].

% transfer all words to lowercase in a stripped line
nocap(L) ->
    lists:map(fun to_lowercase/1, L).

% transfer a word to its lowercase
to_lowercase([]) -> 
    [];
to_lowercase([Char|T]) when Char >= $A, Char =< $Z -> 
    [Char + 32|to_lowercase(T)];
to_lowercase([Char|T]) ->
    [Char|to_lowercase(T)].

% remove all short words that are of length less than 3
remove_short_words(L) ->
    lists:filter(fun(Word) -> length(Word) >= 3 end, L).
