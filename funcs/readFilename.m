function coord = readFilename(folder,pattern)
% read filename in folder and return coordinates of all dots
%   Detailed explanation goes here
    files = struct2cell(dir(folder))';
    filenames = files(:,1);
    col = count(pattern,'%f');
    coord = zeros(length(filenames),col);
    for i = 1:length(filenames)
        item = string(filenames(i));
        out = sscanf(item,pattern)';
        if ~isempty(out)
            coord(i,:) = out;
        end
    end
end

