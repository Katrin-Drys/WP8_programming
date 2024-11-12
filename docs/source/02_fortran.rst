What is the purpose of programming?
-----------------------------------
Programming is the art of precisely telling a computer what to do, usually to perform an 
action or solve a problem which would be too difficult or would take too long
to do by hand. It thus involves the following steps: 

1. **Problem definition**: What do you want to achieve?
2. **Algorithm design**: How can you achieve it?
3. **Implementation**: Translate the algorithm into a programming language.
4. **Testing**: Compile and run the program to see if it works.
5. **Debugging**: Fix any errors that occur.
6. **Data analysis**: Interpret the results only after verifying the program's correctness.

In this chapter, we will introduce you to the basics of the Fortran programming language.
We will start with the basic syntax and structure of a Fortran program, and then move on to
some easy coding examples.


Compiling and running a Fortran program
---------------------------------------
Before beginning to write a computer code, or ``to code`` in short, one needs to choose a 
programming language. Many of them exist: some are general, some are specifically designed for
a task, e.g. web site design or piloting a plane, some have simple data structures, some have 
very special data structures like census data, some are rather new and follow very modern principles, 
some have a long history and thus rely on time-tested concepts. 

For the purpose of this module, the FORTRAN90 (F90) language was chosen because it is still used 
frequently in the field of scientific computing and it is also quite easy and fast to code. 

For executing a program, the code must be translated into a language that the computer can understand.
This process is called ``compilation``. The compiler is a program that translates the code into machine
language, which is a set of instructions that the computer can execute. 
If you work on the computer of the institute, the ``GNU Fortran compiler`` for Compiling your
program is already installed. If you work on your own computer, you need to install the compiler first.

Let's take a look at the simplest Fortran program:

.. code-block:: fortran
    :linenos:

    program hello
        write(*,*) 'Hello World!'
    end program hello

If you execute this program, it will write the text ``Hello World!`` to the screen. The first line
declares the program name, which is ``hello`` in this case, but you can choose any name you like.
The ``write`` statement causes the program to display whatever is behind it until the end of the line. 
In this case, it will display the text ``Hello World!``. 
The single quotes enclosing the sentence make the program recognize that the following characters are
a ``string`` of text and not a variable name or a command.
The last name contains the ``end program`` statement, followed by the program name. This is the end of the program.

Now open your favorite text editor and copy the code above into a new file. Save the file as 
``hello.f90``. 
All files witten in Fortran must have the extension ``.f90``.
F90 is case-insensitive, so you can write the code in uppercase or lowercase letters and it will
still work.
To compile the program, open a terminal and type:

.. code-block:: bash

    gfortran hello.f90 -o hello

The ``gfortran`` command is the compiler, ``hello.f90`` is the source code file.
The ``-o`` flag allows you to specify the name of the output file, which is ``hello`` in this case.
If you don't specify the output file name, the compiler will create a file called ``a.out``.
To run the program, type:

.. code-block:: bash

    ./hello

Performing simple computing tasks
---------------------------------
Next, we will perform simple computational tasks in Fortran.
We will start with adding two numbers.
To do so, we need to introduce the concept of ``variables`` and ``variable typing``.
``Variables`` are used in computing tasks to give meaning to numbers.
They can have different values, similar to the variables used in math.
However, in Fortran, variables cannot be used as unknowns in an equation, only in an assignment.
We need to declare the data type of every variable explicitly, this means that a variable is given a 
specific and unchanging data type like ``character``, ``integer`` (:math:`\in\mathbb{Z}`) or ``real`` (:math:`\in\mathbb{R}`).

.. code-block:: fortran
    :linenos:

    program declare
        implicit none

        ! Declare variables
        integer :: a 
        character(len=9) :: b
        real :: c

        ! Assign values to variables
        a = 5
        b = 'pineapple'
        c = 3.14

        ! Print the values of the variables
        write(*,*) 'a = ', a
        write(*,*) 'b = ', b
        write(*,*) 'c = ', c
    end program declare

In this program, we declare three variables: ``a``, ``b`` and ``c``.
``a`` is an integer, ``b`` is a character and ``c`` is a real number.
The ``len=9`` attribute of the character variable ``b`` specifies that the variable can only hold nine characters.

Programming languages use strong variable typing to help with efficiency and error avoidance.
The need to declare a variable also arises from the fact that in order to use a variable, you need to have an 
appropriate chunk of main memory (RAM) to store the value of the variable in. The size (and partitioning) of that 
chunk is determined by the data type of the variable. 

Now we are ready to write a program that adds two numbers.

.. code-block:: fortran
    :linenos:

    program add
        implicit none

        ! Declare variables
        integer :: a, b, res

        ! Assign values to variables
        a = 5
        b = 3

        ! Add the numbers
        res = a + b

        ! Print the result
        write(*,*) 'The sum of ', a, ' and ', b, ' is ', res
    end program add

Let's go through the program step by step:

#. Line 1: The program name is ``add``.
#. Line 2: The ``implicit none`` statement tells the compiler that all variables must be declared explicitly.
           If this is not done, the compiler will assume that variables starting with the letters ``i``, ``j``, ``k``,
           ``l``, ``m`` and ``n`` are integers, when not declared explicitly.
           Put this statement at the beginning of every program you write!
#. Line 5: We declare three variables: ``a``, ``b`` and ``res`` as integers.
#. Lines 8 and 9: We assign the values 5 and 3 to the variables ``a`` and ``b``.
#. Line 12: We add the numbers and store the result in the variable ``res``.
#. Line 15: We print the result.
#. Line 16: The program ends.

All lines starting with an exclamation mark (!) are comments and are ignored by the compiler.
Comments are used to explain the code to the reader and to make the code more readable.
A nicely commented code is easier to understand and debug.

As already mentioned, variables cannot be used as unknowns in an equation, only in an assignment.
This means that the following code will not work:

.. code-block:: fortran
    :linenos:

    program wrong
        implicit none

        ! Declare variables
        integer :: a, b, res

        ! Assign values to variables
        a = 5
        b = 3

        ! Add the numbers
        a + b = res

        ! Print the result
        write(*,*) 'The sum of ', a, ' and ', b, ' is ', res
    end program wrong

If you try to compile this code, you will get an error message like this:

.. code-block:: bash

    wrong.f90:12:9:

    12 |         a + b = res
       |         1
    Error: Unclassifiable statement at (1)

An important and useful consequence of this feature is that the statement ``a = a + 1`` is valid
and will increase the value of ``a`` by 1, as long as ``a`` was declared as an integer or real number
beforehand.
Always remember to declare and initialize your variables before using them!
Otherwise the program might just use some random value that was stored in the memory location
where the variable is supposed to be stored.
Unlike other errors, the compiler will not warn you about this.

.. admonition:: Exercise 1
    
    The ``read(*,*)`` statement works similarly to the ``write(*,*)`` statement, and its general input 
    statement is ``read/write(unit, format)``. 
    Here ``unit`` is the input/output variable name, which is usually ``*`` for the console, and ``format`` is the
    statement number or label of the format statement, also usually ``*`` for the console.

    Modify the program above to:

    1. Read the values of ``a`` and ``b`` from the console.
    2. Perform a division instead of an addition.


Accuracy of numbers 
-------------------
The accuracy of numbers is a rather subtle issue. Two seemingly identical operations may
yield different results if the numbers involved are specified to different accuracy. Consider the
following program:

.. code-block:: fortran
    :linenos:

    program accuracy
        implicit none

        ! Declare variables
        real*8 :: a, b, c

        ! Assign values to variables
        a = 1.0d0 / 3.0d0
        b = 1.0e0 / 3.0e0
        c = 1.0 / 3.0

        ! Print the values of the variables
        write(*,*) 'a = ', a
        write(*,*) 'b = ', b
        write(*,*) 'c = ', c
    end program accuracy

In this program, we declare three variables: ``a``, ``b`` and ``c`` as real numbers.
The ``*8`` following the ``real`` keyword specifies that 8 bytes of memory should be allocated for the variable.
This is a way to specify the accuracy of the number. The more bytes are allocated, the more accurate the number is.
When you compile and run this program, you will see that the values of ``b`` and ``c`` are the same, but the 
value of ``a`` is different.
This is because the ``d0`` suffix specifies that the number is a double precision number, which is more accurate
than a single precision number, which is indicated by the ``e0`` suffix, or no suffix at all.

In this course, we will use double precision numbers for all calculations including real numbers.
Thus, you will use the ``*8`` suffix for all real numbers in your program.

Repeating tasks (do loop)
-------------------------
In programming, you often need to repeat a task multiple times. This is done using a ``do loop``.
One could of course simply copy and paste the code multiple times, but this is not only tedious, but also
error-prone. If you need to change the code, you would have to change it everywhere you copied it.

Loops generally have the following structure:
An index variable and its starting and ending values are declared.
The code inside the loop is executed as long as the index variable is within the specified range.
At the end of each iteration, the index variable is increased by a specified amount, usually 1.
When the index variable reaches the end value, the loop ends and the program continues with the code after the loop.

Let's look at a program that calculates the sum of the first 10 natural numbers.

.. code-block:: fortran
    :linenos:

    program sum
        implicit none

        ! Declare variables
        ! Most programmers use i, j, k, l, m, n as index variables
        integer :: i, res

        ! Initialize the res
        res = 0

        ! Loop over the numbers
        ! The loop starts with i = 1 and ends with i = 10, after each iteration i is increased by 1
        do i = 1, 10
            res = res + i
        end do

        ! Print the result
        write(*,*) 'The sum of the first 10 natural numbers is ', res
    end program sum

.. admonition:: Exercise 2

    Write a program that calculates the factorial of a number (n!) using a do loop.


Conditional statements 
----------------------------
if then else
~~~~~~~~~~~~~~~~
Frequently, we need to test for a certain fact or condition and take one or the other action
accordingly. An example is the convergence of a calculation (which would lead to a termination
of the program) or a wrong input (which would result in aborting the program early). Virtually
all programming languages have a construct that allows for this, usually termed the if-branching.

.. code-block:: fortran
    :linenos:

    program nTest
        implicit none

        ! Declare variables
        integer :: n

        ! Read the value of n from the console
        write(*,*) 'Enter a number:'
        read(*,*) n

        ! Test if n is positive
        if (n > 0) then
            write(*,*) 'n is positive'
        else
            write(*,*) 'n is not positive'
        end if
    end program nTest

In this program, we declare a variable ``n`` and read its value from the console.
We then test if ``n`` is positive and print the result.
To check if a number is equal to another number, you can use the ``==`` operator, not the ``=`` operator!
The ``==`` operator is used for comparison, while the ``=`` operator is used for assignment.
    
cycle and exit
~~~~~~~~~~~~~
Sometimes you want to skip the rest of the loop and start the next iteration, or you want to exit the loop
completely. This can be done using the ``cycle`` and ``exit`` statements.

The ``cycle`` statement skips the rest of the loop and starts the next iteration.
The ``exit`` statement exits the loop completely.

Let's look at an example:

.. code-block:: fortran
    :linenos:

    program CycleExit
        implicit none

        ! Declare variables
        integer :: i
            
        ! Loop over the numbers
        do i = 1, 10

            ! Skip the rest of the loop if i is even
            if (mod(i, 2) == 0) cycle

            ! Exit the loop if i is greater than 5
            if (i > 5) exit

            ! Print the value of i 
            write(*,*) i
        end do
    end program CycleExit


.. admonition:: Exercise 3

    Modify the program that calculates the sum of the first 10 natural numbers to find out when the 
    sum exceeds 60. 
    Make the program print the sum and the number of iterations it took to exceed 60.
    (Answer: 11.)

Structured Data (arrays)
------------------------
Often it is necessary to store a large number of values in a program. This can be done using ``arrays``.
An array is a collection of variables of the same type that are stored in contiguous memory locations.
In an array, not only the values of the variables are important, but also the position of the variable in the array.
Common examples of arrays are ``vectors`` and ``matrices`` and higher dimensional arrays.
F90 offers a natural way to handle arrays, which is shown in the following example:

.. code-block:: fortran
    :linenos:

    program array
        implicit none

        ! Simple floating point number
        real*8 :: scalar

        ! Vector of floating point numbers
        ! Both declarations are equivalent and create a vector with 3 elements
        real*8, dimension(3) :: vector1
        real*8 :: vector2(3)

        ! Matrix of floating point numbers
        ! Both declarations are equivalent and create a 3x3 matrix
        real*8, dimension(3, 3) :: matrix1
        real*8 :: matrix2(3, 3)

        ! Assign values to the variables
        ! Helper variable
        integer :: i

        ! Assign all elements of the vector1
        vector1 = (/1.0d0, 2.0d0, 3.0d0/)
        ! Reassign the first element of the vector1
        vector1(1) = 4.0d0

        ! Assign the first row of the matrix1
        matrix1(1, :) = (/1.0d0, 2.0d0, 3.0d0/)
        ! Assign the second row of the matrix1 in a loop
        do i = 1, 3
            matrix1(2, i) = i
        end do
    end program array

When dealing with arrays, there are two main things to consider:
The first one is the allocation of memory. The size of the array must be specified when declaring the array.
There will be situations where you don't know the size of the array beforehand. 
An instance may be an array of atom positions, where the number of atoms is not known until the program is run.
It is not a good idea to define a very large array and hope that it will be large enough, because 
it may not be large enough or it may be too large and waste memory.
In this case, you can use ``allocatable`` arrays, which are declared without a size and are allocated memory 
dynamically.
The syntax for declaring an allocatable array is:

.. code-block:: fortran
    :linenos:

    program allocatable
        implicit none

        ! Declare an allocatable array
        real*8, allocatable :: array(:)

        ! Declare a helper variable
        integer :: dimension

        ! Read the dimension of the array from the console
        write(*,*) 'Enter the dimension of the array:'
        read(*,*) dimension

        ! Allocate memory for the array
        allocate(array(dimension))

        ! Do cool stuff with the array

        ! Deallocate the memory
        deallocate(array)
    end program allocatable

The second point is even more important.
Imagine a vector has been allocated with 3 elements, but you try to access the 4th element.
What will happen? The answer is: nobody knows.
One of the following things may happen:

#. The best case is that the program is not permitted by the operating system (Linux in our case) to 
access that part of main memory that you just tried to access. In that case, it would give a message 
like ``Operation not permitted`` or ``Segmentation fault`` (segfault in short) and you actually know 
that there is an error in your code.
#. The program may fail quietly, leaving you wondering what happened.
#. The worst case is this: No safety checks catch the problem, and your program reads whatever it finds 
in the location described by vector(4). This may be anything from total garbage to zero. Since the program 
has no indication that there was a problem, it will use that value in a computation - which will give 
unexpected or flawed results. It is the very nature of such errors that they are hard to spot, even when 
you are aware that there is a problem.

What actually happens depends on many factors: operating system, system usage, number and nature of concurrently 
running programs etc. If a program (which does not use random numbers) gives different results with the same input 
if executed a number of times, chances for the existence of a wrong access are high.
Related to the bad access mistake listed above is the following mistake: Allocating or declaring a variable and 
using it in an addition (or similar operation) without giving it an explicit start value. This will also lead to 
strange results, because whatever was in the main memory at the space assigned to your variable will be used 
instead of the number that you want (which is usually zero). Thus, whenever introducing a variable, make sure that 
it starts off with a defined value. This process is called initialization and is of fundamental importance.

.. admonition:: Exercise 4

    Write a program that - takes the dimension and the values of two vectors :math:`\vec{a}` and :math:`\vec{b}`
    as input, and calculates the scalar product of the two vectors :math:`\vec{a}\cdot\vec{b}`.
    Additionally, if the dismensions of the two vectors are 3, it should also calculate the vector product of the 
    two vectors :math:`\vec{a}\times\vec{b}`.

    Remember that vou can pipe files into the program to provide input without having to type it manually
    in the console every time. 


Reusing code (subroutines)
--------------------------
In the planning of a project, you will sometimes find that you need to do a particular small task 
in a similar fashion at more than one point in your code. An example of this may be the multiplication 
of two matrices or the calculation of the angle between two vectors.
It is therefore advisable to separate the necessary code for that task from the rest of your program 
(and structure both as necessary, too), so that it can be useful in more than one place. The preferred 
way to do this in F90 is the use of subroutines. Structurally, they are very similar to the main program 
that you used so far. 

.. code-block:: fortran
    :linenos:

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


.. tip::
    It is a good idea to define modules in which you collect subroutines for specific tasks.
    This way, you can easily reuse the code in other programs and keep your code organized.
    If you define modules, you can even write the code into separate files and include them in your program
    using the ``use`` statement.

    If you dicide to keep the modules in a file named ``FileNameModule.f90`` and the main program in another
    file named ``FileNameProgram.f90``, you need to compile the module first.
    In this example, the following steps are necessary:

    .. code-block:: bash

        gfortran -c FileNameModule.f90
        gfortran -c FileNameProgram.f90
        gfortran FileNameModule.o FileNameProgram.o -o MyProgram
        ./MyProgram

Let's proceed with another exercise.

.. admonition:: Exercise 5

    Copy and modify your vector-program such that you calculate the scalar product and the vector product 
    in subroutines. Notice that if you give descriptive names to your subroutines, the structure of the main 
    program is much easier to understand. You therein describe what you do, not how you do it.

Application
-----------
Finally, to give a more complicated example using several of the syntactic elements discussed above, 
we sketch a code for a three dimensional generalization placing Argon atoms on a ``simple cubic`` grid. 
The side length of the cubic box is :math:`l = 17.158~\text{Å}` and the number of atoms is ``natom = 108``.

.. code-block:: fortran
    :linenos:

    program SC_grid
        implicit none

        integer, parameter :: natom = 108       ! Number of atoms
        integer :: nlp                          ! Number of lattice points per side
        integer :: counter, i, j, k    
        real*8, parameter :: l = 17.158d0       ! Side length of the cubic box
        real*8 :: hl, dl                        ! Half length and distance between atoms
        real*8, dimension(3,natom) :: coord     ! Position of the atoms

        hl = l / 2.0d0
        nlp = int(natom**(1.0d0/3.0d0))

        if (nlp**3 < natom) then
            nlp = nlp + 1
        end if

        dl = l / nlp

        ! Creates a file to store the positions of the atoms
        open(14, file='SC_box.xyz')
        write(14,*) natom
        write(14,*) 'Ar atoms in a simple cubic box'

        counter = 0

        ! Loop over the lattice points
        do i = 0, nlp-1
            do j = 0, nlp-1
                do k = 0, nlp-1
                    counter = counter + 1
                    if (natom >= counter) then
                        coord(1, counter) = i * dl - hl
                        coord(2, counter) = j * dl - hl
                        coord(3, counter) = k * dl - hl
                        write(14,*) 'Ar', coord(:, counter)
                    end if
                end do
            end do
        end do
        close(14)
    end program SC_grid

To place the atoms on the grid, we first calculate the number of lattice points per side, ``nlp``,
as the cube root of the number of atoms. The function ``int()`` truncates a (positive) real number 
to the largest integer smaller than the number. 
To ensure that we have enough lattice points to place all atoms ``N`` = natom, we increase the 
number of lattice points per side by one if the number of lattice points cubed is smaller than the 
number of atoms.
Now of course we have too many lattice points, and thus some of them will remain empty.

.. tip::
    You can visualize the box you created using the ``VMD`` program.
    To do so type:

    .. code-block:: bash

        vmd SC_box.xyz

.. admonition:: Exercise 6

    The provided code will be applied repeatedly to set up a system of particles in a cubic periodic 
    cell which serves as the starting configuration for the simulation of a liquid. The simple cubic 
    (sc) lattice generated by the code is of course not an ideal configuration for a liquid. Better
    would be a face centered cubic (fcc) lattice which is locally more similar to the closed packed 
    encountered in (simple) liquids. Extend the code for the sc lattice for the construction of fcc 
    lattices.
    Remember that all atoms lying on the edges of the periodic cell are also mirrored to the opposite 
    edge.

Great! You have now learned the basics of Fortran programming and are ready to build your own 
MD simulation program.
