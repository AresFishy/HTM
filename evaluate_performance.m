% function [LtoL_events, LtoR_events] = Lick_histogram(proj_meta, site, tp)

correct = [];
for site = 1:9
    cnt = 0;
    for tp = 2:2:14
        cnt = cnt+1;
        RewR = proj_meta(site).rd(1,tp).RewardR;
        RewL = proj_meta(site).rd(1,tp).RewardL;
        
        Tones = proj_meta(site).rd(1,tp).ToneID;
        
        toneL_onsets = find(diff(Tones) > 1 & diff(Tones) < 2)+1; % Correct tone for Left Lick is 1.5V
        toneR_onsets = find(diff(Tones) > 2)+1; % Correct tone for Right Lick is 3.5V
        
        RewL_onsets = find(diff(RewL) > 1)+1;
        RewR_onsets = find(diff(RewR) > 1)+1;
        
        correctL = [];
        try
            for ind = 1:length(toneL_onsets)
                toneL_bin = toneL_onsets(ind):toneL_onsets(ind)+35;
                
                correctL(ind) = max(ismember(RewL_onsets, toneL_bin));
            end
        end
        
        try
            correctR = [];
            for ind = 1:length(toneR_onsets)
                toneR_bin = toneR_onsets(ind):toneR_onsets(ind)+30;
                correctR(ind) = max(ismember(RewR_onsets, toneR_bin));
            end
        end
        
        correct(site, cnt) = mean([correctL, correctR]);
        if isempty(correctL) && isempty(correctR)
            correct(site, tp) = NaN;
        end
        %
        %         end
    end
end

figure; hold on;
plot(correct', 'color',[0.5 0.5 0.5]);
plot(nanmean(correct,1),'color','k','linewidth',2)
set(gca,'ytick',0:0.2:1)
ylabel('Fraction correct')
xlabel('Day')
title('Learning performance')



