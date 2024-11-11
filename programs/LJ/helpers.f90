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
        subroutine calc_force(natom, l, coord, fatom)
            implicit none

            integer, intent(in) :: natom
            real*8, intent(in) :: l
            real*8, dimension(3,natom), intent(in) :: coord
            real*8, dimension(3,natom), intent(out) :: fatom

            real*8, parameter :: sigma = 3.405d0, epsilon = 120.0d0
            real*8 :: sigma_sq, r_cutoff, r_cutoff_sq, r_ij_sq, sr_2, sr_6, sr_12, fij

            integer :: i, j

            fatom = 0.0d0
            r_cutoff = 0.5d0 * l
            r_cutoff_sq = r_cutoff * r_cutoff
            sigma_sq = sigma * sigma

            write(15,*) natom
            write(15,*) ''

            do i = 1, natom-1
                do j = i+1, natom
                    r_ij_sq = sum(((coord(:,i))-coord(:,j))**2)
                    sr_2 = sigma_sq / r_ij_sq
                    sr_6 = sr_2 * sr_2 * sr_2
                    sr_12 = sr_6 * sr_6
                    if (r_ij_sq < r_cutoff_sq) then
                        ! Ableitung LJ-Potential für die Kraft zwischen zwei Atomen
                        ! Aber: geteilt durch r_ij
                        fij = 48.0d0 * epsilon * (sr_12 - 0.5d0 * sr_6) / r_ij_sq
                        ! Hier wird die Richtung der Kraft berücksichtigt
                        ! um die Kfäfte die auf die einzelnen Atome wirken zu berechnen
                        fatom(:,i) = fatom(:,i) + fij * ((coord(:,i))-coord(:,j))
                        fatom(:,j) = fatom(:,j) - fij * ((coord(:,i))-coord(:,j))
                    end if
                end do
            end do

            do i = 1, natom
                write(15,*) 'Ar', coord(:,i)
            end do
        end subroutine calc_force

        ! Potential energy calculation
        subroutine calc_pot(natom, l, coord, Epot)
            implicit none

            integer, intent(in) :: natom
            real*8, intent(in) :: l
            real*8, dimension(3,natom), intent(in) :: coord
            real*8, intent(out) :: Epot

            real*8, parameter :: sigma = 3.405d0, epsilon = 120.0d0
            real*8, parameter :: e_cutoff = 3.83738839608178386d-3
            real*8 :: sigma_sq, r_cutoff, r_cutoff_sq, r_ij_sq, sr_2, sr_6, sr_12

            integer :: i, j

            sigma_sq = sigma * sigma
            r_cutoff = 0.5d0 * l
            r_cutoff_sq = r_cutoff * r_cutoff

            Epot = 0.0d0
            do i = 1, natom-1
                do j = i+1, natom
                    r_ij_sq = sum(((coord(:,i))-coord(:,j))**2)
                    sr_2 = sigma_sq / r_ij_sq
                    sr_6 = sr_2 * sr_2 * sr_2
                    sr_12 = sr_6 * sr_6
                    if (r_ij_sq < r_cutoff_sq) then
                        Epot = Epot + sr_12 - sr_6 + e_cutoff
                    end if
                end do
            Epot = 4.0d0 * epsilon * Epot
            end do
        end subroutine calc_pot

end module helpers