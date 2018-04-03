function [toneL_mat, toneR_mat] = tone_responses(proj_meta, site, tp)

Tones = proj_meta(site).rd(1,tp).ToneID;

toneL_onsets = find(diff(Tones) > 1 & diff(Tones) < 2)+1; % Correct tone for Left Lick is 1.5V
toneR_onsets = find(diff(Tones) > 2)+1; % Correct tone for Right Lick is 3.5V

toneL_onsets = toneL_onsets(3:end-1); % Note: the aux data will need to be cleaned a bit 
toneR_onsets = toneR_onsets(3:end-1); % e.g. double onsets for same stimulus

act = act2mat(proj_meta, site, tp);

win_pre = 60;
win_post = 60;
window = win_pre+win_post;

toneL_mat = zeros(size(act,1), length(toneL_onsets), window);
toneR_mat = zeros(size(act,1), length(toneR_onsets), window);

for ind = 1:length(toneL_onsets)
    toneL_mat(:,ind,:) = act(:, toneL_onsets(ind)-win_pre:toneL_onsets(ind)+win_post-1);
end

for ind = 1:length(toneR_onsets)
    toneR_mat(:,ind,:) = act(:, toneR_onsets(ind)-win_pre:toneR_onsets(ind)+win_post-1);
end












