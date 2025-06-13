clc;
clear;
close all;
Fc = 500; % We set the carrier frequency to 1000 Hz

% Load audio file and get audio data and sample rate
[audioData, Fs] = audioread('Recording.wav');
t = (0:length(audioData)-1)/Fs;
t = t';

% Sound audio file
sound(audioData, Fs);

% Plot of audio data in time domain
figure(1);
subplot(2,1,1);
plot(t,audioData);
title('Audio Signal in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

% Plot of audio data in frequency domain
audioFFT = fft(audioData);

subplot(2,1,2);
plot(abs(audioFFT));
title('Audio Signal in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

% Modulating audio signal using amDSBSC function
modulatedSignal = amDSBSC(audioData, Fc, Fs);

% Plot modulated signal in time domain
figure(2);
subplot(2,1,1);
plot(t,modulatedSignal);
title('Modulated Signal in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

% Plot of modulated signal in frequency domain
modulatedFFT = fft(modulatedSignal);
subplot(2,1,2);
plot(abs(modulatedFFT));
title('Modulated Signal in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

pause(7);

% Sound modulated signal
sound(modulatedSignal,Fs);

% Generating noise signals with different SNR levels
snr1 = 5; % SNR level: 5 dB
noise1 = awgn(modulatedSignal, snr1);

snr2 = 25; % SNR level: 25 dB
noise2 = awgn(modulatedSignal, snr2);

snr3 = 45; % SNR level: 45 dB
noise3 = awgn(modulatedSignal, snr3);

% Received signal
received1 = noise1 + modulatedSignal;
received2 = noise2 + modulatedSignal;
received3 = noise3 + modulatedSignal;

% Plot received signals in time domain
figure(3);
subplot(3,1,1);
plot(t,received1);
title('Received Signal with SNR = 5dB in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

subplot(3,1,2);
plot(t,received2);
title('Received Signal with SNR = 25dB in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

subplot(3,1,3);
plot(t,received3);
title('Received Signal with SNR = 45dB in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

% Plot of received signals in frequency domain
receivedFFT1 = fft(received1);
receivedFFT2 = fft(received2);
receivedFFT3 = fft(received3);

figure(4);
subplot(3,1,1);
plot(abs(receivedFFT1));
title('Received Signal with SNR = 5dB in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

subplot(3,1,2);
plot(abs(receivedFFT2));
title('Received Signal with SNR = 25dB in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

subplot(3,1,3);
plot(abs(receivedFFT3));
title('Received Signal with SNR = 45dB in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

% Perform coherent detection on received signals
z1 = amCoDet(received1,Fc,Fs);
z2 = amCoDet(received2,Fc,Fs);
z3 = amCoDet(received3,Fc,Fs);

% Plot demodulated received signals in time domain
figure(5);
subplot(3,1,1);
plot(t,z1);
title('Demodulated Received Signal 1 in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

subplot(3,1,2);
plot(t,z2);
title('Demodulated Received Signal 2 in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

subplot(3,1,3);
plot(t,z3);
title('Demodulated Received Signal 3 in Time Domain');
xlabel ('Time','fontsize',10), ylabel('Amplitude','fontsize',10)

% Plot of  demodulated received signals in frequency domain
z1FFT = fft(z1);
z2FFT = fft(z2);
z3FFT = fft(z3);

figure(6);
subplot(3,1,1);
plot(abs(z1FFT));
title('Demodulated Received Signal 1 in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

subplot(3,1,2);
plot(abs(z2FFT));
title('Demodulated Received Signal 2 in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

subplot(3,1,3);
plot(abs(z3FFT));
title('Demodulated Received Signal 3 in Frequency Domain');
xlabel ('Frequency','fontsize',10), ylabel('Magnitude','fontsize',10)

pause(7);

z1 = z1';
z2 = z2';
z3 = z3';
singleoutputx = [z1;z2;z3];
singleoutput = mean(singleoutputx);

sound(singleoutput,Fs);
