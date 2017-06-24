m = 0;
deltax = 0.01;
deltat = 0.1;


% TODO:
% Need to determine the evolved time
% Need to determine the a value of step size a

T = 1.0;
X = 2.0;
x = linspace(0,X,X/deltax+1);
t = linspace(0,T,T/deltat);

global A B DeltaX;
A = 1.5;
B = 0.2;
% Number of iterations
N = 50;
DeltaX = deltax;
s1 = @(x) (sin(5*pi*x));
s2 = @(x) (A*sin(B*5*pi*x));
pde_ic = @(x) s1(x)+s2(x);
% pde_ic = @(x) 4*sin(20*pi.*x).*sin(0.2*pi.*x);


% mean envelope
m = 0;

sol = pdepe(m,@pde_form, @(x) pde_ic(x) ,@pde_bc,x,t);
% Extract the first solution component as u.
u = sol(:,:,1);

% size(u)

% Determine the number of time steps to d isplay
% t_step_num = 80;

% 
% % Plot the surf solution varied with time
% figure
% surf(x,t(1:t_step_num),u(1:t_step_num,:)) 
% surf(x,t,u);
% title('Numerical solution computed with mesh points.')
% xlabel('Distance x')
% ylabel('Time t')


% Mean envelope
m = u(end,:);
N = 2.1;
figure;
plot(x, pde_ic(x));
hold on;
plot(x, pde_ic(x)-N*m, 'r-o');
legend('signal','IMF1');
title('Forward approach IMF on sin product signal');
% 
% % Plot the solution on different subplots
% figure;
% subplot(5,1,1)
% plot(x,pde_ic(x));
% title('Signal');
% subplot(5,1,2)
% plot(x,s1(x));
% title('Signal 1');
% subplot(5,1,3D)
% plot(x,s2(x));
% title('Signal 2');
% subplot(5,1,4)
% plot(x,pde_ic(x)-u(end,:),'b-o')
% title('IMF1')
% xlabel('x')
% ylabel('IMF')
% 
% subplot(5,1,5)
% plot(x,u(end,:),'b-o')
%     title('mean envelope')
%     xlabel('Distance x')
% ylabel('mean envelope')

 
% figure;
% plot(x,pde_ic(x));
% hold on;
% plot(x,u(end,:),'r-o')
% legend('Signal','Mean Envelope')
% xlabel('x')
% ylabel('y')
% title('Mean Envelope by forward heat equation');


% Performance measure
pm = norm(u(end,:)) ./ norm(s2(x));
