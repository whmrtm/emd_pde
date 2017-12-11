model = createpde();
geometryFromEdges(model,@squareg);

figure;
pdegplot(model,'EdgeLabels','on');
ylim([-1.1,1.1])
axis equal;

applyBoundaryCondition(model,'dirichlet','Edge',[2,4],'u',0);

u0 = @(locations)atan(cos(pi/2*locations.x+0.001*locations.y));
ut0 = @(locations)3*sin(pi*locations.x).*exp(sin(pi/2*locations.y));
setInitialConditions(model,u0,ut0);

m = 1;
c = 1;
f = 0;
specifyCoefficients(model,'m',m,'d',0,'c',c,'a',0,'f',f);


n = 31; % number of frames in eventual animation
tlist = linspace(0,5,n); % list of times

generateMesh(model);
results = solvepde(model,tlist);

u = results.NodalSolution;

umax = max(max(u));
umin = min(min(u));

figure;
M = moviein(n);
for i=1:n,
    pdeplot(model,'XYData',u(:,i),'ZData',u(:,i),...
    'XYGrid','on','ColorBar','off');
    axis([-1 1 -1 1 umin umax]);
    caxis([umin umax]);
    M(:,i) = getframe;
end