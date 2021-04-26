function [roll] = roll_accel(accel, diff_yaw, ms, d_roll, k_roll)
    
    ay = - accel * sin(diff_yaw);
    roll = ay * ms * d_roll / k_roll;

end