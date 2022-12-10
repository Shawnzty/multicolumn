signal = r_cond4(110000:200000,1);    
Fs = 100000;            % Sampling frequency                    
L = length(signal);             % Length of signal

figure();
Y = fft(signal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")
xlim([0 100]);