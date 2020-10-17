function []=coarse_grained_plot(res,param,name,save)

ne = param.ne;
ni = param.ni;
model = param.model;
duration_time  = param.duration;
spike = res.spike;
spike_e = spike(1,:);
spike_i = spike(2,:);
subplot(3,1,1);
scatter(spike_e(spike_e>duration_time-1000), 1*ones(1,sum(spike_e>duration_time-1000)),'.','r');
hold on
scatter(spike_i(spike_i>duration_time-1000), 2*1*ones(1,sum(spike_i>duration_time-1000)),'.','b');
ylim([0 3]);
xlim([duration_time-1000 duration_time]);
legend('spikes of E','spikes of I');
title('raster projection');

subplot(3,1,2);
t = res.rec(5,:);
rec = res.rec;
rec = rec(:, (t>duration_time-1000));
t = t(t>duration_time-1000);
plot(t,rec(1,:)/ne);
hold on
plot(t,rec(2,:)/ni);
legend('N_{ge}/75','N_{gi}/25');
title('number of gate neurons');

subplot(3,1,3);
plot(t,rec(3,:));
hold on
plot(t,rec(4,:));
legend('H_e','H_i');
title('number of pending spikes');
set(gcf,'Position',[10,10,1000,600]);
if save==true
    saveas(gcf,['output\',model,'\linegraph-',name,'.png']);
end
end
    
