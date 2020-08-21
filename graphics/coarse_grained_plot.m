function []=coarse_grained_plot(param,res,type,name,save)
subplot(3,1,1);
scatter(res.spike(1,2:res.spike(1,1)+1), 1*ones(1,res.spike(1,1)),'.','r');
hold on
scatter(res.spike(2,2:res.spike(2,1)+1), 2*ones(1,res.spike(2,1)),'.','b');
legend('spikes of E','spikes of I');
label('raster projection');

subplot(3,1,2);
plot(res.rec(5,:),res.rec(1,:)/75);
hold on
plot(res.rec(5,:),res.rec(2,:)/25);
legend('N_{ge}/75','N_{gi}/25');
lable('number of gate neurons');

subplot(3,1,3);
plot(res.rec(5,:),res.rec(3,:));
hold on
plot(res.rec(5,:),res.rec(4,:));
ylim([0 param.pending_i_maximum]);
legend('H_e','H_i');
lable('number of pending spikes');

if save==ture
    set(gcf,'Position',[10,10,2000,1500]);
    saveas(gcf,['output\',type,'\coarse_grained-',name,'.png']);
end
end
    
