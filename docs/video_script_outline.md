# HEV model video documentation script

Use this repository with the Simulink model open. Suggested walkthrough order:

1. Top-level model architecture
2. Control subsystem
3. Driver PI controller
4. Terrain/grade scenario
5. Stateflow EMS mode selection
6. Torque_Split_Dynamic MATLAB Function
7. Motor_control subsystem
8. Generator_control subsystem
9. Battery subsystem
10. Physical Plant subsystem
11. Engine/clutch section
12. Motor/generator section
13. Brake, tire, vehicle body and grade section
14. Engine sensor subsystem
15. Scope results for Drive Cycle 2
16. Conclusion and limitations

Key line to say: This is a closed-loop series-parallel HEV model in which the control subsystem calculates torque demand and mode commands, while the Simscape physical plant returns speed and engine feedback for the next control step.
