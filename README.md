# Design and Simulation of a Series-Parallel Hybrid Electric Vehicle Using MATLAB Simulink and Stateflow

This repository contains the Simulink model and supporting source files for a **Series-Parallel Hybrid Electric Vehicle (HEV)** model developed under **KPIT Apex Lab**.

The project focuses on HEV energy management, torque split control, battery modelling, motor/generator control, regenerative braking, and vehicle-level simulation using MATLAB Simulink, Stateflow, and Simscape.

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

The project models a Series-Parallel HEV powertrain in MATLAB Simulink and Stateflow. The vehicle can operate in different modes depending on speed demand, torque demand, battery SOC, road grade, and EMS logic.

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
│   └── README.md
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
