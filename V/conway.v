import math
import time

struct Conway {
    h int
    w int
    mut:
    grid [][]int
}

fn Conway.new(h int, w int) Conway {
    row := []int{len: w, init: 0}
    grid := [][]int{len: h, init: row}
    return Conway{h, w, grid}
}

fn draw(value int) string {
    if value == 1 {
        return "#"
    } else {
        return "."
    }
}

fn (c Conway) print() {
    for row in c.grid {
        for e in row {
            print(draw(e))
        }
        println("")
    }
}

fn (mut c Conway) assign(x int, y int, state int) {
    c.grid[math.modulo_floored(x, c.h)][math.modulo_floored(y, c.w)] = state
}

fn (c Conway) query(x int, y int) int {
    return c.grid[math.modulo_floored(x, c.h)][math.modulo_floored(y, c.w)]
}

fn (c Conway) count_neighbors(x int, y int) int {
    n  := c.query(x + 1, y    )
    ne := c.query(x + 1, y + 1)
    e  := c.query(x,     y + 1)
    se := c.query(x - 1, y + 1)
    s  := c.query(x - 1, y    )
    sw := c.query(x - 1, y - 1)
    w  := c.query(x,     y - 1)
    nw := c.query(x + 1, y - 1)
    return n + ne + e + se + s + sw + w + nw
}

fn game_logic(state int, neighbors int) int {
    if state == 1 {
        if neighbors < 2 {
            return 0
        }
        if neighbors > 3 {
            return 0
        }
        return state
    } else {
        if neighbors == 3 {
            return 1
        }
        return state
    }
}

fn (c Conway) step_cell(x int, y int) int {
    state := c.query(x, y)
    neighbors := c.count_neighbors(x, y)
    next_state := game_logic(state, neighbors)
    return next_state
}

fn (mut c Conway) simulate() {
    row := []int{len: c.w, init: 0}
    mut new_grid := [][]int{len: c.h, init: row}

    for i in 0 .. c.h {
        for j in 0 .. c.w {
            new_grid[i][j] = c.step_cell(i, j)
        }
    }
    c.grid = new_grid
}

fn clear_screen() {
	print("\x1B[2J")
}

fn main() {
    mut c := Conway.new(10, 20)

    c.assign(0, 3, 1)
    c.assign(1, 4, 1)
    c.assign(2, 2, 1)
    c.assign(2, 3, 1)
    c.assign(2, 4, 1)

    c.print()

    for {
        clear_screen()
        c.simulate()
        c.print()
        time.sleep(100 * time.millisecond)
    }
}

// v run conway.v
