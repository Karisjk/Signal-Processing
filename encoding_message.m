Fs=10000;
t=0:1/Fs:1-1/Fs;

%message signal- low frequrncy sine
fm=50;
message= sin (2*pi*fm*t);


%Carrier function- High Frequency
fc= 200;
carrier= cos(2*pi*fc*t);

figure;
subplot(2,1,1);
plot(t(1:500), message(1:500));
title('Message sent (50kHz)');
xlabel('Time(s)');
ylabel('Amplitude');


subplot(2,1,2);
plot(t(1:500), carrier(1:500));
title('Carrier Wave (200 kHz)');
xlabel('Time(s)');
ylabel('Amplitude');


%modulating the signal(Encoding)
%Standard AM formula: s(t)=[1+message]*carrier
%The 1+ keeps the signal above 0 so that envelope detection works
m_index=0.8; %Modulation index (0 to 1). Controls how deep the modulation is
am_signal=(1+m_index*message).*carrier; %.* is the elementwise multiplication

%Plot the AM signal
figure;
plot(t(1:1000), am_signal(1:1000), 'Color',[0.85 0.35 0.18]);
hold on;
plot(t(1:1000), (1+m_index*message(1:1000)), 'k--', 'LineWidth', 1.5);
plot(t(1:1000), -(1+m_index*message(1:1000)), 'k--', 'LineWidth', 1.5);
title('AM encoded Signal(dashed=envelope=message)');
xlabel('Time(s)');
ylabel('Amplitude');
legend('AM Signal', 'Upper envelope', 'Lower Envelope');
hold off;
%adding some noise to the channel

noise= 0.3*randn(size(t));
received=am_signal+noise;

figure;
plot(t(1:1000), received(1:1000), 'r');
title('Received Signal(with Noise)');
xlabel('Time(s)');
ylabel('Amplitude');


%--Decoding the received message--
%Stage 1: Rectify by taking the absolute value(flip the negatives to positive)
rectified=abs(received);

%Stage 2: Low Pass filter to smooth thr carrier ripple: lets use mooving average
window=50;
decoded=movmean(rectified, window);
%Remove the DC offset we added earlier (1+)
decoded=decoded-mean(decoded);

%Normalize the Amplitude
decoded= decoded/max(abs(decoded));

%Compare with the original
figure;
subplot (3,1,1);
plot(t(1:2000), message(1:2000), 'b');
title('Original Message'); ylabel('Amplitude');

subplot(3,1,2);
plot(t(1:2000), received(1:2000), 'r');
title('Received message with Noise'); ylabel('Amplitude');

subplot(3,1,3);
plot(t(1:2000), decoded(1:2000), 'g');
title('Decoded Message'); ylabel('Amplitude');
xlabel('Time(s)');



