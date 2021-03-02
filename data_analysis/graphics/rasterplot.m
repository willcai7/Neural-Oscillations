function [] = rasterplot(res,param)
% A function to show scatterplots and save them in folder output

ne = param.ne;
ni = param.ni;

for i=1:ne
times = res.spike(:,i);
% times = times(times > 1000);
% times = times(times < 3000);
num   = size(times, 1);
scatter(times, i*ones(num, 1),10,'.','r');
hold on
end

for i=(ne+1):(ne+ni)
times = res.spike(:,i);
% times = times(times > 1000);
% times = times(times < 3000);
num   = size(times, 1);
scatter(times, i*ones(num, 1),10,'.','b');
hold on
end
% xlim([1000, 3000]);
% %title(name);
% yticks([25 50 75]);
% xticks([]);
% %set(gca, 'xtick',[]);
ylabel('Index');
set(gca,'fontsize',11);
end


