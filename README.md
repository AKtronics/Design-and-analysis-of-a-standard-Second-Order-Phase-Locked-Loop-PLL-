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
