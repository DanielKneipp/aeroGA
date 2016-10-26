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

function mutatedPopulation = nonUniformMutation(population, t, tMax)
    nFeatures = size(getParams(0), 1);
    populationSize = size(population);
    mutatedPopulation = zeros(populationSize);

    v = 0.3 .* (getParams(0,2)' - getParams(0,1)') .* ...
        (1 - genRandVals(1, nFeatures, zeros(1, nFeatures), ones(1, nFeatures)).^((1 - t/tMax)^5));

    for i = 1:populationSize
        r = genRandVals(1, nFeatures, zeros(1, nFeatures), ones(1, nFeatures)) >= 0.5;
        r = r + (r - 1);

        mutatedPopulation(i,:) = population(i,:) + r .* v;
    end
end
