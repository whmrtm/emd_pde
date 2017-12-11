function mean_env = mean_envelope(signal, k, T)
signal = double(signal);
N = size(signal,1);
% N = 50;
L = N;
x = linspace(1,L,N);
y = linspace(1,L,N);

% x = (x(1:end-1) + x(2:end))/2;
% y = (y(1:end-1) + y(2:end))/2;

[X,Y] = meshgrid(x,y);


u0(:,:) = signal(1:N,1:N);

% handle_surf = surf(X,Y,u0);
% handles_axes = gca;
% title('Evolution');

dx = x(2)-x(1);
n = 20;
tspan = linspace(0,T,n);

[t,u] = ode15s(@(t,x)getRHS(x,k,dx,N+1),tspan,u0(:));

Tn = length(t);
u = reshape(u, Tn, N, N);

% filename = 'heat.gif';
% for ii = 1:n
%     Z = u(ii,:,:);
%     Z = squeeze(Z);
%     handle_surf.ZData = Z;
%     drawnow;
%     frame = getframe(gcf);
%     im = frame2im(frame);
%     [A,map] = rgb2ind(im,256);
%     if ii == 1
%         imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
%     else
%         imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
%     end
% end
mean_env = squeeze(u(n,:,:));
end