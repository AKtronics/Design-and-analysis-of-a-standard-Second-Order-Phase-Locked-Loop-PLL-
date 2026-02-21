# Design, Stability Analysis and Transient Response Study of a Second-Order Phase-Locked Loop (PLL) in MATLAB without using simulink for designing and SISOTOOL for analysis

A phase-locked loop (PLL) is a control system that generates an output signal whose phase is fixed relative to the phase of an input signal. Keeping the input and output phase in lockstep also implies keeping the input and output frequencies the same; thus, a phase-locked loop can also track an input frequency. Furthermore, by incorporating a frequency divider, a PLL can generate a stable frequency that is a multiple of the input frequency.
These properties are used for clock synchronization, demodulation, frequency synthesis, clock multipliers, and signal recovery from a noisy communication channel.
I decided to design and analyze a Phase Locked Loop (PLL) used in FM and radio devices but with a small twist.
Instead of using SISO Tool or Simulink blocks, I wanted to build and analyze everything directly from the MATLAB editor using transfer functions, pole zero models, and classical control analysis.
No drag n drop, just equations, compensation, and system dynamics.
What started as a small exploration turned into a pretty insightful study of how PLLs actually behave. This is a preliminary based observation and demanded reliability on academic resources.

⚙️ Step 1: Modeling the Physical Structure
I modeled the PLL using:
Phase Detector (adder + gain block)
Loop Filter (lag compensator)
VCO (integrator + gain)
Unity feedback
This gave me a realistic open-loop transfer function rather than a textbook second-order form.

📉 Initial Observation
With a basic loop filter structure, the PLL showed:
~30% overshoot
~52° phase margin
Underdamped response
Stable but aggressive.
This led me to ask:
Can I improve damping without sacrificing too much bandwidth?

🔧 Compensation Tuning
By shifting the loop filter pole (i.e., reshaping the compensator), I achieved:
Overshoot reduced from ~30% -> ~8%
Phase margin increased from ~52° -> ~73°
Settling time improved
This small structural change significantly improved robustness. It was a strong reminder that, Pole-zero placement is everything in control design.

📊 Bandwidth vs Lock Time Study
Next, I performed a VCO gain sweep (Kv = 5 : 40) and observed:
Increasing Kv reduces lock time
Bandwidth increases
Transient response becomes faster
Classic control trade off behavior.

🔊 Noise Sensitivity Analysis
I injected Gaussian phase noise into the reference input and observed:
The PLL effectively attenuates high-frequency noise
Output phase error variance depends on loop parameters
Higher Kv altered jitter behavior in subtle ways
This reinforced how PLL design is not just about stability it's about balancing speed, robustness, and noise performance.

🧠 Key Takeaways
Open loop analysis must align with closed-loop behavior. Phase margin strongly influences overshoot and damping
Type-2 loop structures behave differently from simple second order textbook systems
This helped me connect:
Control theory : Frequency domain : Time domain : Practical loop behavior
And honestly, that connection felt more valuable than just running simulations.
Always open to feedback or deeper discussions on PLL design and control systems.

Time Responses

<img width="583" height="331" alt="Screenshot 2026-02-17 025518" src="https://github.com/user-attachments/assets/037cf4ad-f31c-4e9b-8ca1-dfc931c85210" />

PLL Step Response
<img width="1919" height="1018" alt="Screenshot 2026-02-17 025526" src="https://github.com/user-attachments/assets/1393bff1-6f87-43e5-8f75-ea5aeda64744" />

PLL Root Locus
<img width="1919" height="1016" alt="Screenshot 2026-02-17 025534" src="https://github.com/user-attachments/assets/ad0dc5b0-4989-4a7e-99df-98d22685d54e" />

PLL Bode Plot
<img width="1919" height="1015" alt="Screenshot 2026-02-17 025545" src="https://github.com/user-attachments/assets/f520b002-ec30-4fb2-9696-5f7bec1299f8" />

Bandwidth Analysis
<img width="1919" height="1011" alt="Screenshot 2026-02-17 025553" src="https://github.com/user-attachments/assets/7e7ecaed-551f-4453-b31d-b5fbd9ff60b4" />

Noise Analysis
<img width="1919" height="1005" alt="Screenshot 2026-02-17 025559" src="https://github.com/user-attachments/assets/623f2bcb-4cbd-481a-9270-abc190c24420" />

PLL Noise Response
<img width="1919" height="1001" alt="Screenshot 2026-02-17 025609" src="https://github.com/user-attachments/assets/20313fac-a607-4802-b9ae-49be935cfa75" />

