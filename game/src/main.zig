const raylib = @import("raylib.zig");

pub fn main() anyerror!void {
    // Initialize Raylib
    raylib.InitWindow(1280, 720, "Red Cube");
    defer raylib.CloseWindow();

    // Set up fullscreen mode
    const monitor = raylib.GetCurrentMonitor();
    const monitor_width = raylib.GetMonitorWidth(monitor);
    const monitor_height = raylib.GetMonitorHeight(monitor);
    raylib.SetWindowSize(monitor_width, monitor_height);
    raylib.SetWindowState(raylib.FLAG_FULLSCREEN_MODE);

    // Center cursor
    raylib.SetMousePosition(@divTrunc(monitor_width, 2), @divTrunc(monitor_height, 2));

    // Disable mouse cursor
    raylib.DisableCursor();

    // Set up cube
    const cube_pos = vec_3(0.0, 0.6, 0.0);
    const cube_size = vec_3(1.0, 1.0, 1.0);

    // Set up floor plane
    const floor_pos = vec_3(0.0, 0.1, 0.0);
    const floor_size = vec_2(10.0, 10.0);

    // Set FPS
    raylib.SetTargetFPS(120); // REMOVE SOME TIME IN THE FUTURE

    // Set up the 3D camera
    var camera: raylib.Camera3D = .{
        .position = vec_3(3.0, 3.0, 3.0),   // camera starting position
        .target = vec_3(0.0, 1.0, 0.0),     // start looking at this point
        .up = vec_3(0.0, 1.0, 0.0),         // camera up vector
        .fovy = 60.0,                               // camera field-of-view
    };
    const camera_mode = raylib.CAMERA_FREE;

    // Main loop
    while (!raylib.WindowShouldClose()) {
        // Update the camera
        raylib.UpdateCamera(&camera, camera_mode);

        // Clear the screen
        raylib.BeginDrawing();
        raylib.ClearBackground(raylib.RAYWHITE);

        // Begin 3D mode
        raylib.BeginMode3D(camera);

        // Draw the grid
        raylib.DrawGrid(25, 1.0);

        // Draw the cube
        raylib.DrawCubeV(cube_pos, cube_size, raylib.RED);
        raylib.DrawCubeWiresV(cube_pos, cube_size, raylib.BLACK);

        // Draw the plane
        raylib.DrawPlane(floor_pos, floor_size, raylib.GRAY);

        // End 3D mode
        raylib.EndMode3D();

        // Draw FPS counter
        raylib.DrawFPS(monitor_width - 100, 10);

        // Draw coordinates
        raylib.DrawRectangle(0, 0, 200, 40, raylib.Fade(raylib.SKYBLUE, 0.5));
        raylib.DrawText(raylib.TextFormat(
            "Position: (%06.3f, %06.3f, %06.3f)",
                camera.position.x,
                camera.position.y,
                camera.position.z
        ), 10, 10, 10, raylib.BLACK);
        raylib.DrawText(raylib.TextFormat(
            "Target: (%06.3f, %06.3f, %06.3f)",
                camera.target.x,
                camera.target.y,
                camera.target.z
        ), 10, 20, 10, raylib.BLACK);

        // Update the screen
        raylib.EndDrawing();
    }
}

fn vec_3(x: f32, y: f32, z: f32) raylib.Vector3 {
    return raylib.Vector3{ .x = x, .y = y, .z = z };
}

fn vec_2(x: f32, y: f32) raylib.Vector2 {
    return raylib.Vector2{ .x = x, .y = y };
}