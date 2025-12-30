# Cessna 182 Longitudinal Dynamics Simulator (Non-Linear)

![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-blue.svg) ![Simulink](https://img.shields.io/badge/Simulink-Model-orange.svg) ![Status](https://img.shields.io/badge/Status-Validated-brightgreen.svg) ![University](https://img.shields.io/badge/USP-EESC-red.svg)

A high-fidelity, non-linear flight dynamics simulator for the **Cessna 182**, built to bridge the gap between theoretical stability derivatives and real-world flight physics. Developed as part of the **SAA0184 - Flight Dynamics** course at the School of Engineering of São Carlos (**EESC-USP**).

---

## Project Overview

Linearized models are the industry standard for control design, but they are approximations. This project implements the **Full Non-Linear Equations of Motion (EOM)** to serve as a "Ground Truth" for validating linear state-space representations.

### Key Technical Features:
* **From-Scratch Implementation:** Every block in the Simulink model was architected from the fundamental 3-DOF longitudinal equations.
* **Newton-Raphson Trimming:** Custom MATLAB routines to solve for equilibrium ($V, \alpha, \delta_e, T$) at specific flight envelopes.
* **Aerodynamic Fidelity:** Derived from **Roskam (Appendix B)** parameters specifically for the Cessna 182.
* **Validation:** Direct comparison between Non-Linear integration and Linear State-Space ($\dot{x} = Ax + Bu$) tracking.

---

## The Physics Behind the Code

The core of this simulator solves the coupled non-linear system in real-time. Instead of relying on pre-built aerospace blocks, the equations were manually implemented to ensure full transparency of the physics:

$$
\begin{cases}
\dot{V} = \frac{1}{m} (T \cos\alpha - D - mg \sin(\theta - \alpha)) \\
\dot{\alpha} = \frac{q \cos\alpha - (L + T \sin\alpha - mg \cos(\theta - \alpha))}{mV} \\
\dot{q} = \frac{M}{I_y}
\end{cases}
$$

By integrating these states, the model captures effects that linear models might miss during larger perturbations, such as the second-order coupling in the **Phugoid** mode.

---

## Architecture & My Contribution

This project was developed by the group *"Zona de Turbulência"*. As the lead for **computational architecture**, my specific contributions were:

1.  **Parameter Adaptation:** Re-engineering legacy parameter extraction scripts (`parameters.m`) to match the Cessna 182 airframe and atmospheric conditions.
2.  **Simulink Modeling:** Designing the modular block architecture (`Simulator.slx`), ensuring proper signal routing for velocities ($u, w$), attitude ($\theta$), and trajectory coordinates.
3.  **Cross-Validation:** Developing the scripts to overlay non-linear results with linear predictions to prove model convergence.

---

## Results & Validation

The model was tested with a **1-degree elevator step input** ($t=0$). The results show a remarkable tracking of the aircraft's natural modes.

> **Insight:** The near-perfect overlap (Blue vs Red line) for small perturbations validates the stability derivatives calculated, proving that the linear model is accurate for stability augmentation systems (SAS) design near the trim point.

*(Please see the validation plots generated after running the simulation).*

---

## How to Run

### 1. Prerequisites
* MATLAB (R2023b or later recommended)
* Simulink

### 2. Trimming the Aircraft
Before running the simulation, you must find the equilibrium point:
1.  Run `parameters.m` to load the Cessna 182 dataset.
2.  Execute `MainSimulator.m`. This solves the Newton-Raphson iteration.
3.  **Check the Command Window:** Note the values for `u0`, `w0`, `q0`, and `theta0`.

### 3. Running the Simulator
1.  Open `Simulator.slx`.
2.  Inside the **"Motion"** block, input the recorded `u0, w0, q0, theta0` as Initial Conditions.
3.  Click **Run**.
4.  Open the **Scopes** to view the real-time dynamic response.

---

## Credits

* **Development Team:** Beatriz Figueirêdo, Gabriel Nobuaki, Helena Aoki, Lívia Máris, and Rodrigo Amancio.
* **Academic Supervisor:** Prof. Dr. Ricardo Afonso Angélico (EESC-USP), for providing the initial analytical framework.

---

### 🔗 Technical Discussion
For a deep dive into the math and the comparison results, check out the full article on my engineering portfolio:
**[Linear vs. Non-Linear: Validating Cessna 182 Dynamics]([https://renato-cm-filho.github.io](https://karyus-labs.github.io/aerospace/simulation/2025/11/16/cessna182-nonlinear-simulator.html))**
