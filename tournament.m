% -----------------------------------------------------------------------------------
% AeroGA: Genetic Algorithm used to optimize the shape of small-scale airplane wings
% Copyright (C) 2016  Daniel Kneipp de Sá Veira
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

function selectedPopulation = tournament(population, populationPerformance, T, selPopulationSize)
    populationSize = size(population);
    selectedPopulation = zeros(selPopulationSize, populationSize(2));
    ring = zeros(T, 1);

    % Number of tournaments is equal of the population size.
    for i = 1:selPopulationSize
        ring(1) = getRandomPos(populationSize(1));
        best = ring(1);
        for j = 2:T
            ring(j) = getRandomPos(populationSize(1));
            % Minimization
            if populationPerformance(ring(j)) < populationPerformance(best)
                best = ring(j);
            end
        end
        selectedPopulation(i,:) = population(best,:);
    end
end
