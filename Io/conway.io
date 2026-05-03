mod := method(x, y,
    if(x > 0, return x % y)
    if(x < 0, return y + x % y)
    return 0
)

Matrix := Object clone do(
    cells := list()
    dim := method(height, width,
        for(i, 1, height,
            ls := list()
            for(j, 1, width,
                ls append(0)
            )
            cells append(ls)
        )
    )
    query := method(x, y,
        height := cells size
        width := cells at(0) size
        ls := cells at(mod(x, height))
        ls at(mod(y, width))
    )
    assign := method(x, y, value,
        height := cells size
        width := cells at(0) size
        ls := cells at(mod(x, height))
        ls atPut(mod(y, width), value)
    )
    countNeighbors := method(x, y,
        n := query(x+1, y)
        ne := query(x+1, y+1)
        e := query(x, y+1)
        se := query(x-1, y+1)
        s := query(x-1, y)
        sw := query(x-1, y-1)
        w := query(x, y-1)
        nw := query(x+1, y-1)
        return n + ne + e + se + s + sw + w + nw
    )
    draw := method(value,
        if(value == 1, return "#", return ".") 
    )
    printMatrix := method(
        height := cells size
        width := cells at(0) size
        for(i, 0, height - 1,
            for(j, 0, width - 1,
                write(draw(query(i, j)))
            )
            write("\n")
        )
    )
    gameLogic := method(state, neighbors,
        if(state == 1,
            if(neighbors < 2, return 0)
            if(neighbors > 3, return 0)
            return state,
            if(neighbors == 3, return 1)
            return state
        )
    )
    stepCell := method(x, y,
        state := query(x, y)
        neighbors := countNeighbors(x, y)
        nextState := gameLogic(state, neighbors)
        return nextState
    )
    simulate := method(
        height := cells size
        width := cells at(0) size
        NewMatrix := Matrix clone
        NewMatrix cells := list()
        NewMatrix dim(height, width)
        for(i, 0, height - 1,
            for(j, 0, width - 1,
                NewMatrix assign(i, j, stepCell(i, j))
            )
        )
        NewMatrix
    )
    clearScreen := method(
        write("\x1b[2J")
    )
)

Matrix dim(10, 20)
Matrix assign(0, 3, 1)
Matrix assign(1, 4, 1)
Matrix assign(2, 2, 1)
Matrix assign(2, 3, 1)
Matrix assign(2, 4, 1)

Matrix printMatrix

for(i, 0, 500,
    // Matrix clearScreen
    Matrix := Matrix simulate
    Matrix printMatrix
    System sleep(0.1)
)
