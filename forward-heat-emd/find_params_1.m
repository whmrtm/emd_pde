%% 3D plot of the params
% T = linspace(1,20,100);
% epsilon = logspace(-9,-3,100);
% % Number of iterations
% N = linspace(1,500,100);

% delta = 0.001;
% [myeps, myN] = meshgrid(epsilon,N);
% Z = sqrt( log(1-(delta).^(1./myN)) ./ log(myeps) );
% s = surf(myeps, myN, Z)

% set(gca,'XScale','log');
% set(get(gca,'XLabel'),'String','epsilon')
% set(get(gca,'YLabel'),'String','N')
% set(get(gca,'ZLabel'),'String','Critical frequency')
% zlim([0,1]);
% caxis([0,1]);
% colorbar()




%% 3D plot of the params
<<<<<<< HEAD
T = linspace(3,30,100);
% Number of iterations
N = linspace(1,500,100);

delta = 0.01;

adj_const = 5;
Z = zeros(100,100);

for i = 1:100
    for j = 1:100
        t = T(i); n = N(j);
        epsilon = exp(-t);
        if (1-epsilon).^n > 1-adj_const*delta
            Z(i,j) = sqrt( log(1-(delta).^(1./n)) ./ (-t) );
        else
            Z(i,j) = 0;
        end
    end
end

[myT, myN] = meshgrid(T, N);

=======
T = linspace(10,20,100);
% Number of iterations
N = linspace(1,500,100);

delta = 0.001;
[myT, myN] = meshgrid(T, N);

Z = sqrt( log(1-(delta).^(1./myN)) ./ (-myT) );
>>>>>>> 073734afd9004ac62514d5ee8fe9d46236659401
surf(myT, myN, Z);
set(get(gca,'XLabel'),'String','T')
set(get(gca,'YLabel'),'String','N')
set(get(gca,'ZLabel'),'String','Critical frequency')
zlim([0,1]);
caxis([0,1]);
colorbar()


