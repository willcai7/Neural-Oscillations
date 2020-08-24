function [] = hist_t(res,param,name,save)
type = param.type;
nbin=60;
histogram(res.delta_t, nbin);
set(gcf,'Position',[10,10,500,500]);
if save==true
saveas(gcf,['output\',type,'\time_interval-',name,'.png']);
end
end

