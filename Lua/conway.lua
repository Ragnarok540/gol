function new_grid(height, width)
    grid = {}
    for i=1, height do
        grid[i] = {}
        for j=1, width do
            grid[i][j] = 0
        end
    end
    return grid
end

function query(grid, x, y)
    height = #grid
    width = #grid[1]
    return grid[x % height + 1][y % width + 1]
end

function assign(grid, x, y, state)
    height = #grid
    width = #grid[1]
    grid[x % height + 1][y % width + 1] = state
end

function count_neighbors(grid, x, y)
    n  = query(grid, x + 1, y    )
    ne = query(grid, x + 1, y + 1)
    e  = query(grid, x,     y + 1)
    se = query(grid, x - 1, y + 1)
    s  = query(grid, x - 1, y    )
    sw = query(grid, x - 1, y - 1)
    w  = query(grid, x,     y - 1)
    nw = query(grid, x + 1, y - 1)
    return n + ne + e + se + s + sw + w + nw
end

function draw(value)
    if value == 1 then
        return "#"
    else
        return "."
    end
end

function print_grid(grid)
    for y, row in pairs(grid) do
        for x, value in pairs(row) do
            io.write(draw(value))
        end
        print()
    end
end

function game_logic(state, neighbors)
    if state == 1 then
        if neighbors < 2 then
            return 0
        end
        if neighbors > 3 then
            return 0
        end
        return state
    else
        if neighbors == 3 then
            return 1
        end
        return state
    end
end

function step_cell(grid, x, y)
    state = query(grid, x, y)
    neighbors = count_neighbors(grid, x, y)
    next_state = game_logic(state, neighbors)
    return next_state
end

function simulate(grid)
    height = #grid
    width = #grid[1]
    new_g = new_grid(height, width)
    for i=1, height do
        for j=1, width do
            new_state = step_cell(grid, i, j)
            assign(new_g, i, j, new_state) 
        end
    end
    return new_g
end

function clear_screen()
    io.write('\x1b[2J')
end

function sleep(n)
  t0 = os.clock()
  while os.clock() - t0 <= n do end
end

grid = new_grid(10, 20)

assign(grid, 1, 4, 1)
assign(grid, 2, 5, 1)
assign(grid, 3, 3, 1)
assign(grid, 3, 4, 1)
assign(grid, 3, 5, 1)

print_grid(grid)

while true do
    clear_screen()
    grid = simulate(grid)
    print_grid(grid)
    sleep(0.1)
end

-- lua conway.lua
