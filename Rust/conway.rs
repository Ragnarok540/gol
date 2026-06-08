use std::{thread, time};
use std::time::{Duration};

struct Conway<const HEIGHT: usize, const WIDTH: usize> {
    grid: [[i8; WIDTH]; HEIGHT],
}

impl<const HEIGHT: usize, const WIDTH: usize> Conway<HEIGHT, WIDTH> {
    fn new() -> Self {
        Self {
            grid: [[0; WIDTH]; HEIGHT],
        }
    }

    fn query(&self, x: i8, y: i8) -> i8 {
        self.grid[x.rem_euclid(HEIGHT as i8) as usize][y.rem_euclid(WIDTH as i8) as usize]
    }

    fn assign(&mut self, x: i8, y: i8, state: i8) {
        self.grid[x.rem_euclid(HEIGHT as i8) as usize][y.rem_euclid(WIDTH as i8) as usize] = state;
    }

    fn count_neighbors(&self, x: i8, y: i8) -> i8 {
        let n  = self.query(x + 1, y    );
        let ne = self.query(x + 1, y + 1);
        let e  = self.query(x,     y + 1);
        let se = self.query(x - 1, y + 1);
        let s  = self.query(x - 1, y    );
        let sw = self.query(x - 1, y - 1);
        let w  = self.query(x,     y - 1);
        let nw = self.query(x + 1, y - 1);
        n + ne + e + se + s + sw + w + nw
    }

    fn print(&self) {
        for row in self.grid {
            for x in row {
                let c = if x == 1 { '#' } else { '.' };
                print!("{c}");
            }
            print!("\n");
        }
    }

    fn game_logic(state: i8, neighbors: i8) -> i8 {
        if state == 1 {
            if neighbors < 2 {
                return 0;
            }
            if neighbors > 3 {
                return 0;
            }
            state
        } else {
             if neighbors == 3 {
                return 1;
            }
            state
        }
    }

    fn step_cell(&self, x: i8, y: i8) -> i8 {
        let state = self.query(x, y);
        let neighbors = self.count_neighbors(x, y);
        let next_state = Self::game_logic(state, neighbors);
        next_state
    }

    fn simulate(&mut self) {
        let mut new_grid = [[0; WIDTH]; HEIGHT];
        for x in 0..HEIGHT {
            for y in 0..WIDTH {
                new_grid[x][y] = self.step_cell(x as i8, y as i8);
            }
        }
        self.grid = new_grid;
    }

    fn clear_screen() {
        print!("\x1B[2J");
    }
}

fn main() {
    const HEIGHT: usize = 10;
    const WIDTH: usize = 20;
    const HUNDRED_MILLIS: Duration = time::Duration::from_millis(100);
    let mut conway: Conway<HEIGHT, WIDTH> = Conway::new();

    conway.assign(0, 3, 1);
    conway.assign(1, 4, 1);
    conway.assign(2, 2, 1);
    conway.assign(2, 3, 1);
    conway.assign(2, 4, 1);

    conway.print();

    loop {
        Conway::<HEIGHT, WIDTH>::clear_screen();
        conway.simulate();
        conway.print();
        thread::sleep(HUNDRED_MILLIS);
    }

}

// mkdir -p bin
// rustc -o bin/conway conway.rs
// ./bin/conway
