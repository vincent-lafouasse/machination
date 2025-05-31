const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Token = union(enum) {
    Number: []const u8,
    Boolean: bool,
    Symbol: []const u8,
    Character: u8,
    String: []const u8,
    Identifier: []const u8,
    Lambda: void,
    If: void,
    Quote: void,
    Letrec: void,
    Begin: void,
    Set: void,
    Define: void,
    Let: void,
    Cond: void,
    And: void,
    Or: void,
    Delay: void,
    ConsStream: void,
    LeftParen: void,
    RightParen: void,
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
