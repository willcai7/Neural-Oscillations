function [] = scatterplot(spikes,ne,ni,name)
% A function to show scatterplots and save them in folder output
for i=1:ne
maxrow = spikes(1,i);
scatter(spikes(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=(ne+1):(ne+ni)
maxrow = spikes(1,i);
scatter(spikes(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end
set(gcf,'Position',[10,10,2000,400]);
saveas(gcf,['output\',name,'.png'])
end

