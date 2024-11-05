program FCC_grid
    implicit none

    integer, parameter :: natom = 108       ! Number of atoms
    integer :: nlp                          ! Number of lattice points per side
    integer :: counter, i, j, k
    real*8, parameter :: l = 17.158d0       ! Side length of the cubic box
    real*8 :: hl, dl                        ! Half length and distance between atoms
    real*8, dimension(3,natom) :: coord     ! Position of the atoms

    ! Number of atoms in fcc : 4 atoms per unit cell
    ! Number of unit cells = natom / 4 = 108 / 4 = 27
    ! Number of unit cells per side = 27^(1/3) = 3
    ! Number of atoms per side = 4
    ! Horizontal distance between atoms = l / 3 = 17.158 / 3 = 5.7193

    hl = l / 2.0d0
    nlp = int((natom / 4.0d0)**(1.0d0/3.0d0))
    write(*,*) 'Number of lattice points per side = ', nlp

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
end program FCC_grid