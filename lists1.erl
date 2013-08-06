-module(lists1).
-export([min/1, max/1, min_max/1]).

min(X) when is_number(X) -> X;
min(X) when is_list(X) -> min(X, x).

min([H|T], x) when is_number(H) -> min(T, H);
min([H|T], Min) when is_number(H), H < Min -> min(T, H);
min([H|T], Min) when is_number(H) -> min(T, Min);
min([], Min) -> Min.

max(X) when is_number(X) -> X;
max(X) when is_list(X) -> max(X, x).

max([H|T], x) when is_number(H) -> max(T, H);
max([H|T], Max) when is_number(H), H > Max -> max(T, H);
max([H|T], Max) when is_number(H) -> max(T, Max);
max([], Max) -> Max.

min_max(X) when is_list(X) -> min_max(X, x, x).

min_max([H|T], x, x) when is_number(H) -> min_max(T, H, H);
min_max([H|T], Min, Max) when is_number(H), H > Max -> min_max(T, Min, H);
min_max([H|T], Min, Max) when is_number(H), H < Min -> min_max(T, H, Max);
min_max([_|T], Min, Max) -> min_max(T, Min, Max);
min_max([], Min, Max) -> {Min, Max}.
