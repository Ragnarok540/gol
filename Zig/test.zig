const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;

test "always succeeds" {
    try expect(true);
}

test "type coercion - @as builtin" {
    const a: u8 = 1;
    const b = @as(u16, a);
    assert(b == 1);
}

test "type coercion - @as builtin 2" {
    const WIDTH: i32 = 10;
    const x: i32 = -1;
    const a: i32 = @mod(x, WIDTH);
    //const b = @intCast(a);
    const b = @as(usize, @intCast(a));
    assert(b == 9);
}
