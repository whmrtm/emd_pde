%% sine mixture study regarding alphas and fs
T = 10.0;
L = 400;
x = linspace(0,6,L);

% define the diffusivity
k = 1/(4*pi.^2);
% k = 1;



wave_num = 2.0.*pi;
alphas = logspace(-2, 2, 100);
fs = linspace(0, 1, 100);
pms = zeros(100, 100);

s1 = sin(wave_num.*x);

for i = 1:100
    for j = 1:100
        alpha = alphas(i);
        f = fs(j);
        s2 = alpha.*sin(f.*wave_num*x);
        signal = s1 + s2;
        [IMFs, residule] = conv_emd(x, signal, k, T, 100, 1);
        HFC = IMFs(1,:);

        pms(i,j) = norm(HFC - s1) ./ norm(s1);

        fprintf('%i,%i\n',i,j);

    end
end


[myAlpha, myF] = meshgrid(alphas, fs);

figure;
mesh(myAlpha, myF, pms);
set(gca, 'XScale', 'log');
set(get(gca,'XLabel'),'String','alpha');
set(get(gca,'YLabel'),'String','f');
set(get(gca,'ZLabel'),'String','Performance Measure');
zlim([0,1]);
caxis([0,1]);

colorbar();



% %% Theoritical value

% T = 10.0;
% L = 400;
% x = linspace(0,6,L);

% % define the diffusivity
% k = 1/(4*pi.^2);
% % k = 1;



% wave_num = 2.0.*pi;
% alphas = logspace(-2, 2, 100);
% fs = linspace(0, 1, 100);
% pms = zeros(100, 100);

% s1 = sin(wave_num.*x);

% for i = 1:100
%     for j = 1:100
%         alpha = alphas(i);
%         f = fs(j);
%         HFC = alpha*exp(-100.*exp(-f.^2*;

%         pms(i,j) = norm(HFC - s1) ./ norm(s1);

%         fprintf('%i,%i\n',i,j);

%     end
% end


% [myAlpha, myF] = meshgrid(alphas, fs);

% figure;
% mesh(myAlpha, myF, pms);
% set(gca, 'XScale', 'log');
% set(get(gca,'XLabel'),'String','alpha');
% set(get(gca,'YLabel'),'String','f');
% set(get(gca,'ZLabel'),'String','Performance Measure');
% zlim([0,1]);
% caxis([0,1]);

% colorbar();



