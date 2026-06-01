class Conway
    attr_accessor :height, :width, :grid

    def initialize(height, width)
        self.height = height
        self.width = width
        self.grid = Array.new(height) { Array.new(width, 0) }
    end

    def query(x, y)
        return self.grid[x % self.height][y % self.width]
    end

    def assign(x, y, state)
        self.grid[x % self.height][y % self.width] = state
    end

    def count_neighbors(x, y)
        n  = self.query(x + 1, y    )
        ne = self.query(x + 1, y + 1)
        e  = self.query(x,     y + 1)
        se = self.query(x - 1, y + 1)
        s  = self.query(x - 1, y    )
        sw = self.query(x - 1, y - 1)
        w  = self.query(x,     y - 1)
        nw = self.query(x + 1, y - 1)
        neighbor_states = [n, ne, e, se, s, sw, w, nw]
        return neighbor_states.sum
    end

    def print_grid
        for i in 0..height - 1
            for j in 0..width - 1
                putc self.grid[i][j] == 1 ? "#" : "."
            end
            puts
        end
    end

    def game_logic(state, neighbors)
        case state
        when 1
            if neighbors < 2
                return 0
            end
            if neighbors > 3
                return 0
            end
            return state
        when 0
            if neighbors == 3
                return 1
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
        new_grid = Array.new(height) { Array.new(width, 1) }

        for i in 0..height - 1
            for j in 0..width - 1
                new_grid[i][j] = self.step_cell(i, j)
            end
        end

        self.grid = new_grid
    end

    def clear_screen
        puts `clear`
        # puts "\e[H\e[2J"
    end

end

g = Conway.new(10, 20)

g.assign(0, 3, 1)
g.assign(1, 4, 1)
g.assign(2, 2, 1)
g.assign(2, 3, 1)
g.assign(2, 4, 1)

g.print_grid

while true
    g.clear_screen
    g.simulate
    g.print_grid
    sleep(0.1)
end

# ruby conway.rb
