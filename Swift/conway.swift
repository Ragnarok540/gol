class Conway {
    let width: Int
    let height: Int
    var grid: Array<Array<Int>>

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let row = Array(repeating: 0, count: width)
        self.grid = Array(repeating: row, count: height)
    }

    func draw(value: Int) -> Character {
        if value == 1 {
            return "#"
        }
        return "."
    } 

    func printGrid() {
        for row in self.grid {
            for e in row {
                print(draw(value: e), terminator: "")
            }
            print()
        }
    }

    func mod(x: Int, y: Int) -> Int {
        if x > 0 {
            return x % y
        }
        if x < 0 {
            return (y + x) % y
        }
        return 0
    }

    func query(x: Int, y: Int) -> Int {
        return self.grid[mod(x: x, y: self.height)][mod(x: y, y: self.width)]
    }

    func assign(x: Int, y: Int, state: Int) {
        self.grid[mod(x: x, y: self.height)][mod(x: y, y: self.width)] = state
    }

    func countNeighbors(x: Int, y: Int) -> Int {
        let n  = query(x: x + 1, y: y    )
        let ne = query(x: x + 1, y: y + 1)
        let e  = query(x: x,     y: y + 1)
        let se = query(x: x - 1, y: y + 1)
        let s  = query(x: x - 1, y: y    )
        let sw = query(x: x - 1, y: y - 1)
        let w  = query(x: x,     y: y - 1)
        let nw = query(x: x + 1, y: y - 1)
        return n + ne + e + se + s + sw + w + nw
    }

    func gameLogic(state: Int, neighbors: Int) -> Int {
        if state == 1 {
            if neighbors < 2 {
                return 0
            }
            if neighbors > 3 {
                return 0
            }
            return state
        } else {
            if neighbors == 3 {
                return 1
            }
            return state
        }
    }

    func stepCell(x: Int, y: Int) -> Int {
        let state = query(x: x, y: y)
        let neighbors = countNeighbors(x: x, y: y)
        let nextState = gameLogic(state: state, neighbors: neighbors)
        return nextState
    }

    func simulate() {
        let row = Array(repeating: 0, count: self.width)
        var newGrid: Array<Array<Int>> = Array(repeating: row, count: self.height)
        
        for x in 0..<self.height {
            for y in 0..<self.width {
                newGrid[x][y] = stepCell(x: x, y: y)
            }
        }
        self.grid = newGrid
    }

    func clearScreen() {
        print("\u{001B}[2J");
    }
}

var c: Conway = Conway(width: 20, height: 10)

c.assign(x: 0, y: 3, state: 1)
c.assign(x: 1, y: 4, state: 1)
c.assign(x: 2, y: 2, state: 1)
c.assign(x: 2, y: 3, state: 1)
c.assign(x: 2, y: 4, state: 1)

c.printGrid()

while true {
    c.clearScreen()
    c.simulate()
    c.printGrid()
    try await Task.sleep(nanoseconds: 100 * 1000000)
}

// swift conway.swift
