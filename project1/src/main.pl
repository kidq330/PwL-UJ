:- consult([puzzle, zipper]).

% createBoard(+N, -B) 
createBoard(N, RetBoard) :- createBoard(N, 1, RetBoard).

% createBoardFromList(+N, +L, -B) 
createBoardFromList(N, List, RetBoard) :-
    NSquared is N*N,
    length(List, NSquared),
    createBoardFromListUtil(List, N, RetBoard).

% movePiece(+N, +Bin, +Row, +Col, -Bout)
movePiece(_N, BoardIn, RowIdx, ColIdx, BoardOut) :-
    from_matrix(BoardIn, InitOuterZ),
    % move_right RowIdx spaces
    shift_right(RowIdx, InitOuterZ, OuterZ),
    current(OuterZ, InitInnerZ),

    % move_right ColIdx spaces
    shift_right(ColIdx, InitInnerZ, InnerZ),
    current(InnerZ, Elem),

    movePieceUtil(OuterZ, InnerZ, Elem, ColIdx, ModifiedOZ),
    to_matrix(ModifiedOZ, BoardOut).

% moveBlankHoriz(+N, +Bin, +Count, -Bout)
moveBlankHoriz(_N, BoardIn, 0, BoardIn).
moveBlankHoriz(_N, BoardIn, K, BoardOut) :-
    K \= 0,
    from_matrix(BoardIn, InitOZ),
    findZero(InitOZ, ZeroOZ),
    current(ZeroOZ, InnerZ),
    (
        K < 0, TransposePred = transposeLeft;
        K > 0, TransposePred = transposeRight
    ),
    AbsK is abs(K),
    compose(AbsK, TransposePred, InnerZ, ModIZ),
    set_current(ZeroOZ, ModIZ, ModOZ),
    to_matrix(ModOZ, BoardOut).

% moveBlankVert(+N, +Bin, +Count, -Bout)
moveBlankVert(_N, BoardIn, 0, BoardIn).
moveBlankVert(_N, BoardIn, K, BoardOut) :-
    K \= 0,
    from_matrix(BoardIn, InitOZ),
    findZero(InitOZ, ZeroOZ),
    (
        K < 0, TransposePred = transposeUp;
        K > 0, TransposePred = transposeDown
    ),
    AbsK is abs(K),
    compose(AbsK, TransposePred, ZeroOZ, ModOZ),
    to_matrix(ModOZ, BoardOut).

    