function isPloted = rvSpace(r,v,pop,cond,state)
%RVSPACE plot a (r,v) phase plane
%   Detailed explanation goes here

if state == "all"
    startFrom = 1;
    endTo = length(r(pop,:,cond));
elseif state == "before"
    startFrom = 1;
    endTo = 100000;
elseif state == "after"
    startFrom = 100001;
    endTo = length(r(pop,:,cond));
end
    
figure();
plot3(r(pop,startFrom:endTo,cond),v(pop,startFrom:endTo,cond),startFrom:endTo);
xlabel("r(t)");
ylabel("v(t)");
view()

isPloted = 1;
end

