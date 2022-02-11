function W_sun = avg_solar(solar_data,year)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Martin Åsell
% ABOUT:
%    Calculating the average heat loss per month or year.
%
% INPUTS:
%   solar_data - Solar data (given, NOTE: type==struct)
%   year ------- Which year
%
% OUTPUTS:
%   W_sun ------ energy from solar panels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    solar_E = 0;
    panel_efficency = 0.07;
    for i=1:length(solar_data.data(:,1))
        if solar_data.data(i,1) == year
            solar_E = solar_E + solar_data.data(i,4);
        end
    end
    W_sun = solar_E*100*panel_efficency; %[W]
end