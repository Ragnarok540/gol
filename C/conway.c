#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>

typedef struct {
    size_t width;
    size_t height;
    int *es;
} Matrix;

#define MAT_AT(m, i, j) (m).es[(i) * (m).width + (j)]

Matrix matrix_alloc(size_t height, size_t width) {
    Matrix m;
    m.width = width;
    m.height = height;
    m.es = malloc(sizeof(*m.es) * width * height);
    assert(m.es != NULL);
    return m;
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

int query(Matrix m, int i, int j) {
    return MAT_AT(m, mod(i, m.height), mod(j, m.width));
}

void assign(Matrix m, int i, int j, int state) {
    MAT_AT(m, mod(i, m.height), mod(j, m.width)) = state;
}

int count_neighbors(Matrix m, int x, int y) {
    int n = query(m, x+1, y);
    int ne = query(m, x+1, y+1);
    int e = query(m, x, y+1);
    int se = query(m, x-1, y+1);
    int s = query(m, x-1, y);
    int sw = query(m, x-1, y-1);
    int w = query(m, x, y-1);
    int nw = query(m, x+1, y-1);
    return n + ne + e + se + s + sw + w + nw;
}

char draw(int value) {
    if (value == 1) {
        return '#';
    } else {
        return '.';
    }
}

void print(Matrix m) {
    for (size_t i = 0; i < m.height; i++) {
        for (size_t j = 0; j < m.width; j++) {
            printf("%c", draw(MAT_AT(m, i, j)));
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

int step_cell(Matrix m, int x, int y) {
    int state = query(m, x, y);
    int neighbors = count_neighbors(m, x, y);
    int next_state = game_logic(state, neighbors);
    return next_state;
}

Matrix simulate(Matrix m) {
    Matrix new_matrix = matrix_alloc(m.height, m.width);
    for (size_t i = 0; i < m.height; i++) {
        for (size_t j = 0; j < m.width; j++) {
            MAT_AT(new_matrix, i, j) = step_cell(m, i, j);
        }
    }
    free(m.es);
    return new_matrix;
}

void clear_screen() {
    printf("\x1B[2J");
}

int main() {
    const int HEIGHT = 10;
    const int WIDTH = 20;
    Matrix matrix = matrix_alloc(HEIGHT, WIDTH);

    assign(matrix, 0, 3, 1);
    assign(matrix, 1, 4, 1);
    assign(matrix, 2, 2, 1);
    assign(matrix, 2, 3, 1);
    assign(matrix, 2, 4, 1);

    matrix = simulate(matrix);
    print(matrix);

    for (;;) {
        clear_screen();
        matrix = simulate(matrix);
        print(matrix);
        usleep(100 * 1000);
    }

    return 0;
}

// mkdir -p bin
// clang -Wall -Wextra -o bin/conway conway.c -lm
// ./bin/conway
