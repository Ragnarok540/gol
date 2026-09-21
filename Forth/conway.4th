5 constant height
5 constant width
height width * constant size
size 1 - constant limit

variable grid limit cells allot
grid size cells erase

variable new-grid limit cells allot
new-grid size cells erase

: fm ( x y -- r c ) swap dup width mod swap height mod ;
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
: copy-params ( a b -- a b a b ) over over ;
\ : n ( x y -- n ) 
\ : count-neighbors ( x y -- n )
    \ copy-params
    \ swap 1 + swap query-grid \ n
    \ x 1 + y 1 + query-grid
    \ rot rot copy-params
    \ 1 +           query-grid \ e
    \ x 1 - y 1 + query-grid
    \ rot rot copy-params
    \ swap 1 - swap query-grid \ s
    \ x 1 - y 1 - query-grid
    \ rot rot copy-params
    \ 1 -           query-grid \ w
    \ x 1 + y 1 - query-grid
    \ + + ;

1 0 1 assign-grid
1 1 2 assign-grid
1 2 0 assign-grid
1 2 1 assign-grid
1 2 2 assign-grid

\ 8 4 4 assign-grid
\ copy-grid
\ -1 -1 fm . .
\ -1 -1 query-grid . CR
\ 0 1 query-grid . CR
1 1 count-neighbors . CR

print-grid

\ bye

\ gforth conway.4th
