-module(concurrency).
-export([two_procs/2, loop/0, n_procs_in_ring/3, loop_two/1]).

two_procs(Msg, Count) when is_integer(Count) ->
    Pid2 = spawn(concurrency, loop, []),
    io:format("Pid ~w spawned!~n", [Pid2]),
    Pid3 = spawn(concurrency, loop, []),
    io:format("Pid ~w spawned!~n", [Pid3]),
    Pid2 ! {Pid3, Msg, Count, 0}.

n_procs_in_ring(NumProcs, NumMsgs, Msg) when is_integer(NumProcs),
        is_integer(NumMsgs) ->

    Pid2 = spawn(concurrency, loop_two, [[]]),
    ring(NumProcs, NumMsgs, Msg, 1, Pid2, Pid2). 


ring(NumProcs, NumMsgs, Msg, Procs, Last, Orig) when Procs < NumProcs ->
    Pid = spawn(concurrency, loop_two, [[]]),
    Last ! {Pid, Orig},
    ring(NumProcs, NumMsgs, Msg, Procs + 1, Pid, Orig);

ring(_, NumMsgs, Msg, _, Last, Orig) ->
    Last ! {Orig, Orig},
    Orig ! {Msg, NumMsgs, 0}.

loop_two([]) ->
    receive
        {NextPid, OrigPid} ->
            loop_two([NextPid, OrigPid])
    end;

loop_two([NextPid, Orig]) ->
    receive
        {Msg, NumMsgs, Count} when self() == Orig, NumMsgs > Count ->
            io:format("Pid: ~w :: Message: ~s :: NumMsgs: ~w :: Count: ~w~n",
                [self(), Msg, NumMsgs, Count + 1]),
            NextPid ! {Msg, NumMsgs, Count + 1},
            loop_two([NextPid, Orig]);

        {_, _, _} when self() == Orig ->
            NextPid ! stop,
            loop_two([NextPid, Orig]);

        {Msg, NumMsgs, Count} ->
            io:format("Pid: ~w :: Message: ~s :: NumMsgs: ~w :: Count: ~w~n",
                [self(), Msg, NumMsgs, Count]),
            NextPid ! {Msg, NumMsgs, Count},
            loop_two([NextPid, Orig]);

        stop when self() == Orig ->
            true;

        stop ->
            NextPid ! stop,
            true
    end.

loop() ->
    receive
        {From, Msg, Count, Sent} when Sent < Count ->
            io:format("Pid: ~w :: Message: ~s :: Count: ~w :: Sent: ~w~n",
                [From, Msg, Count, Sent + 1]),
            From ! {self(), Msg, Count, Sent + 1},
            loop();
        {From, _, _, _} ->
            From ! stop,
            true;
        stop ->
            true
    end.
