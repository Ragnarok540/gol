query <- function(g, x, y) {
    h <- dim(g)[1]
    w <- dim(g)[2]
    return(g[x %% h + 1, y %% w + 1])
}

assign <- function(g, x, y, state) {
    h <- dim(g)[1]
    w <- dim(g)[2]
    g[x %% h + 1, y %% w + 1] <- state
    return(g)
}

count_neighbors <- function(g, x, y) {
    n  <- query(g, x + 1, y    )
    ne <- query(g, x + 1, y + 1)
    e  <- query(g, x,     y + 1)
    se <- query(g, x - 1, y + 1)
    s  <- query(g, x - 1, y    )
    sw <- query(g, x - 1, y - 1)
    w  <- query(g, x    , y - 1)
    nw <- query(g, x + 1, y - 1)
    neighbor_states <- c(n, ne, e, se, s, sw, w, nw)
    return(sum(neighbor_states))
}

draw <- function(value) {
    if (value == 1) {
        return("#")
    } else {
        return(".")
    }
}

print_grid <- function(g) {
    for (r in seq(nrow(g))) {
        for (c in seq(ncol(g))) {
            cat(draw(g[r, c]))
        }
        cat("\n")
    }
}

game_logic <- function(state, neighbors) {
    if (state == 1) { 
        if (neighbors < 2) {
            return(0)
        }
        if (neighbors > 3) {
            return(0)
        }
        return(state)
    } else {
        if (neighbors == 3) {
            return(1)
        }
        return(state)
    }
}

step_cell <- function(g, x, y) {
    state <- query(g, x, y)
    neighbors <- count_neighbors(g, x, y)
    next_state <- game_logic(state, neighbors)
    return(next_state)
}

simulate <- function(g) {
    h <- dim(g)[1]
    w <- dim(g)[2]
    new_vec <- c(0)
    new_grid <- array(new_vec, c(h, w))
    for (r in seq(nrow(g))) {
        for (c in seq(ncol(g))) {
            new_state <- step_cell(g, r, c)
            new_grid <- assign(new_grid, r, c, new_state)
        }
    }
    return(new_grid)
}

clear_screen <- function() {
    cat("\x1b[2J")
}

height <- 10
width <- 20
vec <- c(0)
grid <- array(vec, c(height, width))

grid = assign(grid, 1, 4, 1)
grid = assign(grid, 2, 5, 1)
grid = assign(grid, 3, 3, 1)
grid = assign(grid, 3, 4, 1)
grid = assign(grid, 3, 5, 1)

print_grid(grid)

repeat {
    clear_screen()
    grid <- simulate(grid)
    print_grid(grid)
    Sys.sleep(0.1)
}

# Rscript conway.r
