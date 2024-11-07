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
of ``statical mechanics``.

Verlet algorithm
---------------------------------
A very important algorithm in MD is the ``Verlet algorithm``. The Verlet algorithm is based on a clever
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
velocity dependent quantities such as kinetic energy. 

Velocity Verlet algorithm
---------------------------------
The position and velocity can be brought in step by a reformulation of the Verlet scheme, 
called ``Velocity Verlet``. The prediction of the positions is now simply obtained from the Taylor 
expansion of Equation :eq:`forwardTaylor`, keeping up to the second order (force) term:

.. math::
    :label: forwardTaylor2

    \mathbf{r}_i(t + \delta t)=\mathbf{r}_i(t)+\delta t \mathbf{v}_i(t)+\frac{\delta t^2}{2m_i} \mathbf{f}_i(t).

From the advanced position we compute the force at time :math:`t + \delta t`

.. math::
    :label: force

    \mathbf{f}_i(t + \delta t)=\mathbf{f}_i \left[\mathbf{r}_i(t)+\delta t \mathbf{v}_i(t)+\frac{\delta t^2}{2m_i} \mathbf{f}_i(t)\right],

substitute in the Taylor expansion :math:`t \leftarrow t + \delta t` backward in time using the advanced 
time :math:`t + \delta t` as reference

.. math::
    :label: backwardTaylor2

    \mathbf{r}_i(t)=\mathbf{r}_i(t + \delta t)+\delta t \mathbf{v}_i(t + \delta t)+\frac{\delta t^2}{2m_i} \mathbf{f}_i(t + \delta t),

and add this to the forward expansion Equation :eq:`forwardTaylor` to yield the prediction of the velocity

.. math::
    :label: velocityVVerlet

    \mathbf{v}_i(t + \delta t)=\mathbf{v}_i(t)+\frac{\delta t^2}{2m_i}[\mathbf{f}_i(t)+\mathbf{f}_i(t+\delta t)],

which then can be used together with the prediction of the positions in Equation :eq:`forwardTaylor`
in the next step. 
The (position) Verlet algorithm specified by Equations :eq:`sumTaylor` and :eq:`substractionTaylor`
and the velocity Verlet scheme of Equations :eq:`forwardTaylor2` and :eq:`velocityVVerlet`
may appear rather dissimilar. 
They are, however equivalent, producing  exactly the same discrete trajectory in time. 
This can be demonstrated by elimination of the velocity. Subtracting from the 
:math:`t \rightarrow t + \delta t` the :math:`t -\delta t \rightarrow t` expansion, we find 

.. math::
    :label: checkStep1

    \mathbf{r}_i(t + \delta t)-\mathbf{r}_i(t) = \mathbf{r}_i(t)-\mathbf{r}_i(t - \delta t)+\delta t [\mathbf{v}_i(t)-\mathbf{v}_i(t - \delta t)]+\frac{\delta t^2}{2m_i} [\mathbf{f}_i(t) - \mathbf{f}_i(t - \delta t)].

Next the :math:`t -\delta t \rightarrow t` update for velocity

.. math::
    :label: checkStep2

    \mathbf{v}_i(t)=\mathbf{v}_i(t-\delta t)+\frac{\delta t^2}{2m_i}[\mathbf{f}_i(t-\delta t)+\mathbf{f}_i(t)]

is inserted in Equation :eq:`checkStep1` giving 

.. math::
    :label: checkStep3

    \mathbf{r}_i(t+\delta t)-\mathbf{r}_i(t)=\mathbf{r}_i(t)-\mathbf{r}_i(t-\delta t)+\frac{\delta t^2}{m_i} \mathbf{f}_i(t),

which indeed is identical to the prediction of Equation :eq:`sumTaylor` according to the Verlet scheme 
without explicit velocities. 


Leap-frog algorithm
---------------------------------
A modification of the Verlet algorithm predating velocity Verlet which also makes explicit use of 
velocity as iteration variable is the ``leap-frog algorithm``. In this scheme the position and velocity 
are a half time step out of step. The velocities as half integer time are defined as

.. math::
    :label: velocitiesleapfrog

    \mathbf{v}_i (t-\delta t/2) = \frac{\mathbf{r}_i(t)-\mathbf{r}_i(t-\delta t)}{\delta t}, \\
    \mathbf{v}_i (t+\delta t/2) = \frac{\mathbf{r}_i(t+\delta t)-\mathbf{r}_i(t)}{\delta t}.

Based on these definitions the following sequence of update steps is used to propagate position 
and velocity, one ``leaping`` over the other with a full time step:

.. math::
    :label: leapfrog

    \mathbf{v}_i (t+\delta t/2) =\mathbf{v}_i (t-\delta t/2)+ \frac{\delta t}{m_i} \mathbf{f}_i(t), \\
    \mathbf{r}_i(t+ \delta t)= \mathbf{r}_i(t) + \delta t \mathbf{v}_i (t+\delta t/2).

The velocity at time :math:`t+\delta t` is calculated by adding the velocities at time :math:`t-\delta t/2`
and :math:`t+\delta t/2` and dividing by two.

.. math::
    :label: velocitiesleapfrog2

    \mathbf{v}_i(t)=\frac{1}{2}(\mathbf{v}_i(t+\delta t /2)+ \mathbf{v}_i(t-\delta t /2)).


Implementing a Velocity Verlet algorithm for a Harmonic Oscillator
==================================================================
It is always useful to start with a simple physical problem when developing a new algorithm.
By doing that, we can easily test the algorithm and check whether it reproduces the expected results.
In this case, we will implement the Velocity Verlet algorithm for a harmonic oscillator.
As a starting point, rewrite your fcc program into a subroutine and call this subroutine
within a program, which will from now on be your main program.
You can either store the fcc subroutine in a module in another file or include it in the same file as the main program.
Once you have managed to create the fcc box via the main program, the next step is to
develop a MD program for the harmonic oscillator by calculating the forces and the potential
energy. 

.. figure:: figures/ho.svg
    :width: 400
    :align: center

    Harmonic oscillator. 

In the case of a harmonic oscillator, the force depends linearly on the 
displacement from the equilibrium position, which, in our case, is the origin.
The ``force`` is given by :math:`F = -kx`, where :math:`k` is the force constant and :math:`x` is the
displacement from the equilibrium position. The force constant :math:`k` can be set to 5 in our case.
We can implement this in the following way:

.. code-block:: fortran
    :lineons:

    ...
        real*8, dimension(3, natom) :: fatom
        do i = 1, natom
            fatom(:, i) = -k * coord(:, i)
        end do
    ...

The ``potential energy`` of the system is given by :math:`V = \frac{1}{2}kx^2`.

.. code-block:: fortran
    :lineons:

    ...
        real*8 :: pot_harm = 0.0
        do i = 1, natom
            pot_harm = pot_harm + 0.5d0 * k * sum(coord(:, i)**2)
        end do
    ...

Write these two Codes as subroutines as well. The next step is to implement the ``Velocity Verlet`` algorithm
in order to propagate the particles in time.
We will write the Velocity Verlet algorithm into the main program, and within that program, 
we will call the force and potential energy subroutines from above.

.. code-block:: fortran
    :lineons:

    ...
        integer, parameter :: itime = 1000, natom = 108
        real*8, parameter :: m = 39.948d0, dt = 0.05d0, l = 17.158d0
    
        real*8, dimension(3, natom) :: coord, vatom, fatom
        real*8 :: Epot, Ekin, Etot

        call calc_force(natom, coord, fatom)
        call calc_pot(natom, coord, Epot)

        vatom = 0.0d0

        ! Main loop
        do run = 1, itime
            do i = 1, natom
                vatom(:,i) = vatom(:,i) + 0.5d0 * dt * fatom(:,i) / m
                coord(:,i) = coord(:,i) + dt * vatom(:,i)
            end do

            call calc_force(natom, coord, fatom)

            Ekin = 0.0d0
            do i = 1, natom
                vatom(:,i) = vatom(:,i) + 0.5d0 * dt * fatom(:,i) / m
                Ekin = Ekin + 0.5d0 * m * sum(vatom(:,i)**2)
            end do

            call calc_pot(natom, coord, Epot)
            Etot = Ekin + Epot
        end do
    ...

Use the following parameters as given: 

+-----------------------------+-------------------------+
| Parameter                   | Value                   |
+=============================+=========================+
| Number of particles         | 108                     |
+-----------------------------+-------------------------+
| Mass of particles (amu)     | 39.948                  |
+-----------------------------+-------------------------+
| Length of simulation box (Å)| 17.158                  |
+-----------------------------+-------------------------+
| Number of iterations        | 1000                    |
+-----------------------------+-------------------------+
| Length of time step         | 0.05                    |
+-----------------------------+-------------------------+
| Force constant              | 5                       |
+-----------------------------+-------------------------+

After including all steps and parameters into your main program try to write out a trajectory 
and describe what you observe. Write also out the development of the kinetic, potential and 
total energy per timestep.


Time averages, ensemble averages, and temperature
=================================================
The sequence of positions :math:`\mathbf{r}^N(t_m)` and velocities :math:`\mathbf{v}^N(t_m)` at the 
discrete time points :math:`t_m = m\delta t, m=1, \dots, M` generated by a successful MD 
run represents a continuous trajectory :math:`\mathbf{r}^N(t)` of the system of 
duration :math:`\Delta t = M\delta t` with starting point :math:`t = 0` and end 
point :math:`t = M \Delta t`. We can use this discrete trajectory to visualize 
the motion of the particles on a graphics workstation, but in the end we always 
want to compute a time average of some function 
:math:`\mathcal{A}\left({\bf{r}}^N,{\bf{\dot r}}^N \right)` of position and velocity. 
The total energy :math:`\mathcal{K} + \mathcal{V}` is an example of such a function. 
Written as a function of position :math:`{\bf{r}}^N` and momentum :math:`{\bf{p}}^N`, these 
functions are usually called phase functions. Evaluated along a given trajectory 
:math:`{\bf{r}}^N(t)`, they yield an ordinary function :math:`A(t)` of time

.. math::
    :label: phaseFunction

    A(t) \equiv \mathcal{A} \left( {\bf{r}}^N(t),{\bf{p}}^N(t)\right),

which are, of course, different for different trajectories. Being a proper function of 
time :math:`A(t)` can be differentiated with respect to time giving

.. math::
    :label: derivPhaseFunction

    \frac{dA}{dt} = \frac{d}{dt} \mathcal{A}\left( {\bf{r}}^N(t),{\bf{p}}^N(t)\right) = \sum^n_{j=1} \left[ {\bf{\dot r}}_j \frac{\partial\mathcal{A}}{\partial{\bf{r}}_j} + {\bf{\dot p}}_j \frac{\partial \mathcal{A}}{\partial {\bf{p}}_j} \right].

Denoting the time average of the phase function :math:`\mathcal{A}` over the continuous trajectory 
:math:`{\bf{r}}^N(t)` of length :math:`\Delta t` by :math:`\bar{A}_{\Delta t}` we can write

.. math::
    :label: tAvgPhaseFunction

    \bar{A}_{\Delta t} = \frac{1}{\Delta t} \int^{\Delta t}_0 dt \mathcal{A}\left({\bf{r}}^N(t),{\bf{p}}^N(t) \right) = \frac{1}{\Delta t} \int^{\Delta t}_0 dt A(t).

Since the time step in MD is smaller than the fastest motion in the system the average of the 
discrete points of the MD trajectory gives us a very good approximation to 
:math:`\bar{\mathcal{A}}_{\Delta t}`.

.. math::
    :label: approxTAvgPhaseFunction

    \bar{A}_{\Delta t} \cong \frac{1}{M} \sum^M_{m=1} A\left( t_m \right)

Time averages also provide the connection to statistical mechanics through the ``ergodic principle``.
This principle states that time averages of ergodic systems, in the limit of trajectories of 
infinite length :math:`\Delta t`, can be replaced by ensemble averages.
Since the MD algorithms discussed so far (ideally) produce a trajectory at constant energy, 
the appropriate ensemble for MD is the ``microcanonical ensemble``.

.. math::
    :label: NVEPhaseFunction

    \text{lim}_{\Delta t \to \infty}\bar{A}_{\Delta t} = \int d{\bf{r}}^Nd{\bf{p}}^N \rho_{NVE} \left( {\bf{r}}^N,{\bf{p}}^N\right) \mathcal{A}\left( {\bf{r}}^N,{\bf{p}}^N\right) \equiv \left< A\right>_{NVE}

where :math:`\rho_{NVE}` is given by a Dirac delta function in the total energy, restricting the 
manifold of accessible phase points :math:`{\bf{r}}^N,{\bf{p}}^N` to a hypersurface of constant energy 
:math:`E` only.

.. math::
    :label: distributionNVE

    \rho_{NVE} \left({\bf{r}}^N,{\bf{p}}^N\right) &= \frac{f(N)}{\Omega}\delta\left[\mathcal{H}\left({\bf{r}}^N,{\bf{p}}^N\right)-E\right] \\
    \Omega & = f(N) \int d{\bf{r}}^Nd{\bf{p}}^N \delta\left[\mathcal{H}\left({\bf{r}}^N,{\bf{p}}^N\right)-E\right]

:math:`\mathcal{H}` is the phase function, giving the total energy of the system. :math:`f(N)` is some
function of the number of particles, which can be omitted if we are only interested in the ensemble 
distribution :math:`\rho_{NVE}`. This factor becomes crucial if we want to give the normalization 
factor :math:`\Omega` a thermodynamical interpretation (see below).

Condensed matter systems are hardly ever isolated. The least they do is exchanging energy 
with their environment. In any textbook on the subject, it is shown that states of such a system, 
in equilibrium with a thermal reservoir of temperature :math:`T`, are distributed according to the 
``canonical ensemble``.

.. math::
    :label: distributionNVT

    \rho_{NVT}\left({\bf{r}}^N,{\bf{p}}^N\right) &= \frac{f(N)}{Q_N} \text{exp}\left[-\frac{\mathcal{H}\left({\bf{r}}^N,{\bf{p}}^N\right)}{k_\text{B}T}  \right] \\
    Q_N(V,T) &= f(N) \int d{\bf{r}}^N d{\bf{p}}^N \text{exp}\left[-\frac{\mathcal{H}\left({\bf{r}}^N,{\bf{p}}^N\right)}{k_\text{B}T}  \right]

Canonical expectation values are exponentially weighted averaged over all points in phase space

.. math::
    :label: NVTPhaseFunction

    \left< A \right>_{NVT} &= \int d{\bf{r}}^N d{\bf{p}}^N \rho_{NVT} \left({\bf{r}}^N,{\bf{p}}^N\right) \mathcal{A} \left({\bf{r}}^N,{\bf{p}}^N\right) \\
    &= \frac{f(N)}{Q_N} \int d{\bf{r}}^N d{\bf{p}}^N \mathcal{A} \left({\bf{r}}^N,{\bf{p}}^N\right) \text{exp} \left[-\beta\mathcal{H}\left({\bf{r}}^N,{\bf{p}}^N\right) \right]

where as usual :math:`\beta = 1 / k_\text{B}T`. The canonical ensemble also provides an easy route 
to obtain the expression for the factor :math:`f(N)` by taking the classical limit of the quantum 
canonical ensemble. If all :math:`N` particles are identical (of the same species) the result is

 .. math::
    :label: fN

    f(N) = \left( h^{3N} N!\right)^{-1}

where :math:`h` is Planck's constant. The dimension of :math:`h` is that of position :math:`\times` momentum. 
:math:`f(N)` in Equation :eq:`fN` is therefore a (very small) reciprocal phase space volume which makes the 
normalization factors of the ensembles in Equations :eq:`distributionNVE` and :eq:`distributionNVT`
dimensionless quantities, i.e real numbers. Planck's constant acts therefore as an absolute measure 
of phase space. 
The :math:`N!` takes account of the indistinguishability of the particles. It can be viewed as 
correcting for overcounting in the classical ensemble where permuting the position and 
momentum of a pair of particles would lead to a different state (point) in phase space 
:math:`{\bf{r}}^N,{\bf{p}}^N`.
Multiplied with this :math:`N` dependent coefficient Equation :eq:`fN`, the normalization factors :math:`\Omega`
and :math:`Q_N` can be related to two very important thermodynamic quantities, namely :math:`\Omega` to 
the ``Boltzmann entropy`` :math:`S`

.. math::
    :label: Boltzmann

    S = k_\text{B} \text{ln}\Omega

and :math:`Q_N` to the ``Helmholtz free energy`` :math:`A`.

.. math::
    :label: Helmholtz

    A = -k_\text{B}T \text{ln}Q_N

where :math:`k_\text{B}` is Boltzmann's constant. The standard names for :math:`\Omega` and :math:`Q_N` are 
the microcanonical / canonical partition function respectively. 
Equations :eq:`Boltzmann` and :eq:`Helmholtz` 
are the central relations linking statistical mechanics to thermodynamics. 
The factor :math:`f(N)` played a crucial role in this identification. It is helpful not to 
forget that the founding fathers of statistical mechanics arrived at these results without 
the help of quantum mechanics. Arguments concerning the additivity of entropy of mixing 
and similar considerations led them to postulate the form of the :math:`N` dependence. It was, 
of course, not possible to guess the precise value of the effective volume of the microscopic 
phase element :math:`h^{3N}`.
Kinetic energy is a rather trivial quantity in (classical) statistical thermodynamics. 
The average per particle is, independently of interaction potential or mass, always equal 
to :math:`3 / 2~k_\text{B}T` (equipartition). The basic quantity of interest is the probability 
distribution :math:`P_N\left( {\bf{r}}^N \right)` for the configuration :math:`{\bf{r}}^N` of the 
system obtained by integrating over momenta in Equation :eq:`distributionNVT`.

.. math::
    :label: probDistib

    P_N\left( {\bf{r}}^N \right) &= \frac{1}{Z_N} \left[-\beta \mathcal{V} \left( {\bf{r}}^N \right) \right] \\
    Z_N &= \int d\left( {\bf{r}}^N \right) \text{exp} \left[-\beta \mathcal{V} \left( {\bf{r}}^N \right) \right]

The configurational partition function :math:`Z_N` in Equation :math:`probDistib`, is the integral of the Boltzmann 
exponent :math:`\text{exp}\left[-\beta \mathcal{V} \left( {\bf{r}}^N \right) \right]` over 
all configuration space. We deliberately wrote it in a form free of all reminants on 
quantum theory. :math:`Z_N` is related to the canonical partition function :math:`Q_N` and the 
free energy by

.. math::
    :label: ZNQN

    \text{exp}\left[-A / k_\text{B}T\right] = Q_N = \left(N!\Lambda^{3N}\right)^{-1} Z_N

where :math:`\Lambda` is the thermal wavelength

.. math:: 
    :label: thermalWavelength

    \Lambda = \frac{h}{\sqrt{2\pi mk_\text{B}T}}.

The factor :math:`\Lambda^{3N}` is a temperature dependent volume element in configuration space.
The deeper significance of the thermal wavelength :math:`\Lambda` is that it provides a criterium 
for the approach to the classical limit.
Quantum effects can be ignored in equilibrium statistics if :math:`\Lambda` is smaller than any 
characteristic length in the system.


Temperature in MD and how to control it
=======================================
Temperature was introduced in the previous section as a parameter in the exponent of the canonical 
ensemble distribution function Equation :math:`NVTPhaseFunction`. Via the fundamental 
Equation :eq:`Helmholtz`` this statistical temperature could be identified with the empirical 
temperature of classical thermodynamics. 
It is not immediately obvious, however, how to use these concepts to define and measure 
temperature in an MD simulation. For this we have to return to the ``microcanonical ensemble`` 
and find an observable (phase function) :math:`\mathcal{T}` for which the microcanonical expectation 
value is a simple function of temperature, preferably linear. This temperature could then also 
be measured by determining the time average of the phase function :math:`\mathcal{T}` over a sufficiently 
long period, because Equation :math:`NVEPhaseFunction` allows us to equate the time average and microcanonical ensemble average. 
In fact, this is very much how real thermometers work. For classical systems there is such a phase 
function, namely kinetic energy. The canonical average of kinetic energy is particularly easy to 
compute.

.. math::
    :label: kineticEnergy

    \left< \sum^N_{i=1} \frac{{\bf{p}}_i^2}{2m_i} \right>_{NVT} = \frac{3}{2}Nk_\text{B}T

The microcanonical average :math:`\left< \dots\right>_{NVE}` of Equation :math:`NVEPhaseFunction`
and canonical average of Equation :math:`NVTPhaseFunction` of a quantitative are not identical. 
In statistical mechanics it is shown that for properties such as kinetic energy, the difference 
is one order less in system size :math:`N`. 
This implies that the fractional difference vanishes in the thermodynamic limit of very large :math:`N`.
The microcanonical average of the kinetic energy of a many particle system, therefore, will also 
be equal to :math:`\frac{3}{2}~Nk_\text{B}T`. Hence, we can define an instantaneous or kinetic 
temperature function

.. math::
    :label: kineticTemperature

    T = \frac{1}{3k_\text{B}N} \sum^N_{i=1} m_i\textbf{v}_i^2

which, averaged over an MD run gives us the temperature of the system 

.. math:: 
    :label: systemTemp

    T=\frac{1}{M} \sum^M_{m=1} T(t_m)

The formal way we have introduced kinetic temperature, is clearly somewhat heavy and redundant 
for such a simple propery. However, for other quantities, such as pressure, the relation between 
``mechanical observable`` and their ``thermodynamic counterpart`` is less straightforward. Another 
notorious example is temperature in quantum systems.

After having found a method of measuring temperature in MD, the next problem is how to impose a 
specified temperature on the system and control it during a simulation. Several approaches for 
temperature control in MD have been developed, some more sophisticated and rigorous than others. 
For the purpose of getting started, the most suitable algorithm is the simplest, and also the most 
robust, namely ``temperature scaling``. The idea is to scale all particle velocities by a factor 
determined from the ratio of the instantaneous kinetic temperature and the desired temperature. 
We will illustrate this with the outline of a procedure appropriate for use with the 
Velocity Verlet algorithm.

