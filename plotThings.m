function plotThings(width, height, iterations)
tempVals = 2 .^ [-10:.3:10];
energies = arrayfun(@(temp) getEnergy(width, height, iterations, 1, 1/temp, 0), tempVals);
figure(1);
semilogx(tempVals, energies);
title("With H=0, average energy as function of temperature");
xlabel("Temp");
ylabel("Energy");

figure(2);
magnets = arrayfun(@(temp) getMagnet(width, height, iterations, 1, 1/temp, 0), tempVals);
semilogx(tempVals, magnets, '.');
title("With H=0, average magnetization as function of temperature");
xlabel("Temp");
ylabel("Magnetization");

figure(3);
magnets = arrayfun(@(temp) getMagnet(width, height, iterations*3, 1, 1/temp, 0.01), tempVals);
semilogx(tempVals, magnets, '.');
title("With H=0.01, average magnetization as function of temperature");
xlabel("Temp");
ylabel("Magnetization");

figure(4);
hVals = [-10:.5:10];
magnets = arrayfun(@(h) getMagnet(width, height, iterations, 1, 1/10, h), hVals);
plot(hVals, magnets);
title("With temperature high (tau=10), average magnetization as a function of H");
xlabel("H");
ylabel("Magnetization");

figure(5);
hVals = [-10:.5:10];
magnets = arrayfun(@(h) getMagnet(width, height, iterations, 1, 1/3.5, h), hVals);
plot(hVals, magnets);
title("With temp near critical (tau=3.5), average magnetization as a func of H");
xlabel("H");
ylabel("Magnetization");

figure(6);
hVals = [-10:.5:10];
magnets = arrayfun(@(h) getMagnet(width, height, iterations, 1, 1/1, h), hVals);
plot(hVals, magnets);
title("With temperature very low (tau=1), average magnetization as a function of H");
xlabel("H");
ylabel("Magnetization");

end

function [data] = getEnergy(width, height, iterations, J, beta, H)
    [avgE, avgM] = Metropolis(width, height, iterations, J, beta, H);
    data = avgE;
end

function [data] = getMagnet(width, height, iterations, J, beta, H)
    [avgE, avgM] = Metropolis(width, height, iterations, J, beta, H);
    data = avgM;
end

function [res] = index(arr, n)
    res = arr(n);
end