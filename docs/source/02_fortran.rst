Fortran basics
==============

Programming is the art of precisely telling a computer what to do, usually to perform an 
action or solve a problem which would be too difficult to do by hand. It thus involves the 
following steps: 

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
The ``-o``flag allows you to specify the name of the output file, which is ``hello`` in this case.
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

.. admonition:: Exercise
    
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
