%% run_HEV_model_template.m
% Run this after init_HEV_workspace_template.m

modelName = 'HEV_2_7_26_copy';
modelPath = fullfile('model', [modelName '.slx']);

if ~bdIsLoaded(modelName)
    open_system(modelPath);
end

% Stop time can be adjusted according to selected drive cycle.
set_param(modelName, 'StopTime', '400');

simOut = sim(modelName);
fprintf('Simulation completed for %s.\n', modelName);
