class Conway {
    var height:Int;
    var width:Int;
    var grid:Array<Array<Int>>;

    function new(height, width) {
        this.height = height;
        this.width = width;
        this.grid = newGrid();
    }

    function newGrid() {
        return [for (x in 0...this.height) [for (y in 0...this.width) 0]];
    }

    function draw(state) {
        if (state == 0) {
            return 46; // .
        } else {
            return 35; // # 
        }
    }

    function print() {
        for (x in 0...this.height) {
            var row = new StringBuf();
            for (y in 0...this.width) {
                row.addChar(this.draw(grid[x][y]));
            }
            haxe.Log.trace(row.toString(), null);
        }
    }

    function mod(x, y) {
        if (x > 0) {
            return x % y;
        }
        if (x < 0) {
            return y + x % y;
        }
        return 0;
    }

    function assign(x, y, state) {
        this.grid[mod(x, this.height)][mod(y, this.width)] = state;
    }

    function query(x, y) {
        return this.grid[mod(x, this.height)][mod(y, this.width)];
    }

    function countNeighbors(x, y) {
        var n  = this.query(x + 1, y    );
        var ne = this.query(x + 1, y + 1);
        var e  = this.query(x,     y + 1);
        var se = this.query(x - 1, y + 1);
        var s  = this.query(x - 1, y    );
        var sw = this.query(x - 1, y - 1);
        var w  = this.query(x,     y - 1);
        var nw = this.query(x + 1, y - 1);
        return n + ne + e + se + s + sw + w + nw;
    }

    function gameLogic(state, neighbors) {
        if (state == 1) {
            if (neighbors < 2) {
                return 0;
            }
            if (neighbors > 3) {
                return 0;
            }
            return state;
        } else {
            if (neighbors == 3) {
                return 1;
            }
            return state;
        }
    }

    function stepCell(x, y) {
        var state = this.query( x, y);
        var neighbors = countNeighbors(x, y);
        var nextState = gameLogic(state, neighbors);
        return nextState;
    }

    function simulate() {
        var newG = newGrid();
        for (x in 0...this.height) {
            for (y in 0...this.width) {
                newG[x][y] = stepCell(x, y);
            }
        }
        this.grid = newG;
    }

    function clearScreen() {
        trace("\x1B[2J");
    }

    static public function main() {
        var c = new Conway(10, 20);

        c.assign(0, 3, 1);
        c.assign(1, 4, 1);
        c.assign(2, 2, 1);
        c.assign(2, 3, 1);
        c.assign(2, 4, 1);

        c.print();

        while (true) {
            c.simulate();
            c.print();
            Sys.sleep(0.1);
        } 
    }
}

// haxe --run conway.hx
