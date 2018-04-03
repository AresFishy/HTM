perf = [];
win = 30:40;
for site = 1:9
    cnt = 0;
    
    for tp = 2:2:14
        cnt = cnt + 1;
        try
            [LtoL_events, LtoR_events] = Lick_histogram(proj_meta, site, tp);
            wrong_options = vertcat(squeeze(LtoL_events(2,:,win)), squeeze(LtoR_events(1,:,win)));
            right_options = vertcat(squeeze(LtoL_events(1,:,win)), squeeze(LtoR_events(2,:,win)));
            
            wrong_lick = mean(mean(wrong_options,2) > 0);
            right_lick = mean(mean(right_options,2) > 0);
            
            perf(site, cnt) = right_lick;
%             (right_lick - wrong_lick)/(right_lick+wrong_lick); %/(mean(wrong_lick)+mean(right_lick));
        catch
            perf(site, cnt) = NaN;
        end
    end
end
figure; hold on;
plot(perf','color',[0.5 0.5 0.5])
plot(nanmean(perf,1),'k', 'linewidth', 2)

