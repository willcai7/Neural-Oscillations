function [] = coarse_grained_rasterplot(res, param, save, name)
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
model = param.model;
for i = 1:ne
    times = spike(1, (index_e ==i));
    times = times(times> duration -1000);
    num   = size(times, 2);
    scatter(times, i*ones(num, 1),0.5,'.','r');
    hold on
end 

for i=ne+1:ne+ni
    times = spike(2,(index_i ==i));
    times = times(times> duration-1000);
    num = size(times,2 );
    scatter(times, i*ones(num, 1),0.5,'.','b');
    hold on
end
title(name);
xlabel('Time(ms)');
ylabel('Neuron');
set(gcf,'Position',[10,10,1000,200]);
if save==true
saveas(gcf,['output\', model,'\raster-',name,'.png']);
end
hold off
end

