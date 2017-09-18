L = 400;
x = linspace(0,6,L);
fs = round(L./x(end));
delta_x = 6 ./ L;
% % Three sinusoids
signal = 5*cos(2*pi*x) + 20*cos(0.1*pi*x) + 10*cos(0.5*pi*x);
% signal_pp = -20*pi^2*cos(2*pi*x) - 0.2*pi^2*cos(0.1*pi*x) - 2.5*pi^2*cos(0.5*pi*x);


% load('./data/ECG-data/ECG-data');
% signal = sig_sample_1';
% L = length(signal);
% x = linspace(0,6,L);




signal_pp = diff(signal, 2) ./ (delta_x)^2;
new_sig = signal(3:end);

% signal = sin(4*pi.*[x(1:L/2) zeros(1,L/2)] ) + ...
%  sin(24*pi.*[zeros(1,L/2) x(L/2+1:end)]);

% Constant parameter
c = 1./(4*pi^2);
mean_env = new_sig + c.* signal_pp;




% % Detected Parameter
% [indmin, indmax, indzero] = extr(signal);
% min_dist = min(diff(indmax)) * (x(end)./length(x));
% c = 1./(2*pi./min_dist).^2;
% mean_env = new_sig + c.* signal_pp;


% % piecewise constant
% indices = inflection(x, signal);
% indices = [1 indices];
% mean_env = zeros(1, length(signal));
% c = zeros(1, length(signal));
% for i = 1:length(indices)-1
%     for j = indices(i): indices(i+1)
%         c(j) = (x(indices(i+1)) - x(indices(i)))^2 ./ pi^2;
%     end
% end
% c = c(2:end-1);
% mean_env = new_sig + c.* signal_pp;


% % piecewise constant
% indices = inflection(x, signal);
% indices = [1 indices];
% mean_env = zeros(1, length(signal));
% c = zeros(1, length(signal));
% for i = 1:length(indices)-1
%     for j = indices(i): indices(i+1)
%         c(j) = (x(indices(i+1)) - x(indices(i)))^2 ./ pi^2;
%     end
% end
% c = c(2:end-1);
% mean_env = new_sig + c.* signal_pp;


% C as a variable
% what kind of variable?

figure;
hold on;
plot(new_sig);
plot(mean_env);