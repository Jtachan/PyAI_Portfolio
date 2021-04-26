function [pitch] = pitch_accel(accel, diff_yaw, ms, d_pitch, k_pitch)
    
    ax = - accel * cos(diff_yaw);
    pitch = ax * ms * d_pitch / k_pitch;

end