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
T = linspace(10,20,100);
% Number of iterations
N = linspace(1,500,100);

delta = 0.001;
[myT, myN] = meshgrid(T, N);

Z = sqrt( log(1-(delta).^(1./myN)) ./ (-myT) );
surf(myT, myN, Z);
set(get(gca,'XLabel'),'String','T')
set(get(gca,'YLabel'),'String','N')
set(get(gca,'ZLabel'),'String','Critical frequency')
zlim([0,1]);
caxis([0,1]);
colorbar()


