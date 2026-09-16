floor_mod(X, Y, FM) :-
    X > 0, FM is (X mod Y) + 1.
floor_mod(X, Y, FM) :-
    X < 0, FM is ((X + Y) mod Y) + 1.
floor_mod(X, _, FM) :-
    X = 0, FM is 0 + 1.

query(Grid, R, C, State) :-
    floor_mod(R, 5, RFM),
    floor_mod(C, 5, CFM),
    nth(RFM, Grid, Row),
    nth(CFM, Row, State).

count_neighbors(Grid, R, C, Neighbors) :-
    RP is R + 1, CP is C + 1,
    RM is R - 1, CM is C - 1,
    query(Grid, RP, C,  N ),
    query(Grid, RP, CP, NE),
    query(Grid, R,  CP, E ),
    query(Grid, RM, CP, SE),
    query(Grid, RM, C , S ),
    query(Grid, RM, CM, SW),
    query(Grid, R , CM, W ),
    query(Grid, RP, CM, NW),
    Neighbors is N + NE + E + SE + S + SW + W + NW.

game_logic(State, Neighbors, NextState) :-
    State = 1,
    Neighbors < 2,
    NextState = 0.
game_logic(State, Neighbors, NextState) :-
    State = 1,
    Neighbors > 3,
    NextState = 0.
game_logic(State, _, NextState) :-
    State = 1,
    NextState = State.
game_logic(State, Neighbors, NextState) :-
    State = 0,
    Neighbors = 3,
    NextState = 1.
game_logic(State, _, NextState) :-
    State = 0,
    NextState = State.

step_cell(Grid, R, C, NextState) :-
    query(Grid, R, C, State),
    count_neighbors(Grid, R, C, Neighbors),
    game_logic(State, Neighbors, NextState).

conway(Grid, NextGrid) :-
    NextGrid = [
        [G00,G01,G02,G03,G04],
        [G10,G11,G12,G13,G14],
        [G20,G21,G22,G23,G24],
        [G30,G31,G32,G33,G34],
        [G40,G41,G42,G43,G44]
    ],
    step_cell(Grid, 0, 0, G00), step_cell(Grid, 0, 1, G01), step_cell(Grid, 0, 2, G02), step_cell(Grid, 0, 3, G03), step_cell(Grid, 0, 4, G04),
    step_cell(Grid, 1, 0, G10), step_cell(Grid, 1, 1, G11), step_cell(Grid, 1, 2, G12), step_cell(Grid, 1, 3, G13), step_cell(Grid, 1, 4, G14),
    step_cell(Grid, 2, 0, G20), step_cell(Grid, 2, 1, G21), step_cell(Grid, 2, 2, G22), step_cell(Grid, 2, 3, G23), step_cell(Grid, 2, 4, G24),
    step_cell(Grid, 3, 0, G30), step_cell(Grid, 3, 1, G31), step_cell(Grid, 3, 2, G32), step_cell(Grid, 3, 3, G33), step_cell(Grid, 3, 4, G34),
    step_cell(Grid, 4, 0, G40), step_cell(Grid, 4, 1, G41), step_cell(Grid, 4, 2, G42), step_cell(Grid, 4, 3, G43), step_cell(Grid, 4, 4, G44).

loop(Grid) :-
    conway(Grid, NextGrid),
    maplist(portray_clause, NextGrid), nl,
    sleep(1),
    loop(NextGrid).

start :-
    Grid = [
        [0,1,0,0,0],
        [0,0,1,0,0],
        [1,1,1,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0]
    ],
    maplist(portray_clause, Grid), nl,
    loop(Grid).

% gprolog
% [conway].
% start.
