# Design and Simulation of a Series-Parallel HEV Using MATLAB Simulink and Stateflow

This repository contains the Simulink model and supporting source files for a **Series-Parallel Hybrid Electric Vehicle (HEV)** model developed under **KPIT Apex Lab**.

## Project members

| Name | MIS | Email | Department | Institute |
|---|---:|---|---|---|
| Raj Sawala | 612407149 | sawalar24.extc@coeptech.ac.in | ExTC | COEP Technological University |
| Amaan Mulla | 612409027 | dilippk24.instru@coeptech.ac.in  | Instru | COEP Technological University |
| Karan Patil | 612409031 | nasarma24.instru@coeptech.ac.in  | Instru | COEP Technological University |

**Mentor:** Padma Dwivedi

## Project overview

The project models a Series-Parallel HEV powertrain in MATLAB Simulink and Stateflow. The model includes:

- Battery equivalent-circuit model (1RC ECM)
- Motor torque control and protection logic
- Generator control and battery charging-current calculation
- Stateflow Energy Management System (EMS)
- Dynamic torque split between engine, motor, and generator
- Simscape physical plant with engine, clutch, motor/generator torque sources, gears, wheel, tire, brake, and vehicle body
- Scope outputs for torque, speed, power, battery, mode, and control signals

## Repository structure

```text
.
├── model/
│   └── HEV_2_7_26_copy.slx
├── src/
│   └── matlab_functions/
│       ├── BatteryECM.m
│       ├── DriverPI.m
│       ├── GeneratorPower.m
│       ├── Torque_Split_Dynamic.m
│       ├── generate_terrain_scenario.m
│       └── grade_to_angle.m
├── scripts/
│   ├── init_HEV_workspace_template.m
│   └── run_HEV_model_template.m
├── assets/
│   ├── screenshots/
│   └── results/
├── docs/
│   └── HEV_Model_Documentation_Report_IEEE_Format_Final_Model_Checked_Corrected_v2.docx
├── presentation/
│   └── HEV_Model_Presentation_KPIT_Apex_Lab_Expanded_Clean_v2.pptx
├── .gitignore
└── README.md
```

## How to open the model

1. Open MATLAB.
2. Open this repository folder as the current MATLAB folder.
3. Run the workspace initialization script:

```matlab
run('scripts/init_HEV_workspace_template.m')
```

4. Open the Simulink model:

```matlab
open_system('model/HEV_2_7_26_copy.slx')
```

5. Run the simulation from Simulink, or run:

```matlab
run('scripts/run_HEV_model_template.m')
```

## Important note

The `.slx` model is the main source file. The MATLAB Function block code has also been extracted into `src/matlab_functions/` for easy review on GitHub. If your final simulation uses a separate drive-cycle `.mat` file or exact workspace parameters, add that file to `data/` and update `scripts/init_HEV_workspace_template.m`.

## Main model subsystems

| Subsystem | Purpose |
|---|---|
| `control` | Drive-cycle selection, Driver PI, Stateflow EMS, and torque split |
| `Battery` | SOC and terminal-voltage estimation using 1RC ECM |
| `Motor_control` | Motor torque limiting, SOC protection, regen derating, motor power calculation |
| `Generator_control` | Generator torque saturation, power calculation, and charging-current calculation |
| `Physical Plant` | Simscape HEV driveline and vehicle dynamics |

## Simulation results included

The `assets/results/` folder contains scope screenshots for Drive Cycle 2, including torque, speed, power, battery, mode, and control outputs.

## Limitations / assumptions

- Battery and engine parameters are simplified for simulation-level study.
- Drive-cycle workspace signals must be verified before final validation.
- Generator power calculation should use angular speed in consistent units.
- This is an educational system-level HEV model, not a production-calibrated vehicle model.
