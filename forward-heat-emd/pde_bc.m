function [pl,ql,pr,qr] = pde_bc(xl,ul,xr,ur,t)
% Neumann condition
pl = ul;
ql = 0;
pr = ur;
qr = 0;
end