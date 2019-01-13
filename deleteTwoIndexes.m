function [arr] = deleteTwoIndexes(arr, index1, index2)
%DELETE TWO INDEXES
% Deleting index in the right order (bigger first) in order
% to not alterate the numeration
    if index1 < index2
        arr(index2, :) = [];
        arr(index1, :) = [];
    else
        arr(index1, :) = [];
        arr(index2, :) = [];
    end
end
    

