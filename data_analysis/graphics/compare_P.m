function [] = compare_P(P1,P2)
ne = length(P1.P_GE_E)-1;
ni = length(P1.P_GI_E)-1;
xe = (1:1:(ne+1));
xi = (1:1:(ni+1));
subplot(5,2,1);
plot(xe, P1.P_BE_Ex, 'r');
hold on
plot(xe, P2.P_BE_Ex, 'b');
title('P^{BE}_{Ex}');
ylabel('Prob');
subplot(5,2,2);
plot(xi, P1.P_BI_Ex, 'r');
hold on
plot(xi, P2.P_BI_Ex, 'b');
title('P^{BI}_{Ex}');
ylabel('Prob');
legend("P1", "P2");
subplot(5,2,3);
plot(xe, P1.P_GE_Ex, 'r');
hold on
plot(xe, P2.P_GE_Ex, 'b');
title('P^{GE}_{Ex}');
ylabel('Prob');
subplot(5,2,4);
plot(xi, P1.P_GI_Ex, 'r');
hold on
plot(xi, P2.P_GI_Ex, 'b');
title('P^{GI}_{Ex}');
ylabel('Prob');
subplot(5,2,5);
plot(xe, P1.P_BE_E, 'r');
hold on
plot(xe, P2.P_BE_E, 'b');
title('P^{BE}_{E}');
ylabel('Prob');
subplot(5,2,6);
plot(xi, P1.P_BI_E, 'r');
hold on
plot(xi, P2.P_BI_E, 'b');
title('P^{BI}_{E}');
ylabel('Prob');
subplot(5,2,7);
plot(xe, P1.P_GE_E, 'r');
hold on
plot(xe, P2.P_GE_E, 'b');
title('P^{GE}_{E}');
ylabel('Prob');
subplot(5,2,8);
plot(xi, P1.P_GI_E, 'r');
hold on
plot(xi, P2.P_GI_E, 'b');
title('P^{GI}_{E}');
ylabel('Prob');
subplot(5,2,9);
plot(xe, P1.P_GE_I, 'r');
hold on
plot(xe, P2.P_GE_I, 'b');
title('P^{GE}_{I}');
xlabel('N_{GE}');
ylabel('Prob');
subplot(5,2,10);
plot(xi, P1.P_GI_I, 'r');
hold on
plot(xi, P2.P_GI_I, 'b');
title('P^{GI}_{I}');
xlabel('N_{GI}');
ylabel('Prob');
set(gcf,'Position',[10,10,1000,800]);
end

