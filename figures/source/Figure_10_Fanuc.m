% Figure_10_Fanuc.m — Collision Events Scatter Plot with Finer Markers (Fanuc study)

% Read the simulation results (one row per auction cycle)
T = readtable('HRC_Simulation_Results_Fanuc.csv');

% Identify unique episodes and cycles
episodes = unique(T.Episode);
cycles   = unique(T.Cycle);

% Preallocate a logical matrix of collision flags
numE = numel(episodes);
numC = numel(cycles);
M = false(numE, numC);

% Populate the matrix
for i = 1:height(T)
    epIdx = T.Episode(i);
    cIdx  = T.Cycle(i);
    if T.CollisionFlag(i)
        M(epIdx, cIdx) = true;
    end
end

% Find all collision coordinates
[rowIdx, colIdx] = find(M);

% Create the scatter‐style plot with smaller markers
figure('Name','Figure 10: Collision Events Scatter','Position',[100 100 800 500]);
scatter(colIdx, rowIdx, 8, 'k', 'filled');   % marker size 8, black
title('Collision Events Across Auction Cycles', ...
    'FontName','Palatino Linotype','FontSize',15);
xlabel('Auction Cycle', 'FontName','Palatino Linotype','FontSize',13);
ylabel('Episode',      'FontName','Palatino Linotype','FontSize',13);
set(gca, 'FontName','Palatino Linotype','FontSize',13);

% Adjust axes limits and grid
xlim([min(cycles), max(cycles)]);
ylim([min(episodes), max(episodes)]);
grid minor;
ax = gca;
ax.GridAlpha      = 0.2;
ax.MinorGridAlpha = 0.1;

% Save the figure as PNG
saveas(gcf,'Figure_10_Collision_Scatter_Fanuc_Fine.png');
