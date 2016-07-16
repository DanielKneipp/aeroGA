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

OUTPUT_FILE_NAME = 'result';

N_MAX_ITERS = 200;
N_INDIVIDUALS = 80;
N_REPETITIONS = 100;

fprintf('\n\n======================     AeroGA     ======================\n\n')

solHistFromRepetitions = [];
solHistCostFromRepetitions = [];

initialTime = tic();
for i = 1:N_REPETITIONS
    tic();
    [sol, solHist] = GA(N_INDIVIDUALS, @costFunc, N_MAX_ITERS);

    solHistFromRepetitions = [solHistFromRepetitions; sol];
    solHistCostFromRepetitions = [solHistCostFromRepetitions; performanceEvaluation(sol, @costFunc)];

    fprintf('\nRepetition %d done!', i);
    fprintf('\nSolution: ');
    printSol(sol);
    fprintf('\nCost of the solution: %f\n', performanceEvaluation(sol, @costFunc));

    toc();
end
executionTime = toc(initialTime);

[bestSolCost, bestSolIndex] = min(solHistCostFromRepetitions);
bestSol = solHistFromRepetitions(bestSolIndex, :);

save(OUTPUT_FILE_NAME, 'solHistFromRepetitions', 'solHistCostFromRepetitions', 'bestSol', 'bestSolCost');

fprintf('\n\nBest Solution: ');
printSol(bestSol);
fprintf('\nCost of best solution: %f', bestSolCost);
fprintf('\nObtained on iteration %d', bestSolIndex);
fprintf('\nExecution time: %f seconds\n\n', executionTime);

plotSols('Repetition Number', 'Solution Cost', 'Genetic Algorithm Performance', ...
         solHistCostFromRepetitions);

fprintf('\n\n');
