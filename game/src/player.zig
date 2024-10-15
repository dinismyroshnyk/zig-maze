const raylib = @import("raylib.zig");

pub const Player = struct {
    pos: @Vector(2, c_int),

    pub fn init() Player {
        return Player{ .pos = .{ 0, 0 } };
    }

    pub fn move(self: *Player, pos_x: c_int, pos_y: c_int, cell_size: c_int, cols: c_int, rows: c_int) void {
        const new_x = self.pos[0] + pos_x * cell_size;
        const new_y = self.pos[1] + pos_y * cell_size;

        if (new_x >= 0 and new_x < cols * cell_size) {
            self.pos[0] = new_x;
        }
        if (new_y >= 0 and new_y < rows * cell_size) {
            self.pos[1] = new_y;
        }
    }

    pub fn update(self: *Player, cell_size: c_int, cols: c_int, rows: c_int) void {
        if (raylib.IsKeyPressed(raylib.KEY_RIGHT) or raylib.IsKeyPressed(raylib.KEY_D)) {
            self.move(1, 0, cell_size, cols, rows);
        } else if (raylib.IsKeyPressed(raylib.KEY_LEFT) or raylib.IsKeyPressed(raylib.KEY_A)) {
            self.move(-1, 0, cell_size, cols, rows);
        } else if (raylib.IsKeyPressed(raylib.KEY_UP) or raylib.IsKeyPressed(raylib.KEY_W)) {
            self.move(0, -1, cell_size, cols, rows);
        } else if (raylib.IsKeyPressed(raylib.KEY_DOWN) or raylib.IsKeyPressed(raylib.KEY_S)) {
            self.move(0, 1, cell_size, cols, rows);
        }
    }

    pub fn render(self: Player, cell_size: c_int) void {
        raylib.DrawRectangle(self.pos[0], self.pos[1], cell_size, cell_size, raylib.RED);
    }
};