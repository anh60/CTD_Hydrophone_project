ctd1 = load("../CTD/CTD1.mat");
ctd2 = load("../CTD/CTD2.mat");
ctd3 = load("../CTD/CTD3.mat");
ctd4 = load("../CTD/CTD4.mat");
ctd5 = load("../CTD/CTD5.mat");
ctd6 = load("../CTD/CTD6.mat");
ctd7 = load("../CTD/CTD7.mat");
ctd8 = load("../CTD/CTD8.mat");
ctd9 = load("../CTD/CTD9.mat");


plotSV(ctd2);


% Sound velocity approximation
function [C1, C2, C3] = calculate_SV(T, S, Z)
    % Calder, MacPhee
    C1 = 1449.2 + 4.6*T - 0.055*T^2 + 0.0029*T^3 ... 
        + (1.34-0.010*T)*(S-35) + 0.016*Z;

    % Mackenzie
    C2 = 1448.96 + 4.591*T - 5.304*(10^-2)*T^2 ... 
        + 2.374*(10^-4)*T^3 + 1.340*(S - 35) ... 
        + 1.630*(10^-2)*Z + 1.675*(10^-7)*Z^2 ...
        - 1.025*(10^-2)*T*(S-35) - 7.139*(10^-13)*T*Z^3;
    
    % Leroy's empirical formula
    C3 = 1492.9 + 3*(T-10) - (6*10^-3)*(T-10)^2 - (4*10^-2)*(T-18)^2 ...
        + 1.2*(S-35) - (10^-2)*(T-18)*(S-35) + Z/61;
end

% Get all sound velocity approximatons
function [C1, C2, C3] = getSV(T, S, Z)
    for i = 1:length(T)
    [C1(i), C2(i), C3(i)] = calculate_SV(T(i), S(i), Z(i));
    end
end

% Plot all sound velocity approximations
function [] = plotSV(ctd)
    SV = ctd.Sound_velocity;
    T = ctd.Temperature;
    S = ctd.Salinity;
    Z = ctd.Depth;
    
    [C1, C2, C3] = getSV(T, S, Z);
   
    % CTD sound velocity
    figure(1)
    plot(SV, Z)
    title('Sound Velocity / Depth')
    set(gca, 'YDir', 'reverse');
    
    hold on
    % Calder, MacPhee sound velocity
    plot(C1, Z)
    % Mackenzie sound velocity
    plot(C2, Z)
    % Leroy's empirical formula
    plot(C3, Z)
    hold off

    legend('CTD', 'Calder', 'Mackenzie', 'Leroy')
end