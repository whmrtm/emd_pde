function [c,f,s] = pde_form(x,t,u,DuDx)
global DeltaX;
a = DeltaX.^2/(pi^2*0.01);
c = 1;
f = a*DuDx;
s = 0;
end