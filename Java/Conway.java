public class Conway {

    private int height;
    private int width;
    private boolean[][] rows;

    public Conway(int height, int width) {
        this.height = height;
        this.width = width;
        this.rows = new boolean[this.height][this.width];
    }

    private boolean query(int x, int y) {
        return this.rows[Math.floorMod(x, this.height)][Math.floorMod(y, this.width)];
    }

    private void assign(int x, int y, boolean state) {
        this.rows[Math.floorMod(x, this.height)][Math.floorMod(y, this.width)] = state;
    }

    private int countNeighbors(int x, int y) {
        boolean n = query(x + 1, y);
        boolean ne = query(x + 1, y + 1);
        boolean e = query(x, y + 1);
        boolean se = query(x - 1, y + 1);
        boolean s = query(x - 1, y);
        boolean sw = query(x - 1, y - 1);
        boolean w = query(x, y - 1);
        boolean nw = query(x + 1, y - 1);
        boolean[] neighborStates = new boolean[] {n, ne, e, se, s, sw, w, nw};
        int counter = 0;

        for (boolean value: neighborStates) {
            if (value) {
                counter++;
            }
        }

        return counter;
    }

    private char draw(boolean value) {
        if (value) {
            return '#';
        }
        return '.';
    } 

    private void print() {
        for (boolean[] row: this.rows) {
            for (boolean value: row) {
                System.out.print(draw(value));
            }
            System.out.println();
        }
    }

    private boolean gameLogic(boolean state, int neighbors) {
        if (state) {
            if (neighbors < 2) {
                return false;
            }
            if (neighbors > 3) {
                return false;
            }
            return state;
        } else {
            if (neighbors == 3) {
                return true;
            }
            return state;
        }
    }

    private boolean stepCell(int x, int y) {
        boolean state = this.query(x, y);
        int neighbors = this.countNeighbors(x, y);
        boolean nextState = this.gameLogic(state, neighbors);
        return nextState;
    }

    private void simulate() {
        boolean[][] newRows = new boolean[this.height][this.width];

        for (int x = 0; x < this.height; x++) {
            for (int y = 0; y < this.width; y++) {
                newRows[x][y] = this.stepCell(x, y);
            }
        }

        this.rows = newRows;
    }

    private void clearScreen() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

    public static void main(String[] args) throws InterruptedException {
        Conway con = new Conway(10, 20);
        con.assign(0, 3, true);
        con.assign(1, 4, true);
        con.assign(2, 2, true);
        con.assign(2, 3, true);
        con.assign(2, 4, true);

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
