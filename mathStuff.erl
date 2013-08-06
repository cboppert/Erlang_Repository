% Author: Cody Boppert
% Following Erlang Crash Course at: http://www.erlang.org/course/
% Specifically, sequential programming: 
% http://www.erlang.org/course/sequential_programming.html

-module(mathStuff).
-export([factorial/1, area/1, perimeter/1]).

factorial(0) -> 1;
factorial(N) when N > 0, is_integer(N) -> N * factorial(N-1).

area({square, Side}) ->
    Side * Side;
area({circle, Radius}) ->
    % Approximately
    3.14 * Radius * Radius;
area({triangle, A, B, C}) ->
    S = (A + B + C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area(Other) ->
    {invalid_object, Other}.

perimeter({square, Side}) when is_number(Side) ->
    Side * 4;
perimeter({circle, Radius}) when is_number(Radius) ->
    % Approximately
    2 * 3.14 * Radius;
perimeter({triangle, A, B, C}) when is_number(A), is_number(B), is_number(C) ->
    A + B + C;
perimeter(Other) ->
    {invalid_object, Other}.
