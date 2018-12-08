function [avgE, avgM] = Metropolis(width, height, iterations, J, Beta)
%METROPOLIS performs metropolis algorithm starting with matrix of all 1
matrix = randi([0,1], [height, width]) .* 2 - 1;
totalE = 0;
totalM = 0;

totalE = totalE + calcEnergy(matrix, J);
totalM = totalM + calcMagnetization(matrix);

for i=1:iterations
   matrix=MetropolisStep(matrix, J, Beta);
   totalE = totalE + calcEnergy(matrix, J);
    totalM = totalM + calcMagnetization(matrix);
end

resultingMatrix = matrix;
avgE = totalE / (iterations + 1);
avgM = totalM / (iterations + 1);
end

function [energy] = calcEnergy(matrix, J)
    [height, width] = size(matrix);
    horizRotate = circshift(matrix, [0 1]);
    verticRotate = circshift(matrix, [1 0]);
    energy = - sum(sum((horizRotate + verticRotate) .* matrix)) * J;
end

function [magnet] = calcMagnetization(matrix)
    [height, width] = size(matrix);
    magnet = sum(sum(matrix)) / (height * width);
end

