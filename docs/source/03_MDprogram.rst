The Verlet Algorithms
=====================
Molecular dynamics methods are iterative numerical schemes for solving the 
equation of motion of the system. 

We choose a ``numerical`` method to solve the equations of motion of the system,
since the analytical solution is not possible for systems with more than two
particles. Thus we introduce a discretization of time in terms of small
increments called time steps which we will assume to be of equal length ``h``.

The ``iterative`` nature of the method means that we start from an initial
configuration of the system and then we update the positions and velocities of
the particles at each time step. 
Counting the successive equidistant points on the time axis by the index ``n``, 
the evolution of the system is described by the series of the coordinate values

.. math::
    r^N(t_{n-1}) = r^N(t_n - \delta t)