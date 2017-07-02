% Define the mesh in space
t_0 = 0;
t_f = 5.0;
M = 2000;
N = 2^6;

dx = 2.0/N;
x = 0:dx:2;

x = x';

% define the mesh in time
dt = (t_f-t_0)/M;
t = t_0:dt:t_f;

% define the diffusivity
D = 1/(4*pi.^2);

% define the ratio r
r = D*dt/dx^2;


wave_num = 4.0.*pi;
signal = sin(wave_num*x)+ 0.4*sin(0.2*wave_num*x);


[IMF, residule] = forward_EMD_pde(N, M, D, r, signal);
