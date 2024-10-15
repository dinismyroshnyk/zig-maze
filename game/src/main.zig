const std = @import("std");
const Game = @import("game.zig").Game;

pub fn main() !void {
    var game: Game = undefined;
    defer game.clean_resorces();

    game = Game.init() catch |err| {
        error_printer(err, "Error initializing the game struct!");
        return err;
    };

    while (game.running) {
        game.game_loop();
    }
}

fn error_printer(err: anyerror, message: []const u8 ) void {
    std.debug.print("{s}\n", .{message});
    std.debug.print("Error type: {s}\n", .{@errorName(err)});
    std.debug.print("Error message: {any}\n", .{err});
}