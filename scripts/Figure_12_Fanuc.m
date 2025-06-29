% Figure_12_Fanuc.m — Sensitivity Curves (Fanuc study)

% Read sensitivity analysis results
S = readtable('Sensitivity_Results_Fanuc.csv');

% Identify unique parameter names
params = unique(S.Parameter);

% Prepare display names for legend, capitalizing only specific entries
displayParams = params;
for i = 1:numel(params)
    switch params{i}
        case 'auctionFrequency'
            displayParams{i} = 'Auction Frequency';
        case 'fatigueRate'
            displayParams{i} = 'Fatigue Rate';
        % leave other names unchanged
    end
end

% Create figure with three vertically stacked tiles
figure('Name','Figure 12: Sensitivity','Position',[100 100 800 900]);
tiledlayout(3,1,'TileSpacing','compact');

%% Throughput sensitivity
nexttile;
hold on;
for p = 1:numel(params)
    sel = strcmp(S.Parameter, params{p});
    plot(S.Value(sel), S.Throughput(sel), 'LineWidth',1.5);
end
hold off;
title('Sensitivity: Throughput', ...
    'FontName','Palatino Linotype','FontSize',15);
xlabel('Parameter Value', 'FontName','Palatino Linotype','FontSize',13);
ylabel('Active Auction Cycles·min^{-1}', 'FontName','Palatino Linotype','FontSize',13);
set(gca, 'FontName','Palatino Linotype','FontSize',13);
legend(displayParams, 'FontName','Palatino Linotype','FontSize',12,'Location','best');
grid minor;

%% Fatigue sensitivity
nexttile;
hold on;
for p = 1:numel(params)
    sel = strcmp(S.Parameter, params{p});
    plot(S.Value(sel), S.Workload(sel), 'LineWidth',1.5);
end
hold off;
title('Sensitivity: Average Fatigue per Cycle', ...
    'FontName','Palatino Linotype','FontSize',15);
xlabel('Parameter Value', 'FontName','Palatino Linotype','FontSize',13);
ylabel('Units·cycle^{-1}', 'FontName','Palatino Linotype','FontSize',13);
set(gca, 'FontName','Palatino Linotype','FontSize',13);
legend(displayParams, 'FontName','Palatino Linotype','FontSize',12,'Location','best');
grid minor;

%% Safety sensitivity
nexttile;
hold on;
for p = 1:numel(params)
    sel = strcmp(S.Parameter, params{p});
    plot(S.Value(sel), S.Safety(sel) * 100, 'LineWidth',1.5);
end
hold off;
title('Sensitivity: Safety Rate', ...
    'FontName','Palatino Linotype','FontSize',15);
xlabel('Parameter Value', 'FontName','Palatino Linotype','FontSize',13);
ylabel('Safety (%)', 'FontName','Palatino Linotype','FontSize',13);
set(gca, 'FontName','Palatino Linotype','FontSize',13);
legend(displayParams, 'FontName','Palatino Linotype','FontSize',12,'Location','best');
grid minor;

% Save the figure as PNG
saveas(gcf, 'Figure_12_Sensitivity_Fanuc.png');
