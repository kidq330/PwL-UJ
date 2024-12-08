:- consult('../src/utils.pl').

% compose
append_x(L, [x | L]).
?- compose(5, append_x, [], [x, x, x, x, x]).

incr(X, Y) :- Y is X+1.
?- compose(100, incr, 0, 100).

% iota
?- iota(10, 20, [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]).
?- iota(10, 11, [10]).
?- iota(10, 12, [10, 11]).
?- iota(20, 10, []).

% take
?- 
    iota(1, 7, L),

    take(L, 0, [], L),
    take(L, 1, [1], [2,3,4,5,6]),
    take(L, 2, [1,2], [3,4,5,6]),
    take(L, 3, [1,2,3], [4,5,6]),
    take(L, 4, [1,2,3,4], [5,6]),
    take(L, 5, [1,2,3,4,5], [6]),
    take(L, 6, [1,2,3,4,5,6], []).