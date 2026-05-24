from time import sleep


class Conway:
    def __init__(self, height, width):
        self.height = height
        self.width = width
        self.grid = self.new_grid()

    def new_grid(self):
        return [[False for _ in range(0, self.width)]
                for _ in range(0, self.height)]

    def query(self, x, y):
        return self.grid[x % self.height][y % self.width]

    def assign(self, x, y, state):
        self.grid[x % self.height][y % self.width] = state

    def count_neighbors(self, x, y):
        n  = self.query(x + 1, y    )
        ne = self.query(x + 1, y + 1)
        e  = self.query(x,     y + 1)
        se = self.query(x - 1, y + 1)
        s  = self.query(x - 1, y    )
        sw = self.query(x - 1, y - 1)
        w  = self.query(x,     y - 1)
        nw = self.query(x + 1, y - 1)
        neighbor_states = [n, ne, e, se, s, sw, w, nw]
        return len(list(filter(lambda state: state, neighbor_states)))

    def draw(self, value):
        return '#' if value else '.'

    def print_grid(self):
        for row in self.grid:
            for c in row:
                print(self.draw(c), end='')
            print()

    def game_logic(self, state, neighbors):
        match state:
            case True:
                if neighbors < 2:
                    return False
                if neighbors > 3:
                    return False
                return state
            case False:
                if neighbors == 3:
                    return True
                return state

    def step_cell(self, x, y):
        state = self.query(x, y)
        neighbors = self.count_neighbors(x, y)
        next_state = self.game_logic(state, neighbors)
        return next_state

    def simulate(self):
        new_g = self.new_grid()

        for x in range(0, self.height):
            for y in range(0, self.width):
                new_g[x][y] = self.step_cell(x, y)

        self.grid = new_g

    def clear_screen(self):
        print('\x1b[2J')


if __name__ == '__main__':
    con = Conway(10, 20)

    con.assign(0, 3, True)
    con.assign(1, 4, True)
    con.assign(2, 2, True)
    con.assign(2, 3, True)
    con.assign(2, 4, True)

    con.print_grid()

    while True:
        con.clear_screen()
        con.simulate()
        con.print_grid()
        sleep(0.1)

# python3 conway.py
