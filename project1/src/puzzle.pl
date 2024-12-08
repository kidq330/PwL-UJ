:- consult([utils, zipper]).

% 1
% createRow(+N, +RowNumber, -RetRow)
createRow(N, N, RetRow) :-
    NSquared is N*N,
    RowStart is NSquared - N + 1,
    iota(RowStart, NSquared, Iota),
    append([Iota, [0]], RetRow).
createRow(N, K, RetRow) :-
    0 < K, K < N,
    RowStart is N*(K-1) + 1,
    RowEnd is N*K + 1,
    iota(RowStart, RowEnd, RetRow).

% createRow(+N, +C, -C'BottomRows)
createBoard(N, N, RetBoardBuilder) :-
    createRow(N, N, LastRow),
    RetBoardBuilder = [LastRow].
createBoard(N, K, RetBoardBuilder) :-
    0 < K, K < N,
    createRow(N, K, CurrentRow),
    KPlusOne is K+1,
    createBoard(N, KPlusOne, BottomRows),
    RetBoardBuilder = [CurrentRow | BottomRows].

% 2
% createBoardFromListUtil(+List, +N, -Board)
createBoardFromListUtil([], _, []).
createBoardFromListUtil(List, N, RetBoardAcc) :-
    List \= [],
    take(List, N, NextRow, Tail),
    createBoardFromListUtil(Tail, N, RetBoardAccTail),
    RetBoardAcc = [NextRow | RetBoardAccTail].

% 3
% movePieceUtil(+OuterZipper, +InnerZipper, +Elem, -ModifiedOuterZipper)
movePieceUtil(OuterZ, InnerZ, Elem, ColIdx, RetOZ) :-
    set_current(InnerZ, 0, ElemOverwrittenIZ),
    set_current(OuterZ, ElemOverwrittenIZ, ElemOverwrittenOZ),
    
    (
        move_left(ElemOverwrittenOZ, MovedOZ);
        move_right(ElemOverwrittenOZ, MovedOZ)
    ),
    current(MovedOZ, EmptySlotRowInitIZ),

    compose(ColIdx, move_right, EmptySlotRowInitIZ, EmptySlotRowIZ),
    
    current(EmptySlotRowIZ, 0),

    set_current(EmptySlotRowIZ, Elem, EmptySlotRowOverwrittenIZ),
    set_current(MovedOZ, EmptySlotRowOverwrittenIZ, RetOZ).

movePieceUtil(OZ, IZ, Elem, _ColIdx, RetOZ) :-
    set_current(IZ, 0, ElemOverwrittenIZ),

    (
        move_left(ElemOverwrittenIZ, MovedIZ);
        move_right(ElemOverwrittenIZ, MovedIZ)
    ),
    current(MovedIZ, 0),
    set_current(MovedIZ, Elem, ModifiedIZ),
    set_current(OZ, ModifiedIZ, RetOZ).

% 4
findZeroHorizontal(IZ, IZ) :- current(IZ, 0).
findZeroHorizontal(IZ, RetIZ) :-
    move_right(IZ, NextIZ),
    findZeroHorizontal(NextIZ, RetIZ).

findZeroVertical(OZ, RetOZ) :-
    current(OZ, IZ),
    (
        findZeroHorizontal(IZ, RetIZ),
        set_current(OZ, RetIZ, RetOZ);

        move_right(OZ, NextOZ),
        findZeroVertical(NextOZ, RetOZ)
    ).

findZero(OZ, RetOZ) :- findZeroVertical(OZ, RetOZ).

transposeHorizontal(MovePred, IZ, RetIZ) :-
    IZ = zipper(_, _),
    current(IZ, E1),
    call(MovePred, IZ, PeekIZ),
    current(PeekIZ, E2),
    set_current(IZ, E2, Mod1IZ),
    call(MovePred, Mod1IZ, ModShiftIZ),
    set_current(ModShiftIZ, E1, RetIZ).

transposeLeft(IZ, RetIZ) :- transposeHorizontal(move_left, IZ, RetIZ).
transposeRight(IZ, RetIZ) :- transposeHorizontal(move_right, IZ, RetIZ).

% 5
transposeVertical(MovePred, OZ, RetOZ) :-
    current(OZ, IZ),
    current(IZ, E1),
    
    call(MovePred, OZ, PeekOZ),
    current(PeekOZ, UnalignedNextIZ),
    align(IZ, UnalignedNextIZ, NextIZ),
    current(NextIZ, E2),

    set_current(IZ, E2, ModIZ),
    set_current(NextIZ, E1, ModNextIZ),

    set_current(OZ, ModIZ, ModOZ),
    call(MovePred, ModOZ, NextOZ),
    set_current(NextOZ, ModNextIZ, RetOZ).

transposeUp(OZ, RetOZ) :- transposeVertical(move_left, OZ, RetOZ).
transposeDown(OZ, RetOZ) :- transposeVertical(move_right, OZ, RetOZ).