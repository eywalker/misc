valid = [stim.params.trials.validTrial];
correct = [stim.params.trials.correctResponse];
conditions = [stim.params.trials.condition];
condA = find([stim.params.conditions.cueClass]==2);
ori = {stim.params.trials.trialDirection};

check=cellfun(@isempty, ori);
[ori{check}] = deal(NaN);
ori=[ori{:}];
valid(check) = 0;

expA = ismember(conditions, condA);
respA = (expA == correct);

color_levels = unique([stim.params.conditions.cueColor]);

N = length(color_levels);
figure;
for idx = 1:N
    color_val = color_levels(idx);
    
    cond_nums = find(abs([stim.params.conditions.cueColor] - color_val) < 0.001);
    trials = ismember(conditions, cond_nums);
    
    perc = sum(valid&correct&trials) / sum(valid&trials);
    
    fprintf('For %5.1f%% color, performed %3.1f%% correct over %d trials\n', color_val*100, perc*100, sum(valid&trials));
    
    binEdges = linspace(230,310,40);
    [mu_A,s_A,ct_A,binc] = nanBinnedStats(ori(valid&trials&expA), respA(valid&trials&expA), binEdges);
    
    subplot(3,N,idx);
    %plot(binc, mu_A, 'r');
    errorbar(binc, mu_A, s_A./sqrt(ct_A), 'r');
    title(sprintf('%5.1f%% Color: Class A(red) Trials ', color_val*100));
    if(idx==1)
        ylabel('Proportion A(red) response');
    end
    xlim([230, 310]);
    ylim([0,1]);
    
    binEdges = linspace(230,310,20);
    [mu_B,s_B,ct_B,binc] = nanBinnedStats(ori(valid&trials&~expA), respA(valid&trials&~expA), binEdges);
    
    subplot(3,N,idx+N);
    %plot(binc, mu_B, 'g');
    errorbar(binc, mu_B, s_B./sqrt(ct_B), 'g');
    title(sprintf('%5.1f%% Color: Class B Trials', color_val*100));
    if(idx==1)
        ylabel('Proportion A(red) response');
    end
    xlabel('Stimulus orientation (deg)');
    xlim([230, 310]);
    ylim([0,1]);
    
    
    binEdges = linspace(230,310,20);
    [mu,s,ct,binc] = nanBinnedStats(ori(valid&trials), respA(valid&trials), binEdges);
    
    subplot(3,N,idx+2*N);
    %plot(binc, mu, 'b');
    errorbar(binc, mu, s./sqrt(ct), 'b');
    title(sprintf('%5.1f%% Color: All Trials', color_val*100));
    if(idx==1)
        ylabel('Proportion A(red) response');
    end
    xlabel('Stimulus orientation (deg)');
    xlim([230, 310]);
    ylim([0,1]);
end
   
perc = sum(valid&correct) / sum(valid);
fprintf('Overall, performed %3.1f%% correct\n', perc*100);

%%

