function [avgE, avgM] = Metropolis(width, height, iterations, J, Beta, H)
%METROPOLIS performs metropolis algorithm starting with matrix of all 1
matrix = randi([0,1], [height, width]) .* 2 - 1;

E = calcEnergy(matrix, J, H);
M = calcMagnetization(matrix);

totalE = E;
totalM = M;

for i=1:iterations
   [matrix, deltaE, deltaM] = MetropolisStep(matrix, J, Beta, H);
   E = E + deltaE;
   M = M + deltaM;
   totalE = totalE + E;
   totalM = totalM + M;
end

resultingMatrix = matrix
avgE = totalE / (iterations + 1);
avgM = totalM / (iterations + 1);
end

function [energy] = calcEnergy(matrix, J, H)
    [height, width] = size(matrix);
    horizRotate = circshift(matrix, [0 1]);
    verticRotate = circshift(matrix, [1 0]);
    energy = - sum(sum((horizRotate + verticRotate) .* matrix)) * J - H * sum(sum(matrix));
end

function [magnet] = calcMagnetization(matrix)
    [height, width] = size(matrix);
    magnet = sum(sum(matrix)) / (height * width);
end

