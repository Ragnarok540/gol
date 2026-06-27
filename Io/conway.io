mod := method(x, y,
    if(x > 0, return x % y)
    if(x < 0, return y + x % y)
    return 0
)

Conway := Object clone do(
    grid := list()
    dim := method(height, width,
        for(i, 1, height,
            ls := list()
            for(j, 1, width,
                ls append(0)
            )
            grid append(ls)
        )
    )
    query := method(x, y,
        height := grid size
        width := grid at(0) size
        ls := grid at(mod(x, height))
        ls at(mod(y, width))
    )
    assign := method(x, y, value,
        height := grid size
        width := grid at(0) size
        ls := grid at(mod(x, height))
        ls atPut(mod(y, width), value)
    )
    countNeighbors := method(x, y,
        n  := query(x + 1, y    )
        ne := query(x + 1, y + 1)
        e  := query(x,     y + 1)
        se := query(x - 1, y + 1)
        s  := query(x - 1, y    )
        sw := query(x -1,  y - 1)
        w  := query(x,     y - 1)
        nw := query(x + 1, y - 1)
        return n + ne + e + se + s + sw + w + nw
    )
    draw := method(value,
        if(value == 1, return "#", return ".") 
    )
    printConway := method(
        height := grid size
        width := grid at(0) size
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
        height := grid size
        width := grid at(0) size
        NewConway := Conway clone
        NewConway grid := list()
        NewConway dim(height, width)
        for(i, 0, height - 1,
            for(j, 0, width - 1,
                NewConway assign(i, j, stepCell(i, j))
            )
        )
        NewConway
    )
    clearScreen := method(
        write("\x1B[2J")
    )
)

Conway dim(10, 20)
Conway assign(0, 3, 1)
Conway assign(1, 4, 1)
Conway assign(2, 2, 1)
Conway assign(2, 3, 1)
Conway assign(2, 4, 1)

Conway printConway

while(true,
    // Conway clearScreen
    Conway := Conway simulate
    Conway printConway
    System sleep(0.1)
)

# io conway.io
