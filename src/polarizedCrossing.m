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

function children = polarizedCrossing(population, populationPerformance)
    populationSize = size(population);
    children = zeros(populationSize);

    for i = 1:2:populationSize(1);
        cutPoint = getRandomPos(populationSize(2));
        parent1 = population(i,:);
        parent2 = population(i+1,:);
        child1 = zeros(size(parent1));
        child2 = zeros(size(parent2));
        alpha = 0.9;
        betha = 1 - alpha;

        if rand(1) >= 0.5
            startNormal = 1;
            finishNormal = cutPoint;
            startPolarized = cutPoint + 1;
            finishPolarized = populationSize(2);
        else
            startNormal = cutPoint + 1;
            finishNormal = populationSize(2);
            startPolarized = 1;
            finishPolarized = cutPoint;
        end

        child1(startNormal:finishNormal) = parent1(startNormal:finishNormal);
        child2(startNormal:finishNormal) = parent2(startNormal:finishNormal);

        % Minimization
        if populationPerformance(i) < populationPerformance(i+1)
            child1(startPolarized:finishPolarized) = alpha .* parent1(startPolarized:finishPolarized) + ...
                                                     betha .* parent2(startPolarized:finishPolarized);
        else
            child1(startPolarized:finishPolarized) = alpha .* parent2(startPolarized:finishPolarized) + ...
                                                     betha .* parent1(startPolarized:finishPolarized);
        end

        child2(startPolarized:finishPolarized) =  0.5 .* parent2(startPolarized:finishPolarized) + ...
                                                  0.5 .* parent1(startPolarized:finishPolarized);

        children(i,:) = child1;
        children(i + 1,:) = child2;
    end
end
