close all
clear  
%% Declaración de las constantes del vehículo

gravity = -9.81;
steer_factor = 16.8;

% All next measures are expressed in meters
wheelbase = 2.608;
Lf = 0.9588;
Lr = wheelbase - Lf;

tf = 1.497;
tr = 1.510;
tm = (tf + tr)/2;

H_car = 1.471;
W_car = 1.773;
L_car = 0.935 + wheelbase + 0.717;

% The wheel is R17
% The next radious is expressed in meters
r_wheel = 17 * (2.54/100*0.5) + (205e-3 * 0.5);

% Mass in kg
m = 1360;
mf = 860; % Front mass
mr = 500; % Rear mass
mu = 20; % Wheel mass
ms = m - 4*mu; % Chasis mass

% Cornering stiffness (N/rad)
Cf = 837 * 180 / pi;
Cr = 803.4 * 180 / pi;

% Inertia (kg*m^2)
Ixx = ms * (H_car^2 + L_car^2) / 12;
Iyy = ms * (W_car^2 + L_car^2) / 12;

% Measures till the center of gravity (CG)
z_cg = H_car/2;
h_rp = r_wheel * 2/3;
d_rp = z_cg - h_rp;

% Dampers
xi = 0.7;

Kf = 37663;
wf = 9.36;
Df = xi * (2*wf*mf);

Kr = 30656;
wr = 11.07;
Dr = xi * (2*wr*mr);

% Steady state constants (empirical)
k_roll_ss = 45e3 + m * gravity * H_car;
k_pitch_ss = 53e4 + m * gravity * H_car;

%%--------------------------------%%
% run('recta_accel');
%%--------------------------------%%
load('tablas_mediciones.mat')
dt = 0.1;
vel = outputslam40m.speed/1.105;
steering_wheel = outputslam40m.steeringAngle;
gps_X = outputslam40m.gpsx;
gps_Y = outputslam40m.gpsy;
samples = length(vel);
tiempo = zeros(1,samples);
%%--------------------------------%%

%% Creacion de arrays de variables a evaluar

empty_array = zeros(1, samples);

pos_x = empty_array; 
pos_y = empty_array;
yaw = empty_array;
dist = empty_array;

err_x = empty_array;
err_y = empty_array;
abs_err = empty_array;

clear empty_array

%% Evaluation code for all the samples
% Initial values
diff_yaw = 0; yaw(1) = -5*pi/6;
yaw_offset = -pi/2;

for t = 1:samples-1
        
    %%%%%%%%%%%%%%%%%%%% MODELO BICICLETA
    steering = atan(steering_wheel(t)/steer_factor);
    
    if abs(steering) < 0.001
        beta = 0;
        diff_yaw = 0;
    else
        beta = atan(Lr * tan(steering) / wheelbase);
        diff_yaw = vel(t) * sin(beta) / Lr * dt;
    end
    diff_x = vel(t) * cos(yaw(t) + beta) * dt;
    diff_y = vel(t) * sin(yaw(t) + beta) * dt;
    
    %%%%%%%%%%%%%%%%%%%% ACTUALIZACIÓN ESTADOS
    pos_x(t+1) = pos_x(t) + diff_x;
    pos_y(t+1) = pos_y(t) + diff_y;
    dist(t+1) = dist(t) + vel(t) * dt;
    yaw(t+1) = yaw(t) + diff_yaw;
    
    %%%%%%%%%%%%%%%%%%%% ERRORES
    err_x(t+1) = pos_x(t+1) - gps_X(t+1);
    err_y(t+1) = pos_y(t+1) - gps_Y(t+1);
    abs_err(t+1) = sqrt( err_x(t+1)^2 + err_y(t+1)^2 );
    
end

clear t

%% Representación gráfica

% FIGURE 1 -> Trayectoria y/x
figure(1)
hold on
plot(gps_X, gps_Y,'r')
plot(pos_x,pos_y,'k')
title('Trayectory')
legend('Ground Truth','Estimation')
xlabel('metros')
ylabel('metros')

figure(2)
hold on
plot(abs_err, 'r')
plot(err_x, 'b')
plot(err_y, 'g')
legend('RMS','Error en X', 'Error en Y')
title('Errores')
ylabel('metros')
xlabel('samples')
