5 constant height
5 constant width
height width * constant size
size 1 - constant limit

variable grid limit cells allot
grid size cells erase

variable new-grid limit cells allot

variable x
variable y
variable state
variable neighbors

: fm ( n n -- n n )
    swap width mod swap height mod ;

: index ( n n -- n )
    width rot * + ;

: query-grid ( n n -- n )
    fm index cells grid + @ ;

: assign-grid ( n n n -- )
    index cells grid + ! ;

: print-grid ( -- )
    size 0 do
        i width mod 0 = if
            CR
        then
        i cells grid + @ .
    loop
    CR ;

: copy-grid ( -- )
    size 0 do
        i cells new-grid + @
        i cells grid + !
    loop ;

: count-neighbors ( n n -- n )
    y ! x !
    x @ 1 + y @     query-grid \ n
    x @ 1 + y @ 1 + query-grid \ ne
    x @     y @ 1 + query-grid \ e
    x @ 1 - y @ 1 + query-grid \ se
    x @ 1 - y @     query-grid \ s
    x @ 1 - y @ 1 - query-grid \ sw
    x @     y @ 1 - query-grid \ w
    x @ 1 + y @ 1 - query-grid \ nw
    + + + + + + + ;

: game-logic ( n n -- n )
    neighbors ! state !
    state @ 1 = if
        neighbors @ 2 < if
            0
        else
            neighbors @ 3 > if
                0
            else
                state @
            then
        then
    else
        neighbors @ 3 = if
            1
        else
            state @
        then
    then ;

: step-cell ( n n -- n )
    y ! x !
    x @ y @ query-grid
    x @ y @ count-neighbors
    game-logic ;

: simulate ( -- )
    new-grid size cells erase
    height 0 do
        width 0 do
            i j step-cell
            i j index cells new-grid + ! 
        loop
    loop
    copy-grid ;

: run ( -- )
    0 begin
        page
        simulate
        print-grid
        500 ms
    again ;

1 0 1 assign-grid
1 1 2 assign-grid
1 2 0 assign-grid
1 2 1 assign-grid
1 2 2 assign-grid

print-grid
run
bye

\ gforth conway.4th
