module vector_operations
    implicit none
contains
    ! Our subroutine is part of the module vector_operations
    subroutine vectorLength(dim, vec, length)
        implicit none

        ! Declare variables
        ! The dimension of the vector is an input variable, thus it is declared as intent(in)
        ! That means that the subroutine will not change the value of the variable
        integer, intent(in) :: dim
        ! Same for the vector
        real*8, intent(in) :: vec(:)
        ! The length of the vector is an output variable, thus it is declared as intent(out)
        ! That means that the subroutine will change the value of the variable
        real*8, intent(out) :: length
        integer :: i

        ! Initialize the length
        length = 0.0d0

        ! Calculate the length of the vector
        do i = 1, dim
            length = length + vec(i)**2
        end do

        length = sqrt(length)
    end subroutine vectorLength
end module vector_operations