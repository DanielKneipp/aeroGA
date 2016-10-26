% -----------------------------------------------------------------------------------
% AeroGA: Genetic Algorithm used to optimize the shape of small-scale airplane wings
% Copyright (C) 2016  Daniel Kneipp de S� Veira
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/gpl-3.0.html>.
% -----------------------------------------------------------------------------------

function [params] = getParams(i, j)
    %    min   max
    T = [0.60, 0.80; % Cl
         1.40, 2.00; % Clmax
         3,    30];  % Cp
    %      min  max
    Dist = [69, 69.1];

    if strcmp(i, 'Dist')
        params = Dist;
    else
        if (i == 0)
            if (exist('j', 'var') && ~isempty(j))
                params = T(:,j);
            else
                params = T;
            end
        else
            if (exist('j', 'var') && ~isempty(j))
                params = T(i,j);
            else
                params= T(i,:);
            end
        end
    end
end
