function [centers, groups] = hierarchicalClustering(dataset, numC)
%HIERARCHICAL CLUSTERING 

%Inizializing variables
    centers = dataset;
    [centSize, ~] = size(centers);
    groups = zeros(centSize, 1);
    for i = 1:centSize
        groups(i) = i;
    end
    assign = groups;
    bestD1 = 0;
    bestD2 = 0;
    index1 = 0;
    index2 = 0;
    
%Starting clustering cycle
%Untill you have the number of clusters requested
    while centSize > numC
        bestDist = inf;
%Calculating distances among points, finding the nearest
        for d1 = 1:centSize
            for d2 = 2:centSize
                if(d1 ~= d2)
                    d1Val = centers(d1, :);
                    d2Val = centers(d2, :);
                    curDist = SquareDist(d1Val, d2Val);
                    if curDist < bestDist
                        bestDist = curDist;
                        bestD1 = d1Val;
                        index1 = d1;
                        bestD2 = d2Val;
                        index2 = d2;
                    end
                end
            end
        end
        
%Updating centers
%Calculating distance (average) and adding the couple instead of indexes
        avgD = avg(bestD1, bestD2);
        centers = deleteTwoIndexes(centers, index1, index2);
        centers = vertcat(centers, avgD);
        
%Assigning cluster groups
        g1 = assign(index1, :);
        g2 = assign(index2, :);
        if g1 <= g2 %Smaller group wins
%Second element's group get accorped to the first element's group (smaller one)
            for i = 1:size(groups) 
                if groups(i) == g2
                    groups(i) = g1;
                end
            end
            assign = deleteTwoIndexes(assign, index1, index2);
            assign = vertcat(assign, g1);
        else %First element's group get accorped to the second element's group (smaller one)
            for i = 1:size(groups)
                if groups(i) == g1
                    groups(i) = g2;
                end
            end
            assign = deleteTwoIndexes(assign, index1, index2);
            assign = vertcat(assign, g2);
        end
        [centSize, ~] = size(centers);
    end
end

