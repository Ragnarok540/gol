const HEIGHT = 10
const WIDTH = 20

function mod(x, y) {
    if (x > 0) {
        return x % y
    }
    if (x < 0) {
        return y + x % y
    }
    return 0
}

function newGrid(height, width) {
    let arr = new Array(height)
    for (let i = 0; i < arr.length; i++) {
        arr[i] = new Array(width).fill(0)
    }
    return arr
}

function query(grid, x, y) {
    let height = grid.length
    let width = grid[0].length
    return grid[mod(x, height)][mod(y, width)]
}

function assign(grid, x, y, state) {
    let height = grid.length
    let width = grid[0].length
    grid[mod(x, height)][mod(y, width)] = state
}

function countNeighbors(grid, x, y) {
    let n  = query(grid, x + 1, y    )
    let ne = query(grid, x + 1, y + 1)
    let e  = query(grid, x,     y + 1)
    let se = query(grid, x - 1, y + 1)
    let s  = query(grid, x - 1, y    )
    let sw = query(grid, x - 1, y - 1)
    let w  = query(grid, x,     y - 1)
    let nw = query(grid, x + 1, y - 1)
    return [n, ne, e, se, s, sw, w, nw].reduce((a, b) => a + b, 0)
}

function printGrid(grid) {
    let height = grid.length
    let width = grid[0].length
    for (let i = 0; i < height; i++) {
        for (let j = 0; j < width; j++) {
            process.stdout.write(`${grid[i][j] ? '#' : '.'}`)
        }
        console.log()
    }
}

function gameLogic(state, neighbors) {
    if (state == 1) {
        if (neighbors < 2) {
            return 0
        }
        if (neighbors > 3) {
            return 0
        }
        return state
    } else {
        if (neighbors == 3) {
            return 1
        }
        return state
    }
}

function stepCell(grid, x, y) {
    let state = query(grid, x, y)
    let neighbors = countNeighbors(grid, x, y)
    let next_state = gameLogic(state, neighbors)
    return next_state
}

function simulate(grid) {
    let height = grid.length
    let width = grid[0].length
    let newG = newGrid(height, width)
    for (let i = 0; i < height; i++) {
        for (let j = 0; j < width; j++) {
            assign(newG, i, j, stepCell(grid, i, j))
        }
    }
    return newG
}

function clearScreen() {
    process.stdout.write('\x1b[2J')
}

function sleep(ms) {
    return new Promise((resolve) => {
        setTimeout(resolve, ms)
    })
}

let grid = newGrid(HEIGHT, WIDTH)
assign(grid, 0, 3, 1)
assign(grid, 1, 4, 1)
assign(grid, 2, 2, 1)
assign(grid, 2, 3, 1)
assign(grid, 2, 4, 1)

printGrid(grid)

for (;;) {
    clearScreen()
    grid = simulate(grid)
    printGrid(grid)
    await sleep(100)
}

// node conway.js
