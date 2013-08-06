-module(demo).
-export([double/1, times/2]).

double(X) -> times(X, 2).

times(X, N) -> X * N.
