function new_matrix(height, width)
    matrix = {}
    for i=1, height do
        matrix[i] = {}
        for j=1, width do
            matrix[i][j] = 0
        end
    end
    return matrix
end

function query(m, x, y)
    height = #m
    width = #m[1]
    return m[x % height + 1][y % width + 1]
end

function assign(m, x, y, state)
    height = #m
    width = #m[1]
    m[x % height + 1][y % width + 1] = state
end

function count_neighbors(m, x, y)
    n = query(m, x + 1, y)
    ne = query(m, x + 1, y + 1)
    e = query(m, x, y + 1)
    se = query(m, x - 1, y + 1)
    s = query(m, x - 1, y)
    sw = query(m, x - 1, y - 1)
    w = query(m, x, y - 1)
    nw = query(m, x + 1, y - 1)
    return n + ne + e + se + s + sw + w + nw
end

function draw(value)
    if value == 1 then
        return "#"
    else
        return "."
    end
end

function print_matrix(m)
    for y, row in pairs(m) do
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

function step_cell(m, x, y)
    state = query(m, x, y)
    neighbors = count_neighbors(m, x, y)
    next_state = game_logic(state, neighbors)
    return next_state
end

function simulate(m)
    height = #m
    width = #m[1]
    new_m = new_matrix(height, width)
    for i=1, height do
        for j=1, width do
            new_state = step_cell(m, i, j)
            assign(new_m, i, j, new_state) 
        end
    end
    return new_m
end

function clear_screen()
    io.write('\x1b[2J')
end

function sleep(n)
  t0 = os.clock()
  while os.clock() - t0 <= n do end
end

matrix = new_matrix(10, 20)

assign(matrix, 1, 4, 1)
assign(matrix, 2, 5, 1)
assign(matrix, 3, 3, 1)
assign(matrix, 3, 4, 1)
assign(matrix, 3, 5, 1)

print_matrix(matrix)

while true do
    clear_screen()
    matrix = simulate(matrix)
    print_matrix(matrix)
    sleep(0.1)
end
