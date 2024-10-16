const std = @import("std");
const raylib = @import("raylib.zig");

pub fn main() anyerror!void {
    // Initialize Raylib
    raylib.InitWindow(1280, 720, "Red Cube");
    defer raylib.CloseWindow();

    // Disable mouse cursor
    raylib.DisableCursor();

    // Set up fullscreen mode
    const monitor = raylib.GetCurrentMonitor();
    const monitor_width = raylib.GetMonitorWidth(monitor);
    const monitor_height = raylib.GetMonitorHeight(monitor);
    raylib.SetWindowSize(monitor_width, monitor_height);
    raylib.SetWindowState(raylib.FLAG_FULLSCREEN_MODE);

    // Set FPS
    raylib.SetTargetFPS(60);

    // Set up the 3D camera
    var camera: raylib.Camera3D = .{
    .position = vec_3(3.0, 3.0, 3.0),
    .target = vec_3(0.0, 0.0, 0.0),
    .up = vec_3(0.0, 1.0, 0.0),
    .fovy = 45.0,
    .projection = raylib.CAMERA_PERSPECTIVE,
};

    // Main loop
    while (!raylib.WindowShouldClose()) {
        // Clear the screen
        raylib.BeginDrawing();
        raylib.ClearBackground(raylib.RAYWHITE);

        // Update the camera
        // raylib.UpdateCamera(&camera, raylib.CAMERA_FIRST_PERSON);
        raylib.UpdateCamera(&camera, raylib.CAMERA_FREE);


        // Draw the 3D cube
        raylib.BeginMode3D(camera);
        raylib.DrawCube(vec_3(0.0, 1.0, 0.0), 1.0, 1.0, 1.0, raylib.RED);
        raylib.DrawCubeWires(vec_3(0.0, 1.0, 0.0), 1.0, 1.0, 1.0, raylib.BLACK);
        raylib.DrawGrid(10, 1.0);
        raylib.EndMode3D();

        // Draw FPS counter
        raylib.DrawFPS(monitor_width - 100, 10);

        // Update the screen
        raylib.EndDrawing();
    }
}

fn vec_3(x: f32, y: f32, z: f32) raylib.Vector3 {
    return raylib.Vector3{ .x = x, .y = y, .z = z };
}