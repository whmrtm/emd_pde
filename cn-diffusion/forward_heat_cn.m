% The iterative sifting process of EMD represented by PDE
% Author Heming Wang

% TODO: wrap this to a function

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
r = D*dt/dx^2 

A = zeros(N,N);
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
wave_num = 2.0.*pi;
sigma = D*wave_num^2;
signal = sin(wave_num*x)+ 0.4*sin(0.2*wave_num*x);



% Number of iterations
iter_num = 10;
% Max IMF number 
IMF_num = 3;
IMF = [];

% From this point, the following parameters are needed:
% N, M, signal, sigma,
% iter_num, IMF_num


u = zeros(N+1, M);
residule = signal;


for a = 1:IMF_num
    % Extract IMF functions
    u = repmat(residule,1,M);

    fprintf('Calculating the %i IMF\n', a);
    for k = 1:iter_num

        fprintf('The %i th iteration\n', k);
        for j = 1:M
        u_now = u(:,j);       
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
        temp_res = u(:,1) - mean_env;
        if rms(mean_env) < 0.01
            fprintf('Meet Stop Cretiron, break the iterations\n');
            break;
        end
        u = repmat(temp_res,1,M);

    end

    if rms(temp_res) < 0.03
        fprintf('Meet Stop Cretiron, stop finding IMFs\n');
        break;
    end
    
    fprintf('------------------------------------\n');

    IMF = [IMF temp_res];
    residule = residule - IMF(:,end);

end

figure();
plot(x, signal);
hold on;
plot(x, IMF(:,1),'-o');


% % Plot the result
% figure();
% subplot(6,1,1); plot(x,signal);
% for i = 2:2+IMF_num-1
%     subplot(6,1,i); plot(x,IMF(:,i-1));
% end
