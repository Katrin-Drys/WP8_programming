The Verlet Algorithms
=====================

General overview
----------------
Molecular dynamics (MD) methods are computational approaches used to simulate the 
motion of particles within a system. They do so by employing iterative numerical techniques 
to solve the equations of motion, essentially allowing us to predict how a system evolves 
over time based on fundamental physics.

    ``Numerical``: In this context, numerical means that we solve the equations of motion 
    using approximations rather than exact, analytical solutions. For systems with many 
    interacting particles, we encounter the many-body problem, where the equations of motion
    become too complex to solve analytically. 
    Therefore, we rely on numerical schemes, which are step-by-step calculations that approximate 
    these solutions.

    ``Iterative``: An iterative method involves repeating a set of calculations multiple times. 
    In MD, the process is iterative because we update the positions and velocities of particles 
    at each step based on their previous states. Each step is dependent on the previous one, 
    forming a continuous loop where the state of the system evolves incrementally.

The MD simulation process starts by discretizing time into small, equal increments called 
time steps, denoted by ``h``. Each time step represents a small period of time in which 
particle positions and velocities are recalculated, denoted by the index ``n``.
Thus, starting from an initial configuration, MD methods iterate through each time step, 
updating the system's coordinates and velocities in response to the forces acting on each particle.
The coordinates are given like this:

.. math::
    :label: timestep_def

        &r^N(t_{n-1}) = r^N(t_n - \delta t) \\
        &r^N(t_n)   \\
        &r^N(t_{n+1}) = r^N(t_n + \delta t)

The superscript denotes the particle index, and runs from 1 to the total number of particles in 
the system, *N*.
Thus, Equation :eq:`timestep_def` indicates that the position of particle *N* at time :math:`t_{n-1}` is denoted by 
taking the position of the particle at time :math:`t_n` and moving backward by a time increment of 
:math:`\delta t`. Similarly, the position of the particle at time :math:`t_{n+1}` is determined by 
taking the position at :math:`t_n` and moving forward by the same time increment :math:`\delta t`.
Similar series are defined for the velocities of the particles, denoted by :math:`v^N(t_n)`.

The MD schemes we will discuss all use the Cartesian representation. There are, in fact, good reasons 
for preferring this description for the chaotic interaction many body systems which are the subject 
of statical mechanics.

The logic of the verlet algorithm
---------------------------------
A very important algorithm in MD is the Verlet algorithm. The Verlet algorithm is based on a clever
combination of the Taylor expansion of the position of a particle forward and backward in time.
The third order Taylor expansion for the position :math:`r_i` of a particle at time :math:`t + \delta t`
is given by:

.. math::
    :label: forwardTaylor

    \mathbf{r}_i(t + \delta t)=\mathbf{r}_i(t)+\delta t \mathbf{v}_i(t)+\frac{\delta t^2}{2m_i} \mathbf{f}_i(t)+\frac{\delta t^3}{6} \mathbf{b}_i(t)+O(\delta t^4)

where we have used the familiar symbol :math:`\mathbf{v}_i` for the velocity :math:`\dot{\mathbf{r}}` of 
particle *i* and have inserted the equation of motion in the second order term. If Equation 
:eq:`forwardTaylor` and the equivalent approximation for :math:`t - \delta t`

.. math::
    :label: backwardTaylor

    \mathbf{r}_i(t - \delta t)=\mathbf{r}_i(t)-\delta t \mathbf{v}_i(t)+\frac{\delta t^2}{2m_i} \mathbf{f}_i(t)-\frac{\delta t^3}{6} \mathbf{b}_i(t)+O(\delta t^4)

are added we obtain a prediction for the position :math:`r_i` of the particle at time :math:`t + \delta t`:

.. math::
    :label: sumTaylor

    \mathbf{r}_i(t + \delta t)=2\mathbf{r}_i(t)-\mathbf{r}_i(t - \delta t)+\frac{\delta t^2}{m_i} \mathbf{f}_i(t)+O(\delta t^4).

Note that the accuracy of the prediction is third order in time, i.e., one order better than of the Taylor 
Equations :eq:`forwardTaylor` and :eq:`backwardTaylor`. This gain in accuracy was achieved by cancellation of odd powers in 
time, including the first order term depending on the velocity :math:`\mathbf{v}_i(t)`.
The velocity :math:`\mathbf{v}_i(t)` is obtained in the Verlet algorithm by substraction of the 
forward Taylor expansion :eq:`forwardTaylor` from the backward Taylor expansion :eq:`backwardTaylor`.
This gives the expression:

.. math::
    :label: substractionTaylor

    \mathbf{v}_i(t)=\frac{1}{2 \delta t}[\mathbf{r}_i(t + \delta t)-\mathbf{r}_i(t - \delta t)]+O(\delta t^3),

from which the explicit dependence of the forces has been eliminated. The velocity obtained by 
Equations :eq:`substractionTaylor` is the current value at time *t*. Therefore, the velocity 
update in the Verlet algorithm is one step behind the position update. This is not a problem 
for propagating positions, because assuming that the forces are not dependent on the velocity, 
information on :math:`\mathbf{v}_i(t)` is not needed in Equation :eq:`sumTaylor`.
The way velocity is treated in the Verlet algorithm can be inconvenient for the determination of 
velocity dependent quantities such as kinetic energy. The position and velocity can be brought 
in step by a reformulation of the Verlet scheme, called velocity Verlet. The prediction of the 
positions is now simply obtained from the Taylor expansion of Equation :eq:`forwardTaylor`,
keeping up to the second order (force) term:


.. math::
    :label: secondOrder

    \mathbf{r}_i(t + \delta t)=\mathbf{r}_i(t)+\delta t \mathbf{v}_i(t)+\frac{\delta t^2}{2m_i} \mathbf{f}_i(t).

