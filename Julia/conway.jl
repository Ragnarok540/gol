function query(g, x, y)
    h, w = size(g)
    return g[mod(x, h) + 1, mod(y, w) + 1]
end

function assign(g, x, y, state)
    h, w = size(g)
    g[mod(x, h) + 1, mod(y, w) + 1] = state
end

function count_neighbors(g, x, y)
    n  = query(g, x + 1, y    )
    ne = query(g, x + 1, y + 1)
    e  = query(g, x,     y + 1)
    se = query(g, x - 1, y + 1)
    s  = query(g, x - 1, y    )
    sw = query(g, x - 1, y - 1)
    w  = query(g, x,     y - 1)
    nw = query(g, x + 1, y - 1)
    return n + ne + e + se + s + sw + w + nw;
end

function game_logic(state, neighbors)
    if (state == 1)
        if (neighbors < 2)
            return 0
        elseif (neighbors > 3)
            return 0
        else
            return 1
        end
    else
        if (neighbors == 3)
            return 1
        else
            return 0
        end
    end
end

function step_cell(g, x, y)
    state = query(g, x, y)
    neighbors = count_neighbors(g, x, y)
    return game_logic(state, neighbors)
end

function simulate(g)
    h, w = size(g)
    new_g = zeros(Int8, h, w)
    for i = 1:h
        for j = 1:w
            next = step_cell(g, i, j);
            assign(new_g, i, j, next);
        end
    end
    return new_g
end

g = zeros(Int8, 10, 10)

assign(g, 0, 3, 1)
assign(g, 1, 4, 1)
assign(g, 2, 2, 1)
assign(g, 2, 3, 1)
assign(g, 2, 4, 1)

display(g)

while (true)
    global g = simulate(g)
    display(g)
    sleep(0.4)
end

# julia conway.jl
