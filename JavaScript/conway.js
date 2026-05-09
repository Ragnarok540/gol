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

function newMatrix(height, width) {
    let arr = new Array(height)
    for (let i = 0; i < arr.length; i++) {
        arr[i] = new Array(width).fill(0)
    }
    return arr
}

function query(matrix, x, y) {
    let height = matrix.length
    let width = matrix[0].length
    return matrix[mod(x, height)][mod(y, width)]
}

function assign(matrix, x, y, state) {
    let height = matrix.length
    let width = matrix[0].length
    matrix[mod(x, height)][mod(y, width)] = state
}

function countNeighbors(matrix, x, y) {
    let n = query(matrix, x + 1, y)
    let ne = query(matrix, x + 1, y + 1)
    let e = query(matrix, x, y + 1)
    let se = query(matrix, x - 1, y + 1)
    let s = query(matrix, x - 1, y)
    let sw = query(matrix, x - 1, y - 1)
    let w = query(matrix, x, y - 1)
    let nw = query(matrix, x + 1, y - 1)
    return [n, ne, e, se, s, sw, w, nw].reduce((a, b) => a + b, 0)
}

function draw(value) {
    return value ? '#' : '.'
}

function printMatrix(matrix) {
    let height = matrix.length
    let width = matrix[0].length
    for (let i = 0; i < height; i++) {
        for (let j = 0; j < width; j++) {
            process.stdout.write(`${draw(matrix[i][j])}`)
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

function stepCell(matrix, x, y) {
    let state = query(matrix, x, y)
    let neighbors = countNeighbors(matrix, x, y)
    let next_state = gameLogic(state, neighbors)
    return next_state
}

function simulate(matrix) {
    let height = matrix.length
    let width = matrix[0].length
    let newM = newMatrix(height, width)
    for (let i = 0; i < height; i++) {
        for (let j = 0; j < width; j++) {
            assign(newM, i, j, stepCell(matrix, i, j))
        }
    }
    return newM
}

function clearScreen() {
    process.stdout.write('\x1b[2J')
}

function sleep(ms) {
    return new Promise((resolve) => {
        setTimeout(resolve, ms)
    })
}

let array = newMatrix(HEIGHT, WIDTH)
assign(array, 0, 3, 1)
assign(array, 1, 4, 1)
assign(array, 2, 2, 1)
assign(array, 2, 3, 1)
assign(array, 2, 4, 1)

printMatrix(array)

for (;;) {
    clearScreen()
    array = simulate(array)
    printMatrix(array)
    await sleep(100)
}

// node conway.js
