module helpers 
    implicit none
    contains 

        ! This subroutine generates the positions of the Argon atoms in a FCC grid
        subroutine FCC_grid(natom, l, coord)
            implicit none
        
            integer, intent(in) :: natom                            ! Number of atoms
            real*8, intent(in) :: l                                 ! Side length of the cubic box
            real*8, dimension(3,natom), intent(out) :: coord        ! Position of the atoms

            integer :: nlp                                          ! Number of lattice points per side
            integer :: counter, i, j, k           
            real*8 :: hl, dl                                        ! Half length and distance between atoms
        
            ! Number of atoms in fcc : 4 atoms per unit cell
            ! Number of unit cells = natom / 4 = 108 / 4 = 27
            ! Number of unit cells per side = 27^(1/3) = 3
            ! Number of atoms per side = 4
            ! Horizontal distance between atoms = l / 3 = 17.158 / 3 = 5.7193
        
            hl = l / 2.0d0
            nlp = int((natom / 4.0d0)**(1.0d0/3.0d0))
        
            if ((nlp*4)**3 < natom) then
                nlp = nlp + 1
            end if
        
            dl = l / nlp
        
            ! Creates a file to store the positions of the atoms
            open(14, file='FCC_box.xyz')
            write(14,*) natom
            write(14,*) 'Ar atoms in a simple cubic box'
        
            counter = 0
        
            ! Loop over the lattice points
            do i = 0, nlp-1
                do j = 0, nlp-1
                    do k = 0, nlp-1
        
                        ! Atom 1
                        counter = counter + 1
                        if (natom >= counter) then
                            coord(1, counter) = i * dl - hl
                            coord(2, counter) = j * dl - hl
                            coord(3, counter) = k * dl - hl
                            write(14,*) 'Ar', coord(:, counter)
                        end if
        
                        ! Atom 2
                        counter = counter + 1
                        if (natom >= counter) then  
                            coord(1, counter) = i * dl - hl
                            coord(2, counter) = (j + 0.5d0) * dl - hl
                            coord(3, counter) = (k + 0.5d0) * dl - hl
                            write(14,*) 'Ar', coord(:, counter)
                        end if
        
        
                        ! Atom 3
                        counter = counter + 1
                        if (natom >= counter) then
                            coord(1, counter) = (i + 0.5d0) * dl - hl
                            coord(2, counter) = j * dl - hl
                            coord(3, counter) = (k + 0.5d0) * dl - hl
                            write(14,*) 'Ar', coord(:, counter)
                        end if
        
                        ! Atom 4
                        counter = counter + 1
                        if (natom >= counter) then
                            coord(1, counter) = (i + 0.5d0) * dl - hl
                            coord(2, counter) = (j + 0.5d0) * dl - hl
                            coord(3, counter) = k * dl - hl
                            write(14,*) 'Ar', coord(:, counter)
                        end if
        
                    end do
                end do
            end do
            close(14)
        end subroutine FCC_grid

        ! Force calculation
        subroutine calc_force(natom, coord, fatom)
            implicit none

            integer, intent(in) :: natom
            real*8, dimension(3,natom), intent(in) :: coord
            real*8, dimension(3,natom), intent(out) :: fatom
            integer :: k = 5

            integer :: i

            do i = 1, natom
                fatom(:, i) = -k * coord(:, i)
            end do
        end subroutine calc_force

        ! Potential energy calculation
        subroutine calc_pot(natom, coord, Epot)
            implicit none

            integer, intent(in) :: natom
            real*8, dimension(3,natom), intent(in) :: coord
            real*8, intent(out) :: Epot
            integer :: k = 5

            integer :: i

            Epot = 0.0d0
            do i = 1, natom
                Epot = Epot + 0.5d0 * k * sum(coord(:, i)**2)
            end do

        end subroutine calc_pot

end module helpers