function [Fy] = lateral_forces(steering, beta, vel, diff_yaw, Cf, Cr, Lf, Lr)
    
    Fy_front = 2 * Cf * (steering - beta - Lf / (vel * cos(diff_yaw)) * diff_yaw);
    Fy_rear = 2 * Cr * (- beta + Lr / (vel * cos(diff_yaw)) * diff_yaw);
    Fy = Fy_front + Fy_rear;
    
end