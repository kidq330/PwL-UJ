% slightly modified version of
% https://gist.github.com/lnicola/32746197086ab7d21c72

:- consult([utils]).

empty(zipper([], [])).

singleton(X, zipper([X], [])).

from_list(L, zipper([], L)).

to_list(zipper(Ls, Rs), Ret) :-
    reverse(Ls, RevLs),
    append([RevLs, Rs], Ret).

move_left(zipper([X | Ls], Rs), zipper(Ls, [X | Rs])).
move_right(zipper(Ls, [X | Rs]), zipper([X | Ls], Rs)).

shift_left(N, Z, RetZ) :- compose(N, move_left, Z, RetZ).
shift_right(N, Z, RetZ) :- compose(N, move_right, Z, RetZ).

can_move_left(Z) :- move_left(Z, _).
can_move_right(Z) :- move_right(Z, _).

current(zipper(_, [R | _]), R).
set_current(zipper(Ls, [_ | Rs]), Y, zipper(Ls, [Y | Rs])).

% custom
from_matrix(M, RetZ) :-
    maplist(from_list, M, MofZ),
    from_list(MofZ, RetZ).

to_matrix(zipper(LsZ, RsZ), RetM) :-
    maplist(to_list, LsZ, Ls),
    maplist(to_list, RsZ, Rs),
    reverse(Ls, RevLs),
    append([RevLs, Rs], RetM).

shift_abs(K, Z, RetZ) :-
    K >= 0,
    Z = zipper(Ls, _),
    length(Ls, Len),
    (
        Len > K,
        ShiftAmount is Len - K,
        shift_left(ShiftAmount, Z, RetZ);

        ShiftAmount is K - Len,
        shift_right(ShiftAmount, Z, RetZ)
    ).

align(zipper(Ls, _), ToAlignZ, AlignedZ) :-
    length(Ls, Len),
    shift_abs(Len, ToAlignZ, AlignedZ).
