fun newGrid(height: Int, width: Int): Array<Array<Int>> {
    var grid: Array<Array<Int>> = Array(height) {
        Array(width) { 0 }
    }
    return grid
}

fun query(grid: Array<Array<Int>>, x: Int, y: Int): Int {
    val height = grid.size
    val width = grid[0].size
    return grid[Math.floorMod(x, height)][Math.floorMod(y, width)]
}

fun assign(grid: Array<Array<Int>>, x: Int, y: Int, state: Int) {
    val height = grid.size
    val width = grid[0].size
    grid[Math.floorMod(x, height)][Math.floorMod(y, width)] = state
}

fun countNeighbors(grid: Array<Array<Int>>, x: Int, y: Int): Int {
    val n  = query(grid, x + 1, y    )
    val ne = query(grid, x + 1, y + 1)
    val e  = query(grid, x,     y + 1)
    val se = query(grid, x - 1, y + 1)
    val s  = query(grid, x - 1, y    )
    val sw = query(grid, x - 1, y - 1)
    val w  = query(grid, x,     y - 1)
    val nw = query(grid, x + 1, y - 1)
    return n + ne + e + se + s + sw + w + nw
}

fun draw(value: Int): Char {
    if (value == 1) {
        return '#'
    }
    return '.'
} 

fun printGrid(grid: Array<Array<Int>>) {
    for (row in grid) {
        for (value in row) {
            print(draw(value))
        }
        println()
    } 
}

fun gameLogic(state: Int, neighbors: Int): Int {
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

fun stepCell(grid: Array<Array<Int>>, x: Int, y: Int): Int {
    val state = query(grid, x, y)
    val neighbors = countNeighbors(grid, x, y)
    val nextState = gameLogic(state, neighbors)
    return nextState;
}

fun simulate(grid: Array<Array<Int>>): Array<Array<Int>> {
    val height = grid.size
    val width = grid[0].size
    var newGrid = newGrid(height, width)
    for (x in 0..<height) {
        for (y in 0..<width) {
            newGrid[x][y] = stepCell(grid, x, y)
        }
    }
    return newGrid
}

fun clearScreen() {
    print("\u001b[H\u001b[2J");
}

fun main() {
    var grid = newGrid(10, 20)
    
    assign(grid, 0, 3, 1)
    assign(grid, 1, 4, 1)
    assign(grid, 2, 2, 1)
    assign(grid, 2, 3, 1)
    assign(grid, 2, 4, 1)
    
    printGrid(grid)
    
    while (true) {
        clearScreen()
        grid = simulate(grid)
        printGrid(grid)
        Thread.sleep(100)
    }
}

// kotlinc conway.kt
// kotlin ConwayKt
