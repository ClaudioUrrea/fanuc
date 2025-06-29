% Figure_11_Fanuc.m
% 1) Generate task‐level dataset 
% 2) Aggregate per‐episode metrics 
% 3) Plot Figure 11 boxplots with minor grid

%% 1) Task‐level dataset generation
numEpisodes        = 1000;
cyclesPerEpisode   = 2500;
avgTaskTimeMu      = 10;      % mean robot task time (s)
avgTaskTimeSigma   = 2;       % robot task time std (s)
fatigueRate        = 5e-3;    % fatigue units per second
collisionProb      = 0.0015;  % 0.15% chance per task

rng(12345, 'twister');

% Preallocate a table
taskRecords = table([],[],[],[], ...
    'VariableNames',{'Episode','TaskTime','FatigueIncrement','CollisionFlag'});

for ep = 1:numEpisodes
    % Estimate number of tasks per episode 
    % = (robotActive fraction * total time) / avgTaskTime
    % here robotActive fraction ~0.6, total time = cycles*0.1 s
    numTasks = round(cyclesPerEpisode * 0.6 * 0.1 / avgTaskTimeMu);

    % Sample actual task times and compute fatigue increments
    taskTime      = max(0, normrnd(avgTaskTimeMu, avgTaskTimeSigma, numTasks,1));
    fatigueInc    = fatigueRate * taskTime;
    collisionFlag = rand(numTasks,1) < collisionProb;

    Ep = repmat(ep, numTasks, 1);
    T = table(Ep, taskTime, fatigueInc, collisionFlag, ...
        'VariableNames',{'Episode','TaskTime','FatigueIncrement','CollisionFlag'});
    taskRecords = [taskRecords; T]; %#ok<AGROW>
end

% Optionally save the task‐level dataset
writetable(taskRecords, 'HRC_TaskLevel_Results_Fanuc.csv');

%% 2) Aggregate metrics per episode
episodes   = unique(taskRecords.Episode);
nEpisodes  = numel(episodes);
throughput = zeros(nEpisodes,1);
workload   = zeros(nEpisodes,1);
safetyRate = zeros(nEpisodes,1);

for i = 1:nEpisodes
    sub = taskRecords(taskRecords.Episode==episodes(i), :);

    % Throughput: tasks per minute
    totalTimeMin   = sum(sub.TaskTime)/60;
    throughput(i)  = height(sub) / totalTimeMin;

    % Workload: cumulative fatigue
    workload(i)    = sum(sub.FatigueIncrement);

    % Safety: fraction of tasks without collision
    safetyRate(i)  = sum(sub.CollisionFlag==0)/height(sub);
end

% Build aggregated table
Agg = table(episodes, throughput, workload, safetyRate, ...
    'VariableNames',{'Episode','Throughput','Workload','Safety'});
writetable(Agg, 'HRC_Aggregated_Fanuc.csv');

%% 3) Plot Figure 11: boxplots with minor grid
figure('Name','Figure 11: Boxplots (Fanuc)','Position',[100 100 900 500]);

% Throughput boxplot
subplot(1,2,1);
boxplot(Agg.Throughput);
title('Throughput Distribution by Episode',...
    'FontName','Palatino Linotype','FontSize',15);
ylabel('Tasks·min^{-1}','FontName','Palatino Linotype','FontSize',13);
set(gca,'FontName','Palatino Linotype','FontSize',13);
grid minor;
ax = gca;
ax.GridAlpha      = 0.3;
ax.MinorGridAlpha = 0.1;

% Workload boxplot
subplot(1,2,2);
boxplot(Agg.Workload);
title('Workload Distribution by Episode',...
    'FontName','Palatino Linotype','FontSize',15);
ylabel('Cumulative Fatigue (units)','FontName','Palatino Linotype','FontSize',13);
set(gca,'FontName','Palatino Linotype','FontSize',13);
grid minor;
ax = gca;
ax.GridAlpha      = 0.3;
ax.MinorGridAlpha = 0.1;

% Save the figure
saveas(gcf,'Figure_11_Boxplots_Fanuc_Unified.png');
