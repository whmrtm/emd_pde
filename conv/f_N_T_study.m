% Study the relationship between performance measure and parameters

% %% Theoritical Value

% T = 15.0;
% N = 300;


% alphas = logspace(-2, 2, 100);
% fs = linspace(0, 1, 100);
% pms = zeros(100, 100);

% for i = 1:100
%     for j = 1:100
%         alpha = alphas(j);
%         f = fs(i);
%         pms(i,j) = abs(1 - alpha*(1-exp(-f.^2*T)).^N - (1-exp(-T)).^N) ./ alpha;
%     end
% end


% [myAlpha, myF] = meshgrid(alphas, fs);

% figure;
% mesh(myAlpha, myF, pms);
% set(gca, 'XScale', 'log');
% set(get(gca,'XLabel'),'String','alpha');
% set(get(gca,'YLabel'),'String','f');
% set(get(gca,'ZLabel'),'String','Performance Measure');
% % zlim([0,1]);
% caxis([0,1]);

% colorbar();

%% Explore the relationship between cutoff freq and N,T

% Ns = logspace(1, 8, 500);
Ns = linspace(10, 10000, 500);
Ts = linspace(0,50,500);

f0s = zeros(500, 500);

f = linspace(0,1,500);
epsilon = 0.05;

for i = 1:500
    for j = 1:500
        N = Ns(j);
        T = Ts(i);
        pm2 = abs(1 - (1-exp(-f.^2*T)).^N - (1-exp(-T)).^N);
        f_ind = find(pm2 > epsilon);
        % Cutoff Frequency
        if (1-exp(-T)).^N < 1-5*epsilon || f(f_ind(1)) == 0
            f0s(i,j) = NaN;
        else
            f0s(i,j) = f(f_ind(1));
        end
    end
end


[myN, myT] = meshgrid(Ns, Ts);

figure;
mesh(myN, myT, f0s);
% set(gca, 'XScale', 'log');
set(get(gca,'XLabel'),'String','N','FontSize', 20);
set(get(gca,'YLabel'),'String','T','FontSize', 20);
set(get(gca,'ZLabel'),'String','Cutoff Freq ratio f0','FontSize', 20);
% zlim([0,1]);
caxis([0,1]);

colorbar();


% %% Single Group test
% T = 10;
% N = 1000;
% epsilon = 0.05;
% f = linspace(0, 1, 200);
% pm2 = abs(1 - (1-exp(-f.^2*T)).^N - (1-exp(-T)).^N);
% f_ind = find(pm2 > epsilon);
% (1-exp(-T)).^N
% f0 = f(f_ind(1))
