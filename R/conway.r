height <- 10
width <- 20
vec <- c(0)
matrix <- array(vec, c(height, width))

query <- function(m, x, y) {
    return(m[x %% height + 1, y %% width + 1])
}

assign <- function(m, x, y, state) {
    m[x %% height + 1, y %% width + 1] <- state
    return(m)
}

count_neighbors <- function(m, x, y) {
    n <- query(m, x + 1, y)
    ne <- query(m, x + 1, y + 1)
    e <- query(m, x, y + 1)
    se <- query(m, x - 1, y + 1)
    s <- query(m, x - 1, y)
    sw <- query(m, x - 1, y - 1)
    w <- query(m, x, y - 1)
    nw <- query(m, x + 1, y - 1)
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

print_matrix <- function(m) {
    for (r in seq(nrow(m))) {
        for (c in seq(ncol(m))) {
            cat(draw(m[r, c]))
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

step_cell <- function(m, x, y) {
    state <- query(m, x, y)
    neighbors <- count_neighbors(m, x, y)
    next_state <- game_logic(state, neighbors)
    return(next_state)
}

simulate <- function(m) {
    new_vec <- c(0)
    new_matrix <- array(new_vec, c(height, width))
    for (r in seq(nrow(m))) {
        for (c in seq(ncol(m))) {
            new_state <- step_cell(m, r, c)
            new_matrix <- assign(new_matrix, r, c, new_state)
        }
    }
    return(new_matrix)
}

clear_screen <- function() {
    cat("\x1b[2J")
}

matrix = assign(matrix, 1, 4, 1)
matrix = assign(matrix, 2, 5, 1)
matrix = assign(matrix, 3, 3, 1)
matrix = assign(matrix, 3, 4, 1)
matrix = assign(matrix, 3, 5, 1)

print_matrix(matrix)

repeat {
    clear_screen()
    matrix <- simulate(matrix)
    print_matrix(matrix)
    Sys.sleep(0.1)
}

# Rscript conway.r
