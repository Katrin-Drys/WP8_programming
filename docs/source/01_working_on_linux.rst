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
|  command                | description                                  |
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
options that can not be listed here