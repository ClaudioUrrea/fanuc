% Figure_9_Fanuc.m — Robot Utilization with Emphasized Trend (Fanuc study)

% Read the simulation results (one row per auction cycle)
T = readtable('HRC_Simulation_Results_Fanuc.csv');

% Create a logical indicator: 1 when the robot was active in that cycle
T.RobotActive = strcmp(string(T.Action), 'Robot');

% Group by cycle index and compute mean RobotActive for each cycle
grp = varfun(@mean, T, ...
    'InputVariables', 'RobotActive', ...
    'GroupingVariables', 'Cycle');

% Extract cycle numbers and convert mean activity to percentage
cycles     = grp.Cycle;
util       = grp.mean_RobotActive * 100;  

% Compute a 100-cycle moving average for trend visualization
movAvgWindow = 100;
utilTrend    = movmean(util, movAvgWindow);

% Plot the utilization curve and its trend
figure('Name','Figure 9: Robot Utilization with Trend (Fanuc)','Position',[100 100 800 500]);

% Raw utilization (thinner, lighter blue)
hRaw = plot(cycles, util, 'LineWidth', 1, 'Color', [0.2 0.6 0.9]);
hold on;

% Trend line (thicker, contrasting orange)
hTrend = plot(cycles, utilTrend, 'LineWidth', 2.5, 'Color', [0.85 0.33 0.10]);
hold off;

% Format title and axes
title('Robot Utilization Across Auction Cycles', ...
    'FontName','Palatino Linotype','FontSize',15);
xlabel('Auction Cycle', 'FontName','Palatino Linotype','FontSize',13);
ylabel('Utilization (%)', 'FontName','Palatino Linotype','FontSize',13);

ax = gca;
ax.FontName = 'Palatino Linotype';
ax.FontSize = 13;

% Use minor grid for subtle background, lighten grid lines
grid minor;
ax.GridAlpha       = 0.2;
ax.MinorGridAlpha  = 0.1;
ylim([0 100]);

% Add legend
legend([hRaw, hTrend], {'Raw Utilization','100-Cycle Moving Average'}, ...
    'FontName','Palatino Linotype','FontSize',12, 'Location','best');

% Save the figure as PNG
saveas(gcf, 'Figure_9_Robot_Utilization_EmphasizedTrend_Fanuc.png');