clc, clearvars

function out = modulo(x, y)
    if (x > 0)
        out = mod(x, y);
    elseif (x < 0)
        out = mod(y + x, y);
    else
        out = 0;
    endif
end

function out = query(c, x, y)
    width = length(c);
    height = length(c(:,1));
    out = c(modulo(x, height) + 1, modulo(y, width) + 1);
end

function c = assign(c, x, y, state)
    width = length(c);
    height = length(c(:,1));
   c(modulo(x, height) + 1, modulo(y, width) + 1) = state;
end

function neighbors = count_neighbors(c, x, y)
    n  = query(c, x + 1, y    );
    ne = query(c, x + 1, y + 1);
    e  = query(c, x,     y + 1);
    se = query(c, x - 1, y + 1);
    s  = query(c, x - 1, y    );
    sw = query(c, x - 1, y - 1);
    w  = query(c, x,     y - 1);
    nw = query(c, x + 1, y - 1);
    neighbors = n + ne + e + se + s + sw + w + nw;
end

function next = game_logic(state, neighbors)
    if (state == 1)
        if (neighbors < 2)
            next = 0;
        elseif (neighbors > 3)
            next = 0;
        else
            next = 1;
        endif
    else
        if (neighbors == 3)
            next = 1;
        else
            next = 0;
        endif
    endif
end

function next = step_cell(c, x, y)
    state = query(c, x, y);
    neighbors = count_neighbors(c, x, y);
    next = game_logic(state, neighbors);
end

function new_c = simulate(c)
    width = length(c);
    height = length(c(:,1));
    new_c = zeros(height, width);
    for i = 1:height
        for j = 1:width
            next = step_cell(c, i, j);
            new_c = assign(new_c, i, j, next);
        endfor
    endfor
end

C = zeros(10, 20);
C = assign(C, 1, 4, 1);
C = assign(C, 2, 5, 1);
C = assign(C, 3, 3, 1);
C = assign(C, 3, 4, 1);
C = assign(C, 3, 5, 1)

while (true)
    % clc
    C = simulate(C)
    pause(0.1)
endwhile

% octave conway.m
