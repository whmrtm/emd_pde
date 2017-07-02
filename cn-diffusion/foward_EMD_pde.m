function [IMF, residule] = forward_EMD_pde(N, M, a, r, signal, iter_num=10, IMF_num=3)

% The iterative sifting process of EMD represented by PDE
% Author Heming Wang

    % Matrix for PDE computation
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


    % Initialization
    IMF = []
    u = zeros(N+1, M);
    residule = signal;


    for L = 1:IMF_num
        % Extract IMF functions
        u = repmat(residule,1,M);

        fprintf('Calculating the %i IMF\n', L);
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
end
