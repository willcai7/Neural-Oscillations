function [] = scatterplot(spikes,ne,ni,name)
maxrow=max(spikes(1,:));
for i=1:ne
scatter(spikes(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=(ne+1):(ne+ni)
scatter(spikes(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end
set(gcf,'Position',[10,10,2000,400]);
saveas(gcf,['output\',name,'.png'])
end

