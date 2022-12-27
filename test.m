APC_p = zeros(101,16,16,5);
for i = 1: size(APC,1)
    APC_p(i,:,:,:) = squeeze(APC(i,:,:,:)) .* p;
end