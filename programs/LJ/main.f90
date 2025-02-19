program main 
    use helpers
    implicit none

    integer, parameter :: itime = 8000     
    real*8, parameter :: m = 39.948d0      
    real*8, parameter :: dt = 0.005d0 
    integer, parameter :: natom = 108    
    ! start density: l = 17.158d0; density = 0.095 g/cm^3 - l = 42.2488d0; density = 1.050 g/cm^3 - l = 18.9667d0   
    real*8, parameter :: l = 17.158d0
    integer, parameter :: Treq = 140

    real*8 :: T 
    real*8, dimension(3,natom) :: coord     
    real*8, dimension(3,natom) :: vatom             
    real*8, dimension(3,natom) :: fatom
    real*8 :: Epot, Ekin, Etot
    real*8 :: time
    integer :: i, j, run

    ! Create a FCC grid
    call FCC_grid(natom, l, coord)

    ! -------  Velocity Verlet algorithm   ------- !
    vatom = 0.0d0
    Ekin = 0.0

    ! PBC
    do i = 1, natom
        coord(:,i) = coord(:,i) - l * anint(coord(:,i) / l)
    end do

    call calc_force(natom, l, coord, fatom)
    call calc_pot(natom, l, coord, Epot)
    
    open(15, file='trajectory.xyz')
    open(16, file='energy.txt')
    write(16,*) 'Step ', 'Time', 'Temp', 'Ekin ', 'Epot ', 'Etot '
    
    ! Main loop
    do run = 1, itime
        do i=1,natom
            ! Equation (6)
            vatom(:,i) = vatom(:,i) + 0.5d0*fatom(:,i)*dt/m
            coord(:,i) = coord(:,i) + dt * vatom(:,i)
        end do

        ! PBC
        do i = 1, natom
            coord(:,i) = coord(:,i) - l * anint(coord(:,i) / l)
        end do

        ! Equation (7)
        call calc_force(natom, l, coord, fatom)

        Ekin = 0.0d0

        do i = 1, natom
            ! Equation (9)
            vatom(:, i) = vatom(:, i) + 0.5d0 * dt * fatom(:, i) / m
            Ekin = Ekin + 0.5d0 * m * sum(vatom(:, i)**2)
        end do    

        ! Scale the temperature
        T = 2.0d0 * Ekin / (3.0d0 * real(natom))
        ! Scale all 10 steps
        if (mod(run, 10) == 0) then
            do i = 1, natom
                vatom(:, i) = vatom(:, i) * sqrt(Treq / T)
            end do
        end if
        
        call calc_pot(natom, l, coord, Epot)
        Etot = Ekin + Epot

        time = run * dt
        ! Write the energy into a file
        write(16,*) run, time, T, Ekin, Epot, Etot
    end do      

end program main