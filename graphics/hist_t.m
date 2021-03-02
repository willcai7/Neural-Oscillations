function [] = hist_t(res,param)
nbin=60;
histogram(res.delta_t, nbin);
set(gcf,'Position',[10,10,500,500]);
end

