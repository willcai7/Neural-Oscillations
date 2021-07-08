function [firing_rate] = firing_rate_coarse(res,param)
% A function to calculate average firing rate
ne = param.ne;
ni = param.ni;
spikes = res.spike;
total_time = param.duration;
num_e_spikes = spikes(1,1);
num_i_spikes = spikes(2,1);
firing_rate.e = num_e_spikes/(total_time*ne)*1000;
firing_rate.i = num_i_spikes/(total_time*ni)*1000;
end

