function plot_hht(imf)

for k = 1:size(imf,1)
   b(k) = sum(imf(k,:).*imf(k,:));
   th   = angle(hilbert(imf(k,:)));
   d(k,:) = diff(th)/(2*pi);
end
[u,v] = sort(-b);
b     = 1-b/max(b);

% Set time-frequency plots.
N = size(imf,2);
for k = v(1:2)
   figure, plot(d(k,:),'k.','Color',b([k k k]),'MarkerSize',3);
   set(gca,'FontSize',8,'YLim',[0 1]); xlabel('Time'), ylabel('Frequency');
end
