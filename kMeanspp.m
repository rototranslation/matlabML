function [centers] = kMeanspp(X,k)
%KMEANSPP simple procedure to obtain an set of k centers that are likely 
% to be widespread in the data-set.

[n,d] = size(X);


%select the first center uniformly at random
centers(1,:) = X(randi(n,1),:);


for i = 2:k 

    %compute distance of each point in X to the centers
    D = SquareDist(centers, X);
    %find the distance of each point in X to the closest center
    [Ds, idx] = min(D,[],1);

    
    D2 = Ds.^2;
    P = D2./sum(D2);
    %sample the new center according to the probability P
    idx_nc = randsample(1:n, 1, 'true', P);    
    centers(i,:) = X(idx_nc,:);
    
end
