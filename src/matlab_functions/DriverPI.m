function [T_req, brake_sig, pedal, err] = DriverPI(v_ref, v_actual, Kp, Ki, dt)
% 1. Initialize memory
persistent int_err T_req_filt
if isempty(int_err)
    int_err = 0;
    T_req_filt = 0;
end

% 2. Error calculation
err = v_ref - v_actual;

% 3. Proper Time-Based Integration
int_err = int_err + (err * dt);

% 4. Anti-Windup (Clamp the integrator memory safely)
if Ki ~= 0
    int_limit = 1 / abs(Ki);
    int_err = max(-int_limit, min(int_limit, int_err));
end

% 5. PI Control Law
pedal_unsat = (Kp * err) + (Ki * int_err);
pedal = max(-1, min(1, pedal_unsat));

% 6. Torque Calculation
T_req_raw = max(0, pedal) * 280;
brake_sig = max(0, -pedal);

% 7. Low-Pass Filter (Smooths the output)
alpha = 0.02;
T_req_filt = T_req_filt + alpha * (T_req_raw - T_req_filt);
T_req = T_req_filt;
end
