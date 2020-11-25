-module(assignment1).
-export([perim/1,enclose/1,bits/1,bitCalc/2]).

%% Sorry for lack of any tests
%% ran out of time and I feel like I  
%% am falling behind
perim({square,S}) ->
    S*4;
perim({rectangle,W,H})->
    2*(W+H);
perim({circle,R})->
    math:pi()*R*R;
perim({triangleSimple,A,B,C})->
    A+B+C;
perim({triangleRightAngle,A,B})->
    A+B+hypot(A,B);
perim({triangleNonRightAngle,{angleA,A},B,C})->
     B+C+sideTriangle(A,B,C).

%%enclose takes a tuple of 
%% square
%% rectangle
%% circle
%% simpleTriangle
enclose({square,S})->
    {rectangle,S,S};
enclose({rectangle,W,H})->
    {rectangle,W,H};
enclose({circle,R}) ->
    {rectangle,2*R,2*R};
enclose({triangleSimple,A,B,C}) ->
    {rectangle,max(A,B,C),mid(A,B,C)};
enclose({triangleRightAngle,A,B})->
    {rectangle,A,B}.

bits(1)->
    1;
bits(N)->
    binary_to_list(integer_to_binary(2,N)).
%% I am just dying here trying to turn an int into
%% a bitstring i.e. 7 = 111 and 8 = 1000
%% I managed to create a function that adds up the
%% numbers in the array
bitCalc([],N)->
    N;
bitCalc([H|T],N) when H==1 ->
    bitCalc(T,N+1);
bitCalc([H|T],N) when H==0 ->
    bitCalc(T,N).


%%Helpers    
 
mid(A,B,C)->
    lists:nth(2,lists:sort([A,B,C])).
   
max(A,B,C)->
    max(max(A,B),C).

sideTriangle(AngleA,B,C)->
   math:sqrt((B*B)+(C*C)-2*B*C*cosine(AngleA)).  

cosine(X)->
    math:cos(X * math:pi() /180).

hypot(X,Y) ->
   math:sqrt((X*X) + (Y*Y)).

	     
