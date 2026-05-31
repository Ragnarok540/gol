import java.util.Arrays;

public class Conway {
    private int height;
    private int width;
    private int[][] grid;

    public Conway(int height, int width) {
        this.height = height;
        this.width = width;
        this.grid = new int[this.height][this.width];
    }

    private int query(int x, int y) {
        return this.grid[Math.floorMod(x, this.height)][Math.floorMod(y, this.width)];
    }

    private void assign(int x, int y, int state) {
        this.grid[Math.floorMod(x, this.height)][Math.floorMod(y, this.width)] = state;
    }

    private int countNeighbors(int x, int y) {
        int n  = query(x + 1, y    );
        int ne = query(x + 1, y + 1);
        int e  = query(x,     y + 1);
        int se = query(x - 1, y + 1);
        int s  = query(x - 1, y    );
        int sw = query(x - 1, y - 1);
        int w  = query(x,     y - 1);
        int nw = query(x + 1, y - 1);
        int[] neighborStates = new int[] {n, ne, e, se, s, sw, w, nw};
        return Arrays.stream(neighborStates).sum();
    }

    private char draw(int value) {
        if (value == 1) {
            return '#';
        }
        return '.';
    } 

    private void print() {
        for (int[] row: this.grid) {
            for (int value: row) {
                System.out.print(draw(value));
            }
            System.out.println();
        }
    }

    private int gameLogic(int state, int neighbors) {
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

    private int stepCell(int x, int y) {
        int state = this.query(x, y);
        int neighbors = this.countNeighbors(x, y);
        int nextState = this.gameLogic(state, neighbors);
        return nextState;
    }

    private void simulate() {
        int[][] newGrid = new int[this.height][this.width];
        for (int x = 0; x < this.height; x++) {
            for (int y = 0; y < this.width; y++) {
                newGrid[x][y] = this.stepCell(x, y);
            }
        }
        this.grid = newGrid;
    }

    private void clearScreen() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

    public static void main(String[] args) throws InterruptedException {
        Conway con = new Conway(10, 20);
        con.assign(0, 3, 1);
        con.assign(1, 4, 1);
        con.assign(2, 2, 1);
        con.assign(2, 3, 1);
        con.assign(2, 4, 1);

        con.print();
        
        while (true) {
            con.clearScreen();
            con.simulate();
            con.print();
            Thread.sleep(100);
        }
    }
}

// javac Conway.java
// java Conway
