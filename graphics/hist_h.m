function [] = hist_h(res,param)
subplot(4,1,1);
histogram(res.H_ee);
title("H_{ee}");
subplot(4,1,2);
histogram(res.H_ie);
title("H_{ie}");
subplot(4,1,3);
histogram(res.H_ei);
title("H_{ei}");
subplot(4,1,4);
histogram(res.H_ii);
title("H_{ii}");
set(gcf,'Position',[10,10,500,500]);
end

