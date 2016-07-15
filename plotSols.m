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

function plotSols(xlabel_, ylabel_, title_, sols, solsCost)
    figure();
    plot([1:size(sols, 1)]', solsCost, 'Linewidth', 2);
    title(title_);
    xlabel(xlabel_);
    ylabel(ylabel_);
end