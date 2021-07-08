function []=coarse_grained_linegraph(res,param,name,save)

ne = param.ne;
ni = param.ni;
model = param.model;
duration_time  = param.duration;
spike = res.spike;
spike_e = spike(1,:);
spike_i = spike(2,:);
figure('DefaultAxesFontSize',15)
subplot(2,1,1);
t = res.rec(5,:);
rec = res.rec;
rec = rec(:, (t>duration_time-1000));
t = t(t>duration_time-1000);
plot(t,rec(1,:)/ne);
hold on;
plot(t,rec(2,:)/ni);
hold off;
legend('N_{ge}/75','N_{gi}/25');
title('number of gate neurons');
subplot(2,1,2);
plot(t,rec(3,:));
hold on;
plot(t,rec(4,:));
legend('H_e','H_i');
title('number of pending spikes');
set(gcf,'Position',[10,10,800,320]);
hold off;
if save==true
    saveas(gcf,['output\',model,'\linegraph-',name,'.eps'],'psc2');
end
end
    
