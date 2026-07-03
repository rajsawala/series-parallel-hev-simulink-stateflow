# Design and Simulation of a Series-Parallel Hybrid Electric Vehicle Using MATLAB Simulink and Stateflow

This repository contains the Simulink model and supporting source files for a **Series-Parallel Hybrid Electric Vehicle (HEV)** model developed under **KPIT Apex Lab**.

The project focuses on HEV energy management, torque split control, battery modelling, motor/generator control, regenerative braking, and vehicle-level simulation using **MATLAB Simulink, Stateflow, and Simscape**.

---

## Project Members

| Name | MIS | Email | Department | Institute |
|---|---:|---|---|---|
| Raj Sawala | 612407149 | sawalar24.extc@coeptech.ac.in | ExTC | COEP Technological University |
| Amaan Mulla | 612409027 | nasarma24.instru@coeptech.ac.in | Instru | COEP Technological University |
| Karan Patil | 612409031 | dilippk24.instru@coeptech.ac.in | Instru | COEP Technological University |

**Mentor:** Padma Dwivedi

---

## Project Overview

The project models a Series-Parallel HEV powertrain in MATLAB Simulink and Stateflow. The vehicle can operate in different modes depending on speed demand, torque demand, battery SOC, road grade, and Energy Management System logic.

The model includes:

- Battery equivalent-circuit model using 1RC ECM
- Motor torque control and SOC-based protection logic
- Generator control and battery charging-current calculation
- Stateflow-based Energy Management System
- Dynamic torque split between engine, motor, and generator
- Simscape physical plant with engine, clutch, motor/generator torque sources, gears, wheel, tire, brake, and vehicle body
- Scope outputs for torque, speed, power, battery, mode, and control signals

---

## Repository Structure

```text
.
├── model/
│   └── HEV_2_7_26_copy.slx
│
├── scripts/
│   └── HEV_Combined_Params.m
│
├── src/
│   └── matlab_functions/
│       ├── BatteryECM.m
│       ├── DriverPI.m
│       ├── GeneratorPower.m
│       ├── Torque_Split_Dynamic.m
│       ├── generate_terrain_scenario.m
│       └── grade_to_angle.m
│
├── assets/
│   ├── screenshots/
│   └── results/
│
├── data/
│   ├── UrbanCycle1.mat
│   ├── UrbanCycle2.mat
│   ├── UrbanCycle3.mat
│   ├── UrbanCycle4.mat
│   ├── UrbanCycle5.mat
│   └── UrbanCycle6.mat
│
├── Docs/
│   └── HEV Model Documentation Report 1.pdf
│
├── Presentation/
│   └── HEV_Model_Presentation.pptx
│
├── .gitattributes
├── .gitignore
└── README.md
```

---

## Main Simulink Model

The main Simulink model file is:

```matlab
model/HEV_2_7_26_copy.slx
```

This file contains the complete HEV model architecture, including:

- Battery subsystem
- Motor control subsystem
- Generator control subsystem
- Physical plant subsystem
- Control subsystem with Driver PI, Stateflow EMS, terrain/grade generation, and torque split logic

---

## Workspace Initialization

Before running the Simulink model, execute the parameter initialization script:

```matlab
run('scripts/HEV_Combined_Params.m')
```

This script initializes all required MATLAB workspace variables used by the model, including:

- Drive-cycle variables
- `DriveCycles` array
- `dc_ts` timeseries signals
- `v_ref` reference speed signal
- `t_sim_stop` simulation stop time
- `HEV_Param` structure
- Battery parameters
- Motor parameters
- Generator parameters
- Vehicle parameters
- Controller gains
- 1RC ECM battery variables
- Driver PI gains

---

## Drive Cycle Data

The drive-cycle files are stored in the `data/` folder:

```text
data/
├── UrbanCycle1.mat
├── UrbanCycle2.mat
├── UrbanCycle3.mat
├── UrbanCycle4.mat
├── UrbanCycle5.mat
└── UrbanCycle6.mat
```

Since the drive-cycle files are inside the `data/` folder, the loading section in `HEV_Combined_Params.m` should use this format:

```matlab
cyclePath = 'data';

load(fullfile(cyclePath,'UrbanCycle1.mat'));
load(fullfile(cyclePath,'UrbanCycle2.mat'));
load(fullfile(cyclePath,'UrbanCycle3.mat'));
load(fullfile(cyclePath,'UrbanCycle4.mat'));
load(fullfile(cyclePath,'UrbanCycle5.mat'));
load(fullfile(cyclePath,'UrbanCycle6.mat'));
```

This ensures that MATLAB loads the drive-cycle files correctly even when the repository root folder is selected as the current MATLAB folder.

---

## How to Open the Model

1. Open MATLAB.

2. Set this repository folder as the current MATLAB folder.

3. Run the workspace initialization script:

```matlab
run('scripts/HEV_Combined_Params.m')
```

4. Open the Simulink model:

```matlab
open_system('model/HEV_2_7_26_copy.slx')
```

5. Run the simulation from Simulink, or run:

```matlab
sim('model/HEV_2_7_26_copy')
```

---

## Important Note

The `.slx` file is the main source file of the project. The MATLAB Function block codes have also been extracted into `src/matlab_functions/` so they can be easily reviewed on GitHub.

The main workspace and parameter initialization file is:

```text
scripts/HEV_Combined_Params.m
```

This file replaces the older template initialization script. Before running the model, this script should be executed to load the required HEV parameters, battery parameters, drive-cycle signals, controller gains, and simulation variables.

If the model is moved to another computer, make sure that the required drive-cycle `.mat` files are available inside the `data/` folder.

---

## Main Model Subsystems

| Subsystem | Purpose |
|---|---|
| `control` | Drive-cycle selection, Driver PI, Stateflow EMS, terrain/grade generation, and torque split |
| `Battery` | SOC and terminal-voltage estimation using 1RC equivalent-circuit model |
| `Motor_control` | Motor torque limiting, SOC protection, regenerative braking derating, and motor power calculation |
| `Generator_control` | Generator torque saturation, generated power calculation, and charging-current calculation |
| `Physical Plant` | Simscape HEV driveline and vehicle dynamics model |

---

## Control Strategy

The control subsystem acts as the Energy Management System of the HEV. It compares the reference vehicle speed with actual vehicle speed feedback, generates the required torque demand, selects the operating mode using Stateflow logic, and distributes torque between the engine, motor, and generator.

Main operating modes include:

- Standby mode
- Propulsion mode
- Regenerative braking mode
- Series mode
- Parallel mode
- Series-parallel mode

---

## MATLAB Function Files

The MATLAB Function block logic has been extracted into `src/matlab_functions/` for easier review on GitHub.

| File | Purpose |
|---|---|
| `BatteryECM.m` | Battery SOC and terminal-voltage calculation |
| `DriverPI.m` | Speed error to torque request and brake signal conversion |
| `GeneratorPower.m` | Generator power and charging-current calculation |
| `Torque_Split_Dynamic.m` | Engine, motor, and generator torque split logic |
| `generate_terrain_scenario.m` | Road grade generation based on selected drive cycle or terrain |
| `grade_to_angle.m` | Converts road grade percentage into road angle |

---

## Simulation Results Included

The `assets/results/` folder contains simulation result screenshots and scope outputs.

The current results include Drive Cycle 2 outputs such as:

- Torque response
- Vehicle speed response
- Power flow
- Battery SOC and terminal voltage
- Generator current
- EMS mode-related signals
- Control output signals

For adding results of other drive cycles in the future, the recommended structure is:

```text
assets/
└── results/
    ├── drive_cycle_1/
    ├── drive_cycle_2/
    ├── drive_cycle_3/
    ├── drive_cycle_4/
    ├── drive_cycle_5/
    └── drive_cycle_6/
```

These results help verify the behavior of the motor, generator, battery, controller, and physical plant during different drive-cycle conditions.

---

## Documentation and Presentation

The full project documentation report is available in:

```text
Docs/HEV Model Documentation Report 1.pdf
```

The project presentation is available in:

```text
Presentation/HEV_Model_Presentation.pptx
```

---

## Video Documentation

A video explanation of the project can be added here:

```text
Video Link: Add YouTube or Google Drive link here
```

For large video files, it is recommended to upload the video to YouTube as an unlisted/public video or to Google Drive and add the link here instead of uploading the video directly to GitHub.

---

## Tools and Technologies Used

- MATLAB
- Simulink
- Stateflow
- Simscape
- Simscape Driveline
- MATLAB Function Blocks
- GitHub

---

## Limitations / Assumptions

- The model is developed for educational and system-level simulation purposes.
- Battery, motor, generator, and engine parameters are simplified for project-level analysis.
- The physical plant uses ideal torque sources for engine, motor, and generator modelling.
- Drive-cycle `.mat` files must be available before simulation.
- Generator and engine power calculations should be verified for consistent angular-speed units.
- This is not a production-calibrated HEV model.

---

## Future Scope

Possible improvements include:

- Adding simulation results for all six drive cycles
- Adding realistic fuel consumption and engine efficiency maps
- Improving generator efficiency lookup integration
- Adding better Stateflow hysteresis to reduce mode switching chatter
- Adding automatic result export from Simulation Data Inspector
- Validating acceleration, gradeability, SOC drop, and power-flow results against expected vehicle behavior

---

## Conclusion

This project demonstrates the modelling and simulation of a Series-Parallel Hybrid Electric Vehicle using MATLAB Simulink, Stateflow, and Simscape. The model shows how an HEV Energy Management System can control operating modes, distribute torque between engine and motor, manage generator charging, support regenerative braking, and respond to vehicle speed demand, SOC, and road grade.
