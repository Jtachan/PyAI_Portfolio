function [beta, diff_x, diff_y, diff_yaw] = bycicle(L, lr, steering, yaw, vel, dt)
    % Se utiliza el modelo de la bicicleta para conocer el angulo de
    % deslizamiento (beta) y las variaciones de X, Y y yaw
    % Todos los angulos han de ser radianes
    
    % L = longitud entre ejes
    % lr = longitud del centro de masas al eje trasero
    % steering = angulo de giro de las ruedas
    % yaw = direccion hacia la que apunta el vehiculo (angulo)
    % vel = velocidad del vehiculo
    % dt = diferencial de tiempo
    
    beta = atan(lr * tan(steering) / L);
    diff_x = vel * cos(yaw + beta) * dt;
    diff_y = vel * sin(yaw + beta) * dt;
    yaw_rate = vel * sin(beta) / lr;
    diff_yaw = yaw_rate * dt;

end