ctd1 = load("CTD/CTD1.mat");
ctd2 = load("CTD/CTD2.mat");
ctd3 = load("CTD/CTD3.mat");
ctd4 = load("CTD/CTD4.mat");
ctd5 = load("CTD/CTD5.mat");
ctd6 = load("CTD/CTD6.mat");
ctd7 = load("CTD/CTD7.mat");
ctd8 = load("CTD/CTD8.mat");
ctd9 = load("CTD/CTD9.mat");

ctd = [ctd1, ctd2, ctd3, ctd4, ctd5, ctd6, ctd7, ctd8, ctd9];

Z1 = ctd(1).Depth;
Z2 = ctd(2).Depth;
Z3 = ctd(3).Depth;
Z4 = ctd(4).Depth;
Z5 = ctd(5).Depth;
Z6 = ctd(6).Depth;
Z7 = ctd(7).Depth;
Z8 = ctd(8).Depth;
Z9 = ctd(9).Depth;

T1 = ctd(1).Temperature;
T2 = ctd(2).Temperature;
T3 = ctd(3).Temperature;
T4 = ctd(4).Temperature;
T5 = ctd(5).Temperature;
T6 = ctd(6).Temperature;
T7 = ctd(7).Temperature;
T8 = ctd(8).Temperature;
T9 = ctd(9).Temperature;

Z = {Z1, Z2, Z3, Z4, Z5, Z6, Z7, Z8, Z9};
T = {T1, T2, T3, T4, T5, T6, T7, T8, T9};

X = [];
Y = [];

for i = 1:9
    X(i) = ctd(i).LongitudeStart;
    Y(i) = ctd(i).LatitudeStart;
    length(ctd(i).Depth)
end

figure(1);
scatter3(X,Y,Z1(1:10));









