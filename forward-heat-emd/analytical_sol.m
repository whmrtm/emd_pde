m = 0;
deltax = 0.01;
deltat = 0.1;

% Need to determine the evolved time
% Need to determine the a value of step size a

T = 10.0;
X = 2.0;
x = linspace(0,X,X/deltax+1);
t = linspace(0,T,T/deltat);


N = 50;
omega = 2*pi;
A = 0.01;
F = 0.05;
sinu = @(a,b,omega,x) a*sin(b*omega*x);
s1 = @(x) sinu(1,1,omega,x);

s2 = @(x) sinu(A,F,omega,x);
s = @(x) s1(x) + s2(x);        
a = 1./(4*pi.^2);

imf = (1-exp(-a*omega.^2*T)).^N*s1(x) + ...
(1-exp(-a*F.^2*omega.^2*T)).^N*s2(x);

% Plot signal

figure;
plot(imf);
hold on;
plot(s(x));
hold on;
plot(s1(x));
plot(s2(x));
title('Signal and its first IMF');
legend('IMF','Signal','s1','s2');


% Theoritical critical value
% epsilon = exp(-T);
% delta = 0.01;

% delta = logspace(-4,-1,100);
% ct = sqrt( log((1-delta.^(1./N)*(1-epsilon))) / log(epsilon));
% figure;
% plot(delta,ct,'bo-');
% xlabel('Delta-the tolerance ratio');
% ylabel('Critical value');


% Performance measure
% pm = norm(imf - s1(x)) ./ norm(s2(x))
pm = 1 - norm(imf.*s1(x)) ./ norm(s1(x).^2)