const std = @import("std");

pub const Game = struct {
    running: bool,

    pub fn init() !Game {
        return Game{ .running = true };
    }

    pub fn game_loop(self: *Game) void {
        for (0..10) |i| {
            std.debug.print("Game loop {}\n", .{i + 1});
        }
        self.running = false;
    }

    pub fn clean_resorces(self: *Game) void {
        std.debug.print("Cleaning resources...\n", .{});
        self.running = false;
    }
};