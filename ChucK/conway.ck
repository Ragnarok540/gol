fun string draw(int value) {
    if (value == 1) {
        return "#";
    } else {
        return ".";
    }
}

fun void print(int grid[][]) {
    for (int row[] : grid) {
        for (int cell : row) {
            chout <= draw(cell);
        }
        chout <= "\n";    
    }
}

fun int mod(int x, int y) {
    if (x > 0) {
        return x % y;
    }
    if (x < 0) {
        return y + x % y;
    }
    return 0;
}

fun void assign(int grid[][], int row, int col, int value) {
    value => grid[mod(row, grid.size())][mod(col, grid[0].size())];
}

fun int query(int grid[][], int row, int col) {
    return grid[mod(row, grid.size())][mod(col, grid[0].size())];
}

fun int countNeighbors(int grid[][], int x, int y) {
    query(grid, x + 1, y    ) => int n;
    query(grid, x + 1, y + 1) => int ne;
    query(grid, x,     y + 1) => int e;
    query(grid, x - 1, y + 1) => int se;
    query(grid, x - 1, y    ) => int s;
    query(grid, x - 1, y - 1) => int sw;
    query(grid, x,     y - 1) => int w;
    query(grid, x + 1, y - 1) => int nw;
    return n + ne + e + se + s + sw + w + nw;
}

fun int gameLogic(int state, int neighbors) {
    if (state == 1) {
        if (neighbors < 2 || neighbors > 3) {
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

fun int stepCell(int grid[][], int x, int y) {
    query(grid, x, y) => int state;
    countNeighbors(grid, x, y) => int neighbors;
    gameLogic(state, neighbors) => int nextState;
    return nextState;
}

fun int[][] simulate(int grid[][]) {
    int newGrid[grid.size()][grid[0].size()];
    for (0 => int i; i < grid.size(); i++) {
        for (0 => int j; j < grid[0].size(); j++) {
            assign(newGrid, i, j, stepCell(grid, i, j));
        }
    }
    return newGrid;
}

fun void clearScreen() {
    chout <= "\033[H\033[2J";
}

int grid[10][20];

assign(grid, 0, 3, 1);
assign(grid, 1, 4, 1);
assign(grid, 2, 2, 1);
assign(grid, 2, 3, 1);
assign(grid, 2, 4, 1);

print(grid);

while (true) {
    clearScreen();
    simulate(grid) @=> grid;
    print(grid);
    100::ms => now;
}

// ./chuck conway.ck
