#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>

typedef struct {
    size_t width;
    size_t height;
    int *grid;
} Conway;

#define GRID_AT(c, i, j) (c).grid[(i) * (c).width + (j)]

Conway conway_alloc(size_t height, size_t width) {
    Conway c;
    c.width = width;
    c.height = height;
    c.grid = malloc(sizeof(*c.grid) * width * height);
    assert(c.grid != NULL);
    return c;
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

int query(Conway c, int i, int j) {
    return GRID_AT(c, mod(i, c.height), mod(j, c.width));
}

void assign(Conway c, int i, int j, int state) {
    GRID_AT(c, mod(i, c.height), mod(j, c.width)) = state;
}

int count_neighbors(Conway c, int x, int y) {
    int n  = query(c, x + 1, y    );
    int ne = query(c, x + 1, y + 1);
    int e  = query(c, x,     y + 1);
    int se = query(c, x - 1, y + 1);
    int s  = query(c, x - 1, y    );
    int sw = query(c, x - 1, y - 1);
    int w  = query(c, x,     y - 1);
    int nw = query(c, x + 1, y - 1);
    return n + ne + e + se + s + sw + w + nw;
}

char draw(int value) {
    if (value == 1) {
        return '#';
    } else {
        return '.';
    }
}

void print(Conway c) {
    for (size_t i = 0; i < c.height; i++) {
        for (size_t j = 0; j < c.width; j++) {
            printf("%c", draw(GRID_AT(c, i, j)));
        }
        printf("\n");
    }
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

int step_cell(Conway c, int x, int y) {
    int state = query(c, x, y);
    int neighbors = count_neighbors(c, x, y);
    int next_state = game_logic(state, neighbors);
    return next_state;
}

Conway simulate(Conway c) {
    Conway new_conway = conway_alloc(c.height, c.width);
    for (size_t i = 0; i < c.height; i++) {
        for (size_t j = 0; j < c.width; j++) {
            GRID_AT(new_conway, i, j) = step_cell(c, i, j);
        }
    }
    free(c.grid);
    return new_conway;
}

void clear_screen() {
    printf("\x1B[2J");
}

int main() {
    const int HEIGHT = 10;
    const int WIDTH = 20;
    Conway conway = conway_alloc(HEIGHT, WIDTH);

    assign(conway, 0, 3, 1);
    assign(conway, 1, 4, 1);
    assign(conway, 2, 2, 1);
    assign(conway, 2, 3, 1);
    assign(conway, 2, 4, 1);

    print(conway);

    for (;;) {
        clear_screen();
        conway = simulate(conway);
        print(conway);
        usleep(100 * 1000);
    }

    return 0;
}

// mkdir -p bin
// clang -Wall -Wextra -o bin/conway conway.c -lm
// ./bin/conway
