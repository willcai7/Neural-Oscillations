function [] = scatterplot(res,ne,ni,type,name,save)
% A function to show scatterplots and save them in folder output
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
title(name);

if save==true
set(gcf,'Position',[10,10,2000,400]);
saveas(gcf,['output\',type,'\scatter-',name,'.png']);
end

end

