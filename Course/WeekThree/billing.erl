-module(billing).
-export([data/0,findItem/1, getItems/1, print_lines/1, filler/3,price_string/1,print_header/0,print_all/1]).


data()->
    [{4719, "Fish Fingers" , 121},
    {5643, "Nappies" , 1010},
    {3814, "Orange Jelly", 56},
    {1111, "Hula Hoops", 21},
    {1112, "Hula Hoops (Giant)", 133},
    {1234, "Dry Sherry, 1lt", 540}].


findItem(Id)->
    findItem(Id, data()).
findItem(_,[]) ->
    {not_found};
findItem(Id, [{I,_,_}|T]) when Id =/= I ->
    findItem(Id, T);
findItem(Id, [{I,Name,Price}|_]) when Id == I ->
    {I,Name,Price/100}.  


getItems(L)-> 
    getItems(L,[]).
getItems([],L)     -> 
    L;
getItems([H|T], L) ->
    getItems(T, [findItem(H)|L]).


print_header()->
    "\n          Erlang Shop            \n" .   


print_lines_([{not_found}|T], Accu, Total)   -> 
    print_lines_(T, Accu, Total);
print_lines_([{_,Name,Price}|T], Accu, Total) ->
    Line = filler(Name, price_string(Price),[]),
    print_lines_(T, [Line|Accu], Total + Price);
print_lines_([], Accu, Price)-> {Accu,Price}.


print_lines(L)->
    print_lines_(getItems(L), [], 0).


filler(Title,Price,Filler)  when length(Title) + length(Price) + length(Filler) < 35 ->
    filler(Title,Price, "." ++ Filler); 
filler(Title,Price,Filler)->
    Title ++ Filler ++ Price.


price_string(Price)->
      io_lib:format("~.2f", [Price]).


print_all(Items)->
    {Lines, Total} = print_lines(Items),
    print_out(lists:append([print_header() | Lines] , [print_total(Total)])).


print_total(Total) ->
     filler("\nTotal", price_string(Total), []).


print_out([H|T]) ->
    io:format("~s~n", [H]),
    print_out(T);
print_out([]) ->  io:format("~s~n", [""]).
