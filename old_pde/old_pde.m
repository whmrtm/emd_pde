%% Amplitude variations according to frequency

N = 6;
t = linspace(0, 0.1, 100);
omega = pi.*linspace(0, 4, N);
figure;
delta = sqrt(2)./(2.0*pi);
mrk={'o','.','*','v','+','^'};


for i=1:N
    h = plot(t, exp((omega(i).^2./2 - 1./delta.^2)*t));
    ylim([0 4]);
    hold on;
    legendInfo{i} = ['\omega = ' num2str(omega(i))];
    set(h,{'Marker'},mrk(i));

end
title('Amplitude variations according to frequency');
str = '$$\omega \in (0,4\pi), \delta = \frac{\sqrt(2)\omega}{2\pi}$$';
text(0.01,3,str,'Interpreter','latex')
xlabel('Evolve time t');
ylabel('Ratio');
legend(legendInfo);



%% Different Mean envelope


