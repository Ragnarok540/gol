#include <iostream>
#include <unistd.h>

#define GRID_AT(i, j) grid[(i) * width + (j)]
#define NEW_GRID_AT(i, j) new_grid[(i) * width + (j)]

class Conway {
    public:
    size_t width;
    size_t height;
    int *grid;

    Conway(size_t h, size_t w) {
        width = w;
        height = h;
        grid = new int[height * width]{ 0 };
    }

    void assign(int i, int j, int state) {
        GRID_AT(mod(i, height), mod(j, width)) = state;
    }

    void print() {
        for (size_t i = 0; i < height; i++) {
            for (size_t j = 0; j < width; j++) {
                std::cout << (GRID_AT(i, j) == 0 ? "." : "#");
            }
        std::cout << "\n";
        }
    }

    void simulate() {
        int *new_grid = new int[height * width]{ 0 };
        for (size_t i = 0; i < height; i++) {
            for (size_t j = 0; j < width; j++) {
                NEW_GRID_AT(i, j) = step_cell(i, j);
            }
        }
        grid = new_grid;
    }

    void clear_screen() {
        printf("\x1B[2J");
    }

    private:
    int mod(int x, int y) {
        if (x > 0) {
            return x % y;
        }
        if (x < 0) {
            return y + x % y;
        }
        return 0;
    }

    int query(int i, int j) {
        return GRID_AT(mod(i, height), mod(j, width));
    }

    int count_neighbors(int x, int y) {
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

    int game_logic(int state, int neighbors) {
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

    int step_cell(int x, int y) {
        int state = query(x, y);
        int neighbors = count_neighbors(x, y);
        int next_state = game_logic(state, neighbors);
        return next_state;
    }
};

int main() {
    const int HEIGHT = 10;
    const int WIDTH = 20;
    Conway conway(HEIGHT, WIDTH);

    conway.assign(0, 3, 1);
    conway.assign(1, 4, 1);
    conway.assign(2, 2, 1);
    conway.assign(2, 3, 1);
    conway.assign(2, 4, 1);

    conway.print();

    for (;;) {
        conway.clear_screen();
        conway.simulate();
        conway.print();
        usleep(100 * 1000);
    }
}

// mkdir -p bin
// g++ -Wall -Wextra -o bin/conway conway.cpp -lm
// ./bin/conway
