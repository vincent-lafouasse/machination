const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Token = struct {
    pub fn tokenize(input: []const u8, allocator: Allocator) std.ArrayList(Token) {
        _ = input;

        return std.ArrayList(Token).init(allocator);
    }
};
