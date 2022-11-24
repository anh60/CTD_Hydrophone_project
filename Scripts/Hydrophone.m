% *Andreas Hølleland
% *2022

% --------- LOG -----------------------------------------------------------
% 12:56 Starting hydrophone
% 12:58 Starting 67kHz tags
% 12:59 Starting 69kHz tag
% 13:05 Hydrophones dropped in the water (5 meter depth)
% 13:12 Tags dropped in the water    - 5m
% 13:15 Tags pulled out              - 14m
% 13:17 Tags dropped in the water    - 101m
% 13:20 Tags pulled out              - 109m
% 13:22 Tags dropped in the water    - 206m
% 13:26 Tags pulled out              - 205m
% 13:28 Tags dropped in the water    - 314m
% 13:32 Tags pulled out              - 322m
% 13:34 Tags dropped in the water    - 499m
% 13:38 Tags pulled out              - 496m
% 13:41 Tags dropped in the water    - 705m
% 13:45 Tags pulled out              - 703m
% 13:48 Tags dropped in the water    - 1000m
% 13:52 Tags pulled out              - 987m
% 13:55 Tags dropped in the water    - 1.3km
% 14:00 Tags pulled out              - 1.3km
% 14:06	Hydrophones pulled out of the water
% -------------------------------------------------------------------------

% ---------- TAG INFO -----------------------------------------------------
% Tag1:
%   ID: 24
%   CT: S256
%   Fs: 67kHz
%   TR: 20-40s (random)
%   SL: 156dB re. 1uPa @1m
% Tag2:
%   ID: 25
%   CT: S256
%   Fs: 67kHz
%   TR: 20-40s (random)
%   SL: 156dB re. 1uPa @1m
% Tag3:
%   ID: 200
%   CT: S256
%   Fs: 69kHz
%   TR: 10s (fast)
%   SL: 139dB re. 1uPa @1m
% -------------------------------------------------------------------------

% First transmission happens at 11:12 (13:12, data has +2 hours error)

[y, Fs] = audioread("../Data/Hydrophone/1114.wav");


% --------- SPECTROGRAM ---------------------------------------------------

window = [];
window = hamming(512);

noverlap = [];
noverlap = 256;

nfft = [];
%nfft = 685000:69500;

%figure(7)
%spectrogram(y, window, noverlap, nfft, Fs, 'yaxis');


% ---------- BUTTERWORTH FILTER -------------------------------------------

% Pass frequency +-500Hz of tag'samplings frequency
Fc67 = [66500 67500];
Fc69 = [68500 69500];

n_order = 6;    % 8 is maximum order
Fny = Fs/2;

% Filter coefficients
[b67, a67] = butter(n_order, Fc67/Fny);
[b69, a69] = butter(n_order, Fc69/Fny);

% Plot 67kHz filter
%figure(1);
%freqz(b67, a67, [], Fs);
% Plot 69kHz filter
%figure(2);
%freqz(b67, a67, [], Fs);


% ---------- PLOT FILTERED DATA -------------------------------------------

x = length(y)/Fs;

% Raw data (no filter)
%figure(3)
%plot(y)
title("Raw data (no filter)");

% Filter the data
y67 = filter(b67, a67, y);
figure(4);
plot(y67)
title("Filtered data 67kHz");

y69 = filter(b69, a69, y);
figure(5);
plot(y69)
title("Filtered data 69kHz");


% ---------- DEMODULATION OF DATA -----------------------------------------

% Code-Type 256 = 360ms difference (+-1ms)
ct_min = int32(0.351*Fs);
ct_max = int32(0.361*Fs);

% Peak threshold
ymax = 2*10^-4;

% Sampling interval
t0 = 10;
t1 = 15;
x0 = int32(t0*Fs);
x1 = int32(t1*Fs);

x_start = 0;
ct_done = 0;
ct_time = 0;

for x = x0:1:x1
    if(ct_done == 0)
        % Check for pulse
        if(y69(x) > ymax)
            % Check if it is the first pulse
            if(x_start == 0)
                x_start = x;
            end
            % Check for Code-Type match
            x_delta = x - x_start;
            if(x_delta >= ct_min && x_delta <= ct_max)
                ct_time = double(x_delta) / Fs;
                ct_done = x;
            end
        end
    else
        break; % exit loop
    end
end

ct_done
ct_time

gt_done = 0;
gt_time = 0;
x_start = 0;
ct_done = ct_done+25600;

for x = (ct_done):x1
    if(gt_done == 1)
    else
        break;
    end
end






