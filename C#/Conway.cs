class Conway {
    private int height;
    private int width;
    private int[,] grid;

    Conway(int h, int w) {
        height = h;
        width = w;
        grid = new int[height, width];
    }

    private int Mod(int x, int y) {
        if (x > 0) {
            return x % y;
        }
        if (x < 0) {
            return y + x % y;
        }
        return 0;
    }

    private void Assign(int x, int y, int state) {
        grid[Mod(x, height), Mod(y, width)] = state;
    }

    private void Print() {
        for (int i = 0; i < grid.GetLength(0); i++) {
            for (int j = 0; j < grid.GetLength(1); j++) {
                Console.Write(grid[i, j] == 1 ? '#' : '.');
            }
            Console.WriteLine();
        }
    }

    private int Query(int x, int y) {
        return grid[Mod(x, height), Mod(y, width)];
    }

    private int CountNeighbors(int x, int y) {
        int n  = Query(x + 1, y    );
        int ne = Query(x + 1, y + 1);
        int e  = Query(x,     y + 1);
        int se = Query(x - 1, y + 1);
        int s  = Query(x - 1, y    );
        int sw = Query(x - 1, y - 1);
        int w  = Query(x,     y - 1);
        int nw = Query(x + 1, y - 1);
        int[] neighborStates = new int[] {n, ne, e, se, s, sw, w, nw};
        return neighborStates.Sum();
    }

    private int GameLogic(int state, int neighbors) {
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

    private int StepCell(int x, int y) {
        int state = Query(x, y);
        int neighbors = CountNeighbors(x, y);
        int nextState = GameLogic(state, neighbors);
        return nextState;
    }

    private void Simulate() {
        int[,] newGrid = new int[height, width];
        for (int i = 0; i < grid.GetLength(0); i++) {
            for (int j = 0; j < grid.GetLength(1); j++) {
                newGrid[i, j] = StepCell(i, j);
            }
        }
        grid = newGrid;
    }

    private void ClearScreen() {
        Console.Write("\x1B[2J");
    }

    static void Main() {
        Conway con = new Conway(10, 20);
        con.Assign(0, 3, 1);
        con.Assign(1, 4, 1);
        con.Assign(2, 2, 1);
        con.Assign(2, 3, 1);
        con.Assign(2, 4, 1);

        con.Print();

        while (true) {
            con.ClearScreen();
            con.Simulate();
            con.Print();
            Thread.Sleep(100);
        }
    }
}

// dotnet Conway.cs
