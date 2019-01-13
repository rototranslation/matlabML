function [vectX, groups] = spectralClustering(myset, k, numC)
%SPECTRAL CLUSTERING

%Inizializing variables
    [n, d] = size(myset);
    groups =  zeros(n, 1);
    myset;
    count = zeros(n, 1);
    for i = 1:n
        val = myset(i, :);
        c = 0;
        for j = 1:n
            if(myset(j, :) == val)
                c = c + 1;
            end
        end
        count(i, :) = c;
    end

    if k < max(count)
        error("Can't apply the algorithm, for sure k has to be > %d", max(count));
    end
%Building Laplace matrix with distance-weighted matrix and diagonal matrix
    adjMat = adjMatBuilder(myset, k);
    degree = zeros(n, 1);
    for i = 1:n
        [deg, ~] = size(adjMat(adjMat(:,i) ~= zeros(n, 1), :));
        degree(i, :)= deg;
    end
    
    diagMat = eye(n).*degree;
    lapMat = diagMat-adjMat;
    lapNorm = mpower(diagMat, -0.5)*lapMat*mpower(diagMat, -0.5);
%Extracting eigen vectors and eigen values
    [eigVect, eigVal] = eig(lapNorm);
    eigVal = diag(eigVal);
    [~, indexes] = mink(eigVal, 2);
%Finding the column that will be used for splitting
    vectX = eigVect(:, indexes(1));
    toSplit = unique(real(vectX)); %Discarding doubles
    [numR, ~] = size(toSplit); 
    index = floor(numR/2);
    bound = toSplit(index, 1); %Drawing middle value (median)
%Filling cluster groups according to values
    groups(vectX > bound, :) = 1;
    groups(vectX <= bound, :) = 2;
end

