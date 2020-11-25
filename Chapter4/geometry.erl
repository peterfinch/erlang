-module(geometry).
-export([area/1, test/0]).

test() -> 
	100 = area({rectangle, 10 , 10}),
	100 = area({square, 10}),
	tests_worked.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14159 * Radius * Radius.