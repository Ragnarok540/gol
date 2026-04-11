struct Conway<const HEIGHT: usize, const WIDTH: usize> {
    matrix: [[i8; WIDTH]; HEIGHT],
}

impl<const HEIGHT: usize, const WIDTH: usize> Conway<HEIGHT, WIDTH> {
    fn query(&self, x: i8, y: i8) -> i8 {
        self.matrix[x.rem_euclid(HEIGHT as i8) as usize][y.rem_euclid(WIDTH as i8) as usize]
    }

    fn assign(&mut self, x: i8, y: i8, state: i8) {
        self.matrix[x.rem_euclid(HEIGHT as i8) as usize][y.rem_euclid(WIDTH as i8) as usize] = state;
    }

    fn count_neighbors(self, x: i8, y: i8) -> i8 {
        let n = self.query(x + 1, y);
        let ne = self.query(x + 1, y + 1);
        let e = self.query(x, y + 1);
        let se = self.query(x - 1, y + 1);
        let s = self.query(x - 1, y);
        let sw = self.query(x - 1, y - 1);
        let w = self.query(x, y - 1);
        let nw = self.query(x + 1, y - 1);
        n + ne + e + se + s + sw + w + nw
    }

    fn print(&self) {
        for row in self.matrix {
            for x in row {
                print!("{x}");
            }
            print!("\n");
        }
    }
}

fn main() {
    const HEIGHT: usize = 10;
    const WIDTH: usize = 20;

    let mut conway = Conway {
        matrix: [[0; WIDTH]; HEIGHT],
    };

    conway.assign(0, 3, 1);
    conway.assign(1, 4, 1);
    conway.assign(2, 2, 1);
    conway.assign(2, 3, 1);
    conway.assign(2, 4, 1);

    conway.print();

    // let x = conway.count_neighbors(1, 3);
    // print!("{x}");
}

// mkdir -p bin
// rustc -o bin/conway conway.rs
// ./bin/conway
