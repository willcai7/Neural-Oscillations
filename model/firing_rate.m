function [firing_rate] = firing_rate(spikes,ne,ni)
% A function to calculate average firing rate
num_row = size(spikes);
num_row = num_row(1);
total_time = max(max(spikes(2:num_row,:)));
num_e_spikes = sum(spikes(1,1:ne));
num_i_spikes = sum(spikes(1,ne+1:ne+ni));
firing_rate.e = num_e_spikes/(total_time*ne)*1000;
firing_rate.i = num_i_spikes/(total_time*ni)*1000;
end

