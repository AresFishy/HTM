function [LtoL_events, LtoR_events] = Lick_histogram(proj_meta, site, tp)


LickR = proj_meta(site).rd(1,tp).LickR;
LickL = proj_meta(site).rd(1,tp).LickL;
Lick_total = [LickL; LickR];

Tones = proj_meta(site).rd(1,tp).ToneID;

toneL_onsets = find(diff(Tones) > 1 & diff(Tones) < 2)+1; % Correct tone for Left Lick is 1.5V
toneR_onsets = find(diff(Tones) > 2)+1; % Correct tone for Right Lick is 3.5V

half_window = 60;
window = 2*half_window;
% Remove first and last onsets 
toneL_onsets = toneL_onsets(2:end-1);
toneR_onsets = toneR_onsets(2:end-1);

Lick_to_L = zeros(2, length(toneL_onsets), window);
Lick_to_R = zeros(2, length(toneR_onsets), window);

for ind = 1:length(toneL_onsets)
    Lick_to_L(:,ind,:) = Lick_total(:,toneL_onsets(ind)-half_window:toneL_onsets(ind)+half_window-1); % Make sure onset is at frame 60
end

for ind = 1:length(toneR_onsets)
    Lick_to_R(:,ind,:) = Lick_total(:,toneR_onsets(ind)-half_window:toneR_onsets(ind)+half_window-1); % Make sure onset is at frame 60
end

% figure;
% subplot(1,2,1); 
% imagesc(squeeze(Lick_to_R(1,:,:))); title('Left spout licks')
% subplot(1,2,2);
% imagesc(squeeze(Lick_to_R(2,:,:))); title('Right spout licks (correct)')
% 
% figure;
% subplot(1,2,1); 
% imagesc(squeeze(Lick_to_L(1,:,:))); title('Left spout licks (correct)')
% subplot(1,2,2);
% imagesc(squeeze(Lick_to_L(2,:,:))); title('Right spout licks')


if site < 5
    thresh = 6;
    LtoL_onsets = find(diff(abs(Lick_to_L),1,3) > thresh);
    LtoR_onsets = find(diff(abs(Lick_to_R),1,3) > thresh);
else
    thresh = 0.5;
    LtoL_onsets = find(diff((Lick_to_L),1,3) < -thresh);
    LtoR_onsets = find(diff((Lick_to_R),1,3) < -thresh);
end


LtoL_events = zeros(size(Lick_to_L));
LtoR_events = zeros(size(Lick_to_R));

LtoL_events(LtoL_onsets) = 1;
LtoR_events(LtoR_onsets) = 1;







