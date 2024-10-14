const raylib = @import("raylib.zig");

pub const Player = struct {
    x: i32,
    y: i32,

    pub fn init(x: i32, y: i32) Player {
        return Player{ .x = x, .y = y };
    }

    pub fn move(self: *Player, dx: i32, dy: i32, cell_size: i32, cols: i32, rows: i32) void {
        const new_x = self.x + dx * cell_size;
        const new_y = self.y + dy * cell_size;

        if (new_x >= 0 and new_x < cols * cell_size) {
            self.x = new_x;
        }
        if (new_y >= 0 and new_y < rows * cell_size) {
            self.y = new_y;
        }
    }

    pub fn draw(self: Player, cell_size: i32) void {
        raylib.DrawRectangle(self.x, self.y, cell_size, cell_size, raylib.RED);
    }
};