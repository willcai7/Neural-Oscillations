function [] = rasterplot(res,param,name,save)
% A function to show scatterplots and save them in folder output

ne = param.ne;
ni = param.ni;
model = param.model;
duration = param.duration;

for i=1:ne
times = res.spike(:,i);
times = times(times > duration - 1000);
num   = size(times, 1);
scatter(times, i*ones(num, 1),0.5,'.','r');
hold on
end

for i=(ne+1):(ne+ni)
times = res.spike(:,i);
times = times(times > duration - 1000);
num   = size(times, 1);
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

end

