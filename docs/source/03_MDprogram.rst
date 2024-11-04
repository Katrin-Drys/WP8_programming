The Verlet Algorithms
=====================
Molecular dynamics methods are iterative numerical schemes for solving the 
equation of motion of the system. 

A ``numerical`` method to solve the equations of motion of the system is chosen,
since the analytical solution is not possible for systems with more than two
particles. Thus we introduce a discretization of time in terms of small
increments called time steps which we will assume to be of equal length ``h``.

The ``iterative`` nature of the method means that we start from an initial
configuration of the system and then we update the positions and velocities of
the particles at each time step. 
Counting the successive equidistant points on the time axis by the index ``n``, 
the evolution of the system is described by the series of the coordinate values

.. math::

    \begin{align}
        &r^N(t_{n-1}) = r^N(t_n - \delta t) \\
        \quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad &r^N(t_n) \quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\quad\tag{1} \\
        &r^N(t_{n+1}) = r^N(t_n + \delta t) 
    \end{align}

This tells us, that the position of particle *N* at time :math:`t_{n-1}` is equal to
the position of the particle at time :math:`t_n` minus the time step :math:`\delta t`.
The position of the particle at time :math:`t_{n+1}` is equal to the position of the
particle at time :math:`t_n` plus the time step :math:`\delta t`.
