function [] = hist_v(res,type,name,save)
subplot(2,1,1);
nbin=50;
histogram(res.V_e, nbin);
title("V_e");
subplot(2,1,2);
histogram(res.V_i, nbin);
title("V_i");
if save==true
set(gcf,'Position',[10,10,500,500]);
saveas(gcf,['output\',type,'\membrane_potential-',name,'.png']);
end
end

