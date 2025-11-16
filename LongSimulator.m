%% Preparing the function to pass to ODE45
function xdot = LongSimulator(t, x, params, input) 
    u = x(1);
    w = x(2);
    q = x(3);
    theta = x(4);
    delta_e = input(1);

    Uinf = sqrt(u^2 + w^2);
    alpha = atan2(w, u);

    alphad_new = 0;
    alphad = 1;
    tol_alphad = 1e-6;

    % Iteration loop for angle of attack derivative
    while abs(alphad_new - alphad) > tol_alphad
        alphad = alphad_new;

        [CD,CL,CM] = aerocoef(params, alpha, alphad, Uinf, q, delta_e);
    
        coefs = [CD,CL,CM];
        
        [X,Z,M] = forcesmoments(params, alpha, coefs, Uinf, params.engine.T_trim_value); 
    
        f_m = [X,Z,M];
    
        xdot = motion(params, f_m, x);
    
        % Compute updated alpha_dot
        alphad_new = (xdot(2) * u - w * xdot(1)) /  (u * u);
    end
end

%% Module A (aerodynamic coefficients)
function [CD, CL, CM] = aerocoef(params, alpha, alphad, Uinf, q, delta_e) 
    c = params.chord.si; 
    AoA = params.aero.alpha; 

    % Lift coefficients
    CL0 = params.aero.CL0; 
    CLa = params.aero.CLa;
    CLad = params.aero.CLad; 
    CLq = params.aero.CLq;
    CLde = params.aero.CLde;

    CL = CL0 + CLa * alpha + (CLad * alphad + CLq * q) * ( c / (2*Uinf)) + CLde * delta_e ;

    % Moment coefficients
    CM0 = params.aero.CM0; 
    CMa = params.aero.CMa;
    CMad = params.aero.CMad;
    CMq = params.aero.CMq;
    CMde = params.aero.CMde;

    CM = CM0 + CMa * alpha + (CMad * alphad + CMq * q) * ( c / (2*Uinf)) + CMde * delta_e ;

    % Drag coefficient
    k = params.aero.k;
    CD0 = params.aero.CD0;
    CD = CD0 + k * CL * CL ;
end

%% Module B (forces and moments)
function [X, Z, M] = forcesmoments(params, alpha, coefs, Uinf, T_applied_value)
    S = params.area.si;
    c = params.chord.si;
    rho = params.flycond.rho; 
    eps_T = params.engine.epsilon_T;

    % Aerodynamic forces
    D = 0.5 * rho * Uinf * Uinf * S * coefs(1); 
    L = 0.5 * rho * Uinf * Uinf * S * coefs(2);
    M = 0.5 * rho * Uinf * Uinf * S * coefs(3) * c;

    % Thrust
    T = T_applied_value; 

    % Force decomposition in X and Z axes
    X = T * cos(eps_T) - D * cos(alpha) + L * sin(alpha);
    Z = -T * sin(eps_T) - D * sin(alpha) - L * cos(alpha);
end

%% Module C (motion)
function xdot = motion(params, f_m, x) 
    g = params.flycond.gravity; 
    m = params.mass.si;
    Iyy = params.Iyy.si; 

    X = f_m(1);
    Z = f_m(2);
    M = f_m(3);

    u = x(1);
    w = x(2);
    q = x(3);
    theta = x(4);
    xe = x(5);
    ze = x(6);

    % Equations of motion
    udot = X / m - g * sin(theta) - q * w ;
    wdot = Z / m + g * cos(theta) + q * u ;
    qdot = M / Iyy ;
    thetadot = q ;

    % Kinematic relations
    xedot = u * cos(theta) + w * sin(theta);
    zedot = -u * sin(theta) + w * cos(theta);

    xdot = [udot, wdot, qdot, thetadot, xedot, zedot];
end
