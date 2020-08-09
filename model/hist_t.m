function [] = hist_t(res,name)
nbin=60;
histogram(res.delta_t, nbin);
set(gcf,'Position',[10,10,500,500]);
saveas(gcf,['output\time_interval-',name,'.png']);
end

