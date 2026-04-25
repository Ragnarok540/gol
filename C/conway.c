#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef struct {
    size_t width;
    size_t height;
    int *es;
} Matrix;

#define MAT_AT(m, i, j) (m).es[(i) * (m).width + (j)]

Matrix matrix_alloc(size_t width, size_t height) {
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

int main() {
    const int HEIGHT = 20;
    const int WIDTH = 10;
    Matrix matrix = matrix_alloc(HEIGHT, WIDTH);

    assign(matrix, 0, 3, 1);
    assign(matrix, 1, 4, 1);
    assign(matrix, 2, 2, 1);
    assign(matrix, 2, 3, 1);
    assign(matrix, 2, 4, 1);

    print(matrix);
    return 0;
}

// mkdir -p bin
// clang -Wall -Wextra -o bin/conway conway.c -lm
// ./bin/conway
