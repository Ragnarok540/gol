floorMod(X, Y, FM) :-
    X > 0,
    FM is (X mod Y) + 1.
floorMod(X, Y, FM) :-
    X < 0,
    FM is ((X + Y) mod Y) + 1.
floorMod(X, Y, FM) :-
    X = 0,
    FM is 0 + 1.

element(Grid, R, C, Element) :-
    floorMod(R, 5, RR),
    floorMod(C, 5, CC),
    nth(RR, Grid, Row),
    nth(CC, Row, Element).

count_neighbors(Grid, R, C, Neighbors) :-
    RP is R + 1,
    CP is C + 1,
    RM is R - 1,
    CM is C - 1,
    element(Grid, RP, C,  N ),
    element(Grid, RP, CP, NE),
    element(Grid, R,  CP, E ),
    element(Grid, RM, CP, SE),
    element(Grid, RM, C , S ),
    element(Grid, RM, CM, SW),
    element(Grid, R , CM, W ),
    element(Grid, RP, CM, NW),
    Neighbors is N + NE + E + SE + S + SW + W + NW.

conway(Grid) :- % , NextGrid
    Grid = [
        [0,1,0,0,0],
        [0,0,1,0,0],
        [1,1,1,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0]
    ],
    % NextGrid = [
    %     [G00,G01,G02,G03,G04],
    %     [G10,G11,G22,G13,G14],
    %     [G20,G21,G32,G23,G24],
    %     [G30,G31,G42,G33,G34],
    %     [G40,G41,G42,G43,G44]
    % ],
    % next(Grid, 0, 0, G00),
    maplist(portray_clause, Grid), nl,
    % count_neighbors(Grid, 2, 2, Neighbors),
    % count_neighbors(Grid, 0, 2, Neighbors),
    element(Grid, 2, 2, E),
    write(E).
