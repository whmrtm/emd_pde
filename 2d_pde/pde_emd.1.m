z = linspace(0,2*pi,100);
nframes = length(z);
Frames = moviein(nframes);
for i = 1:nframes
    x = cos(i);
    y = sin(i);
    plot(x,y,'o','erase','none');
    Frames(:,i) = getframe;
    pause(0.25);
end
movie(Frames,1)