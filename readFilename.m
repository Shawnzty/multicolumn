function coord = readFilename(folder,pattern)
% read filename in folder and return coordinates of all dots
%   Detailed explanation goes here
    files = struct2cell(dir(folder))';
    filenames = files(:,1);
    coord = zeros(length(filenames),3);
    for i = 1:length(filenames)
        item = string(filenames(i));
        out = sscanf(item,pattern)';
        coord(i,:) = out;
    end
end

