defmodule Conway do
    defstruct [:height, :width, :grid] 

    def new(h, w) do
        grid = for _ <- 0..h-1 do
            for _ <- 0..w-1, do: 0
        end
        %__MODULE__{
            height: h,
            width: w,
            grid: grid,
        }
    end

    def draw(row) do
        Enum.map(row, fn e ->
            case e do
                0 -> "."
                1 -> "#"
            end
        end)
    end

    def print(g) do
        Enum.map(g.grid, fn row ->
            IO.puts(Enum.join(draw(row), ""))
        end)
    end

    def assign(g, y, x, state) do
        row = Enum.at(g.grid, y)
        updated_row = List.replace_at(row, x, state)
        grid = List.replace_at(g.grid, y, updated_row)
        %{g | grid: grid}
    end

    def mod(x, y) when x > 0, do: rem(x, y)
    def mod(x, y) when x < 0, do: rem(y + x, y)
    def mod(0, _), do: 0

    def query(g, y, x) do
        row = Enum.at(g.grid, mod(y, g.height))
        Enum.at(row, mod(x, g.width))
    end

    def count_neighbors(g, y, x) do
        n  = query(g, y + 1, x    )
        ne = query(g, y + 1, x + 1)
        e  = query(g, y,     x + 1)
        se = query(g, y - 1, x + 1)
        s  = query(g, y - 1, x    )
        sw = query(g, y - 1, x - 1)
        w  = query(g, y,     x - 1)
        nw = query(g, y + 1, x - 1)
        n + ne + e + se + s + sw + w + nw
    end

    def game_logic(1, neighbors) do
        if neighbors < 2 or neighbors > 3 do
            0
        else
            1
        end
    end
    def game_logic(0, neighbors) do
        if neighbors == 3 do
            1
        else
            0
        end
    end

    def step_cell(g, y, x) do
        state = query(g, y, x)
        neighbors = count_neighbors(g, y, x)
        game_logic(state, neighbors)
    end

    def simulate(g) do
        grid = for y <- 0..g.height-1 do
            for x <- 0..g.width-1, do: step_cell(g, y, x)
        end
        %{g | grid: grid}
    end

    def clear_screen do
        IO.puts("\ec")
    end

    def demo_grid do
        height = 10
        width = 20
        g = new(height, width)
        g = assign(g, 0, 3, 1)
        g = assign(g, 1, 4, 1)
        g = assign(g, 2, 2, 1)
        g = assign(g, 2, 3, 1)
        assign(g, 2, 4, 1)
    end

    def run_simulation(g) do
        clear_screen()
        g = simulate(g)
        print(g)
        Process.sleep(100)
        run_simulation(g)
    end

    def start do
        g = demo_grid()
        run_simulation(g)
    end
end

Conway.start

# elixir conway.exs
