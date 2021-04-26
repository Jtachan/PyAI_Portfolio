function [Fc, diss_z] = dumper_forces(pitch, roll, d_zfr_ant, d_zfl_ant, d_zrr_ant, d_zrl_ant, Kf, Kr, Df, Dr, Lf, Lr, tf, tr, dt)
    
    displ_zfr = -Lf * pitch + tf/2 * roll;
    displ_zfl = -Lf * pitch - tf/2 * roll;
    displ_zrr = Lr * pitch + tr/2 * roll;
    displ_zrl = Lr * pitch - tr/2 * roll;
    
    diff_zfr = d_zfr_ant - displ_zfr;
    diff_zfl = d_zfl_ant - displ_zfl;
    diff_zrr = d_zrr_ant - displ_zrr;
    diff_zrl = d_zrl_ant - displ_zrl;
    
    % Añadir los terminos de masa que soporta cada amortiguador
    Fc_fr = Kf * displ_zfr + Df * diff_zfr / dt;
    Fc_fl = Kf * displ_zfl + Df * diff_zfl / dt;
    Fc_rr = Kr * displ_zrr + Dr * diff_zrr / dt;
    Fc_rl = Kr * displ_zrl + Dr * diff_zrl / dt;
    
    Fc = [-Fc_fr, -Fc_fl, -Fc_rr, -Fc_rl];
    diss_z = [displ_zfr, displ_zfl, displ_zrr, displ_zrl];
    
end