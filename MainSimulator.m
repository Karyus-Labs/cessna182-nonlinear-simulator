%% Main function
function [params, response] = MainSimulator
    
    clear all
    close all
    clc
    load('aircraft.mat');
    
    [alpha_trim, delta_trim, T_calculated_trim] = trim_aircraft(params);
    
    params.engine.T_trim_value = T_calculated_trim;
    
    u0 = params.flycond.speed.si * cos(alpha_trim)
    w0 = params.flycond.speed.si * sin(alpha_trim)
    q0 = 0.0
    theta0 = alpha_trim
    x0 = 0;
    z0 = -params.flycond.altitude.si;
    
    x = [u0, w0, q0, theta0, x0, z0]; 
    
    input = [0.0*delta_trim]; 
    
    xdot = @(t,x)transpose(LongSimulator(t,x,params,input));
    
    [t_sim, x_sim] = ode45(xdot, [0 250], x);
    
end

%% Trimming
function [alpha_trim, delta_trim, T_trim] = trim_aircraft(params)
    c = params.chord.si; 
    S = params.area.si;
    rho = params.flycond.rho;
    Uinf = params.flycond.speed.si;
    m = params.mass.si;
    g = params.flycond.gravity;
    CL0 = params.aero.CL0; 
    CLa = params.aero.CLa;
    CLde = params.aero.CLde;
    CM0 = params.aero.CM0;
    CMa = params.aero.CMa;
    CMde = params.aero.CMde;

    CLtrim = (m * g) / (0.5 * rho * Uinf^2 * S)
    M_matrix = [CMa, CMde; CLa, CLde];
    f_vector = [-CM0; CLtrim - CL0];
    resp = M_matrix \ f_vector;
    alpha_trim = resp(1)
    delta_trim = resp(2)
    CDtrim = params.aero.CD0 + params.aero.k * CLtrim^2;
    D = 0.5 * rho * Uinf^2 * S * CDtrim;
    L = 0.5 * rho * Uinf^2 * S * CLtrim;
    T_trim = -L * sin(alpha_trim) + D * cos(alpha_trim)
end
