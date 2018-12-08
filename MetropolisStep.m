%Performs a single interation of the metropolis algorithm
function [newMatrix, deltaE, deltaM] = MetropolisStep(matrix, J, Beta)
    [height, width] = size(matrix);
    x = randi([1,width]);%pick random coordinate in matrix
    y = randi([1,height]);
    
    deltaM = 0;
    deltaE = 0;
    potentialDeltaE = CalcEnergyDiff(matrix, x, y, J);
    probabilityFlip = 1;
    if potentialDeltaE > 1
        probabilityFlip = exp(-1*Beta*potentialDeltaE);
    end
    
    if rand() < probabilityFlip
        matrix(y,x) = -matrix(y,x);
        deltaM = 2 * matrix(y, x) / (width*height);
        deltaE = potentialDeltaE;
    end
    
    newMatrix=matrix;
    
end

%This function calculates the energy change in energy from multiplying the value %matrix(x,y) by -1
function [diff] = CalcEnergyDiff(matrix, x, y, J) %J is the parameter in the ising model
    [height, width] = size(matrix);
    %for those of you who believe 1 indexing arrays is good, look at the next two lines. The jig is up
    xs = mod([x-1, x, x, x+1]-1,width) + 1; %x coordinates surrouding cell
    ys = mod([y, y+1, y-1, y]-1,height) + 1; %y corrdinates surrounding cell
    places = sub2ind([height, width], ys, xs); %translate (x,y) pairs to indices (an index is a single number which tells place in matrix)
    
    sumNeighbors = sum(matrix(places)); %sum of the four neighboring values in the matrix
    
    diff = 2 * J * matrix(y,x) * sumNeighbors; %formula for deltaE2d from lecture 15 notes
end

