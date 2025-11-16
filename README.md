# Nonlinear Simulink Flight Dynamics Simulator (Cessna 182)

## Project Summary

This repository contains a nonlinear longitudinal flight dynamics simulator for a Cessna 182 aircraft, implemented entirely in MATLAB & Simulink. The model was developed to analyze the aircraft's response to disturbances, such as an elevator step input, and to validate the accuracy of classical linearized models.

## Context and Credits

This simulator was my main contribution to the final project "Turbulence Zone" for the course SAA0184 - Flight Dynamics, at the School of Engineering of São Carlos (EESC-USP), in June 2025.

The project was carried out as a group and compared linearized models with this nonlinear model. I thank my teammates: Beatriz Figueirêdo, Gabriel Nobuaki, Helena Aoki, Lívia Máris, and Rodrigo Amancio.

Special thanks to **Prof. Dr. Ricardo Afonso Angélico**, who provided the base scripts for parameter extraction (such as the original navion.m), which I adapted for this project.

My specific contribution was:

The adaptation of the parameter scripts (navion_023.m) for the Cessna 182, using data from Appendix B of Roskam.

The complete implementation and assembly of the nonlinear equations of motion (described in Chapter 3 of the project's PDF) inside the visual Simulink model (A20250527.slx).

## How to Run the Simulation

The simulation workflow is divided between setup scripts (for trimming) and the Simulink model (for the dynamic simulation).

**1. Obtain Trimming Parameters:**

Run the script navion_023.m to load the aircraft parameters (Cessna 182) into the workspace.

Run the script MainSimulator.m.  
This script will calculate the equilibrium (trim) conditions for cruise flight.

Record the output values in the console (e.g., u0, w0, q0, theta0).

**2. Insert Initial Conditions in Simulink:**

Open the model A20250527.slx.

Double-click the "Motion" block.

Manually enter the trimming parameters (u0, w0, q0, theta0) that you recorded in the previous step, as shown below:

**3. Run the Simulation:**

The model is configured for a 1-degree elevator step disturbance applied at t = 0.

Click "Run" in Simulink. The simulation results (velocities, attitude) can be viewed in the model's Scopes.

## The Main Insight: Linear Model Validation

The purpose of this nonlinear simulator was to serve as the "ground truth" for the linearized model (studied in parallel in the project).

The most significant result (shown in Figure 4.3 of the report) is the remarkable agreement between the responses of the two models for a small perturbation. This validates the robustness of classical linearization techniques for stability analysis.
