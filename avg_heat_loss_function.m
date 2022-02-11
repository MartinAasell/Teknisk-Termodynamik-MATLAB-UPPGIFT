function Q_out = avg_heat_loss_function(T_data, T_inside ,no, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Martin Åsell
% ABOUT:
%    Calculating the average heat loss per month or year.
%
% INPUTS:
%   T_data --- Temperature data (given, NOTE: type==struct)
%   T_inside - Temperature of the house (assume constant 21 degrees C)
%   no ------- Which month/year
%   varargin - 'month' or 'year'
%
% OUTPUTS:
%   Q_out ---- heat loss per month or year
%
% NOTE:
%   when calling the function, varargin needs to be a string of 'month' or
%   'year'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    heat_loss_const = 2e6; %[MJ/h] Given constant
    heat_loss = 0;
    number_of_days = 0;
    switch lower(varargin{1}) % swith/case for month or year
        case 'month'
            month = no;
            for i=1:length(T_data.data(:,1))
                if T_data.data(i,2) == month
                    dT = T_inside - T_data.data(i,4); % Change between inside and outside temperature
                    heat_loss = heat_loss + dT*heat_loss_const; 
                    number_of_days = number_of_days + 1;
                end
            end
            Q_out = (heat_loss / number_of_days) / 3600; 
            
        case 'year'
            year = no;
            for i=1:length(T_data.data(:,1))
                if T_data.data(i,1) == year
                    dT = T_inside - T_data.data(i,4); % Change between inside and outside temperature
                    heat_loss = heat_loss + dT*heat_loss_const;
                end
            end
            Q_out = (heat_loss) / 3600;     %[W]
    end
end

