%% init_HEV_workspace_template.m
% Workspace initialization template for HEV_2_7_26_copy.slx
% Verify/tune these values against your final model settings before submission.

clearvars -except ans; clc;

dt = 0.01;                 % Simulation sample time [s]
SOC_init = 0.90;           % Initial SOC [fraction]
V_RC_init = 0;             % Initial RC branch voltage [V]

% Battery parameters - verify with final chosen values
C_nom = 5;                 % Nominal capacity [Ah] placeholder
R1 = 0.015;                % RC resistance [ohm] placeholder
C1 = 2400;                 % RC capacitance [F] placeholder
I_max_charge = 50;         % Maximum generator charging current [A] placeholder
T_gen_max = 150;           % Generator torque saturation [Nm]

% Driver controller gains - verify with Simulink constants
Kp = 2;
Ki = 0.05;

% Drive-cycle placeholders: replace with actual drive-cycle data if available.
t = (0:dt:400)';
dc_ts = cell(1,6);
dc_ts{1} = timeseries(20 + 10*square(2*pi*t/120), t);              % city-like
dc_ts{2} = timeseries(max(0, min(35, 0.12*(t-20))) .* (t<115) + ...
                     14.*(t>=115 & t<190) + 19.*(t>=190 & t<250) + ...
                     (19 + 0.16*(t-250)).*(t>=250 & t<335) + ...
                     max(0, 33 - 0.9*(t-335)).*(t>=335), t);
dc_ts{3} = timeseries(25 + 8*sin(2*pi*t/160), t);                 % mountain-like
dc_ts{4} = timeseries(15 + 5*sin(2*pi*t/90), t);
dc_ts{5} = timeseries(30 + 4*sin(2*pi*t/150), t);
dc_ts{6} = timeseries(18 + 8*sin(2*pi*t/110), t);

fprintf('HEV workspace template loaded. Verify all placeholder parameters before final validation.\n');

