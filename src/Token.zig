const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Token = struct {};

pub const Lexer = struct {
    input: []const u8,
    head: usize,

    pub fn init(input: []const u8) Lexer {
        return Lexer{
            .input = input,
            .head = 0,
        };
    }

    pub fn tokenize(self: *Lexer, allocator: Allocator) std.ArrayList(Token) {
        _ = self;
        return std.ArrayList(Token).init(allocator);
    }
};
