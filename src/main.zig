const std = @import("std");
const Allocator = std.mem.Allocator;

const String = @import("String.zig").String;
const Token = @import("Token.zig").Token;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    while (true) {
        try stdout.print("> ", .{});

        var line = String.readline(stdin, allocator) catch |err| {
            switch (err) {
                std.io.AnyReader.Error.EndOfStream => return,
                else => return err,
            }
        };
        defer line.deinit();

        try stdout.print("{s}\n", .{line});

        const tokens = Token.tokenize(line.asSlice(), allocator);
        defer tokens.deinit();
    }
}
