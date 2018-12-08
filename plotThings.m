function plotThings(width, height, iterations)
tempVals = 2 .^ [-10:.3:10];
energies = arrayfun(@(temp) getData(width, height, iterations, 1, 1/temp, 100000000), tempVals);
semilogx(tempVals, energies);
end

function [data] = getData(width, height, iterations, J, beta, H)
    [avgE, avgM] = Metropolis(width, height, iterations, J, beta, H);
    data = avgM;
end

function [res] = index(arr, n)
    res = arr(n);
end