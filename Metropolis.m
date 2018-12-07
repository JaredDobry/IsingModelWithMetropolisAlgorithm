function [resultingMatrix] = Metropolis(width, height, iterations, J, Beta)
%METROPOLIS performs metropolis algorithm starting with matrix of all 1
matrix = -ones(height, width);

magnetization = zeros(1, iterations + 1);
energy = zeros(1, iterations + 1);

for i=1:iterations
   matrix=MetropolisStep(matrix, J, Beta);
   magnetization(i + 1) = (sum(sum(matrix))/(width*height))/i + magnetization(i);
   energy(i + 1) = -J*sum(sum(matrix))/i + energy(i);  
end

%popping off the first element of the arrays
magnetization(1) = [];
energy(1) = [];

plot(magnetization,'o');
title('Mean Magnetization');
xlabel('iterations');
ylabel('magnetization');
figure();
plot(energy,'o');
title('Mean Energy');
xlabel('iterations');
ylabel('energy');


resultingMatrix = matrix;
end
