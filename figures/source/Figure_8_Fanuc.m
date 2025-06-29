% Figure_8_Fanuc.m — Fatigue Accumulation Curves with Emphasized Trend (Fanuc study)

% Read the simulation results (one row per auction cycle)
T = readtable('HRC_Simulation_Results_Fanuc.csv');

% Group by Cycle and compute mean Fatigue for each cycle
grp = varfun(@mean, T, ...
    'InputVariables', 'Fatigue', ...
    'GroupingVariables', 'Cycle');

% Extract cycle numbers and mean fatigue
cycles      = grp.Cycle;
meanFatigue = grp.mean_Fatigue;

% Compute a 100-cycle moving average for trend visualization
movAvgWindow = 100;
fatigueTrend = movmean(meanFatigue, movAvgWindow);

% Plot the fatigue curve and trend line
figure('Name','Figure 8: Fatigue Accumulation with Emphasized Trend (Fanuc)','Position',[100 100 800 500]);

% Raw fatigue line (thinner, lighter)
hRaw = plot(cycles, meanFatigue, 'LineWidth', 1, 'Color', [0 0.4470 0.7410]);
hold on;

% Trend line (thicker, vivid)
hTrend = plot(cycles, fatigueTrend, 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980]);
hold off;

% Format axes and labels
title('Fatigue Accumulation Over Auction Cycles', ...
    'FontName','Palatino Linotype','FontSize',15);
xlabel('Auction Cycle', 'FontName','Palatino Linotype','FontSize',13);
ylabel('Mean Fatigue (units)', 'FontName','Palatino Linotype','FontSize',13);

ax = gca;
ax.FontName = 'Palatino Linotype';
ax.FontSize = 13;

% Use minor grid for subtle background
grid minor;
ax.GridAlpha = 0.2;    % lighten grid lines
ax.MinorGridAlpha = 0.1;

% Add legend
legend([hRaw, hTrend], {'Raw Mean Fatigue','100-Cycle Moving Average'}, ...
    'FontName','Palatino Linotype','FontSize',12, 'Location','best');

% Save the figure as PNG
saveas(gcf, 'Figure_8_Fatigue_Curves_EmphasizedTrend_Fanuc.png');