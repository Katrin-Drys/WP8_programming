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
        write(*,*), 'Hello World!'
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

Performing simple computing tasks
---------------------------------
Next, we will perform simple computational tasks in Fortran.
We will start with adding two numbers.
To do so, we need to introduce the concept of ``variables`` and ``variable typing``.
``Variables`` are used in computing tasks to give meaning to numbers.
They can have different values, similar to the variables used in math.
However, in Fortran, variables cannot be used as unknowns in an equation, only in an assignment.
It can be useful to strongly type variables, meaning that a variable is given a specific and unchanging role.
For instance, it can be a floating point number or a string of text, which then defines possible uses of the variable.

.. code-block:: fortran
    :linenos:

    program variable_example
        implicit none

        // Declare variables
        pi = 3.14159
        radius = 2.0
        area = pi * radius**2

        // Print the result
        write(*,*), 'The area of a circle with radius ', radius, ' is ', area
    end program variable_example

Programming languages use strong variable typing to help with efficiency and error avoidance.
The need to declare a variable also arises from the fact that in order to use a variable, you need to have an 
appropriate chunk of main memory (RAM) to store the value of the variable in. The size (and partitioning) of that 
chunk is determined by the type of the variable. The most important types of variables you will work with are integers, 
i.e., ``whole`` numbers (\mathbb{Z}) and floating point numbers (floats, doubles), i.e., real numbers (\mathbb{R}) 
expressed as decimal numbers.
