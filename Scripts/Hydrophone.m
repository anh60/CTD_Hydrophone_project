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

[y, fs] = audioread("../Data/Hydrophone/1113.wav");
data = readcell("../Data/TBR700/TagDetFiltered.csv");

% TBR700RT is 48 seconds ahead of hydrophone (wav_time - 48)
wavStartTime = 1500;
wavEndTime = 1600;


% --------- SPECTROGRAM ---------------------------------------------------

% % window = [];
% window = hamming(512);

% noverlap = [];
% % noverlap = 256;

% nfft = [];
% % nfft = 685000:69500;

% figure(1)
% spectrogram(y, window, noverlap, nfft, Fs, 'yaxis');


% ---------- BUTTERWORTH FILTER -------------------------------------------

f67 = 67000;
f69 = 69000;

fc67 = 500;
fc69 = 500;

fb67 = [f67-fc67,f67+fc67];
fb69 = [f69-fc69,f69+fc69];

n_order = 4;
Fny = fs/2;

[b67, a67] = butter(n_order, fb67/Fny);
[b69, a69] = butter(n_order, fb69/Fny);


% ---------- PLOT BUTTERWORTH ---------------------------------------------

% % Plot 67kHz filter
% figure(2);
% freqz(b67, a67, [], Fs);
% % Plot 69kHz filter
% figure(3);
% freqz(b67, a67, [], Fs);


% ---------- FILTER DATA --------------------------------------------------

x = [];

for i = 1:length(y)
    x(i) = i / fs;
end

y67 = filtfilt(b67, a67, y);
y69 = filtfilt(b69, a69, y);


% ---------- PLOT DATA ----------------------------------------------------

% % Raw data (no filter)
% figure(4)
% %plot(y)
% title("Raw data (no filter)");

% figure(5);
% plot(x,y67)
% title("Filtered data 67kHz");


% figure(6);
% plot(x,y69)
% title("Filtered data 69kHz");


% ---------- PLOT FILTERED DATA WITH TBR700RT -----------------------------

mStart = 43;% 37;
mEnd = 48;% 83;

[times] = getTimes(mStart, mEnd, data);
[ids] = getId(mStart, mEnd, data);

times

% 67kHz
figure(6)
plot(x, y67)
hold on
plotId(times, ids);
%getData(times, ids, wavStartTime, wavEndTime);
hold off
axis padded
title("67kHz");

% 69kHz
figure(7)
plot(x, y69)
hold on
plotId(times, ids);
%getData(times, ids, wavStartTime, wavEndTime);
hold off
axis padded
title("69kHz");


% ---------- TBR700RT -----------------------------------------------------

% function[] = getData(times, id, startTime, endTime)
%     [ftime, fid] = filterTime(times, id, startTime, endTime);
%     for i = 1:length(ftime)
%         string = num2str(ftime(i));
%         m = str2double(string(1:2));
%         s = str2double(string(3:4));
%         ftime(i) = s;
%     end
%     plotId(ftime, fid)
% end
% 
% % Filter lists to get measurements within a specific timeframe
% function[ftimes, fid] = filterTime(times, id, startTime, endTime)
%     ftimes = [];
%     fid = [];
%     for i = 1:length(times)
%         if(times(i) > startTime && times(i) < endTime)
%             ftimes(i) = times(i);
%             fid(i) = id(i);
%         end
%     end
%     ftimes = ftimes(ftimes ~= 0);
%     fid = fid(fid ~= 0);
% end

% PLOT ID
function[] = plotId(times, id)
    for i = 1:length(id)
        string = num2str(times(i));
        s = str2double(string(3:4));

        if(id(i) == 200)
            scatter(s, 9*(10^-4), [], "red");
        elseif(id(i) == 24)
            scatter(s, 8*(10^-4), [], "blue");
        elseif(id(i) == 25)
            scatter(s, 7*(10^-4), [], "green");
        end
    end
end

% GET TIME
function[times] = getTimes(startIndex, endIndex, data)
    dateTime = string(data(startIndex:endIndex, 1));
    for i = 1:(endIndex-startIndex+1)
        time = dateTime{i};
        time = time(12:19);
    
        %h = time(1:2);          % Hour
        minute = time(4:5);      % Minute
        second = time(7:8);      % Seconds
        
%         m = str2double(minute);
%         s = str2double(second);
        
        % Compensate for +48s lag between the hydrophone and TBR700RT
%         if((s-48) <= 0)
%             m = m - 1;
%             s = s + 12;
%         else
%             s = s - 48;
%         end
% 
%         m_str = string(m);
%         s_str = string(s);

        t = strcat(minute,second);
        
        times(i) = str2double(t);
    end
end

function[id] = getId(startIndex, endIndex, data)
    id = string(data(startIndex:endIndex, 3));
    id = str2double(id);
end


% ---------- DEMODULATION OF DATA -----------------------------------------

% % Code-Type 256 = 360ms difference (+-1ms)
% ct_min = int32(0.351*Fs);
% ct_max = int32(0.361*Fs);
% 
% % Peak threshold
% ymax = 2*10^-4;
% 
% % Sampling interval
% t0 = 10;
% t1 = 15;
% x0 = int32(t0*Fs);
% x1 = int32(t1*Fs);
% 
% x_start = 0;
% ct_done = 0;
% ct_time = 0;
% 
% for x = x0:1:x1
%     if(ct_done == 0)
%         % Check for pulse
%         if(y69(x) > ymax)
%             % Check if it is the first pulse
%             if(x_start == 0)
%                 x_start = x;
%             end
%             % Check for Code-Type match
%             x_delta = x - x_start;
%             if(x_delta >= ct_min && x_delta <= ct_max)
%                 ct_time = double(x_delta) / Fs;
%                 ct_done = x;
%             end
%         end
%     else
%         break; % exit loop
%     end
% end
% 
% ct_done
% ct_time
% 
% gt_done = 0;
% gt_time = 0;
% x_start = 0;
% ct_done = ct_done+25600;





