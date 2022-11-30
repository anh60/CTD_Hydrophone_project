% *Andreas Hølleland
% *2022

data = readcell("../Data/TBR700/TagDetFiltered.csv");

% Data only available for 6/8 tests (5m to 705m)
mStart = 37;
mEnd = 83;
% Measurement 1 [5m  , 14m ] [13:12, 13:15]
Start1 = 37;
End1 = 56;
% Measurement 2 [101m, 109m] [13:17, 13:20]
Start2 = 57;
End2 = 65;
% Measurement 3 [206m, 205m] [13:22, 13:26]
Start3 = 66;
End3 = 71;
% Measurement 4 [314m, 322m] [13:28, 13:32]
Start4 = 72;
End4 = 78;
% Measurement 5 [499m, 496m] [13:34, 13:38]
Start5 = 79;
End5 = 81;
% Measurement 6 [705m, 703m] [13:41, 13:45]
Start6 = 82;
End6 = 83;

% Get time from all experiments
[times] = getTimes(mStart, mEnd, data);
% [times1] = getTimes(Start1, End1, data);
% [times2] = getTimes(Start2, End2, data);
% [times3] = getTimes(Start3, End3, data);
% [times4] = getTimes(Start4, End4, data);
% [times5] = getTimes(Start5, End5, data);
% [times6] = getTimes(Start6, End6, data);

% Get id from all experiments
[ids] = getId(mStart, mEnd, data);
% [id1] = getId(Start1, End1, data);
% [id2] = getId(Start2, End2, data);
% [id3] = getId(Start3, End3, data);
% [id4] = getId(Start4, End4, data);
% [id5] = getId(Start5, End5, data);
% [id6] = getId(Start6, End6, data);

% figure(1)
% hold on
% plotId(times1, id1);
% plotId(times2, id2);
% plotId(times3, id3);
% plotId(times4, id4);
% plotId(times5, id5);
% plotId(times6, id6);
% hold off
% axis padded
% title("ID / Time")

figure(1)
getData(times, ids, mStart, mEnd);

% Match measurements with hydrophone sampling frequency
function[] = getData(times, id, startTime, endTime)
    [ftime, fid] = filterTime(times, id, startTime, endTime);
    for i = 1:length(ftime)
        string = num2str(ftime(i));
        min = string(1:2);
        sec = string(3:4);
        ftime(i) = strcat(min,sec);
    end
    figure(1)
    hold on
    plotId(ftime, fid)
    hold off
    axis padded
end

% Filter lists to get measurements within a specific timeframe
function[ft, fd] = filterTime(times, id, startTime, endTime)
    ftimes = [];
    fid = [];
    for i = 1:length(times)
        if(times(i) > startTime && times(i) < endTime)
            ftimes(i) = times(i);
            fid(i) = id(i);
        end
    end
    ft = ftimes(ftimes ~= 0);
    fd = fid(fid ~= 0);
end

% PLOT ID
function[] = plotId(times, id)
    for i = 1:length(id)
        if(id(i) == 200)
            scatter(times(i), 1, [], "red");
        elseif(id(i) == 24)
            scatter(times(i), 1, [], "blue");
        elseif(id(i) == 25)
            scatter(times(i), 1, [], "green");
        end
    end
end

% GET TIME
function[times] = getTimes(startIndex, endIndex, data)
    dateTime = string(data(startIndex:endIndex, 1));
    for i = 1:(endIndex-startIndex+1)
        time = dateTime{i};
        time = time(12:19);

        h = time(1:2);      % Hour
        m = time(4:5);      % Minute
        s = time(7:8);      % Seconds
        t = strcat(m,s);    % [MinuteSeconds]
        
        times(i) = str2double(t);
    end
end

function[id] = getId(startIndex, endIndex, data)
    id = string(data(startIndex:endIndex, 3));
    id = str2double(id);
end


