function COP_avg = avg_COP_function(T_data, T_L, no, varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Martin Åsell
% ABOUT:
%    Calculating the average heat loss per month or year.
%
% INPUTS:
%   T_data --- Temperature data (given, NOTE: type==struct)
%   T_L  ----- Temperature of the resouvare (assume constant 10 degrees C)
%   no ------- Which month/year
%   varargin - 'month' or 'year'
%
% OUTPUTS:
%   COP_avg -- average COP value per month or year   
%
% NOTE:
%   when calling the function, varargin needs to be a string of 'month' or
%   'year'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    COP_ = 0;
    switch lower(varargin{1})
        case 'month'
            number_of_days = 0;
            for i=1:length(T_data.data(:,1))
                if T_data.data(i,2) == no
                    if COP_function(T_L, T_data.data(i,4)) ~= 0
                        COP_ = COP_ + COP_function(T_L,T_data.data(i,4));
                        number_of_days = number_of_days + 1;
                    end
                end
            end
        COP_avg = COP_ / number_of_days;
        case 'year'
            for i=1:length(T_data.data(:,1))
                if T_data.data(i,1) == no && COP_function(T_L, T_data.data(i,4)) ~= 0
                    COP_ = COP_ + COP_function(T_L,T_data.data(i,4));
                end
            end
        COP_avg = COP_ /365;
    end
end
