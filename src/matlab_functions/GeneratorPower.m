function [P_gen,I_gen] = GeneratorPower(T_gen_sat, omega_eng, V_bat, eta, I_max_charge)

% Electrical power generation
P_gen = T_gen_sat * omega_eng * eta;

% Avoid divide-by-zero
V_nom_min = 1;
V_safe = max(V_bat, V_nom_min);

% Charging current
I_gen = P_gen / V_safe;

% Current limit
I_gen = min(I_gen, I_max_charge);

% No negative charging current
I_gen = max(I_gen,0);

end
