function [vel, steering_wheel, samples, time] = trayectos(select, dt)

    time = 0;
    end_time = 30;
    samples = end_time/dt;
    
    vel = zeros(1, samples);
    steering_wheel = zeros(1, samples);
    
    if select == 1
        % Recta con aceleraciones
        flag_accel = true;
        flag_turning = false;
        
    elseif select == 2
        % Curva con aceleración nula
        flag_accel = false;
        flag_turning = true;
        
    else
        % Curva con aceleraciones
        flag_accel = true;
        flag_turning = true;
    end
    
    if flag_accel
        samples = 1;
        acc = 0;
        while time < 0.15  % +2 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = 2;
        while time < 7  % +5 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = 0;
        while time < 11  % +4 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = -3;
        while time < 12.5  % +1.5 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = 0;
        while time < 16  % +3.5 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = -1.5;
        while time < 19  % +3 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = 0;
        while time < 20  % +1 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = -2.5;
        while time < 22  % +2 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = 2.5;
        while time < 24  % +2 seconds
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
        acc = 0;
        while time < end_time  % +6 seconds (30 seconds)
            vel(samples+1) = vel(samples) + acc * dt;
            samples = samples + 1;
            time = time + dt;
        end
    end
    
    if flag_turning
        % steering_wheel = 0;
        steering_wheel = zeros(1, samples);
    end
    
    if ~flag_accel
        for i = 1:samples
            vel(i) = 15;
        end
    end
    
    time = zeros(1,samples);
    for i = 2:samples
        time(i) = time(i-1) + dt;
    end
end