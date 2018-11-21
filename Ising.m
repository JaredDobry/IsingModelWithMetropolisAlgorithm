clear all;
close all;

%function which finds m and square of m for one randomly generated matrix of a parameterized size and returns m and m^2
function [m,m2] = genMat(i)    
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
    %Calculate magnetization and square of magnetization
    m = sum(sum(a))/N^2;
    m2 = m^2;
end

%Decide N for run
NMatrix = [3, 10, 64];
%call function on each matrix size
for x = 1:length(NMatrix)
    %do averaging over some large number of trials
    m_arr=[];
    m2_arr=[];%defining empty arrays
    for y=1:1000
        [gen_m,gen_m2]=genMat(x); %get m and m2 from the function
        m_arr=[m_arr,gen_m]; 
        m2_arr=[m2_arr,gen_m2]; %adding newly generated values to arrays
    end
    avg_m=mean(m_arr);%averageing values of these arrays
    avg_m2=mean(m2_arr);
    dispersion = avg_m2 - avg_m^2; %Note: this dispersion is not correct I think, I think we have to do multiple trials to find the average value of m^2
    s = sprintf('%d x %d matrix generated random magnetization %f and dispersion %f', N, N, avg_m, dispersion);
    disp(s);
end
