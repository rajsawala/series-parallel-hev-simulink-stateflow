function [T_req, Grade] = generate_terrain_scenario(Terrain_Mode, T_req_in)
% #codegen
% This block generates simulated vehicle states based on selected terrain.
%
% Input:
%   Terrain_Mode - 1 = City, 2 = Highway, 3 = Mountain, etc.
%
% Outputs:
%   T_req  - Driver torque request in Nm
%   Grade  - Road gradient in %

    switch Terrain_Mode
        case 1
            % drive cycle 1
            T_req = T_req_in;    % Nm
            Grade = 0.0;         % flat road
        case 2
            % drive cycle 2
            T_req = T_req_in;    % Nm
            Grade = 1.0;         % slight road grade
        case 3
            % drive cycle 3
            T_req = T_req_in;    % Nm
            Grade = 8.0;         % steep uphill road  
        case 4
            % drive cycle 4
            T_req = T_req_in;    % Nm
            Grade = 0.0;         % flat road
        case 5
            % drive cycle 5
            T_req = T_req_in;    % Nm
            Grade = 1.0;         % slight road grade
        case 6
            % drive cycle 6
            T_req = T_req_in;    % Nm
            Grade = 8.0;         % steep uphill road  
        otherwise
            % DEFAULT / FAILSAFE
            T_req = 0.0;         % Safely zero out torque demand
            Grade = 0.0;         % Assume flat ground
    end
end
