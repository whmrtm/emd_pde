% The iterative sifting process of EMD represented by PDE
% Author Heming Wang

% Define the mesh in space
t_0 = 0;
t_f = 50;
M = 200;
N = 400;

dx = 6.0/(N-1);
x = 0:dx:6;
x = x';

% define the mesh in time
dt = (t_f-t_0)/M;
t = t_0:dt:t_f;

% define the diffusivity
% D = 1/(4*pi.^2);
D = 1;

% define the ratio r
r = D*dt/dx^2 

A = zeros(N,N);
A(1,1) = 1;
for j=2:N-1
  A(j,j-1) = -r/2;
  A(j,j) = 1+r;
  A(j,j+1) = -r/2;
end
A(end,end) = 1;

% Initial Condition
signal = 0.5*cos(2*pi*x) + 2*cos(0.1*pi*x) + 0.8*cos(0.5*pi*x);


u = zeros(N, M);
residule = signal;

u = repmat(residule,1,M);
RHS = zeros(1,N);
for j = 1:M
    u_now = u(:,j);
    RHS(1) = u_now(1);
        for i = 2:N-1
            RHS(i) = u_now(i) + r/2*(u_now(i+1)-2*u_now(i)+u_now(i-1));
        end
    RHS(N) = u_now(N);
    u(1:N,j+1) = periodic_tridiag(A,RHS);  
end


mean_env = u(:,end);

figure();
plot(x, signal);
hold on;
plot(x, mean_env);
legend('signal', 'mean envelope');
