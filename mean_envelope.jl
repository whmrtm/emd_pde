using PyPlot
include("emd.jl")
include("mhs.jl")

x = linspace(0, 2, 1000)
signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);
signal_pp = -2*pi^2*cos(2*pi*x) - 0.02*pi^2*cos(0.1*pi*x) - 0.2*pi^2*cos(0.5*pi*x)

mean_env, min_env, max_env = mean_env(signal)

figure;
subplot(4,1,1)
plot(x, signal)

subplot(4,1,2)
plot(x, min_env)

subplot(4,1,3)
plot(x, max_env)

subplot(4,1,4)
plot(x, mean_env)
