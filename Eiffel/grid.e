class GRID
create make
feature
    a: ARRAY [INTEGER]
    height, width: INTEGER

    make (h: INTEGER; w: INTEGER)
        do
            create a.make (1, h * w)
            height := h
            width := w
        end

    draw (state: INTEGER)
        do
            if state = 1 then
                io.put_string ("#")
            else
                io.put_string (".")
            end
        end

    print_grid
        local
            i: INTEGER
        do
            from i := a.lower until i > a.upper loop
                draw (a.item (i))
                if (i \\ width) = 0 then
                    print("%N")
                end
                i := i + 1
            end
        end

    floor_mod (x: INTEGER; y: INTEGER): INTEGER
        do
            if x > 0 then
                Result := x \\ y
            end
            if x < 0 then
                Result := (x + y) \\ y
            end
            if x = 0 then
                Result := 0
            end
        end

    set (x: INTEGER; y: INTEGER; state: INTEGER)
        local
            h, w, i: INTEGER
        do
            h := floor_mod (x, height)
            w := floor_mod (y, width)
            i := (h * width + w) + 1
            a.put (state, i)
        end

    query (x: INTEGER; y: INTEGER): INTEGER
        local
            h, w, i: INTEGER
        do
            h := floor_mod (x, height)
            w := floor_mod (y, width)
            i := (h * width + w) + 1
            Result :=  a.item (i)
        end

    count_neighbors (x: INTEGER; y: INTEGER): INTEGER
        local
            n, ne, e, se, s, sw, w, nw: INTEGER
        do
            n  := query (x + 1, y    )
            ne := query (x + 1, y + 1)
            e  := query (x,     y + 1)
            se := query (x - 1, y + 1)
            s  := query (x - 1, y    )
            sw := query (x - 1, y - 1)
            w  := query (x,     y - 1)
            nw := query (x + 1, y - 1)
            Result := n + ne + e + se + s + sw + w + nw
        end

    game_logic (state: INTEGER; neighbors: INTEGER): INTEGER
        do
            if state = 1 then
                if neighbors < 2 then
                    Result := 0
                elseif neighbors > 3 then
                    Result := 0
                else
                    Result := state
                end
            else
                if neighbors = 3 then
                    Result := 1
                else
                    Result := state
                end
            end
        end

    step_cell (x: INTEGER; y: INTEGER): INTEGER
        local
            state, neighbors: INTEGER
        do
            state := query (x, y)
            neighbors := count_neighbors (x, y)
            Result := game_logic(state, neighbors)
        end

    simulate
        local
            new_a: ARRAY [INTEGER]
            next_state, i, j, k: INTEGER
        do
            create new_a.make (1, height * width)
            from i := 0 until i = height loop
                from j := 0 until j = width loop
                    next_state := step_cell(i, j)
                    k := (i * width + j) + 1
                    new_a.put (next_state, k)
                    j := j + 1
                end
                i := i + 1
            end
            a := new_a
        end

end
