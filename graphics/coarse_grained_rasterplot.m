function [] = coarse_grained_rasterplot(res, param)
spike = res.spike;
ne = param.ne;
ni = param.ni;
duration = param.duration;
num_e_spikes = spike(1,1);
num_i_spikes = spike(2,1);
index_e = randi(ne, 1, num_e_spikes);
index_i = randi(ni, 1, num_i_spikes);
index_i = index_i + ne;
spike = spike(:, 2:end);
for i = 1:ne
    times = spike(1, (index_e ==i));
    times = times(times> duration -1000);
    num   = size(times, 2);
    scatter(times, i*ones(num, 1),10,'.','r');
    hold on
end 

for i=ne+1:ne+ni
    times = spike(2,(index_i ==i));
    times = times(times> duration-1000);
    num = size(times,2 );
    scatter(times, i*ones(num, 1),10,'.','b');
    hold on
end
%title(name);
yticks([25 50 75]);
xticks([]);
ylabel('Index');
set(gca,'fontsize',11);
hold off
end

