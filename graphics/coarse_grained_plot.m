function []=coarse_grained_plot(param,res,duration_time,type,name,save)
ne = param.ne;
ni = param.ni;
subplot(3,1,1);
scatter(res.spike(1,2:res.spike(1,1)+1), 1*ones(1,res.spike(1,1)),'.','r');
hold on
scatter(res.spike(2,2:res.spike(2,1)+1), 2*ones(1,res.spike(2,1)),'.','b');
ylim([0 3]);
xlim([0 duration_time]);
legend('spikes of E','spikes of I');
title('raster projection');

subplot(3,1,2);
plot(res.rec(5,:),res.rec(1,:)/ne);
hold on
plot(res.rec(5,:),res.rec(2,:)/ni);
legend('N_{ge}/75','N_{gi}/25');
title('number of gate neurons');

subplot(3,1,3);
plot(res.rec(5,:),res.rec(3,:));
hold on
plot(res.rec(5,:),res.rec(4,:));
ylim([0 param.pending_i_maximum]);
legend('H_e','H_i');
title('number of pending spikes');
 set(gcf,'Position',[10,10,2000,1500]);
if save==true
    saveas(gcf,['output\',type,'\',name,'.png']);
end
end
    
