program Conway(output);
uses Crt, Video;

const
    Height = 10;
    Width = 20;

type
    State = 0..1;
    Rows = 1..Height;
    Cols = 1..Width;
    Grid = array[Rows, Cols] of State;
    Neighbors = 0..8;

var
    i, j: Integer;
    gr : Grid;

function Draw(s: State): Char;
begin
    if s = 1 then
        Draw := '#'
    else
        Draw := '.';
end;

procedure Print(g: Grid);
begin
    for i := low(Rows) to high(Rows) do begin
        for j := low(Cols) to high(Cols) do begin
            Write(Draw(g[i][j]))
        end;
        WriteLn()
    end;
end;

procedure Assign(var g: Grid; row: Integer; col: Integer; s: State);
begin
    g[Rows((row mod Height) + 1)][Cols((col mod Width) + 1)] := s;
end;

function Query(g: Grid; row: Integer; col: Integer): State;
begin
    Query := g[Rows((row mod Height) + 1)][Cols((col mod Width) + 1)];
end;

function CountNeighbors(g: Grid; row: Integer; col: Integer): Neighbors;
    var n, ne, e, se, s, sw, w, nw: Neighbors;
begin
    n  := Neighbors(query(g, row + 1, col    ));
    ne := Neighbors(query(g, row + 1, col + 1));
    e  := Neighbors(query(g, row,     col + 1));
    se := Neighbors(query(g, row - 1, col + 1));
    s  := Neighbors(query(g, row - 1, col    ));
    sw := Neighbors(query(g, row - 1, col - 1));
    w  := Neighbors(query(g, row,     col - 1));
    nw := Neighbors(query(g, row + 1, col - 1));
    CountNeighbors := n + ne + e + se + s + sw + w + nw;
end;

function GameLogic(s: State; n: Neighbors): State;
begin
    if s = 1 then begin
        if (n < 2) or (n > 3) then
            GameLogic := 0
        else
            GameLogic := s
    end;
    if s = 0 then begin
        if n = 3 then
            GameLogic := 1
        else
            GameLogic := s
    end;
end;

function StepCell(g: Grid; row: Integer; col: Integer): State;
    var s: State;
    var n: Neighbors;
begin
    s := Query(g, row, col);
    n := CountNeighbors(g, row, col);
    StepCell := GameLogic(s, n);
end;

function Simulate(g: Grid): Grid;
    var newG: Grid;
begin
    for i := low(Rows) to high(Rows) do
        for j := low(Cols) to high(Cols) do
            Assign(newG, i, j, StepCell(g, i, j));
    Simulate := newG;
end;

begin
    for i := low(Rows) to high(Rows) do
        for j := low(Cols) to high(Cols) do
            gr[i][j] := 0;

    Assign(gr, 0, 3, 1);
    Assign(gr, 1, 4, 1);
    Assign(gr, 2, 2, 1);
    Assign(gr, 2, 3, 1);
    Assign(gr, 2, 4, 1);

    Print(gr);
    InitVideo;
    
    while True do begin
        ClearScreen;
        gr := Simulate(gr);
        Print(gr);
        Delay(100);
    end;

    DoneVideo
end.

{mkdir -p bin}
{fpc -FEbin conway.pas}
{./bin/conway}
