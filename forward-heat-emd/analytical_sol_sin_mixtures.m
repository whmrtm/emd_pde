m = 0;
deltax = 0.0001;
deltat = 0.1;

% Need to determine the evolved time
% Need to determine the a value of step size a

T = 10.0;
X = 2.0;
x = linspace(0,X,X/deltax+1);
t = linspace(0,T,T/deltat);


N = 50;
omega = 2*pi;
sinu = @(a,b,omega,x) a.*sin(b.*omega*x);
s1 = @(x) sinu(1,1,omega,x);


mypm = zeros(100,100);
myA = logspace(-2,2,100);
myF = linspace(0,1,100);
a = 1./omega.^2;


for i = 1:100
    for j = 1:100
        A = myA(j);
        F = myF(i);
        s2 = @(x) sinu(A,F,omega,x);
        s = @(x) s1(x) + s2(x);
        imf = (1-exp(-a*omega.^2*T)).^N*s1(x) + ...
        (1-exp(-a*F.^2*omega.^2*T)).^N*s2(x);

        % Performance Measure 1
        % pm = norm(imf - s1(x)) ./ norm(s2(x));

        % Performance Measure 2
        % pm = norm(imf - s1(x)) ./ norm(s1(x));

        % Performance Measure 3
        pm = norm(imf.*s1(x)) ./ norm(s1(x).^2);
        
        
        mypm(i,j) = pm;
    end
end


[A,F] = meshgrid(myA,myF);
% imf = (1-exp(-a*omega.^2*T)).^N*s1(x) + ...
% (1-exp(-a*F.^2*omega.^2*T)).^N*s2(x);
% PM = norm(imf - s1(x)) ./ norm(s2(x));

% imagesc(mypm);
figure;
mesh(A,F,mypm)
set(gca,'XScale','log');
set(get(gca,'XLabel'),'String','log_{10} a')
set(get(gca,'YLabel'),'String','f')
set(get(gca,'ZLabel'),'String','Performance Measure')
% zlim([0,1]);
% caxis([0,1]);

zlim([0.5,4]);
caxis([0.5,4]);
colorbar()

