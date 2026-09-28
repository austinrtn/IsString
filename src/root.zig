const std = @import("std");
const Io = std.Io;

pub const isString = @import("IsString.zig").isString;

test "main" {
    _ = @import("IsString.zig");
}
