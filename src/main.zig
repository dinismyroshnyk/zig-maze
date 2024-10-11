const std = @import("std");
const raylib = @import("raylib.zig");

pub fn main() !void {
    const screenWidth = 1500;
    const screenHeight = 720;

    raylib.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    //raylib.SetTargetFPS(60);

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();
        raylib.ClearBackground(raylib.RAYWHITE);
        raylib.DrawText("Congrats! You created your first window!", 190, 200, 20, raylib.LIGHTGRAY);
        raylib.DrawFPS(screenWidth - 100, 10);
        raylib.EndDrawing();
    }

    raylib.CloseWindow();
}