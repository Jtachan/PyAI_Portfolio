# Vehicle Model Predictor with 6-DoF (VMP)
This was my Final Bachelor's Degree Project at the University.
The formal memory is also uploaded to the same file, however it's only in Spanish.
In it, at the last page, it's all the external links and bibliography I used for research.
If someone find it usefull for further research, cite my work.

The motivation for the research is to find a mathematically accurate vehicle model,
which can predict the 6 degrees of freedom (DoF) of a vehicle in motion.
With it, the model could help at autonomous driving applications.
Within the main idea, it was desired to implement the model at an odometry application to improve the efficiency of the *Unscented Kalman Filter* (UKF).

  <img src="imgs/full_vehicle.png" width=500 alt="vehicle_model">

## Project specifications
The fisrt step was to set all the signals and variables that the model would need:

  - *State variables:*
    - Cartesian positioning along all axes: {*X, Y, Z*}
    - Rotation along all axes: {*roll, pitch, yaw*} or {*&theta;, &phi;, &psi;*}
  - *Input control signals:*
    - Position of the steering wheel: *&lambda;*
    - Vehicle speed: *V*

  <img src="imgs/rpy.png" width=500 alt="roll_pitch_yaw">
  
Some aditional criteria was also specified to simplify the model:

  - The vehicle is a four tyres private car
  - The vehicle travels without any significant load
  - The model works for low velocity (urban routes)
  - The road has no slope and no bumps

With it, the final model is defined as a **combination** of different mathematical and/or physical models.

# Vehicle caracterization
## Relation steering wheel and front tyres rotation
As specified before, one of the control signals is the steering wheel position (as an angle).
However this data has to be transformed into a front tyre rotation to be used at the model.
By following the Ackerman turning model, the rotation of the tyre is greater at the inner wheel than the outer.

<img src="imgs/Ackerman.png" alt="ackerman" width=500>

With this information, the final solution will show the ratio steering wheel / middle tyre.
The middle tyre does not exist physically, but it will be use as an approximation.
For the ratio calculation, a Citröen C4 is used as the test model for all physical measurements.
Thus, the first measurement was for the tyres rotation, obtaining the following results:

<img src="imgs/tyres_rotation.png" alt="tyres_rotation" width=650>

At the graph, the orange function represents the left tyre and the blue one, the right tyre.
The ratio was obtained by the second degree ecuation of the curve created by the mean of both, the left and right tyres, measurements.

*ratio = 15.75 &plus; 2 &sdot; 10<sup>-16</sup> &sdot; &lambda; &minus; 4 &sdot; 10<sup>-6</sup> &sdot; &lambda;<sup>2</sup>*

By taking care of no linealities, the front middle tyre rotation (*&delta;*) is defined as following:

*&delta; = arctan(&lambda; &frasl; ratio)*

## Center of Gravity (CG)
The CG is the imaginary point around which all resultant torques vanishes.
Thus, by definition, the CG is positioned within the body as a function of the weight distribution.<br />
By analyzing a vehicle; and defining the axis as X to the front, Y to the left and Z upwards; its CG is position:
  
  - Closer to the front of the vehicle at the X axis.
  - At the origin at the Y axis, because a vehicle is laterally well-balanced.
  - Close to the ground (the origin) at the axis Z but with height.

The only two coordinates that are not known are the X and Z position.
These ones can be found at any vehicle by realizing two weight measurements and aplying trigonometry:

First measurement | Second measurement
--------------- | ---------------
<img src="imgs/side_cg.png" alt="CG" width=450> | <img src="imgs/side_elev_cg.png" alt="elevated_CG" width=450>

With the **first measurement** it's known the front and rear mass (*M<sub>f</sub>, M<sub>r</sub>*).
Applying these terms to the equilibrium equation, the distance from CG to the front and the rear distance (*l<sub>f</sub>, l<sub>r</sub>*) are found,
defining the CG position along the X axis.
At the next equations, *L* represents the wheelbase of the vehicle.

*l<sub>f</sub> = L &sdot; M<sub>r</sub> / M* <br />
*l<sub>r</sub> = L &sdot; M<sub>f</sub> / M = L &minus; l<sub>f</sub>*

With the **second measurement**, *H* is a selected height to elevate the rear part of the vehicle.
Applying basic trigonometry, the angle represented as *&#1012;* is also known. 
Therefore, because of the new mass distribution due to the elevation, the front and rear masses (*M<sub>1</sub>, M<sub>2</sub>*) are different.
<br />Then the height of the CG is defined by the following mathematical relation:

*Z<sub>CG</sub> = (M<sub>1</sub> &sdot; l<sub>f</sub> &minus; M<sub>2</sub> &sdot; l<sub>r</sub>)
/ (M &sdot; tan(&#1012;))*

