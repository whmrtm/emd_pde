x = linspace(0,6,400);
<<<<<<< HEAD
signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);
delta = 0.1;

signal_pp = -4*pi.^2*0.5*cos(2*pi*x) + -0.01*pi.^2*2*cos(0.1*pi*x) + ...
            -0.25*pi.^2*0.8*cos(0.5*pi*x);

mean_env = signal + delta.^2./2.*signal_pp;

figure;
plot(x, signal);
hold on;
plot(x, mean_env);
legend('signal', 'mean envelope');
=======
signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);
>>>>>>> f1975c9e017170b4ca9c37e905ce95c109d4785f
