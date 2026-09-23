5 constant height
5 constant width
height width * constant size
size 1 - constant limit

variable grid limit cells allot
grid size cells erase

variable new-grid limit cells allot
new-grid size cells erase

variable x
variable y

: fm ( x y -- r c ) swap width mod swap height mod ;
: index ( r c -- i ) width rot * + ;
: query-grid ( r c -- n ) fm index cells grid + @ ;
: assign-grid ( n r c -- ) index cells grid + ! ;
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
: count-neighbors ( x y -- n )
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

1 0 1 assign-grid
1 1 2 assign-grid
1 2 0 assign-grid
1 2 1 assign-grid
1 2 2 assign-grid

\ 0 0 count-neighbors . CR

print-grid

\ bye

\ gforth conway.4th
