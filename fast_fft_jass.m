%--- creating 3 signals---
Fs=1000; % Sampling Frequency
T=1/Fs; %Time between each sample
t= 0:T:1-T; % 1 second of time, 1000 points in total

f1= 50; A1=1.0;
f2= 55; A2=0.6;
f3=300; A3=0.3;


%mix all three
signal= A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
%plot y the time domain (first 50ms)
plot(t(1:50), signal(1:50), 'r');
title('Time Domain- first 50 samples');
xlabel('Time(s)');
ylabel('Amplitude');


N=length(signal); % Number of Samples (1000)
Y= fft(signal);
% FFT is complex. it has real and imaginary parts

%We want the magnitude(how strong each frequency is
magnitude= abs(Y)/N; %Divide by N to normalize the amplitude

%The FFT produces N values but the 2nd half is a mirror of the first
magnitude=magnitude(1:N/2+1); %We keep the first half only(the one sided spectrum
magnitude(2:end -1)=2*magnitude(2:end -1);  %Double to compensate

%Build the matching frequency axis (0 Hz upto Fs/2)
f=Fs*(0:N/2)/N;

%Plotting the frequency spectrum
figure;
plot(f, magnitude, 'b', 'linewidth', 1.5);
title('Frequency Spectrum');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
grid on;


%Adding Noise
noise= 0.5*randn(size(t));
noisy_signal= signal+noise;
Y_noisy=fft(noisy_signal);
mag_noisy=abs(Y_noisy)/N;
mag_noisy=(1:N/2+1);
mag_noisy(2:end-1)= 2*mag_noisy(2:end-1);

figure;
subplot(2, 1,1);
plot(f, magnitude, 'b');
title('Clean Signal Spectrum');
xlabel('Hz'); ylabel('Amplitude'); grid on;

subplot(2, 1,2);
plot(f, mag_noisy, 'r');
title('Noisy Signal Spectrum');
xlabel('Hz'); ylabel('Amplitude');  grid on;
