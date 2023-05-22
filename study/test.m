
tX = [0,0.050000000000000,0,0.050000000000000];
tS1 = 0;
tT1 = 0;
qX = linspace(0, 0.05, 200);

qY1=interp1(tX,[tS1,tS1,tT1,tT1],qX,'pchip');
