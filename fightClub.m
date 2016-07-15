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

function survivors = fightClub(parents, parentsPerformance, children, nTops, costFunction)

    % Prepare the population merging the children with parents.
    population = [parents; children];
    childrenPerformance = performanceEvaluation(children, costFunction);
    populationPerformance = [parentsPerformance; childrenPerformance];

    % Get the best individuals to ensure that they stay for the next generation.
    [topPopuPerf, topPopuPos] = getBestNElements(populationPerformance, nTops);
    popuToFight = population;
    popuToFight(topPopuPos,:) = [];
    popuToFightPerf = populationPerformance;
    popuToFightPerf(topPopuPos) = [];

    % Its Time!!!
    winnersSize = size(parents, 1) - nTops;
    winners = tournament(popuToFight, popuToFightPerf, 2, winnersSize);

    survivors = [winners; population(topPopuPos,:)];
end
