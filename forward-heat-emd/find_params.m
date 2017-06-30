
%% Critical Value  

T = 10.0;
epsilon = exp(-T);
% Number of iterations
N = 50;

% Find params

% Need (1-epsilon)^N ~= 1
% disp('(1-epsilon)^N');
% (1-epsilon).^N

% The greater critical value f, the better

% ratio after EMD algorithm
% delta = 0.001
% A = 1;
% % Critical value f
% disp('critical value f')
% f = sqrt(log(1-(1-epsilon)*(delta./A)^(1./N))./ log(epsilon))


% Plot the delta variatios
A = 1;
A = logspace(-2,2,8);
figure;
mrk={'o','.','*','v','+','^'};
for i = 1:5
    hold all;
    deltas = logspace(-3,0,100);
    fs = zeros(1,100);
    indicator = 1-(1-epsilon).*(deltas./A(i)).^(1./N);
    deltas =  deltas(indicator > 0);
    fs = sqrt(log(1-(1-epsilon).*(deltas./A(i)).^(1./N)) ... 
        ./ log(epsilon));
    h = plot(deltas, fs);
    set(h,{'Marker'},mrk(i));

    legendInfo{i} = ['\alpha = ' num2str(A(i))];
end
title('Critical value variation');
xlabel('\delta')
ylabel('f_0')
legend(legendInfo)



