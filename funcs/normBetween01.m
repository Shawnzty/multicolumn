function outMatrix = normBetween01(inMatrix, dim)
% normalize values between 0 and 1
    % Check if there is a negative value in the matrix
    if any(inMatrix(:) < 0)
        error('Input matrix contains negative values.')
    end
    
    % Check if the dimension is valid
    if dim > ndims(inMatrix)
        error('Invalid dimension. Input matrix does not have this many dimensions.')
    end

    minVal = min(inMatrix, [], dim);
    maxVal = max(inMatrix, [], dim);

    % Avoid division by zero for cases where minVal == maxVal
    range = maxVal - minVal;
    range(range == 0) = 1;
    
    % Normalize the matrix
    outMatrix = bsxfun(@minus, inMatrix, minVal);
    outMatrix = bsxfun(@rdivide, outMatrix, range);
end
