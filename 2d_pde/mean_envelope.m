function mean_env = mean_envelope(signal, k, T)
signal = double(signal);

%Specifying parameters
nx=size(signal,1);                           %Number of steps in space(x)
ny=size(signal,2);                           %Number of steps in space(y)       
dt=2;                         %Width of each time step
nt=round(T./dt);                           %Number of time steps 
dx=1;                     %Width of space step(x)
dy=1;                     %Width of space step(y)
x=0:nx-1;                        %Range of x(0,2) and specifying the grid points
y=0:ny-1;                        %Range of y(0,2) and specifying the grid points
u=zeros(nx,ny);                  %Preallocating u (initial signal)
un=zeros(nx,ny);                 %Preallocating un

vis=k;                         %Diffusion coefficient/viscocity
UW=125;                            %x=0 Dirichlet B.C 
UE=125;                            %x=L Dirichlet B.C 
US=125;                            %y=0 Dirichlet B.C 
UN=125;                            %y=L Dirichlet B.C 
UnW=0;                           %x=0 Neumann B.C (du/dn=UnW)
UnE=0;                           %x=L Neumann B.C (du/dn=UnE)
UnS=0;                           %y=0 Neumann B.C (du/dn=UnS)
UnN=0;                           %y=L Neumann B.C (du/dn=UnN)

%%
%Initial Conditions
u = signal;

%%
%B.C vector
bc=zeros(nx-2,ny-2);
bc(1,:)=UW/dx^2; bc(nx-2,:)=UE/dx^2;  %Dirichlet B.Cs
bc(:,1)=US/dy^2; bc(:,ny-2)=UN/dy^2;  %Dirichlet B.Cs
%bc(1,:)=-UnW/dx; bc(nx-2,:)=UnE/dx;  %Neumann B.Cs
%bc(:,1)=-UnS/dy; bc(:,nx-2)=UnN/dy;  %Neumann B.Cs
%B.Cs at the corners:
bc(1,1)=UW/dx^2+US/dy^2; bc(nx-2,1)=UE/dx^2+US/dy^2;
bc(1,ny-2)=UW/dx^2+UN/dy^2; bc(nx-2,ny-2)=UE/dx^2+UN/dy^2;
bc=vis*dt*bc;

%Calculating the coefficient matrix for the implicit scheme
Ex=sparse(2:nx-2,1:nx-3,1,nx-2,nx-2);
Ax=Ex+Ex'-2*speye(nx-2);        %Dirichlet B.Cs
%Ax(1,1)=-1; Ax(nx-2,nx-2)=-1;  %Neumann B.Cs
Ey=sparse(2:ny-2,1:ny-3,1,ny-2,ny-2);
Ay=Ey+Ey'-2*speye(ny-2);        %Dirichlet B.Cs
%Ay(1,1)=-1; Ay(ny-2,ny-2)=-1;  %Neumann B.Cs
A=kron(Ay/dy^2,speye(nx-2))+kron(speye(ny-2),Ax/dx^2);
D=speye((nx-2)*(ny-2))-vis*dt*A;

%%
%Calculating the field variable for each time step
i=2:nx-1;
j=2:ny-1;

for it=0:nt
    un=u;
%     h=surf(x,y,u','EdgeColor','none');       %plotting the field variable
%     shading interp
%     axis ([0 nx 0 ny 0 255])
%     title({['2-D Diffusion with {\nu} = ',num2str(vis)];['time (\itt) = ',num2str(it*dt)]})
%     xlabel('Spatial co-ordinate (x) \rightarrow')
%     ylabel('{\leftarrow} Spatial co-ordinate (y)')
%     zlabel('Transport property profile (u) \rightarrow')
%     drawnow; 
%     refreshdata(h)
    %Uncomment as necessary
    %Implicit method:
%     U=un;U(1,:)=[];U(end,:)=[];U(:,1)=[];U(:,end)=[];
%     U=reshape(U+bc,[],1);
%     U=D\U;
%     U=reshape(U,nx-2,ny-2);
%     u(2:nx-1,2:ny-1)=U;
    %Boundary conditions
    %Dirichlet:
%     u(1,:)=UW;
%     u(nx,:)=UE;
%     u(:,1)=US;
%     u(:,ny)=UN;
    %Neumann:
    %u(1,:)=u(2,:)-UnW*dx;
    %u(nx,:)=u(nx-1,:)+UnE*dx;
    %u(:,1)=u(:,2)-UnS*dy;
    %u(:,ny)=u(:,ny-1)+UnN*dy;
    %}
    %Explicit method:
    
    u(i,j)=un(i,j)+(vis*dt*(un(i+1,j)-2*un(i,j)+un(i-1,j))/(dx*dx))+(vis*dt*(un(i,j+1)-2*un(i,j)+un(i,j-1))/(dy*dy));
    %Boundary conditions
    %Dirichlet:
    u(1,:)=signal(1,:);
    u(nx,:)=signal(nx,:);
    u(:,1)=signal(:,1);
    u(:,ny)=signal(:,ny);
    %Neumann:
    %u(1,:)=u(2,:)-UnW*dx;
    %u(nx,:)=u(nx-1,:)+UnE*dx;
    %u(:,1)=u(:,2)-UnS*dy;
    %u(:,ny)=u(:,ny-1)+UnN*dy;
    
end
mean_env = un;

% figure;
% surf(un);
end