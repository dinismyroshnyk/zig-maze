const std = @import("std");
const raylib = @import("raylib.zig");

pub fn main() !void {
    const screen_width = 1500;
    const screen_height = 720;
    const cell_size = 50;

    const Player = struct {
        x: c_int,
        y: c_int,
    };

    var player = Player {
        .x = screen_width / 2,
        .y = screen_height / 2,
    };

    raylib.InitWindow(screen_width, screen_height, "zig-maze");
    //raylib.SetTargetFPS(60);

    while (!raylib.WindowShouldClose()) {
        if (raylib.IsKeyPressed(raylib.KEY_RIGHT) or raylib.IsKeyPressed(raylib.KEY_D)) {
            player.x += cell_size;
        } else if (raylib.IsKeyPressed(raylib.KEY_LEFT) or raylib.IsKeyPressed(raylib.KEY_A)) {
            player.x -= cell_size;
        } else if (raylib.IsKeyPressed(raylib.KEY_UP) or raylib.IsKeyPressed(raylib.KEY_W)) {
            player.y -= cell_size;
        } else if (raylib.IsKeyPressed(raylib.KEY_DOWN) or raylib.IsKeyPressed(raylib.KEY_S)) {
            player.y += cell_size;
        }

        raylib.BeginDrawing();
        raylib.ClearBackground(raylib.RAYWHITE);

        raylib.DrawRectangle(player.x, player.y, cell_size, cell_size, raylib.RED);

        raylib.DrawFPS(screen_width - 100, 10);
        raylib.EndDrawing();
    }

    raylib.CloseWindow();
}