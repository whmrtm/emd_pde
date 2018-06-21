% Demo of mean envelope extraction
L = 400;
x = linspace(0,6,L);

signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);
% signal = sin(2*pi.*x) + 0.5.*sin(0.8*pi.*x);

k = 1./(4*pi^2);
T = 3;
mean_env = mean_envelope(x, signal, k, T);



% plot the result
figure();
plot(signal,'-' ,'LineWidth', 2);
hold on;
plot(mean_env, '--', 'LineWidth', 2);
legend('signal', 'mean envelope');
xlabel('x');
ylabel('y');