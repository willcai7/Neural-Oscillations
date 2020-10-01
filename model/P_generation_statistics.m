function [P] = P_generation_statistics(res,rare_res, param, bar)
% Use statistical method to estimate P

bar_e   = bar.e;
bar_i   = bar.i;
V_e     = res.V_e;
V_i     = res.V_i;
N_GI    = res.N_GI;
ne      = param.ne;
ni      = param.ni;
N_GE    = res.N_GE;
Mr      = param.Mr;
M       = param.M;
s_ee    = param.s_ee;
s_ie    = param.s_ie;
s_ei    = param.s_ei;
s_ii    = param.s_ii;  

V_e = [V_e,rare_res.V_e];
V_i = [V_i,rare_res.V_i];
N_GI = [N_GI,rare_res.N_GI];
N_GE = [N_GE,rare_res.N_GE];





P.P_BE_Ex = zeros(1, ne+1);
P.P_GE_Ex = zeros(1, ne+1);
P.P_BE_E  = zeros(1, ne+1);
P.P_GE_E  = zeros(1, ne+1);
P.P_GE_I  = zeros(1, ne+1);
P.P_BI_Ex = zeros(1, ni+1);
P.P_GI_Ex = zeros(1, ni+1);
P.P_BI_E  = zeros(1, ni+1);
P.P_GI_E  = zeros(1, ni+1);
P.P_GI_I  = zeros(1, ni+1);



check_times = length(N_GE);
V_e = reshape(V_e, ne, check_times);
V_i = reshape(V_i, ni, check_times);
N_GE = sum(V_e>bar_e);
N_GI = sum(V_i>bar_i);
max_N_GE = max(N_GE);
max_N_GI = max(N_GI);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, ne * sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-Mr:1:M+1],'normalization','probability');
PDF_e_temp = PDF_e_temp.Values;
close;
P.P_BE_Ex(i) = PDF_e_temp(bar_e+Mr+1)/sum(PDF_e_temp(1: (bar_e+Mr+1)));
P.P_GE_Ex(i) = PDF_e_temp(M+Mr)/sum(PDF_e_temp(bar_e+Mr+2: M+Mr+1));
P.P_BE_E(i) = sum(PDF_e_temp((bar_e+Mr+1-s_ee+1):bar_e+Mr+1))/sum(PDF_e_temp(1:bar_e+Mr+1));
P.P_GE_E(i) = min(sum(PDF_e_temp((Mr+M+2-s_ee):M+Mr+1))/sum(PDF_e_temp(bar_e+Mr+2: M+Mr+1)),1);
P.P_GE_I(i) = min(sum(PDF_e_temp(bar_e+Mr+2:bar_e+Mr+s_ei+1))/sum(PDF_e_temp(bar_e+Mr+2: M+Mr+1)),1);
end

for i =1:max_N_GI+1
V_i_temp = V_i(:, N_GI==(i-1));
V_i_temp = reshape(V_i_temp, 1, ni*sum(N_GI==(i-1)));
PDF_i_temp = histogram(V_i_temp,[-Mr:1:M+1],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P.P_BI_Ex(i) = PDF_i_temp(bar_i+ Mr +1)/sum(PDF_i_temp(1: (bar_i + Mr + 1)));
P.P_GI_Ex(i) = PDF_i_temp(M+Mr)/sum(PDF_i_temp(bar_i+Mr+2: Mr+M+1));
P.P_BI_E(i) = sum(PDF_i_temp((bar_i+Mr+2-s_ie): bar_i+Mr+1))/sum(PDF_i_temp(1:bar_i+Mr+1));
P.P_GI_E(i) = min(sum(PDF_i_temp((M+Mr+2-s_ie):M+Mr+1))/sum(PDF_i_temp(bar_i+Mr+2:M+Mr+1)),1);
P.P_GI_I(i) = min(sum(PDF_i_temp(bar_i+Mr+2:bar_i+Mr+s_ii+1))/sum(PDF_i_temp(bar_i+Mr+2: M+Mr+1)),1);

end

end

