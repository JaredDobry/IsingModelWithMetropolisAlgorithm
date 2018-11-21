function [resultingMatrix] = Metropolis(width, height, iterations, J, Beta)
%METROPOLIS performs metropolis algorithm starting with matrix of all 1
matrix = -ones(height, width);

for i=1:iterations
   matrix=MetropolisStep(matrix, J, Beta);
end

resultingMatrix = matrix;
end

