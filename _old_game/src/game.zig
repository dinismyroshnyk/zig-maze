const std = @import("std");
const raylib = @import("raylib.zig");
const Player = @import("player.zig").Player;

pub const Game = struct {
    running: bool,
    playing: bool,

    player: Player,

    cell_size: c_int,
    cols: c_int,
    rows: c_int,

    monitor_width: c_int,
    monitor_height: c_int,
    game_logic_size: @Vector(2, c_int),
    screen_size: @Vector(2, c_int),

    pub fn init() !Game {
        raylib.InitWindow(1280, 720, "Zig-Maze");

        const monitor = raylib.GetCurrentMonitor();
        const monitor_width = raylib.GetMonitorWidth(monitor);
        const monitor_height = raylib.GetMonitorHeight(monitor);
        const cell_size = 50;

        raylib.SetWindowSize(monitor_width, monitor_height);
        raylib.SetWindowState(raylib.FLAG_FULLSCREEN_MODE);

        return Game{
            .running = true,
            .playing = false,

            .player = Player.init(),

            .cell_size = cell_size,
            .cols = @divTrunc(monitor_width, cell_size),
            .rows = @divTrunc(monitor_height, cell_size),

            .monitor_width = monitor_width,
            .monitor_height = monitor_height,
            .game_logic_size = .{ 1280, 720 },
            .screen_size = .{ monitor_width, monitor_height },
        };
    }

    pub fn game_loop(self: *Game) void {
        while (self.running) {
            self.update();
            self.render();
        }
    }

    pub fn update(self: *Game) void {
        self.handle_exit_input();
        self.player.update(self.cell_size, self.cols, self.rows);
    }

    fn handle_exit_input(self: *Game) void {
        if (raylib.IsKeyPressed(raylib.KEY_ESCAPE)) {
            self.running = false;
        }
    }

    pub fn render(self: *Game) void {
        raylib.BeginDrawing();
        raylib.ClearBackground(raylib.RAYWHITE);
        self.player.render(self.cell_size);
        raylib.DrawFPS(self.monitor_width - 100, 10);
        raylib.EndDrawing();
    }

    pub fn clean_resorces(self: *Game) void {
        raylib.CloseWindow();
        self.running = false;
        self.playing = false;
    }
};