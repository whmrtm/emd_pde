A = 100;
B = 100;


N = logspace(0,3,A);
T = linspace(0,50,B);

[myN, myT] = meshgrid(N, T);

pm = exp(-myN.*exp(-myT));


surf(myN, myT, pm);
xlabel('N');
ylabel('T');
zlabel('performance');
