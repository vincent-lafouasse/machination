const std = @import("std");
const Allocator = std.mem.Allocator;

const String = @import("String.zig").String;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    while (true) {
        try stdout.print("> ", .{});

        var line = try String.readline(stdin, allocator);
        defer line.deinit();

        try stdout.print("{s}\n", .{line});
    }
}
