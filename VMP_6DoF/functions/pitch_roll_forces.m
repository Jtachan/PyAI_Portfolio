function [diff_pitch, diff_roll, vel_pitch, vel_roll, acc_pitch, accel_roll] = pitch_roll_forces(accel, pitch, roll, ...
    vel_pitch, vel_roll, diff_yaw, Fc, Fy, ...
    Ixx, Iyy, ms, Lf, Lr, tm, d_pr, h_pc, dt)
    
    % Acceleration vectors
    ax =  -accel * cos(diff_yaw);
    ay =  -accel * sin(diff_yaw);
    gravity = 9.81;
    
    % Forces evaluation
    % Fc = [front_right, front_left, rear_right, rear_left]
    % 'Fy' given as an input of the function
    Fc_front = Fc(1) + Fc(2);
    Fc_rear = Fc(3) + Fc(4);
    Fc = Fc_front + Fc_rear;
    
    % Terms in pitch acceleration equation
    pitch_fx = ms * ax * h_pc;
    pitch_fc = Fc_front * Lf + Fc_rear * Lr;
    pitch_ax_g = ms * d_pr * (ax + gravity * tan(pitch));
    
    % Pitch evaluation
    acc_pitch = (pitch_fx + pitch_fc + pitch_ax_g - 10e4*vel_pitch) / (Iyy + ms * d_pr^2);
%     acc_pitch = (pitch_fx + pitch_fc + pitch_ax_g) / (Iyy + ms * d_pr^2);
    diff_pitch = vel_pitch * dt + 0.5 * acc_pitch * dt^2;
    vel_pitch = vel_pitch + acc_pitch * dt;
    
    % Terms in roll acceleration equation
    roll_fy = Fy * h_pc;
    roll_fc = Fc * tm/2;
    roll_ax_g = ms * d_pr * (ay + gravity * roll);
    
    % Roll evaluation
    accel_roll = (roll_fy + roll_fc + roll_ax_g) / (Ixx + ms * d_pr^2);
    if accel_roll == 'NaN'
        accel_roll = 0;
    end
    diff_roll = vel_roll * dt + 0.5 * accel_roll * dt^2;
    vel_roll = vel_roll + accel_roll * dt;
    
end