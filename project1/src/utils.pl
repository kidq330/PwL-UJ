% compose(+N, +Fun, +In, -Out)
compose(0, _Fun, In, In).
compose(N, Fun, In, Out) :-
    N > 0, NMinus1 is N-1,
    call(Fun, In, FunAppliedOnce),
    compose(NMinus1, Fun, FunAppliedOnce, Out).

% iota(+Start, +End, -Ret)
iota(Start, End, []) :- Start > End.
iota(Start, StartPlus1, [Start]) :-
    StartPlus1 is Start + 1.

iota(Start, End, Ret) :-
    End - Start > 1,
    StartPlus1 is Start + 1,
    iota(StartPlus1, End, Tail),
    Ret = [Start | Tail].

% take(+List, +ToTake, -Prefix, -Suffix)
take(List, 0, [], List).
take([], ToTake, [], []) :- ToTake > 0.
take([Head | Tail], ToTake, Prefix, Suffix) :-
    ToTake > 0,
    ToTakeMinus1 is ToTake - 1,
    take(Tail, ToTakeMinus1, PrefixWithoutHead, Suffix),
    Prefix = [Head | PrefixWithoutHead].