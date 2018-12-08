clear all;
close all;
%Decide N for run
N = 20;
J = 1;
Tarray = [10 20 30 40 50 100 200 300 400 500 600 800 1000]; %K
Kb = 1.38064852*10^(-23); %m^2 kg s^-2 K^-1
%Begin metropolis algorithm
for j = 1:length(Tarray)
    T = Tarray(j);
    B = 1/(T*Kb);
    a = ones(N,N);
    clear E;
    clear M;
    for i = 1:(N^2*10)
        %Pick a random particle
        row = randi([1, N]);
        column = randi([1, N]); 
        %Check neighbors for energy
        %Check for positional conditions (being on boundary)
        if row == 1
            if column == 1 %check only row+1 column+1
                delE = 2*J*a(row,column)*(a(row+1,column) + a(row,column+1));
            elseif column == N %Check only row+1 column-1
                delE = 2*J*a(row,column)*(a(row+1,column) + a(row,column-1));
            else %don't check row-1
                delE = 2*J*a(row,column)*(a(row+1,column) + a(row,column+1) + a(row,column-1));
            end
        elseif row == N
            if column == 1 %check only row-1 column+1
                delE = 2*J*a(row,column)*(a(row-1,column) + a(row,column+1));
            elseif column == N
                delE = 2*J*a(row,column)*(a(row-1,column) + a(row,column-1));
            else
                delE = 2*J*a(row,column)*(a(row-1,column) + a(row,column+1) + a(row,column-1));
            end
        else
            if column == 1 %don't check column-1
                delE = 2*J*a(row,column)*(a(row-1,column) + a(row+1,column) + a(row,column+1));
            elseif column == N %don't check column+1
                delE = 2*J*a(row,column)*(a(row-1,column) + a(row+1,column) + a(row,column-1));
            else
                delE = 2*J*a(row,column)*(a(row-1,column) + a(row+1,column) + a(row,column+1) + a(row,column-1));
            end
        end
        %Check to flip the sign
        if delE > 0
            a(row,column) = -a(row,column);
        else
            %Check if it'll flip on probability
            r = rand([0,1]);
            if r < exp(-B*delE)
                a(row,column) = -a(row,column);
            end
        end
        %Calculate E(r)
        sumE = 0;
        for x = 1:N-1
            for y = 1:N-1
                sumE = sumE + a(x,y) * a(x+1,y) + a(x,y) * a(x,y+1);
            end
        end
        E(i) = -J*sumE;
        %Calculate M(r)
        M(i) = sum(sum(a))/N^2;
        %Running average
        meanEnergy(j,i) = sum(E)/length(E);
        meanMagnetization(j,i) = sum(M)/length(M);
    end
    disp(j);
end
figure;
hold on;
for i = 1:length(Tarray)
    plot(meanEnergy(i,:),'.');
end
hold off;
legend('10K', '20K', '30K', '40K','50K','100K','200K','300K','400K','500K','600K','800K','1000K','Location','southeast');
figure;
hold on;
for i = 1:length(Tarray)
    plot(meanMagnetization(i,:),'.');
end
hold off;
legend('10K', '20K', '30K', '40K','50K','100K','200K','300K','400K','500K','600K','800K','1000K');
