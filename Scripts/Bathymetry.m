data = importdata("../Data/Bathymetry/Depth_data.txt");
data = struct2cell(data);
data = data{1};

x = [];
y = [];
z = [];

data

for i = 1:length(data)
    y(i) = data(i,1);
    x(i) = data(i,2);
    z(i) = data(i,3);
end

