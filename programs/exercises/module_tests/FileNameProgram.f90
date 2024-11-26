program vector
    ! This needs to be included in order to be able to use the subroutines in the module
    use vector_operations
    implicit none

    ! Declare variables
    real*8, allocatable :: vecA(:)
    real*8 :: lengthA
    integer :: dimA

    ! Read the dimension of the vector from the console
    write(*,*) 'Enter the dimension of the vector:'
    read(*,*) dimA

    ! Allocate memory for the vector
    allocate(vecA(dimA))

    ! Read the values of the vector from the console
    write(*,*) 'Enter the values of the vector:'
    read(*,*) vecA

    ! Call the subroutine that calculates the length of the vector
    call vectorLength(dimA, vecA, lengthA)

    ! Print the length of the vector
    write(*,*) 'The length of the vector is ', lengthA
end program vector