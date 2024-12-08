:- consult('../src/zipper.pl').

?-
    L = [1, 2, 3, 4, 5],
    from_list(L, Zsh0),

    current(Zsh0, 1),
    move_right(Zsh0, Zsh1),
    current(Zsh1, 2),
    move_right(Zsh1, Zsh2),
    current(Zsh2, 3),
    move_right(Zsh2, Zsh3),
    current(Zsh3, 4),
    move_right(Zsh3, Zsh4),
    current(Zsh4, 5),

    move_left(Zsh4, Zsh3),
    move_left(Zsh3, Zsh2),
    move_left(Zsh2, Zsh1),
    move_left(Zsh1, Zsh0),

    to_list(Zsh0, L),
    to_list(Zsh1, L),
    to_list(Zsh2, L),
    to_list(Zsh3, L),
    to_list(Zsh4, L),

    set_current(Zsh2, -1, ModZ),
    to_list(ModZ, [1, 2, -1, 4, 5]).

testMatrixZippers([Z1, Z2, Z3], M) :-
    to_matrix(zipper([], [Z1, Z2, Z3]), M),
    to_matrix(zipper([Z1], [Z2, Z3]), M),
    to_matrix(zipper([Z2, Z1], [Z3]), M),
    to_matrix(zipper([Z3, Z2, Z1], []), M).

?-
    from_list([1, 2, 3], Z1),
    from_list([4, 5, 6], Z2),
    from_list([7, 8, 9], Z3),

    M = [[1, 2, 3],
         [4, 5, 6],
         [7, 8, 9]],
    from_matrix(M, zipper([], [Z1, Z2, Z3])),

    Z2sh0 = Z2,
    move_right(Z2sh0, Z2sh1),
    move_right(Z2sh1, Z2sh2),
    move_right(Z2sh2, Z2sh3),

    testMatrixZippers([Z1, Z2sh0, Z3], M),
    testMatrixZippers([Z1, Z2sh1, Z3], M),
    testMatrixZippers([Z1, Z2sh2, Z3], M),
    testMatrixZippers([Z1, Z2sh3, Z3], M).

?-
    L = [1, 2, 3, 4, 5],
    from_list(L, Zsh0),

    current(Zsh0, 1),
    move_right(Zsh0, Zsh1),
    current(Zsh1, 2),
    move_right(Zsh1, Zsh2),
    current(Zsh2, 3),
    move_right(Zsh2, Zsh3),
    current(Zsh3, 4),
    move_right(Zsh3, Zsh4),
    current(Zsh4, 5),

    shift_abs(1, Zsh0, Zsh1),
    shift_abs(1, Zsh1, Zsh1),
    shift_abs(1, Zsh2, Zsh1),
    shift_abs(1, Zsh3, Zsh1),
    shift_abs(1, Zsh4, Zsh1),

    shift_abs(2, Zsh0, Zsh2),
    shift_abs(2, Zsh1, Zsh2),
    shift_abs(2, Zsh2, Zsh2),
    shift_abs(2, Zsh3, Zsh2),
    shift_abs(2, Zsh4, Zsh2),

    shift_abs(3, Zsh0, Zsh3),
    shift_abs(3, Zsh1, Zsh3),
    shift_abs(3, Zsh2, Zsh3),
    shift_abs(3, Zsh3, Zsh3),
    shift_abs(3, Zsh4, Zsh3),

    shift_abs(4, Zsh0, Zsh4),
    shift_abs(4, Zsh1, Zsh4),
    shift_abs(4, Zsh2, Zsh4),
    shift_abs(4, Zsh3, Zsh4),
    shift_abs(4, Zsh4, Zsh4).
