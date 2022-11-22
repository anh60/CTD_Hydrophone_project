% *Andreas Hølleland
% *2022

data = readcell("../Data/TBR700/TagDetFiltered.csv");

% Data only available for 6/8 tests (5m to 705m)
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

[times1] = getTimes(Start1, End1, data);
[times2] = getTimes(Start2, End2, data);
[times3] = getTimes(Start3, End3, data);
[times4] = getTimes(Start4, End4, data);
[times5] = getTimes(Start5, End5, data);
[times6] = getTimes(Start6, End6, data);

[id1] = getId(Start1, End1, data);
[id2] = getId(Start2, End2, data);
[id3] = getId(Start3, End3, data);
[id4] = getId(Start4, End4, data);
[id5] = getId(Start5, End5, data);
[id6] = getId(Start6, End6, data);

figure(1)
hold on
%plotId(times1, id1);
plotId(times2, id2);
%plotId(times3, id3);
%plotId(times4, id4);
%plotId(times5, id5);
%plotId(times6, id6);
hold off
axis padded
title("ID / Time")

% PLOT ID
function[] = plotId(times, id)
    for i = 1:length(id)
        if(id(i) == 200)
            scatter(times(i), id(i), [], "red");
        elseif(id(i) == 24)
            scatter(times(i), id(i), [], "blue");
        elseif(id(i) == 25)
            scatter(times(i), id(i), [], "green");
        end
    end
end

% GET TIME
function[times] = getTimes(startIndex, endIndex, data)
    dateTime = string(data(startIndex:endIndex, 1));
    for i = 1:(endIndex-startIndex+1)
        time = dateTime{i};
        time = time(12:19);

        %h = time(1:2);
        %h = str2double(time(1:2)) + 4;

        m = time(4:5);
        s = time(7:8);
        t = strcat(m,s);
      
        %m = str2double(time(4:5));
        %s = str2double(time(7:8));
        
        times(i) = str2double(t);
    end
end

function[id] = getId(startIndex, endIndex, data)
    id = string(data(startIndex:endIndex, 3));
    id = str2double(id);
end


