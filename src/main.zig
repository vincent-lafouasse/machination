const std = @import("std");
const Token = @import("Token.zig").Token;
const Allocator = std.mem.Allocator;

const String = struct {
    data: std.ArrayList(u8),

    const Self = @This();

    pub fn init(allocator: Allocator) Self {
        const data = std.ArrayList(u8).init(allocator);

        return Self{ .data = data };
    }

    pub fn deinit(self: *Self) void {
        self.data.deinit();
    }

    pub fn readline(reader: anytype, allocator: Allocator) !String {
        var out = String.init(allocator);

        try reader.streamUntilDelimiter(out.data.writer(), '\n', null);

        return out;
    }

    pub fn format(
        self: *const Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;

        for (self.data.items) |c| {
            try writer.print("{c}", .{c});
        }
    }
};

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
