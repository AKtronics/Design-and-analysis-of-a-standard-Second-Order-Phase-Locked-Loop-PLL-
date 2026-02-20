% Second order Phase Locked Loop 
% phase Detector : feedback adder + gain
% loop filter : low pass filter
% voltage controlled oscillator(VCO) : Integrator + gain
% feedback function : unity by default

%% phase detector parameters
Kd = 1;

%% loop filter parameters
Kf =1; 
T =0.1; clc

Zf =[-1/T];
Pf =[-0.5/T];
LF = zpk(Zf,Pf,Kf);

%% VCO parameters
Kv = 10;
Zv=[];
Pv=[0];
VCo =zpk(Zv,Pv,Kv);

%% total OLTF
Gs = Kd*LF*VCo;

%% pll CLTF
PLL = feedback(Gs,1);

%% system response
figure;
step(PLL);
grid on;
title('PLL step response');
 
%% root locus
figure;
rlocus(Gs);
title('Root locus of PLL');

%% bode plot
figure;
bodeplot(PLL);
grid on;
title('Bode plot of PLL');

%% time response parameters
disp('Time responses');
info = stepinfo(PLL);
fprintf('Steadystate settling time= %.4f sec\n', info.SettlingTime);
fprintf('peak overshoot = %.2f %%\n', info.Overshoot);
fprintf('peak time = %.4f sec\n', info.PeakTime);
fprintf('Rise time = %.4f sec\n', info.RiseTime);


%% stability parameters
disp('Stability Analysis');
[GM, PM, Wcg, Wcp] = margin(Gs);
fprintf('Gain margin = %.4f db\n', 20 * log10(GM));
fprintf('Phase margin = %.2f deg\n', PM);
fprintf('Gain crossover frequency = %.4f rad/s\n', Wcg);
fprintf('Phase crossover frequency = %.4f rad/s\n', Wcp);

%% Bandwidth analysis
disp('Bandwidth analysis')

KvVar = [5 10 20 40];
ssTime  = zeros(1, length(KvVar));
jitterV = zeros(1, length(KvVar));

t = 0:0.001:5;
u = ones(size(t));
noise_amp = 0.1;

for i = 1:length(KvVar)
    
    Kv = KvVar(i);
    VCo = zpk([], [0], Kv);
    Gs = Kd *LF* VCo;
    PLL_temp = feedback(Gs,1);
    
    info = stepinfo(PLL_temp);
    ssTime(i) = info.SettlingTime;
    

    noise = noise_amp *randn(length(t),1);
    u_noisy = ones(length(t),1) + noise;
    y = lsim(PLL_temp, u_noisy, t);
    errorSgl = u_noisy - y;
    jitterV(i) = std(errorSgl(:)); 
end

figure;
plot(KvVar, ssTime,'-o');
xlabel('VCO Gain (Kv)');
ylabel('Settling Time');
title('Kv vs Settling Time');
grid on;

figure;
plot(KvVar, jitterV, '-o');
xlabel('VCO Gain (Kv)');
ylabel('Jitter (Std Phase Error)');
title('Kv vs Noise Sensitivity');
grid on;

%% Noise Analysisi

disp('Noise analysis')
Kv = 10;
VCo = zpk([], [0], Kv);
Gs = Kd* LF* VCo;
PLL = feedback(Gs,1);

t = 0:0.001:5;
u = ones(size(t));
noise = 0.2 *randn(size(t));
u_noisy = u + noise;
y = lsim(PLL, u_noisy, t);

figure;
plot(t, u_noisy, 'r');
hold on;
plot(t, y, 'b');
legend('Noisy Input','PLL Output');
title('PLL Response under Phase Noise');
grid on;

