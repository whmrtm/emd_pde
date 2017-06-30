model = createpde();
width = 1;
height = 2;
gdm = [3 4 0 width width 0 0 0 height height]';
g = decsg(gdm);
geometryFromEdges(model,g);

% Plot the geometry
% figure;
% pdegplot(model,'EdgeLabels','on');
% axis([-.1 1.1 -.1 1.1]);
% title 'Geometry With Edge Labels Displayed';

% Neumann boundary condition
applyBoundaryCondition(model,'edge',[2,4],'u',0);

% Dirichelet boundary condition
% applyBoundaryCondition(model,'edge',[1,3],'g',0);



% Set Initial Condition
alpha = 10;
pde_ic = @(x) sin(4*pi.*x) + sin(alpha*pi.*x);

initfun = @(locations) pde_ic(locations.x);

setInitialConditions(model,initfun);


% Generate the mesh
hmax = 0.05;
msh = generateMesh(model,'Hmax',hmax);
% Plot the mesh
% pdeplot(model);
% axis equal


% Set the parameters
deltax = 0.05;
m = 0;
d = 1;
c = deltax.^2 / pi.^2;
a = 0;
f = 0;
specifyCoefficients(model,'m',m,'d',d,'c',c,'a',a,'f',f);

% Solve the PDE
nframes = 10;
tlist = linspace(0,400,nframes);
model.SolverOptions.ReportStatistics ='on';
result = solvepde(model,tlist);

% u = result.NodalSolution;

% figure;
% pdeplot(model,'zdata',u(:,end));
% xlabel('x');
% ylabel('t');
% zlabel('u');




% Animaion
% figure
% umax = max(max(u));
% umin = min(min(u));
% for i = 1:nframes
%     pdeplot(model,'XYData',u(:,i),'ZData',u(:,i),'ZStyle','continuous',...
%                   'Mesh','off','XYGrid','on','ColorBar','off');
%     axis([-2 2 -2 2 umin umax]);
%     caxis([umin umax]);
%     xlabel x
%     ylabel y
%     zlabel u
%     M(i) = getframe;
% end

x = linspace(0,width,100);
xq = x;
yq = ones(1,length(xq));
uintrp = interpolateSolution(result,xq,yq,1:length(tlist));
mean_env = uintrp(:,end)';


N = 1000;
IMF = pde_ic(x) - mean_env*N;


figure;
plot(x,pde_ic(x));
hold on;
plot(x,mean_env);
plot(x,IMF);

