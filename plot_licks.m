function plot_licks(LtoL_events, LtoR_events)

figure;
subplot(1,2,1); hold on;
plot(smooth(squeeze(mean(LtoR_events(1,:,:),2))))
plot(smooth(squeeze(mean(LtoR_events(2,:,:),2))))
box off
legend('Left lick', 'Right lick (correct)')
line([60 60], get(gca,'ylim'),'color','k')
hold off;

subplot(1,2,2); hold on;
plot(smooth(squeeze(mean(LtoL_events(1,:,:),2))))
plot(smooth(squeeze(mean(LtoL_events(2,:,:),2))))
box off
legend('Left lick (correct)', 'Right lick')
line([60 60], get(gca,'ylim'),'color','k')
hold off;





