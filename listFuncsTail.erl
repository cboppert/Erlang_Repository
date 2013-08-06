-module(listFuncsTail).
-export([sum/1, len/1, average/1]).

sum(X) when is_number(X) -> X;
sum(X) when is_list(X) -> sum(X, 0).

sum([H|T], Sum) -> sum(T, Sum + H);
sum([], Sum) -> Sum.

len(X) when is_list(X) -> len(X, 0);
len(_) -> 1.

len([_|T], Length) -> len(T, Length + 1);
len([], Length) -> Length.

average(X) when is_number(X) -> X;
average(X) when is_list(X) -> average(X, 0, 0).

average([H|T], Sum, Length) when is_number(H) ->
    average(T, Sum + H, Length + 1);
average([], Sum, Length) ->
    Sum / Length.
