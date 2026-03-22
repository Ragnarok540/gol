from time import sleep


class Grid:
    def __init__(self, height, width):
        self.height = height
        self.width = width
        self.rows = [[False for _ in range(0, self.width)]
                     for _ in range(0, self.height)]

    def query(self, x, y):
        return self.rows[x % self.height][y % self.width]

    def assign(self, x, y, state):
        self.rows[x % self.height][y % self.width] = state

    def count_neighbors(self, x, y):
        n = self.query(x + 1, y)
        ne = self.query(x + 1, y + 1)
        e = self.query(x, y + 1)
        se = self.query(x - 1, y + 1)
        s = self.query(x - 1, y)
        sw = self.query(x - 1, y - 1)
        w = self.query(x, y - 1)
        nw = self.query(x + 1, y - 1)
        neighbor_states = [n, ne, e, se, s, sw, w, nw]
        return len(list(filter(lambda state: state, neighbor_states)))

    def draw(self, value):
        return '#' if value else '.'

    def print(self):
        for row in self.rows:
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
        new_rows = [[False for _ in range(0, self.width)]
                    for _ in range(0, self.height)]

        for x in range(0, self.height):
            for y in range(0, self.width):
                new_rows[x][y] = self.step_cell(x, y)

        self.rows = new_rows

    def clear_screen(self):
        print('\x1b[2J')


if __name__ == '__main__':
    g = Grid(10, 20)

    g.assign(0, 3, True)
    g.assign(1, 4, True)
    g.assign(2, 2, True)
    g.assign(2, 3, True)
    g.assign(2, 4, True)

    g.print()

    while True:
        g.clear_screen()
        g.simulate()
        g.print()
        sleep(0.5)
