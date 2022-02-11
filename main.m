%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Martin Åsell 2022-01-10
% About:
%   Script to solve the problems in the course "Teknisk Termodynamik"
%   The script relies on several functions (5) to solve all of the problems.
%   As is now you don't have to change anything, just make sure you have
%   the functions in the same directory and run 'main.m' (this file).
%   The script is also divided into different sections to easier run just
%   one part of the script (select which section and press CTRL+ENTER).
% 
%   In addition you need to have the datasets (found in the course
%   homepage)
%   Uppsala_stralning_2008_2018.txt
%   Uppsala_temperaturer_2008_2018.txt
%   In the same directory as all the files
% 
% Functions:
%   - heat_loss_function
%   - avg_heat_loss_function
%   - COP_function
%   - avg_COP_function
%   - avg_solar
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 0, importing data and seting constants
clear; close;
temp_data = importdata('Uppsala_temperaturer_2008_2018.txt');
solar_data = importdata('Uppsala_stralning_2008_2018.txt');

inside_temp = 21;                   %degrees [C]
T_L = 10;                           %degrees [C]
outside_temp = temp_data.data(:,4); %degrees [C]

%% Part 1.1, calculate heat_loss, COP, and Energy consumption.
heat_loss = heat_loss_function(outside_temp, inside_temp);  % heat loss [kW]
COP = COP_function(10, outside_temp);                       % COP-values
House_energy_consumation = heat_loss ./ COP;                % Energy_consumption

%% Part 1.2 Plot the averages of the caluculated quantaies calculated above.
%% Ploting the average heat loss of the house each month
figure(1)
hold on
for i=1:12
    h = bar(i,avg_heat_loss_function(temp_data, inside_temp,i,'month')/1000);
    set(h,'Facecolor','b');
end
title('Average heat loss of the house per month')
ylabel('Heat loss [kW]');
xlabel('Month');
hold off
%% Plotting the average COP of the heat pump each month
figure(2)
hold on
for i=1:12
    h = bar(i, avg_COP_function(temp_data, T_L, i, 'month'));
    set(h,'Facecolor','b');
end
title('Average COP-value for the heat pump');
ylabel('COP');
xlabel('month');
hold off
%% Plotting the average energy consumption per month
figure(3)
hold on
for i=1:12
    h = bar(i,(avg_heat_loss_function(temp_data, inside_temp,i,'month')/1000)/...
    (avg_COP_function(temp_data, T_L, i, 'month')));
    set(h,'Facecolor','b');
end
title('Average Energy Consumption Per Month');
ylabel('Energy Consumption [kW]');
xlabel('Month');

%% PART 2 - Calculating the yearly enegry consumption [kWh] and ploting
figure(4)
hold on 
for i=2008:2017
    Q_out = avg_heat_loss_function(temp_data, inside_temp,i,'year') / 1000;
    avg_COP = avg_COP_function(temp_data, T_L, i, 'year');
    TOT = Q_out / (avg_COP) *24;
    h = bar(i, TOT);
    set(h,'Facecolor','b');
end
title('Average yearly energy consumption');
ylabel('kWh')
xlabel('year')

%% PART 3  - Calculating daily energy consumption with solar panels
%% PART 3.1 - Ploting the amount of energy the solar panels contributed to.
figure(5)
hold on
for i=2008:2017
    Q_out = avg_heat_loss_function(temp_data, inside_temp, i, 'year');
    Q_sun = avg_solar(solar_data, i);
    h = bar(i, (Q_out-Q_sun)/(avg_COP_function(temp_data,T_L,i,'year')*365));
    set(h, 'Facecolor', 'b');
end
title('Average energy saved per year with solar panels');
xlabel('Year');
ylabel('kWh');

%% PART 3.2 - Ploting the percentage the solarpanels contibuted with

figure(6)
hold on
for i=2008:2017
    Yearly_consumption = avg_heat_loss_function(temp_data, inside_temp, i, 'year');
    Yearly_solar = avg_solar(solar_data,i);
    percent = Yearly_solar / Yearly_consumption;
    h = bar(i, percent*100);
    set(h,'Facecolor','b');
end
title('Percentage of yearly energy consuption deliverrd by solar panels');
ylabel('Percent %');
xlabel('Year');