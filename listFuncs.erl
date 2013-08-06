-module(listFuncs).
-export([average/1, double/1, member/2]).

average(X) when is_number(X) -> X;
average(X) when is_list(X) -> sum(X) / len(X).

sum([H|T]) when is_number(H) -> H + sum(T);
sum([]) -> 0.

len([_|T]) -> 1 + len(T);
len([]) -> 0.

double([H|T]) when is_number(H) -> [2*H|double(T)];
double([]) -> [].

member(H, [H|_]) -> true;
member(H, [_|T]) -> member(H, T);
member(_, []) -> false.
