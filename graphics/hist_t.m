function [] = hist_t(res,type,name,save)
nbin=60;
histogram(res.delta_t, nbin);
if save==true
set(gcf,'Position',[10,10,500,500]);
saveas(gcf,['output\',type,'\time_interval-',name,'.png']);
end
end

