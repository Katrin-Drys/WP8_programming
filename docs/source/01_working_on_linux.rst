Working on Linux
================

Within this seminar you will be working under the operating system Linux. The Linux distribution 
SuSE 42.3 is installed on all computers in the CIP-pool. A specific machine has be
assigned to each of you and you will work at the assigned computer in the university and/or 
via remote. In order to work remote, you must log in on the ssh5 exchange server, using your credentials.
On the terminal on your personal pc, or on a
simulator, type:

.. code-block:: bash

   sssh username@ssh5.thch.uni-bonn.de

Please don't keep huge amount of data on ssh5.
From ssh5 type:

.. code-block:: bash

   ssh username@cNUMBER 

where NUMBER is the number of the pc.

The Shell
---------
On the left you can see the so called ``prompt``. Depending on the default settings of your
system it provides you with various information. In a standard configuration it will show:
``username@hostname:~>``. Where ``username`` is your username, ``hostname`` is the name of the
computer and the tilde (~) shows that you are currently located in your home directory. The
Linux file structure follows the 'Filesystem Hierarchy Standard', which ensures a similar file
structure on every version of Linux you can get. As you work with the system you will rapidly
gain experience about the di↵erent directories and their purposes. For now you should know
that you are in your home directory which is located at ``/home/username`` and is abbreviated
by ~.

With your user account you have the power to create, edit, and delete files in your home
directory. But with great power also comes great responsibility. You have to be careful with
the commands you execute, because if you delete or overwrite a file it will be gone for good.
With that in mind, we can now start with the first couple of commands. To see exactly which
directory you are in, type ``pwd`` (print working directory) and press ``<Return>``. Since you are in
your home directory, this will print the path to that home directory to the screen:

.. code-block:: bash

   username@hostname:~> pwd
   /home/username

A standard set of commands is shown in the following table.

+-------------------------+----------------------------------------------+
|  Command                | Description                                  |
+=========================+==============================================+
| ``pwd``                 | Prints the working directory.                |
+-------------------------+----------------------------------------------+
| ``ls``                  | Lists the files in the current directory.    |
+-------------------------+----------------------------------------------+
| ``cd <dir>``            | Changes to the directory with the name <dir>.|
+-------------------------+----------------------------------------------+
| ``cd ..``               | Changes to the parent directory.             |
+-------------------------+----------------------------------------------+
| ``cp <file1> <file2>``  | Copies file ``<file1>`` to ``<file2>``.      |
+-------------------------+----------------------------------------------+
| ``cp -r <dir1> <dir2>`` | Copies directory ``<dir1>`` to ``<dir2>``.   |
+-------------------------+----------------------------------------------+
| ``mv <old> <new>``      | Moves/Renames file/directory.                |
+-------------------------+----------------------------------------------+
| ``rm <file>``           | Removes file with name ``<file>``            |
+-------------------------+----------------------------------------------+
| ``rm -r <dir>``         | Removes directory recursively (caution!).    |
+-------------------------+----------------------------------------------+
| ``mkdir <dir>``         | Creates a new directory with name ``<dir>``. |
+-------------------------+----------------------------------------------+
| ``rmdir <name>``        | remove (empty) directory with ``<name>``     |
+-------------------------+----------------------------------------------+


This is only a very basic list of commands available and some of them possess a huge variety of 
options that can not be listed here.
For further reading you can visit the ``manpage`` of a command by typing ``man <commandname>``,
(e.g. ``man ls`` will show you the manpage of the ls command). By default, ``man`` uses the
``less`` program, whose internal commands are described in the table below. Many commands have also
implemented the ``-h`` or ``-help`` option, that shows the possibility available with that specific
command. Another very useful feature in Linux is the use of wildcards characters. You can use
those wildcards in any shell command. For example, the command ``rm *.tmp`` will remove all
files with the extension tmp in the current working directory. And ``ls *.F90`` will list all files
with extension F90.
The Linux shell offers a huge variety of tools, which are installed on the system by default.
In the following table some useful commands for dealing with text files are listed.

+----------------------------------+----------------------------------------------+
|  Command                         | Description                                  |
+==================================+==============================================+
| ``cat <file>``                   | Prints the content of the file to the screen.|
+----------------------------------+----------------------------------------------+
| ``less <file>``                  | Shows the content of the file in a pager.    |
+----------------------------------+----------------------------------------------+
| ``head <file>``                  | Shows the first 10 lines of the file.        |
+----------------------------------+----------------------------------------------+
| ``tail <file>``                  | Shows the last 10 lines of the file.         |
+----------------------------------+----------------------------------------------+
| ``grep <pattern> <file>``        | Searches for the pattern in the file.        |
+----------------------------------+----------------------------------------------+
| ``wc <file>``                    | Counts the number of lines, words and        |
|                                  | characters in the file.                      |
+----------------------------------+----------------------------------------------+
| ``sed `s/text1/text2/g <file>``  | Replaces the text1 with text2 in the file.   |
+----------------------------------+----------------------------------------------+

Redirecting the Input/Output
----------------------------
All programs that run in the shell have three standard channels assigned. These are

1. The standard input channel ``stdin``. Normally this channel reads from the keyboard, which is connected to your shell.
2. The standard output channel ``stdout``. Normally this channel writes to the screen, which is connected to your shell.
3. The standard error channel ``stderr``. Normally this channel writes to the screen, much like ``stdout``.

You can now redirect those channels using your shell commands. To redirect ``stdin`` use the ``<``
character. You could rewrite all the commands you learned by now, which need the contents
of a file, using the input redirection. For example: ``less < filename``.
Redirecting the ``stdout`` is done by using the ``>`` character. This really comes in handy with the
sed command you learned before. As you remember this action only prints the changes in a
file to the screen and does not save them. To store the data we simply redirect the output of
the sed command to a file by: ``sed 's/text1/text2/g' oldfile > newfile`` This will create
a file with name newfile which contains the changes you have made by replacing text1 by
text2. Note that the two files cannot be identical in this case. Use the ``sed`` command with the
``-i`` option and a single filename for this.
The last way of dealing with channels in your shell is the so called pipe command. This is used
if you want to provide the output of one program directly as input for another one without
saving it to a file. Piping is done by the ``|`` character. To find a file in a huge directory you
could pipe the ls commend like this: ls ``| grep -i 'exercise'``
ls will list the content of your current working directory. The pipe character will cause your
system to hand the text over to the next command, ``grep``, which will only show those lines
matching the pattern provided. As a result, this will print out all files (and directories), which
contain the word ``exercise`` and are listed in the current working directory.