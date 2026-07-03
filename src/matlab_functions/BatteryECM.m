function [SOC_new, V_terminal, V_RC_new, I_batt_out] = ...
         BatteryECM(I_batt, OCV, R0, SOC_in, V_RC_in, dt, C_nom, R1, C1, N_series)

%% 1. SOC integration (Coulomb counting)
dSOC    = -I_batt * dt / (C_nom * 3600);
SOC_new = SOC_in + dSOC;
SOC_new = max(0, min(1, SOC_new));

%% 2. RC pair dynamics at cell level
alpha = exp(-dt/(R1*C1));
V_RC_new = alpha*V_RC_in + R1*(1-alpha)*I_batt;

%% 3. Terminal voltage at pack level
OCV_pack       = OCV * N_series;
R0_pack_drop   = I_batt * R0 * N_series;
V_RC_pack      = V_RC_new * N_series;

V_terminal = OCV_pack - R0_pack_drop - V_RC_pack;
V_terminal = max(2.5*N_series, min(4.3*N_series, V_terminal)); % pack-level clamp

%% 4. Pass-through
I_batt_out = I_batt;
end
