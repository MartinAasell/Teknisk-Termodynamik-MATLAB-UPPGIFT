function Q_out = heat_loss_function(T_data_outside, T_inside)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Martin Åsell 2022-02-10
% Function to calculate the heat loss in the house
% ABOUT: The heat loss of the house can be calculated using the following
% formula,
% 
%   heat_loss = CONSTANT * dT, where dT = (T_inside - T_outside)
%
% Where the CONSTANT is given in the assignment.
%
%
% INPUTS:
%   T_data_out: - The outside temperature (given in the dataset)
%   T_in_       - The inside temperature (ASSUME CONSTANT)
% 
% OUTPUTS:
%   heat_loss: - The heat loss of the house
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

heat_loss_const = 2e6; %[MJ/h] Given constant mentioned above
dT = T_inside - T_data_outside; % Change between inside and outside temperature

Q_out = dT*heat_loss_const/3600; % /3600 to get [W]
end