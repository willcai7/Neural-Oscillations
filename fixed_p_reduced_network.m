%This is a script to simulate fixed P applied in reduced network which is calculated 
%through the membrane potential distribution across time.
%res7,res8,res9 is got from main function.
addpath(genpath(pwd));
res=res9;

PDF_e=histogram(res.V_e,[-66:1:100],'Normalization','Probability');
PDF_e=PDF_e.Values;
PDF_i=histogram(res.V_i,[-66:1:100],'Normalization','Probability');
PDF_i=PDF_i.Values;


gate=75;
s_ee     = 25;
s_ie     = 10;
s_ei     = 25;
s_ii     = 25;
param.lambda_e = 1/7;
param.lambda_i = 1/7;
param.tau_ee   = 1.3;
param.tau_ie   = 0.95;
param.tau_i    = 4.5;
param.p_ee     = 0.15;
param.p_ie     = 0.5;
param.p_ei     = 0.5;
param.p_ii     = 0.4;

LHS_e=sum(PDF_e(1:166-(100-gate)));
RHS_e=1-LHS_e;
LHS_i=sum(PDF_i(1:166-(100-gate)));
RHS_i=1-LHS_i;

P.P_BE_Ex=PDF_e(166-(100-gate))/LHS_e*ones(1,76);
P.P_BI_Ex=PDF_i(166-(100-gate))/LHS_i*ones(1,26);
P.P_GE_Ex=PDF_e(166)/RHS_e*ones(1,76);
P.P_GI_Ex=PDF_i(166)/RHS_i*ones(1,26);
P.P_BE_E=sum(PDF_e(166-(100-gate)-s_ee+1:166-(100-gate)))/LHS_e*ones(1,76);
P.P_BI_E=sum(PDF_e(166-(100-gate)-s_ie+1:166-(100-gate)))/LHS_i*ones(1,26);
P.P_GE_E=ones(1,76);
P.P_GI_E=sum(PDF_i(166-s_ie+1:166))/RHS_i*ones(1,26);
P.P_GE_I=ones(1,76);
P.P_GI_I=ones(1,26);

param.ne=75;
param.ni=25;
param.type='hom';

q=ones(1,10);
s=false;
duration_time=1000;
name='..';
save=false;

result=model_reduced_network_P(s,duration_time,param, P,q);
scatterplot(result,param,name,save);
title('n=100-t=1000-hom-fixed')

