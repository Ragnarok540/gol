from std/math import floorMod
from std/os import sleep

const
    Height = 10
    Width = 20

type
    Row = array[Width, int]
    Grid = array[Height, Row]

func draw(val: int): char =
    return if val == 1: '#' else: '.'

proc print(g: Grid) =
    for row in g:
        for val in row:
            stdout.write(val.draw())
        stdout.write('\n')

func query(g: Grid, x: int, y: int): int =
    return g[floorMod(x, Height)][floorMod(y, Width)]

proc assign(g: var Grid, x: int, y: int, state: int) =
    g[floorMod(x, Height)][floorMod(y, Width)] = state

func countNeighbors(g: Grid, x: int, y: int): int =
    let n  = g.query(x + 1, y    )
    let ne = g.query(x + 1, y + 1)
    let e  = g.query(x,     y + 1)
    let se = g.query(x - 1, y + 1)
    let s  = g.query(x - 1, y    )
    let sw = g.query(x - 1, y - 1)
    let w  = g.query(x,     y - 1)
    let nw = g.query(x + 1, y - 1)
    return n + ne + e + se + s + sw + w + nw

func gameLogic(state: int, neighbors: int): int =
    case state:
        of 1:
            if neighbors < 2:
                return 0
            if neighbors > 3:
                return 0
            return state
        of 0:
            if neighbors == 3:
                return 1
            return state
        else:
            return state

func stepCell(g: Grid, x: int, y: int): int =
    let state = g.query(x, y)
    let neighbors = g.countNeighbors(x, y)
    let nextState = gameLogic(state, neighbors)
    return nextState

func simulate(g: Grid): Grid =
    var newG: Grid
    for x in 0..Height-1:
        for y in 0..Width-1:
            newG[x][y] = g.stepCell(x, y)
    return newG

proc clearScreen() =
    stdout.write("\x1b[2J")

var grid: Grid

grid.assign(0, 3, 1)
grid.assign(1, 4, 1)
grid.assign(2, 2, 1)
grid.assign(2, 3, 1)
grid.assign(2, 4, 1)

grid.print

while true:
    clearScreen()
    grid = grid.simulate
    grid.print
    sleep(100)

# mkdir -p bin
# nim c -o:bin/conway conway.nim
# ./bin/conway
