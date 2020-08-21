function [] = hist_v(res,name)
subplot(2,1,1);
nbin=50;
histogram(res.V_e, nbin);
title("V_e");
subplot(2,1,2);
histogram(res.V_i, nbin);
title("V_i");
set(gcf,'Position',[10,10,500,500]);
saveas(gcf,['output\membrane_potential-',name,'.png']);
end

