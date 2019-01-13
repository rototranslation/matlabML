function [adjMat] = adjMatBuilder(myset, k)
%ADJACENCY MATRIX BUILDER

%Variable initialization
    distMat = squareform(pdist(myset(:,2)));
    [row, col] = size(distMat);
    adjMat = zeros(row, col);
    
    count = zeros(row, 1);

     for i = 1:col
        c = 0;
        for j = 1:row
            if(distMat(i, j) == 0)
                c = c + 1;
            end
        end
        count(i, :) = c;
    end

    if k < max(count)
        error("Can't apply the algorithm, minimum k value required  = %d", max(count));
    end
    
%Weighting the distances
    for i=1:row
        [~, indexes] = mink(distMat(i, :), k+1);
        for j = 1:k+1
            val = distMat(i, indexes(:, j));
%             if val > (floor(val)+0.5)
            adjMat(i, indexes(:, j)) = val+1;
%             else
%                 adjMat(i, indexes(:, j)) = val;
%             end
%             if distMat(i, indexes(:, j)) > 2
%                 adjMat(i,indexes(:, j)) = 3;
%             else
%                 if distMat(i, indexes(:, j)) > 1
%                 adjMat(i,indexes(:, j)) = 2; 
%                 else 
%                     adjMat(i,indexes(:, j)) = 1;
%                 end
%             end
        end
        adjMat(i,i) = 0;
    end
end


