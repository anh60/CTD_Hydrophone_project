% *Andreas Hølleland
% *2022

ctd1 = load("../Data/CTD/CTD1.mat");
ctd2 = load("../Data/CTD/CTD2.mat");
ctd3 = load("../Data/CTD/CTD3.mat");
ctd4 = load("../Data/CTD/CTD4.mat");
ctd5 = load("../Data/CTD/CTD5.mat");
ctd6 = load("../Data/CTD/CTD6.mat");
ctd7 = load("../Data/CTD/CTD7.mat");
ctd8 = load("../Data/CTD/CTD8.mat");
ctd9 = load("../Data/CTD/CTD9.mat");

% Positions
ctd = [ctd1, ctd2, ctd3, ctd4, ctd5, ctd6, ctd7, ctd8, ctd9];

T = {}; % Temperature
Z = {}; % Depth
S = {}; % Salinity
V = {}; % Sound Velocity

% Get data
for i = 1:length(ctd)
    T{1, i} = ctd(i).Temperature;
    Z{1, i} = ctd(i).Depth;
    S{1, i} = ctd(i).Salinity;
    V{1, i} = ctd(i).Sound_velocity;
end

%plotSingle(ctd(1));
plotAll(T, Z, S, V)

% Plot a single position
function [] = plotSingle(ctd)
    figure(1);
    plot(ctd.Temperature, ctd.Depth);
    set(gca, 'YDir', 'reverse');
    title('Depth / Temperature');

    figure(2);
    plot(ctd.Salinity, ctd.Depth);
    set(gca, 'YDir', 'reverse');
    title('Depth / Salinity');

    figure(3);
    plot(ctd.Sound_velocity, ctd.Depth);
    set(gca, 'YDir', 'reverse');
    title('Depth / Sound Velocity');
end

% Plot all positions
function [] = plotAll(T, Z, S, V)
    figure(1);
    hold on
    for i = 1:length(Z)
        plot(T{1, i}, Z{1, i});
    end
    hold off
    set(gca, 'YDir', 'reverse');
    title('Depth / Temperature');
    legend('1', '2', '3', '4', '5', '6', '7', '8', '9');

    figure(2);
    hold on
    for i = 1:length(Z)
        plot(S{1, i}, Z{1, i});
    end
    hold off
    set(gca, 'YDir', 'reverse');
    title('Depth / Salinity');
    legend('1', '2', '3', '4', '5', '6', '7', '8', '9');

    figure(3);
    hold on
    for i = 1:length(Z)
        plot(V{1, i}, Z{1, i});
    end
    hold off
    title('Depth / Sound Velocity');
    set(gca, 'YDir', 'reverse');
    legend('1', '2', '3', '4', '5', '6', '7', '8', '9');
end
