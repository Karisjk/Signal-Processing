%--- creating 3 signals---
Fs=1000; % Sampling Frequency
T=1/Fs; %Time between each sample
t= 0:T:1-T; % 1 second of time, 1000 points in total

f1= 50; A1=1.0;
f2= 120; A2=0.6;
f3=300; A3=0.3;


%mix all three
signal= A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
%plot y the time domain (first 50ms)
plot(t(1:50), signal(1:50), 'r');
title('Time Domain- first 50 samples');
xlabel('Time(s)');
ylabel('Amplitude');

