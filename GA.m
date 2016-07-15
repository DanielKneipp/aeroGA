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

function [bestSol, solHist] = GA(populationSize, costFunction, nMaxIters)
%GA Genetic Algorithm using real encoding, penalization method,
% polarized crossing, non uniform mutation and tournament selection

nDecisionVars = 3; % Cl, Clmax, Cp
initialPopulation = genRandVals(populationSize, nDecisionVars, getParams(0,1)', getParams(0,2)');
nIters = 1;
solHist = [];
bestSol = [];

population = initialPopulation;
while nIters <= nMaxIters
    % Fitness evaluation
    populationalPerformance = performanceEvaluation(population, costFunction);

    % Selection
    selectedPopulation = tournament(population, populationalPerformance, 2, size(population, 1));
    SelectedPopulationalPerformance = performanceEvaluation(selectedPopulation, costFunction);

    % Crossing
    children = polarizedCrossing(selectedPopulation, SelectedPopulationalPerformance);

    % Mutation
    mutatedChildren = nonUniformMutation(children, nIters, nMaxIters);

    % Selection of the individuals within parents and children to continue to the next generation.
    newPopulation = fightClub(selectedPopulation, SelectedPopulationalPerformance, mutatedChildren, 4, costFunction);
    population = newPopulation;

    bestSol = getBestSol(population, costFunction);
    solHist = [solHist; bestSol];
    nIters = nIters + 1;
end

end

function [bestSol, bestSolPos] = getBestSol(solutions, costFunction)
    solutionsPerf = performanceEvaluation(solutions, costFunction);
    [val, bestSolPos] = min(solutionsPerf);
    bestSol = solutions(bestSolPos,:);
end
