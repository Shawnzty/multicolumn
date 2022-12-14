function gammaPower = getGammaPower(inputArg)
%GETBANDPOWER get gamma power of the signal
%   Detailed explanation goes here
    sampleFreq = 100000;
    gammaPower = bandpower(inputArg, sampleFreq, [25 100]);
end
