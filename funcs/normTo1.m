function outputArray = normTo1(inputArray, dim)
% normalize and add up to 1 along a specified dimension
    % Ensure the input is a numeric array
    assert(isnumeric(inputArray), 'Input must be a numeric array');
    
    % Check if 'dim' argument was provided, if not, default to 1
    if nargin < 2
        dim = 1;
    end
    
    % Compute the sum of the input array along the specified dimension
    totalSum = sum(inputArray, dim);
    
    % Normalize the array so its elements add up to 1 along the specified dimension
    % Add a small number to the denominator to avoid division by zero
    outputArray = bsxfun(@rdivide, inputArray, totalSum + eps);
end
