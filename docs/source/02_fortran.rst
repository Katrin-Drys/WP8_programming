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

    program hello
    write(*,*), 'Hello World!'
    end program hello

If you execute this program, it will write the text ``Hello World!`` to the screen. The first line
declares the program name, the second line writes the text to the screen, and the third line ends 
the program.
Now open your favorite text editor and copy the code above into a new file. Save the file as 
``hello.f90``. 
All files witten in Fortran must have the extension ``.f90``.
F90 is case-insensitive, so you can write the code in uppercase or lowercase letters and it will
still work.
To compile the program, open a terminal and type:

.. code-block:: bash

    gfortran hello.f90 -o hello

The ``gfortran`` command is the compiler, ``hello.f90`` is the source code file, and ``-o hello``
is the output file. The output file is the file that will be created after the compilation.
