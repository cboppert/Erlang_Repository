-module(time).
-export([swedish_date/0]).

swedish_date() ->
    Date = date(),
    Year = get_year(integer_to_list(element(1, Date)), 0),
    Month = add_zeros(integer_to_list(element(2, Date))),
    Day = add_zeros(integer_to_list(element(3, Date))),
    Swedish = lists:append([Year, Month, Day]),
    io:format("~s~n", [Swedish]).

get_year([_|T], Count) when Count < 2 ->
    get_year(T, Count + 1);
get_year(X, _) ->
    X.

add_zeros(X) when length(X) < 2 ->
    [integer_to_list(0)|X];
add_zeros(X) ->
    X.
