% *Andreas Hølleland
% *2022

% data : (row, 1) = Latitude, (row, 2) = Longitude, (row, 3) = Depth
data = readmatrix("../Data/Bathymetry/Depth_data.txt");

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

latitude = [];
longitude = [];

for i = 1:length(ctd)
    latitude(i) = ctd(i).LatitudeStart;
    longitude(i) = ctd(i).LongitudeStart;
end

latitude
longitude

x = [];
y = [];
z = [];

for i = 1:length(data)
    y(i) = data(i, 1);
    x(i) = data(i, 2);
    z(i) = data(i, 3);
end

xlin = linspace(min(x), max(x));
ylin = linspace(min(y), max(y));

[X,Y] = meshgrid(xlin, ylin);

Z = griddata(x,y,z,X,Y);

f = figure(1)
s = surf(X,Y,Z)

f.CurrentAxes.ZDir = 'Reverse'

hold on
    for i = 1:length(ctd)
        plot3(longitude(i), latitude(i), 0, '.', 'MarkerSize', 30);
    end
    legend ('0', '1','2','3','4','5','6','7','8','9')
hold off

xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')



