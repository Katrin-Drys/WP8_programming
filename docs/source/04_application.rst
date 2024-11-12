Perform two MD simulations 
===========================

Simulate the behavior of two Lennard-Jones-systems (Argon) with the following parameters
using your own MD program:

+-----------------------------+-------------------------+
| Parameter                   | Value                   |
+=============================+=========================+
| Number of particles         | 108                     |
+-----------------------------+-------------------------+
| Mass of particles (amu)     | 39.948                  |
+-----------------------------+-------------------------+
| Number of iterations        | 8000                    |
+-----------------------------+-------------------------+
| Length of time step (ps)    | 0.005                   |
+-----------------------------+-------------------------+
| Temperature (K)             | 140                     |
+-----------------------------+-------------------------+

System 1 should have a density of :math:`\rho_1 = 0.095~g/cm^3` and 
System 2 should have a density of :math:`\rho_2 = 1.050~g/cm^3`.

Estimate when the equilibrium is reached by plotting the total energy and temperature. 
Explain your decision process. Furthermore calculate the average kinetic, potential and 
total energy when the equilibrium is reached. 

Plot for both equilibrated systems the ``radial distribution function`` by using ``TRAVIS``. 
To do so, type the following command in your terminal:

.. code-block:: bash

   travis -p yourTrajectory.xyz

and answer the questions that are asked.
Compare the pair distribution functions. What kind of structural changes can be observed and what 
kind of physical states are we simulating? Explain which system represents which physical state.

Acknowledgements
================

We would like to acknowledge the Numerical Simulations in Chemistry course by Michiel Sprik and the 
QCII script by the Grimme group, which inspired us for our script. 
