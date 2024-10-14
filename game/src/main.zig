const std = @import("std");
const Game = @import("game.zig").Game;

pub fn main() !void {
    var game: Game = undefined;
    defer game.clean_resorces();

    game = Game.init() catch |err| {
        std.debug.print("Error initializing the game struct!\n", .{});
        error_printer(err);
        return err;
    };

    while (game.running) {
        game.game_loop();
    }
}

fn error_printer(err: anyerror) void {
    std.debug.print("Error type: {s}\n", .{@errorName(err)});
    std.debug.print("Error message: {any}\n", .{err});
}