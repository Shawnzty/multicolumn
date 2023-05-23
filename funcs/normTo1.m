function outputArray = normTo1(inputArray)\
% normalize and add up to 1
    % Ensure the input is a numeric array
    assert(isnumeric(inputArray), 'Input must be a numeric array');
    
    % Compute the sum of the input array
    totalSum = sum(inputArray(:));
    
    % Normalize the array so its elements add up to 1
    outputArray = inputArray / totalSum;
end
