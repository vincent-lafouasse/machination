const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Token = union(enum) {
    LeftParen: void,
    RightParen: void,
    Identifier: []const u8,
    Directive: []const u8,
    EndOfFile: void,
};

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

    fn peek(self: *const Lexer) u8 {
        return self.input[self.head];
    }

    fn advance(self: *Lexer) void {
        if (!self.eof()) {
            self.head += 1;
        }
    }

    fn eof(self: *const Lexer) bool {
        return self.head == self.input.len;
    }

    fn get(self: *const Lexer) u8 {
        const out = self.input[self.head];
        self.advance();
        return out;
    }

    fn readToken(self: *Lexer) !Token {
        if (self.eof()) {
            return Token.EndOfFile;
        }
    }
};
