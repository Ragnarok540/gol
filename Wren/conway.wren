class Conway {
    width { _width }
    height { _height }
    grid { _grid }

    grid=(value) {
        _grid = value
    }

    construct new(h, w) {
        _grid = []
        _height = h
        _width = w

        for (i in 0..(h * w)) {
            _grid.add(0)
        }
    }

    draw(value) {
        if (value == 1) {
            return "#"
        } else {
            return "."
        }
    }

    print {
        for (i in 0...(height * width)) {
            if (i % width == 0) System.print()
            System.write(draw(grid[i]))
        }
    }

    mod(x, y) {
        if (x > 0) {
            return x % y
        }
        if (x < 0) {
            return y + x % y
        }
        return 0
    }

    assign(x, y, state) {
        var h = mod(x, height)
        var w = mod(y, width)
        var i = h * width + w
        grid[i] = state
    }

    query(x, y) {
        var h = mod(x, height)
        var w = mod(y, width)
        var i = h * width + w
        return grid[i]
    }

    countNeighbors(x, y) {
        var n  = query(x + 1, y    )
        var ne = query(x + 1, y + 1)
        var e  = query(x,     y + 1)
        var se = query(x - 1, y + 1)
        var s  = query(x - 1, y    )
        var sw = query(x - 1, y - 1)
        var w  = query(x,     y - 1)
        var nw = query(x + 1, y - 1)
        return n + ne + e + se + s + sw + w + nw
    }

    gameLogic(state, neighbors) {
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

    stepCell(x, y) {
        var state = query(x, y)
        var neighbors = countNeighbors(x, y)
        var nextState = gameLogic(state, neighbors)
        return nextState
    }

    simulate {
        var newGrid = []
        for (i in 0..(height * width)) {
            newGrid.add(0)
        }
        for (i in 0...height) {
            for (j in 0...width) {
                //System.print(i * width + j)
                newGrid[i * width + j] = stepCell(i, j)
            }
        }
        grid = newGrid
    }

    sleep(n) {
        var t0 = System.clock
        while (System.clock - t0 <= n) {}
    }

    clearScreen {
        System.print("\x1B[2J")
    }

}

var c = Conway.new(10, 20)

c.assign(0, 3, 1)
c.assign(1, 4, 1)
c.assign(2, 2, 1)
c.assign(2, 3, 1)
c.assign(2, 4, 1)

c.print

while (true) {
    c.clearScreen
    c.simulate
    c.print
    c.sleep(0.1)
}

// ./wren_cli conway.wren 
