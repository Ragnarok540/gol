const print = @import("std").debug.print;

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

pub fn print_grid(grid: [HEIGHT][WIDTH]i8) void {
    for (grid) |row| {
        for (row) |cell| {
            print("{}", .{cell});
        }
        print("\n", .{});
    }
}

pub fn main() void {
    var grid: [HEIGHT][WIDTH]i8 = @splat(@splat(0));

    grid[0][0] = 1;
    grid = assign(grid, -1, -1, 1);

    print_grid(grid);

    print("{}\n", .{query(grid, 0, 0)});
}

//    for (all_zero, 0..) |row, row_index| {
//        for (row, 0..) |cell, column_index| {
//           print("{}", .{cell});
//        }
//        print("\n", .{});
//    }

// zig run conway.zig
// https://ziglang.org/documentation/master/#Multidimensional-Arrays
