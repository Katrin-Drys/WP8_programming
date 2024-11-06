program main 
    use helpers
    implicit none

    integer, parameter :: natom = 108       
    real*8, parameter :: l = 17.158d0      
    real*8, dimension(3,natom) :: coord     
    real*8, dimension(3,natom) :: v             

    integer, parameter :: itime = 2000     
    real*8, parameter :: m = 39.948d0      
    real*8, parameter :: dt = 0.005d0   

    real*8, dimension(3,natom) :: fatom
    real*8 :: Epot, Ekin, Etot
    integer :: i, run

    ! Create a FCC grid
    call FCC_grid(natom, l, coord)

    ! Velocity Verlet algorithm !
    v = 0.0d0
    Ekin = 0.0d0

    ! Write the coordinates into a file
    open(14, file='Ar_ho.xyz')
    write(14,*) natom
    write(14,*) 'Ar atoms'

    ! Create a file for the energies
    open(15, file='Ar_ho.dat')
    write(15,*) 'run', 'Ekin', 'Epot', 'Etot'
    
    ! Main loop
    do run = 1, itime
    
        do i = 1, natom
            ! Equation (6)
            v(:, i) = v(:, i) + 0.5d0 * dt * fatom(:, i) / m
            coord(:, i) = coord(:, i) + dt * v(:, i)
        end do

        ! Equation (7)
        call calc_force(natom, coord, fatom)

        ! Set Ekin to zero
        Ekin = 0.0d0

        do i = 1, natom
            ! Equation (9)
            v(:, i) = v(:, i) + 0.5d0 * dt * fatom(:, i) / m
            Ekin = Ekin + 0.5d0 * m * sum(v(:, i)**2)
        end do    
        
        ! Calculate the total energy
        call calc_pot(natom, coord, Epot)
        Etot = Ekin + Epot

        ! Write the coordinates into a file
        write(14,*) natom
        write(14,*) 'Ar atoms'
        do i = 1, natom
            write(14,*) 'Ar', coord(:, i)
        end do

        ! Write the energy into a file
        write(15,*) run, Ekin, Epot, Etot

    end do      

end program main