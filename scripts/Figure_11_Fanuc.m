
% Figure_11_Fanuc.m
% 1) Generate task‐level dataset 
% 2) Aggregate per‐episode metrics 
% 3) Plot Figure 11 boxplots with minor grid (revised)

%% 1) Task‐level dataset generation
numEpisodes        = 1000;
cyclesPerEpisode   = 2500;
avgTaskTimeMu      = 10;      % mean robot task time (s)
avgTaskTimeSigma   = 2;       % robot task time std (s)
fatigueRate        = 5e-3;    % fatigue units per second
collisionProb      = 0.0015;  % 0.15% chance per task

rng(12345,'twister');

taskRecords = table([],[],[],[], ...
    'VariableNames',{'Episode','TaskTime','FatigueIncrement','CollisionFlag'});

for ep = 1:numEpisodes
    numTasks     = round(cyclesPerEpisode * 0.6 * 0.1 / avgTaskTimeMu);
    taskTime      = max(0, normrnd(avgTaskTimeMu, avgTaskTimeSigma, numTasks,1));
    fatigueInc    = fatigueRate * taskTime;
    collisionFlag = rand(numTasks,1) < collisionProb;

    Ep = repmat(ep,numTasks,1);
    T  = table(Ep, taskTime, fatigueInc, collisionFlag, ...
        'VariableNames',{'Episode','TaskTime','FatigueIncrement','CollisionFlag'});
    taskRecords = [taskRecords; T]; %#ok<AGROW>
end
writetable(taskRecords,'HRC_TaskLevel_Results_Fanuc.csv');

%% 2) Aggregate metrics per episode
episodes   = unique(taskRecords.Episode);
nEpisodes  = numel(episodes);
throughput = zeros(nEpisodes,1);
workload   = zeros(nEpisodes,1);
safetyRate = zeros(nEpisodes,1);

for i = 1:nEpisodes
    sub = taskRecords(taskRecords.Episode==episodes(i),:);
    totalTimeMin  = sum(sub.TaskTime)/60;
    throughput(i) = height(sub)/totalTimeMin;
    workload(i)   = sum(sub.FatigueIncrement);
    safetyRate(i) = sum(sub.CollisionFlag==0)/height(sub);
end

Agg = table(episodes,throughput,workload,safetyRate, ...
    'VariableNames',{'Episode','Throughput','Workload','Safety'});
writetable(Agg,'HRC_Aggregated_Fanuc.csv');

%% 3) Plot Figure 11
figure('Name','Figure 11: Boxplots (Fanuc)','Position',[100 100 900 520],'Color','w');
tl = tiledlayout(1,2,'TileSpacing','compact','Padding','compact');

% --- Throughput boxplot ---
ax1 = nexttile;
boxplot(ax1,Agg.Throughput);
title(ax1,'Throughput Distribution','FontName','Palatino Linotype','FontSize',15);
ylabel(ax1,'Tasks·min^{-1}','FontName','Palatino Linotype','FontSize',13);
set(ax1,'XTick',1,'XTickLabel',{'Episodes (n=1000)'}, ...
    'FontName','Palatino Linotype','FontSize',13);
grid(ax1,'minor'); ax1.GridAlpha=0.3; ax1.MinorGridAlpha=0.1;
hold(ax1,'on');
hMean1 = plot(ax1,1,mean(Agg.Throughput),'d','MarkerFaceColor',[1 0.5 0],'MarkerEdgeColor',[1 0.3 0],'MarkerSize',7);
hBox1  = findobj(ax1,'Tag','Box'); % box patch para la leyenda

% --- Fatigue boxplot ---
ax2 = nexttile;
boxplot(ax2,Agg.Workload);
title(ax2,'Fatigue Distribution','FontName','Palatino Linotype','FontSize',15);
ylabel(ax2,'Cumulative Fatigue (units)','FontName','Palatino Linotype','FontSize',13);
set(ax2,'XTick',1,'XTickLabel',{'Episodes (n=1000)'}, ...
    'FontName','Palatino Linotype','FontSize',13);
grid(ax2,'minor'); ax2.GridAlpha=0.3; ax2.MinorGridAlpha=0.1;
hold(ax2,'on');
plot(ax2,1,mean(Agg.Workload),'d','MarkerFaceColor',[1 0.5 0],'MarkerEdgeColor',[1 0.3 0],'MarkerSize',7);

% Single legend
lgd = legend(ax1,[hBox1(1) hMean1],{'Median & IQR (boxplot)','Mean (orange diamond)'}, ...
    'Orientation','horizontal','FontName','Palatino Linotype','FontSize',11);
lgd.Layout.Tile = 'south';
