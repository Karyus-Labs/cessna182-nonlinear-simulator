%% Geometric Parameters:

params.chord.value = 4.9; %(ft)
params.chord.si = params.chord.value/3.28084; %(m)
params.area.value = 174; %(ft^2)
params.area.si = params.area.value/10.7639; %(m^2)

%% Aerodynamic Parameters - Referring to angle of attack of 0° (0 RAD) in cruise:

params.aero.alpha = 0; %(RAD)
params.aero.CL0 = 0.307;
params.aero.CLa = 4.41;
params.aero.CLad = 1.7;

params.aero.CLq = 3.9;
params.aero.CLde = 0.43; % (per radian)

params.aero.CM0 = 0.04;
params.aero.CMa = -0.613;
params.aero.CMad = -7.27;
params.aero.CMq = -12.4;
params.aero.CMde = -1.122; % (per radian)
params.aero.k = 0.032; % k is associated with induced drag
params.aero.CD0 = 0.0270; % CD0 is associated with parasite drag

%% Engine Parameters:

params.engine.epsilon_T = 0.0; % Assumed zero angle between aircraft axis and engine

%% Cruise Flight Condition Parameters:

params.flycond.pd.value = 49.6; %(lbs/ft^2)
params.flycond.pd.si = params.flycond.pd.value*47.8803;
params.flycond.gravity = 9.81; % (m/s^2)
params.flycond.speed.value = 220.1; % (ft/s)
params.flycond.speed.si = params.flycond.speed.value/3.28084; % (m/s)
params.flycond.rho = 2*params.flycond.pd.si/(params.flycond.speed.si*params.flycond.speed.si); % (Kg/m^3) Density at 5000 ft
params.flycond.altitude.value = 5000; % (ft)
params.flycond.altitude.si = params.flycond.altitude.value/3.28084; % (m)

params.mass.value = 2650; % (lbs)
params.mass.si = params.mass.value/2.20462; % (Kg)
params.Iyy.value = 1346; % (slug*ft^2)
params.Iyy.si = params.Iyy.value/1.3558; % (Kg*m^2)

save('aircraft.mat', 'params') % creates the file 'aircraft.mat' where the variables are saved
