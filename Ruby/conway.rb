class Grid
    attr_accessor :height, :width, :rows

    def initialize(height, width)
        self.height = height
        self.width = width
        self.rows = Array.new(height) { Array.new(width, false) }
    end

    def query(x, y)
        return self.rows[x % self.height][y % self.width]
    end

    def assign(x, y, state)
        self.rows[x % self.height][y % self.width] = state
    end

    def count_neighbors(x, y)
        n = self.query(x + 1, y)
        ne = self.query(x + 1, y + 1)
        e = self.query(x, y + 1)
        se = self.query(x - 1, y + 1)
        s = self.query(x - 1, y)
        sw = self.query(x - 1, y - 1)
        w = self.query(x, y - 1)
        nw = self.query(x + 1, y - 1)
        neighbor_states = [n, ne, e, se, s, sw, w, nw]
        states = neighbor_states.select {|state| state}
        return states.length
    end

    def print_grid
        for i in 0..height - 1
            for j in 0..width - 1
                putc self.rows[i][j] ? "#" : "."
            end
            puts
        end
    end

    def game_logic(state, neighbors)
        case state
        when true
            if neighbors < 2
                return false
            end
            if neighbors > 3
                return false
            end
            return state
        when false
            if neighbors == 3
                return true
            end
            return state
        end
    end

    def step_cell(x, y)
        state = self.query(x, y)
        neighbors = self.count_neighbors(x, y)
        next_state = self.game_logic(state, neighbors)
        return next_state
    end

    def simulate
        new_rows = Array.new(height) { Array.new(width, false) }

        for i in 0..height - 1
            for j in 0..width - 1
                new_rows[i][j] = self.step_cell(i, j)
            end
        end

        self.rows = new_rows
    end

    def clear_screen
        puts `clear`
        # puts "\e[H\e[2J"
    end

end

g = Grid.new(10, 20)

g.assign(0, 3, true)
g.assign(1, 4, true)
g.assign(2, 2, true)
g.assign(2, 3, true)
g.assign(2, 4, true)

g.print_grid

while true
    g.clear_screen
    g.simulate
    g.print_grid
    sleep(0.1)
end

# ruby conway.rb
