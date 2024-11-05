program main 

    ! Use the helper module
    use helpers

    implicit none

    integer, parameter :: natom = 108       ! Number of atoms
    real*8, parameter :: l = 17.158d0       ! Side length of the cubic box

    ! Create a FCC grid
    call FCC_grid(natom, l)

    
end program main