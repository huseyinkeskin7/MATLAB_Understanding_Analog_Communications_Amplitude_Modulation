function modulatedSignal = amDSBSC(message, fc, fs)

wid = size(message,1);
if(wid ==1)
    message = message(:);
end

% Do the modulation
t = (0:1/fs:((size(message, 1)-1)/fs))';
t = t(:, ones(1, size(message, 2)));
modulatedSignal = (message) .* cos(2 * pi * fc * t);

%In this section, we took the necessary parts of the data we obtained from the built-in library of MATLAB and defined our amplitude modulation function.