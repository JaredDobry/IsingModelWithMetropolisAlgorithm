clear all;
close all;
%Decide N for run
NMatrix = [3, 10, 64];
for i = 1:length(NMatrix)
    N = NMatrix(i);
    %Generate NxN matrix of random spin up or down
    a = zeros(N,N);
    for row = 1:N
        for column = 1:N
            r = randi([0,1]);
            if r == 0
                a(row,column) = -1;
            else
                a(row,column) = 1;
            end
        end
    end
    %Calculate magnetization
    m(i) = sum(sum(a))/N^2;
    m2(i) = m(i)^2; %This will always just be 1/N so this is not the way to do this
    s = sprintf('Grid of %d x %d had magnetization %f', N, N, m(i));
    disp(s);
end
%Calculate dispersion
avgM2 = sum(m2)/length(m2);
avgM = sum(m)/length(m);
dispersion = avgM2 - avgM^2; %Note: this dispersion is not correct I think, I think we have to do multiple trials to find the average value of m^2
s = sprintf('dispersion %f', dispersion);
disp(s);
