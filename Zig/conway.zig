const std = @import("std");
const print = std.debug.print;

const HEIGHT: i8 = 10;
const WIDTH: i8 = 20;

pub fn query(grid: [HEIGHT][WIDTH]i8, x: i8, y: i8) i8 {
    return grid[@as(usize, @intCast(@mod(x, HEIGHT)))][@as(usize, @intCast(@mod(y, WIDTH)))];
}

pub fn assign(grid: [HEIGHT][WIDTH]i8, x: i8, y: i8, value: i8) [HEIGHT][WIDTH]i8 {
    var result = grid;
    result[@as(usize, @intCast(@mod(x, HEIGHT)))][@as(usize, @intCast(@mod(y, WIDTH)))] = value;
    return result;
}

pub fn draw(value: i8) *const [1:0]u8 {
    if (value == 1) {
        return "#";
    } else {
        return ".";
    }
}

pub fn print_grid(grid: [HEIGHT][WIDTH]i8) void {
    for (grid) |row| {
        for (row) |cell| {
            print("{s}", .{draw(cell)});
        }
        print("\n", .{});
    }
}

pub fn count_neighbors(grid: [HEIGHT][WIDTH]i8, x: i8, y: i8) i8 {
    const n  = query(grid, x + 1, y    );
    const ne = query(grid, x + 1, y + 1);
    const e  = query(grid, x,     y + 1);
    const se = query(grid, x - 1, y + 1);
    const s  = query(grid, x - 1, y    );
    const sw = query(grid, x - 1, y - 1);
    const w  = query(grid, x,     y - 1);
    const nw = query(grid, x + 1, y - 1);
    return n + ne + e + se + s + sw + w + nw;
}

fn game_logic(state: i8, neighbors: i8) i8 {
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

pub fn step_cell(grid: [HEIGHT][WIDTH]i8, x: i8, y: i8) i8 {
    const state = query(grid, x, y);
    const neighbors = count_neighbors(grid, x, y);
    const next_state = game_logic(state, neighbors);
    return next_state;
}

pub fn simulate(grid: [HEIGHT][WIDTH]i8) [HEIGHT][WIDTH]i8 {
    var new_grid: [HEIGHT][WIDTH]i8 = @splat(@splat(0));
    for (grid, 0..) |row, i| {
        for (row, 0..) |_, j| {
            new_grid[i][j] = step_cell(grid, @as(i8, @intCast(i)), @as(i8, @intCast(j)));
        }
    }
    return new_grid;
}

pub fn clear_screen() void {
	print("\x1B[2J", .{});
}

pub fn main(init: std.process.Init) !void {
    var grid: [HEIGHT][WIDTH]i8 = @splat(@splat(0));

    grid = assign(grid, 0, 3, 1);
    grid = assign(grid, 1, 4, 1);
    grid = assign(grid, 2, 2, 1);
    grid = assign(grid, 2, 3, 1);
    grid = assign(grid, 2, 4, 1);

    print_grid(grid);

    while (true) {
        clear_screen();
        grid = simulate(grid);
        print_grid(grid);
        try std.Io.sleep(init.io, std.Io.Duration.fromMilliseconds(100), .awake);
    }
}

// zig run conway.zig
