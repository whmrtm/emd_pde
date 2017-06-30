% The iterative sifting process of EMD represented by PDE
% Author Heming Wang


% define the mesh in space
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
r = D*dt/dx^2 

A(1,N) = -r/2;
A(1,1) = 1+r;
A(1,2) = -r/2;
for j=2:N-1
  A(j,j-1) = -r/2;
  A(j,j) = 1+r;
  A(j,j+1) = -r/2;
end
A(N,N-1) = -r/2;
A(N,N) = 1+r;
A(N,1) = -r/2;

% Initial Condition
k = 2*pi;
sigma = D*k^2;

% define the initial data:
signal = sin(k*x)+ 0.6*sin(0.2*k*x);
u(:,1) = signal;


% Number of iterations
iter_num = 10;

for k = 1:iter_num

    for j = 1:M
    u_now = u(:,j);
    % RHS(1) = u_now(1) + r/2*(u_now(2)-2*u_now(1)+u_now(N));
    
    for i = 2:N-1
        RHS(i) = u_now(i) + r/2*(u_now(i+1)-2*u_now(i)+u_now(i-1));
    end
    RHS(N) = u_now(N) + r/2*(u_now(1)-2*u_now(N)+u_now(N-1));
    u(1:N,j+1) = periodic_tridiag(A,RHS);  
    end

    % impose periodicity
    % u(N+1,:) = u(1,:);
    % u_now(N+1) = u_now(1);

    % Substitute the IC into the process
    mean_env = u(:,end);
    u(:,1) = u(:,1) - mean_env;
end

figure;
plot(x,signal,'b-o');
hold on;
plot(x,u(:,1),'r-*');
legend('Signal', 'IMF');
title('signal: sin(2*pi*x)+ 0.6*sin(0.2*2*pi*x)');
