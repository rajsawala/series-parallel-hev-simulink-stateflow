function [T_engine, T_motor, T_gen] = Torque_Split_Dynamic(...
     T_req, SOC, Grade, Clutch_Cmd, Engine_Cmd, Gen_Load,omega_eng)

%  CONSTANTS & VEHICLE PARAMETERS
g            = 9.81;        % m/s^2 - Gravity
m_veh        = 1200;        % kg    - Vehicle mass
r_wheel      = 0.3;        % m     - Wheel radius

%% POWERTRAIN PARAMETERS
T_engine_max = 200;         % Nm    - Max engine torque
T_motor_max  = 150;         % Nm    - Max motor torque
T_gen_max    = 150;         % Nm    - Max generator torque capacity
T_engine_opt = 120;         % Nm    - Engine best efficiency torque


eta_gen      = 0.90;        % -     - Generator efficiency
eta_motor    = 0.92;        % -     - Motor efficiency
eta_clutch   = 0.97;        % -     - Clutch mechanical efficiency

%% SOC THRESHOLDS
SOC_low      = 30;          % %     - Low battery threshold
SOC_high     = 80;          % %     - High battery threshold
SOC_target   = 60;          % %     - Ideal SOC target
k_soc        = 0.5;         % -     - SOC error gain

%%  PHYSICS CALCULATIONS

theta = atan(Grade / 100);               % [radians]
F_grade = m_veh * g * sin(theta);        % Grade force [N]


W_soc = max(0, min(1, (SOC - SOC_low) / (SOC_high - SOC_low)));
delta_T_charge = k_soc * (SOC_target - SOC); 

%%  COMMAND-BASED TORQUE SPLIT

% Initialize all values
T_engine = 0; T_motor = 0; T_gen = 0;
omega_engine = omega_eng;

if Engine_Cmd == 0 && Clutch_Cmd == 0 && Gen_Load == 1
    % --- STANDBY or REGEN BRAKING ---
    if T_req < 0 
        T_motor = -abs(T_req) * eta_motor;
        T_motor = max(T_motor, -T_motor_max);              
    else
        T_motor  = 0;
    end

elseif Engine_Cmd == 1 && Clutch_Cmd == 0 && Gen_Load == 1
    % --- SERIES MODE ---
    T_motor = min(T_req, T_motor_max);
    
    if SOC >= SOC_high
        T_engine = 0;
    else
        T_engine = T_engine_opt + delta_T_charge;
        T_engine = max(0, min(T_engine, T_engine_max));
    end
    
    T_gen = T_engine; % Generator absorbs mechanical torque directly

elseif Engine_Cmd == 1 && Clutch_Cmd == 1 && Gen_Load == 0
    % --- PARALLEL MODE ---
    T_grade_motor = F_grade * r_wheel;                  
    
    T_engine = (1 - W_soc) * T_engine_max;
    T_engine = min(T_engine, T_req);
    
    T_motor  = (T_req - (T_engine * eta_clutch)) + T_grade_motor;
    T_motor  = max(0, min(T_motor, T_motor_max));
    T_gen    = 0;

elseif Engine_Cmd == 1 && Clutch_Cmd == 1 && Gen_Load == 1
    % --- SERIES-PARALLEL MODE ---
    T_engine = T_engine_opt;
    
    if T_engine >= T_req
        % Engine has surplus. Calculate torque gap and route to generator.
        T_surplus = T_engine - T_req;
        T_gen     = T_surplus;
        T_motor   = 0;
    else
        % Engine has deficit. Motor must assist.
        T_motor = min(T_req - T_engine, T_motor_max);
        T_gen   = 0;
    end
end


T_engine = max(0, min(T_engine, T_engine_max));
T_motor  = max(-T_motor_max, min(T_motor, T_motor_max));

% BUG 4 FIXED: Clamped to T_gen_max instead of T_engine_max
T_gen    = max(0, min(T_gen, T_gen_max)); 

end
