clear all;
close all;
%Decide N for run
Energy = figure(1);
Magnetization = figure(2);
N = 10;
J = 1;
Tarray = [10 50 100 200 300 400 500 600 800 1000]; %K
Kb = 1.38064852*10^(-23); %m^2 kg s^-2 K^-1
%Begin metropolis algorithm
for j = 1:length(Tarray)
    T = Tarray(j);
    B = 1/(T*Kb);
    a = ones(N,N);
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
    %     for x = 1:N
    %         for y = 1:N
    %             sigI = a(x,y);
    %             for z = 1:N
    %                 for w = 1:N
    %                     if ~(z == x && w == y) %Make sure we dont check same element
    %                         sumE = sumE + sigI * a(z,w);
    %                     end
    %                 end
    %             end
    %         end
    %     end
        for x = 1:N-1
            for y = 1:N-1
                sumE = sumE + a(x,y) * a(x+1,y) + a(x,y) * a(x,y+1);
            end
        end
        E(i) = -J*sumE;
        %Calculate M(r)
        M(i) = sum(sum(a))/N^2;
        %Running average plot
        meanEnergy(i,j) = sum(E)/length(E);
        meanMagnetization(i,j) = sum(M)/length(M);
%         figure(Energy);
%         plot(meanEnergy,'o');
%         title('Mean Energy'); xlabel('Iteration number'); ylabel('Energy (kgm/s^2)');
%         drawnow;
%         figure(Magnetization);
%         plot(meanMagnetization,'o'); 
%         title('Mean Magnetization'); xlabel('Iteration number'); ylabel('Magnetization (unit)');
%         drawnow;
    end
    disp(j);
end
plot(meanEnergy); 
legend('10K','50K','100K','200K','300K','400K','500K','600K','800K','1000K','Location','southeast');
figure;
plot(meanMagnetization);
legend('10K','50K','100K','200K','300K','400K','500K','600K','800K','1000K');
