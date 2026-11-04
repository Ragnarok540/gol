class Conway {
    int height
    int width
    int[][] grid

    Conway(height, width) {
        this.height = height
        this.width = width
        this.grid = new int[this.height][this.width]
    }

    int query(x, y) {
        this.grid[Math.floorMod(x, this.height)][Math.floorMod(y, this.width)]
    }

    void assign(x, y, state) {
        this.grid[Math.floorMod(x, this.height)][Math.floorMod(y, this.width)] = state
    }

    char draw(value) {
        if (value == 1) {
            '#'
        } else {
            '.'
        }
    }

    void print() {
        for (def row: this.grid) {
            for (def value: row) {
                print draw(value)
            }
            println()
        }
    }

    int countNeighbors(x, y) {
        def n  = query x + 1, y
        def ne = query x + 1, y + 1
        def e  = query x,     y + 1
        def se = query x - 1, y + 1
        def s  = query x - 1, y    
        def sw = query x - 1, y - 1
        def w  = query x,     y - 1
        def nw = query x + 1, y - 1
        n + ne + e + se + s + sw + w + nw
    }

    int gameLogic(state, neighbors) {
        if (state == 1) {
            if (neighbors < 2 || neighbors > 3) {
                0
            } else {
                state
            }
        } else {
            if (neighbors == 3) {
                1
            } else {
                state
            }
        }
    }

    int stepCell(x, y) {
        def state = this.query x, y
        def neighbors = this.countNeighbors x, y
        this.gameLogic state, neighbors
    }

    void simulate() {
        def newGrid = new int[this.height][this.width]
        for (def x = 0; x < this.height; x++) {
            for (def y = 0; y < this.width; y++) {
                newGrid[x][y] = this.stepCell x, y
            }
        }
        this.grid = newGrid
    }

    void clearScreen() {
        print "\033[H\033[2J"
    }

    static void main(String[] args) {
        def con = new Conway(10, 20)

        con.assign 0, 3, 1
        con.assign 1, 4, 1
        con.assign 2, 2, 1
        con.assign 2, 3, 1
        con.assign 2, 4, 1

        con.print()

        while (true) {
            con.clearScreen()
            con.simulate()
            con.print()
            Thread.sleep 100
        }
    }
}

// groovy conway.groovy
