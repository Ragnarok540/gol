import core.thread;
import std.stdio;

class Conway {
    int width;
    int height;
    int[][] grid;

    this(int h, int w) {
        width = w;
        height = h;
        grid = new int[][](h, w);
    }

    void print() {
        foreach (i; 0..height) {
            foreach (j; 0..width) {
                write(grid[i][j] == 0 ? "." : "#");
            }
            writeln();
        }
    }

    int mod(int x, int y) {
        if (x > 0) {
            return x % y;
        }
        if (x < 0) {
            return y + x % y;
        }
        return 0;
    }

    void assign(int i, int j, int state) {
        grid[mod(i, height)][mod(j, width)] = state;
    }

    int query(int i, int j) {
        return grid[mod(i, height)][mod(j, width)];
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
        int next_state = gameLogic(state, neighbors);
        return next_state;
    }

    void simulate() {
        auto new_grid = new int[][](height, width);
        foreach (i; 0..height) {
            foreach (j; 0..width) {
                new_grid[i][j] = stepCell(i, j);
            }
        }
        grid = new_grid;
    }

    void clearScreen() {
        write("\x1B[2J");
    }
}

void main() {
    enum HEIGHT = 10;
    enum WIDTH = 20;

    auto conway = new Conway(HEIGHT, WIDTH);
    conway.assign(0, 3, 1);
    conway.assign(1, 4, 1);
    conway.assign(2, 2, 1);
    conway.assign(2, 3, 1);
    conway.assign(2, 4, 1);

    conway.print();

    while (true) {
        conway.clearScreen();
        conway.simulate();
        conway.print();
        Thread.sleep(100.msecs);
    }
}

// mkdir -p bin
// ldc2 -w --od bin --of bin/conway conway.d
// ./bin/conway
