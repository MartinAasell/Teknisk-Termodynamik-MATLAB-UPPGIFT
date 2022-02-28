function COP = COP_function(T_L, T_outside)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Martin Åsell 2022-02-10
% Function to calculate the heatpumps COP-value
% About:
%   Since we can assume the heat pump is a Carnot-heatpump and the ground
%   water is assumed to be constant T_L=10 degrees C. We can easily
%   calculate the COP-value according to,
%
%       COP = 1 / (1-T_L/T_H);
%
% Where T_L is the ground water temperature and T_H is the temperature in
% the house (assumed to be constant at 23 degreees C) which is equall to
% the radiators temperature, meaning T_H = T_radiator.
% The temperature of the radiator depends on the outside temperature by
%
%                   | 36.44 - 0,64*T_out,        T_out < -4C
%                   |          39,        -4C <= T_out <= 4C
%     T_radiator =  | 43.26 - 1.06*T_out   4C  < T_out <= 21C
%                   |       Shut off,      21  < T_out
%
% INPUTS: 
%         T_L: - The temperature of the ground water
%         T_H: - The temperature of the radiator
% OUTPUTS:
%         COP: - The COP-value of the heatpump.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initilize the radiators temperature to be 0. 
T_H = zeros(length(T_outside),1);
% For all data points calculate the temperature of the radiator
for i=1:length(T_H)
    if T_outside(i) < -4  
        T_H(i) = 36.44 - 0.64*T_outside(i);
    elseif (-4 <= T_outside(i)) && (T_outside(i) <= 4)
        T_H(i) = 39;
    elseif (4 < T_outside(i)) && (T_outside(i) <= 21)
        T_H(i) = 43.26 - 1.06*T_outside(i);
    elseif 21 < T_outside(i)
        T_H(i) = 0;
    end
end
% Calculate the COP-value for each day.
COP = 1 ./ (1-(T_L+273.15)./(T_H+273.15));
% COP = 1 ./ (1-T_L./T_H);

end
