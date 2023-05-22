function array = normalize_1d(array)
%NORMALIZE_ID normalize the 1d array and keep 0 values

% Find the minimum non-zero value in the array
min_val = min(array(array > 0));

% Subtract min_val from all non-zero values
array(array > 0) = array(array > 0) - min_val;

% Find the maximum value in the array
max_val = max(array(:));

% Normalize the array by dividing all non-zero values by max_val
array(array > 0) = array(array > 0) / max_val;

end

