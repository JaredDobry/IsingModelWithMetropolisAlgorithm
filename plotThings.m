function plotThings(width, height, iterations)
tempVals = 2 .^ [-10:.3:10];
energies = arrayfun(@(temp) index(Metropolis(width, height, iterations, 1, 1/temp), 1), tempVals);
semilogx(tempVals, energies);
end

function [res] = index(arr, n)
    res = arr(n);
end