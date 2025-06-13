function demodulatedSignal = amCoDet(modulatedSignal, fc, fs)
[num,den] = butter(5,fc*2/fs);
wid = size(modulatedSignal,1);
if(wid ==1)
    modulatedSignal = modulatedSignal(:);
end

t = (0 : 1/fs :(size(modulatedSignal,1)-1)/fs)';
t = t(:, ones(1, size(modulatedSignal, 2)));
demodulatedSignal = modulatedSignal .* cos(2*pi * fc * t);
demodulatedSignal = filtfilt(num, den, demodulatedSignal) * 2;

%In this section, we took the necessary parts of the data we obtained from the built-in library of MATLAB and defined our amplitude demodulation function.
