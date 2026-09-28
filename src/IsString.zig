const std = @import("std");
const Testing = std.testing;

pub fn isString(comptime val: anytype) bool {
    const type_info = if(@TypeOf(val) == type) @typeInfo(val) else @typeInfo(@TypeOf(val));

    return switch(type_info) {
        .array => |a| a.child == u8,
        .pointer => |p| switch(p.size) {
            .slice => p.child ==  u8,
            .one => switch(@typeInfo(p.child)) {
                .array => |a| a.child == u8,
                else => false,
            },
            else => false
        },
        else => false
    };
}

test "IsString" {
    const const_slice: []const u8 = "Hello World";
    const buf: [1024]u8 = undefined;
    const x = "Foo";
    const int = 23;
    const b = true;

    try Testing.expect(isString(const_slice));
    try Testing.expect(isString(buf));
    try Testing.expect(isString(x));
    try Testing.expect(!isString(int));
    try Testing.expect(!isString(b));

    try Testing.expect(isString([]const u8));
    try Testing.expect(isString([1024]u8));
    try Testing.expect(!isString(u32));
}
