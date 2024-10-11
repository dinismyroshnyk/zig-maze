const std = @import("std");
const Player = @import("player.zig").Player;

pub const GameState = struct {
    player: Player,
    screen_width: i32,
    screen_height: i32,
    cell_size: i32,
    cols: i32,
    rows: i32,
    prng: std.rand.DefaultPrng,

    pub fn init(screen_width: i32, screen_height: i32, cell_size: i32) GameState {
        const cols = @divTrunc(screen_width, cell_size);
        const rows = @divTrunc(screen_height, cell_size);

        const prng = std.rand.DefaultPrng.init(blk: {
            var seed: u64 = undefined;
            std.posix.getrandom(std.mem.asBytes(&seed)) catch {};
            break :blk seed;
        });

        return GameState{
            .player = Player.init(0, 0),
            .screen_width = screen_width,
            .screen_height = screen_height,
            .cell_size = cell_size,
            .cols = cols,
            .rows = rows,
            .prng = prng,
        };
    }

    pub fn randomizePlayerPosition(self: *GameState) void {
        const random_col = self.prng.random().intRangeAtMost(i32, 0, self.cols - 1);
        const random_row = self.prng.random().intRangeAtMost(i32, 0, self.rows - 1);

        self.player.x = random_col * self.cell_size;
        self.player.y = random_row * self.cell_size;
    }

    pub fn update(self: *GameState) void {
        const raylib = @import("raylib.zig");

        if (raylib.IsKeyPressed(raylib.KEY_RIGHT) or raylib.IsKeyPressed(raylib.KEY_D)) {
            self.player.move(1, 0, self.cell_size, self.cols, self.rows);
        } else if (raylib.IsKeyPressed(raylib.KEY_LEFT) or raylib.IsKeyPressed(raylib.KEY_A)) {
            self.player.move(-1, 0, self.cell_size, self.cols, self.rows);
        } else if (raylib.IsKeyPressed(raylib.KEY_UP) or raylib.IsKeyPressed(raylib.KEY_W)) {
            self.player.move(0, -1, self.cell_size, self.cols, self.rows);
        } else if (raylib.IsKeyPressed(raylib.KEY_DOWN) or raylib.IsKeyPressed(raylib.KEY_S)) {
            self.player.move(0, 1, self.cell_size, self.cols, self.rows);
        }
    }

    pub fn draw(self: GameState) void {
        const raylib = @import("raylib.zig");

        raylib.ClearBackground(raylib.RAYWHITE);

        // Draw grid
        // var x: i32 = 0;
        // while (x < self.cols) : (x += 1) {
        //     var y: i32 = 0;
        //     while (y < self.rows) : (y += 1) {
        //         raylib.DrawRectangleLines(
        //             x * self.cell_size,
        //             y * self.cell_size,
        //             self.cell_size,
        //             self.cell_size,
        //             raylib.LIGHTGRAY
        //         );
        //     }
        // }

        self.player.draw(self.cell_size);
        raylib.DrawFPS(self.screen_width - 100, 10);
    }
};