function state = getState(r, T, dt, stimIn)
%GETSTATE discriminate 'ON-ON', 'OFF-ON', 'ON-OFF' and 'OFF_OFF'
%   Detailed explanation goes here

% if none - OFF
isNoneBefore = r(round(stimIn/dt-100)) == r(round(stimIn/dt-90)); % isNone == true
isNoneAfter = r(round(T/dt-100))== r(round(T/dt-90));
% if converge - OFF
gammaPowerBefore0 = getGammaPower(r(round(stimIn/dt-40001):round(stimIn/dt-30001)));
gammaPowerBefore1 = getGammaPower(r(round(stimIn/dt-30001):round(stimIn/dt-20001)));
gammaPowerBefore2 = getGammaPower(r(round(stimIn/dt-20001):round(stimIn/dt-10001)));
gammaPowerBefore3 = getGammaPower(r(round(stimIn/dt-10001):round(stimIn/dt-1)));

gammaPowerAfter0 = getGammaPower(r(round(T/dt-40001):round(T/dt-30001)));
gammaPowerAfter1 = getGammaPower(r(round(T/dt-30001):round(T/dt-20001)));
gammaPowerAfter2 = getGammaPower(r(round(T/dt-20001):round(T/dt-10001)));
gammaPowerAfter3 = getGammaPower(r(round(T/dt-10001):round(T/dt-1)));

isConvergeBefore0 = gammaPowerBefore0 > gammaPowerBefore1;
isConvergeBefore1 = gammaPowerBefore1 > gammaPowerBefore2; % isCOnverge == true
isConvergeBefore2 = gammaPowerBefore2 > gammaPowerBefore3;

isConvergeAfter0 = gammaPowerAfter0 > gammaPowerAfter1;
isConvergeAfter1 = gammaPowerAfter1 > gammaPowerAfter2;
isConvergeAfter2 = gammaPowerAfter2 > gammaPowerAfter3;
% else ON

% if
if isNoneBefore || (isConvergeBefore0 && isConvergeBefore1 && isConvergeBefore2)
    if isNoneAfter || (isConvergeAfter0 && isConvergeAfter1 && isConvergeAfter2)
        state = 'OFF_OFF/';
    else
        state = 'OFF_ON/';
    end
else
    if isNoneAfter || (isConvergeAfter0 && isConvergeAfter1 && isConvergeAfter2)
        state = 'ON_OFF/';
    else
        state = 'ON_ON/';
    end
end