model = createpde();
x0 = 0;
x1 = 2;
y0 = -2;
y1 = 2;
geom = [3;4;x0;x1;x1;x0;y0;y0;y1;y1];
g = decsg(geom);
geometryFromEdges(model,g);

% Neumann boundary condition
applyBoundaryCondition(model,'edge',[2,4],'u',0);

% Dirichelet boundary condition
% applyBoundaryCondition(model,'edge',[1,3],'g',0);

delta = 0.1;
m = 0;
d = 1;
c = -0.5;
a = -1/delta.^2;
f = 0;

specifyCoefficients(model,'m',m,'d',d,'c',c,'a',a,'f',f);

generateMesh(model,'Hmax',0.1)
alpha = 4;

initfun = @(locations) sin(pi*locations.x) + sin(alpha*pi*locations.x);
setInitialConditions(model,initfun);

nframes = 20;
tlist = linspace(0,0.8,100);
results = solvepde(model, tlist);
model.SolverOptions.ReportStatistics ='on';
u = results.NodalSolution;
pdeplot(model,'XYData',u,'ZData',u,'Mesh','on')
% 
% for j = 1:nframes
%     pdeplot(model, 'XYData', u(:,j),'ZData', u(:,j));
% 
% end