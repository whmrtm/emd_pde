function emdpde
m = 0;
x = linspace(0,10,200);
t = linspace(0,5,200);

sol = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
% Extract the first solution component as u.
u = sol(:,:,1);

% A surface plot is often a good way to study a solution.
surf(x,t(1:36),u) 
title('Numerical solution computed mesh points.')
xlabel('Distance x')
ylabel('Time t')

% A solution profile can also be illuminating.
figure
plot(x,u(end,:))
title('Solution at t = 2')
xlabel('Distance x')
ylabel('u(x,2)')
% --------------------------------------------------------------
function [c,f,s] = pdex1pde(x,t,u,DuDx)
delta = 0.2;
c = 1;
f = -0.5*DuDx;
s = -u./delta.^2;
% --------------------------------------------------------------
function u0 = pdex1ic(x)
u0 = cos(pi*x);
% --------------------------------------------------------------
function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
pl = ul-cos(pi*xl);
ql = 0;
pr = ur-cos(pi*xr);
qr = 0;
