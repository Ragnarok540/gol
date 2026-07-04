program main

    implicit none
    integer, parameter :: h = 10
    integer, parameter :: w = 20

    type conway
        integer :: height
        integer :: width
        integer :: grid(h, w)
    end type conway

    type(conway) :: c

    c = new_grid(h, w)

    call assign_state(c, 1, 4, 1)
    call assign_state(c, 2, 5, 1)
    call assign_state(c, 3, 3, 1)
    call assign_state(c, 3, 4, 1)
    call assign_state(c, 3, 5, 1)

    call print_grid(c)
    
    do
        call clear_screen
        c = simulate(c)
        call print_grid(c)
        call sleep(1)
    end do

contains

    function new_grid(height, width) result(c)
        integer, intent(in) :: height, width
        integer :: grid(height, width)
        type(conway) :: c
        c = conway(height, width, grid)
        c%grid = 0
    end function new_grid

    subroutine assign_state(c, x, y, state)
        type(conway), intent(out) :: c
        integer, intent(in) :: x, y, state
        c%grid(modulo(x, c%height) + 1, modulo(y, c%width) + 1) = state
    end subroutine assign_state

    function query(c, x, y) result(state)
        type(conway), intent(in) :: c
        integer, intent(in) :: x, y
        integer :: state
        state = c%grid(modulo(x, c%height) + 1, modulo(y, c%width) + 1)
    end function query

    function count_neighbors(c, x, y) result(neighbors)
        type(conway), intent(in) :: c
        integer, intent(in) :: x, y
        integer :: n, ne, e, se, s, sw, w, nw, neighbors
        n  = query(c, x + 1, y    )
        ne = query(c, x + 1, y + 1)
        e  = query(c, x,     y + 1)
        se = query(c, x - 1, y + 1)
        s  = query(c, x - 1, y    )
        sw = query(c, x - 1, y - 1)
        w  = query(c, x,     y - 1)
        nw = query(c, x + 1, y - 1)
        neighbors = n + ne + e + se + s + sw + w + nw
    end function count_neighbors

    subroutine print_grid(c)
        type(conway), intent(in) :: c
        integer :: i
        do i = 1, c%height
            print '(20I0)', c%grid(i, 1:c%width)
        end do
    end subroutine print_grid

    function game_logic(state, neighbors) result(next)
        integer, intent(in) :: state, neighbors
        integer :: next
        if (state == 1) then
            if (neighbors < 2) then
                next = 0
            else if (neighbors > 3) then
                next = 0
            else
               next = 1
            end if
        else
            if (neighbors == 3) then
                next = 1
            else
                next = 0
            end if
        end if
    end function game_logic

    function step_cell(c, x, y) result(next)
        type(conway), intent(in) :: c
        integer, intent(in) :: x, y
        integer :: next, state, neighbors
        state = query(c, x, y)
        neighbors = count_neighbors(c, x, y)
        next = game_logic(state, neighbors)
    end function step_cell

    function simulate(c) result(new_c)
        type(conway), intent(in) :: c
        type(conway) :: new_c
        integer :: i, j, next
        new_c = new_grid(c%height, c%width)
        do i = 1, c%height
            do j = 1, c%width
                next = step_cell(c, i, j)
                call assign_state(new_c, i, j, next)
            end do
        end do
    end function simulate

    subroutine clear_screen
        print *, achar(27)//"[2J"
    end subroutine clear_screen

end program main

! mkdir -p bin
! gfortran -Wall -Wextra -o bin/conway conway.f90 -lm
! ./bin/conway
