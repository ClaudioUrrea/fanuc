% Figure_8_Fanuc_FromTaskLevel_Final.m 
% Reconstruct per-cycle fatigue curves from task-level CSV files
% and compute initial slopes for Auction vs. Baseline.

%% Parameters
auctionTaskFile   = 'HRC_TaskLevel_Results_Fanuc.csv';        % auction dataset (required)
baselineTaskFile  = 'HRC_TaskLevel_Results_Baseline.csv';     % baseline dataset
cyclesPerEpisode  = 2500;
cycleDuration     = 0.1;      % 100 ms per cycle
movAvgWindow      = 100;      % moving average window (cycles)
maxFitCycle       = 1000;     % cycles used for linear regression

%% Helper function
reconstructMeanFatigue = @(tbl) local_reconstruct(tbl, cyclesPerEpisode, cycleDuration);

%% Auction dataset
TAuction = readtable(auctionTaskFile);
[meanFatigueA, cyclesVec] = reconstructMeanFatigue(TAuction);
trendA = movmean(meanFatigueA, movAvgWindow);
idxFit = cyclesVec <= maxFitCycle;
pA = polyfit(cyclesVec(idxFit), meanFatigueA(idxFit), 1);
slopeA = pA(1);

%% Baseline dataset
TBase = readtable(baselineTaskFile);
[meanFatigueB, ~] = reconstructMeanFatigue(TBase);
trendB = movmean(meanFatigueB, movAvgWindow);
pB = polyfit(cyclesVec(idxFit), meanFatigueB(idxFit), 1);
slopeB = pB(1);
relDiff = (slopeB - slopeA)/slopeB * 100;  % % lower slope for Auction

%% Plot
figure('Name','Figure 8: Fatigue Accumulation','Position',[100 100 900 520],'Color','w');

% Raw curves
hRawA = plot(cyclesVec, meanFatigueA, 'LineWidth',1, 'Color',[0 0.4470 0.7410]); hold on;
hRawB = plot(cyclesVec, meanFatigueB, 'LineWidth',1, 'Color',[0.5 0.5 0.5]);

% Smoothed trends
hTrendA = plot(cyclesVec, trendA, 'LineWidth',2.5, 'Color',[0.8500 0.3250 0.0980]);
hTrendB = plot(cyclesVec, trendB, 'LineWidth',2.5, 'Color',[0.2 0.2 0.2]);

title('Fatigue Accumulation Over Auction Cycles','FontName','Palatino Linotype','FontSize',15);
xlabel('Auction Cycle','FontName','Palatino Linotype','FontSize',13);
ylabel('Mean Fatigue (units)','FontName','Palatino Linotype','FontSize',13);
ax = gca; ax.FontName='Palatino Linotype'; ax.FontSize=13;
grid minor; ax.GridAlpha=0.2; ax.MinorGridAlpha=0.1;

yMax = max([meanFatigueA; meanFatigueB]);
ylim([0, yMax + 0.05]);

% Legend (includes slope difference)
legTxtA = sprintf('Auction (slope = %.2e; %.1f%% lower)', slopeA, relDiff);
legTxtB = sprintf('Baseline (slope = %.2e)', slopeB);
legend([hTrendA, hTrendB, hRawA], ...
    {legTxtA, legTxtB, 'Raw Auction Fatigue'}, ...
    'FontName','Palatino Linotype','FontSize',11,'Location','northwest');

hold off;

saveas(gcf,'Figure_8_FatigueAccumulation.png');
saveas(gcf,'Figure_8_FatigueAccumulation.pdf');

%% Local function
function [meanFatigue, cyclesVec] = local_reconstruct(tbl, cyclesPerEpisode, cycleDuration)
    episodes = unique(tbl.Episode);
    nEpisodes = numel(episodes);
    fatigueByEpisode = zeros(cyclesPerEpisode, nEpisodes);
    for e = 1:nEpisodes
        sub = tbl(tbl.Episode==episodes(e),:);
        fatigue = 0; cyclePtr = 1;
        for i = 1:height(sub)
            numCyclesTask = max(1, round(sub.TaskTime(i)/cycleDuration));
            incPerCycle = sub.FatigueIncrement(i)/numCyclesTask;
            for c = 1:numCyclesTask
                if cyclePtr > cyclesPerEpisode, break; end
                fatigue = fatigue + incPerCycle;
                fatigueByEpisode(cyclePtr,e) = fatigue;
                cyclePtr = cyclePtr + 1;
            end
            if cyclePtr > cyclesPerEpisode, break; end
        end
        if cyclePtr <= cyclesPerEpisode
            fatigueByEpisode(cyclePtr:end,e) = fatigue;
        end
    end
    meanFatigue = mean(fatigueByEpisode,2);
    cyclesVec = (1:cyclesPerEpisode)';
end