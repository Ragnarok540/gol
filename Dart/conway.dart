import "dart:io";

class Conway {
    int height, width;
    List grid = [];

    Conway(this.height, this.width) {
        grid = List.generate(height, (i) => List.generate(width, (j) => 0), growable: false);
    }

    String draw(int value) {
        if (value == 1) {
            return "#";
        }
        return ".";
    } 

    void printGrid() {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                stdout.write(draw(grid[i][j]));
            }
            print("");
        }
    }

    void assign(int i, int j, int value) {
        grid[i % height][j % width] = value;
    }

    int query(int i, int j) {
        return grid[i % height][j % width];
    }

    int countNeighbors(int x, int y) {
        int n  = query(x + 1, y    );
        int ne = query(x + 1, y + 1);
        int e  = query(x,     y + 1);
        int se = query(x - 1, y + 1);
        int s  = query(x - 1, y    );
        int sw = query(x - 1, y - 1);
        int w  = query(x,     y - 1);
        int nw = query(x + 1, y - 1);
        return n + ne + e + se + s + sw + w + nw;
    }

    int gameLogic(int state, int neighbors) {
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

    int stepCell(int x, int y) {
        int state = query(x, y);
        int neighbors = countNeighbors(x, y);
        int nextState = gameLogic(state, neighbors);
        return nextState;
    }

    void simulate() {
        List newGrid = List.generate(height, (i) => List.generate(width, (j) => 0), growable: false);
        for (int x = 0; x < this.height; x++) {
            for (int y = 0; y < this.width; y++) {
                newGrid[x][y] = this.stepCell(x, y);
            }
        }
        grid = newGrid;
    }

    void clearScreen() {
        stdout.write("\x1B[2J");
    }
}

void main() {
    var c = Conway(10, 20);
    c.assign(0, 3, 1);
    c.assign(1, 4, 1);
    c.assign(2, 2, 1);
    c.assign(2, 3, 1);
    c.assign(2, 4, 1);

    c.printGrid();
    
    while (true) {
        c.clearScreen();
        c.simulate();
        c.printGrid();
        sleep(const Duration(milliseconds: 100));
    }
}

// dart run conway.dart
