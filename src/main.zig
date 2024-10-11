const std = @import("std");
const raylib = @import("raylib.zig");
const GameState = @import("game_state.zig").GameState;

pub fn main() !void {
    const screen_width: i32 = 1500;
    const screen_height: i32 = 720;
    const cell_size: i32 = 50;

    var game_state = GameState.init(screen_width, screen_height, cell_size);
    game_state.randomizePlayerPosition();

    raylib.InitWindow(screen_width, screen_height, "zig-maze");

    while (!raylib.WindowShouldClose()) {
        game_state.update();

        raylib.BeginDrawing();
        game_state.draw();
        raylib.EndDrawing();
    }

    raylib.CloseWindow();
}