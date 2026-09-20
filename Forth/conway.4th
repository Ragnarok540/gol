5 constant height
5 constant width
height width * constant size
size 1 - constant limit
variable grid limit cells allot
grid size cells erase
: fm ( x y -- r c ) swap dup width mod swap height mod ;
: index ( r c -- i ) width rot * + ;
: query-grid ( r c -- n ) fm index cells grid + @ ;
: assign ( n r c -- ) index cells grid + ! ;
: print-grid ( -- )
    size 0 do
        i width mod 0 = if
            CR
        then
        i cells grid + @ .
    loop
    CR ;

1 0 1 assign
1 1 2 assign
1 2 0 assign
1 2 1 assign
1 2 2 assign

1 4 4 assign
\ -1 -1 fm . .
-1 -1 query-grid . CR
0 1 query-grid . CR

print-grid

bye

\ gforth conway.4th
