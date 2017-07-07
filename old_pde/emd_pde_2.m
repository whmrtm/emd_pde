function emdpde
m = 0;
deltax = 0.05;
deltat = deltax.^2*0.5;
T = 0.1;
X = 2.0;
x = linspace(0,X,X/deltax+1);
t = linspace(0,T,T/deltat);
sol = pdepe(m,@emd_pde,@pdeic,@pdebc,x,t);

% Extract the first solution component as u.
u = sol(:,:,1);
% size(u)

% Determine the number of time steps to display
% t_step_num = 80;

% TODO:
% Need to determine the evolved time
% Need to determine the delta value


figure
% surf(x,t(1:t_step_num),u(1:t_step_num,:)) 
surf(x,t,u);
title('Numerical solution computed with mesh points.')
xlabel('Distance x')
ylabel('Time t')
% 
% % A solution profile can also be illuminating.
figure;
plot(x,pdeic(x));
figure;
hold on;
plot(x,u(end,:),'b-o')
title('Solution at t = t step num')
xlabel('Distance x')
ylabel('u(x,2)')
 




function [c,f,s] = emd_pde(x,t,u,DuDx)
a = 0.5;
c = 1;
f = -a*DuDx;
s = -u;
% --------------------------------------------------------------
function u0 = pdeic(x)
a = 2;
% u0 = sin(pi*x) + sin(2*pi*x);
% u_0 = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);
% u0 = sin(2*pi*x)+sin(4*pi*x);
% u0 = sin(2*pi*x);
% --------------------------------------------------------------
function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t)
pl = ul;
ql = 0;
pr = ur;
qr = 0;