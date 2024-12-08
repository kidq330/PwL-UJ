:- consult('../src/puzzle.pl').

% findZero
testFindZero(M) :-
    from_matrix(M, Z),
    findZero(Z, ZeroZ),
    current(ZeroZ, IZ),
    current(IZ, 0).

?- testFindZero([[0, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]).
?- testFindZero([[1, 0, 3],
                 [4, 5, 6],
                 [7, 8, 9]]).
?- testFindZero([[1, 2, 0],
                 [4, 5, 6],
                 [7, 8, 9]]).
?- testFindZero([[1, 2, 3],
                 [0, 5, 6],
                 [7, 8, 9]]).
?- testFindZero([[1, 2, 3],
                 [4, 0, 6],
                 [7, 8, 9]]).
?- testFindZero([[1, 2, 3],
                 [4, 5, 0],
                 [7, 8, 9]]).
?- testFindZero([[1, 2, 3],
                 [4, 5, 6],
                 [0, 8, 9]]).
?- testFindZero([[1, 2, 3],
                 [4, 5, 6],
                 [7, 0, 9]]).
?- testFindZero([[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 0]]).
?- \+ testFindZero([[1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9]]).

?- 
    M = [[1],
         [2],
         [3]],
    from_matrix(M, OZ1),
    current(OZ1, IZ1),
    % move_right(IZ1, IZ2),
    set_current(OZ1, IZ1, OZ2),
    transposeDown(OZ2, OZ3),
    transposeDown(OZ3, RetOZ),
    to_matrix(RetOZ, [[2],[3],[1]]).