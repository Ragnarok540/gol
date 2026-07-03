module conway
implicit none
contains

    function new_grid(h, w) result(grid)
        integer, intent(in) :: h
        integer, intent(in) :: w
        integer :: grid(h, w)
        grid = 0
    end function new_grid

    subroutine print_grid(h, w, G)
        implicit none
        integer, intent(in) :: h
        integer, intent(in) :: w
        integer, intent(in) :: G(h, w)

        integer :: i

        do i = 1, h
            print '(20I0)', G(i, 1:w)
        end do

    end subroutine print_grid

end module

program main
    use conway
    integer, parameter :: height = 10
    integer, parameter :: width = 20
    integer :: grid(height, width)
    grid = new_grid(height, width)
    grid(1, 4) = 1
    grid(2, 5) = 1
    grid(3, 3) = 1
    grid(3, 4) = 1
    grid(3, 5) = 1
    call print_grid(height, width, grid)
end program

! mkdir -p bin
! gfortran -Wall -Wextra -o bin/conway conway.f90 -lm
! ./bin/conway
