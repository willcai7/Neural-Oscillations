function [] = scatterplot(res,ne,ni,name)
% A function to show scatterplots and save them in folder output
subplot(2,1,1)
for i=1:ne
maxrow = res.spike(1,i);
scatter(res.spike(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=(ne+1):(ne+ni)
maxrow = res.spike(1,i);
scatter(res.spike(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end
% ylim([0 2]);

subplot(2,1,2)

plot(res.record(7,:),res.record(3,:)/75+4);
hold on
plot(res.record(7,:),res.record(4,:)/25+4);
hold on
plot(res.record(7,:),res.record(1,:)/2000);
hold on
plot(res.record(7,:),res.record(2,:)/2000);
hold on
plot(res.record(7,:),res.record(5,:)+2);
hold on
plot(res.record(7,:),res.record(6,:)+2);
legend('N_{ge}/75','N_{gi}/25','H_e/2000','H_i/2000','H_{ee}/H_e','H_{ei}/H_i');


set(gcf,'Position',[10,10,2000,2000]);
saveas(gcf,['output\scatter-',name,'.png']);
end

