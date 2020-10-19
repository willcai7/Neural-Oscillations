function [P] = P_generation_statistics(res,rare_res, param, bar)
% Use statistical method to estimate P

bar_e   = bar.e;
bar_i   = bar.i;
V_e     = res.V_e;
V_i     = res.V_i;
ne      = param.ne;
ni      = param.ni;
Mr      = param.Mr;
M       = param.M;
s_ee    = param.s_ee;
s_ie    = param.s_ie;
s_ei    = param.s_ei;
s_ii    = param.s_ii;  
s_ei    = ceil((66*s_ei+bar_e*166)/(166-s_ei) - bar_e);
s_ii    = ceil((66*s_ii+bar_i*166)/(166-s_ii) - bar_i);

V_e = [V_e,rare_res.V_e];
V_i = [V_i,rare_res.V_i];


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



check_times = length(V_e)/ne;
V_e = reshape(V_e, ne, check_times);
V_i = reshape(V_i, ni, check_times);
N_GE = sum(V_e>bar_e);
N_GI = sum(V_i>bar_i);
max_N_GE = max(N_GE);
max_N_GI = max(N_GI);

for i =1:max_N_GE+1
V_e_temp = V_e(:, N_GE==(i-1));
V_e_temp = reshape(V_e_temp, 1, ne * sum(N_GE==(i-1)));
PDF_e_temp = histogram(V_e_temp,[-Mr-0.5:1:M+0.5],'normalization','probability');
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
PDF_i_temp = histogram(V_i_temp,[-Mr-0.5:1:M+0.5],'normalization','probability');
PDF_i_temp = PDF_i_temp.Values;
close;

P.P_BI_Ex(i) = PDF_i_temp(bar_i+ Mr )/sum(PDF_i_temp(1: (bar_i + Mr + 1)));
P.P_GI_Ex(i) = PDF_i_temp(M+Mr)/sum(PDF_i_temp(bar_i+Mr+2: Mr+M+1));
P.P_BI_E(i) = sum(PDF_i_temp((bar_i+Mr+2-s_ie): bar_i+Mr+1))/sum(PDF_i_temp(1:bar_i+Mr+1));
P.P_GI_E(i) = min(sum(PDF_i_temp((M+Mr+2-s_ie):M+Mr+1))/sum(PDF_i_temp(bar_i+Mr+2:M+Mr+1)),1);
P.P_GI_I(i) = min(sum(PDF_i_temp(bar_i+Mr+2:bar_i+Mr+s_ii+1))/sum(PDF_i_temp(bar_i+Mr+2: M+Mr+1)),1);
end


position=max(find(P.P_BE_Ex~=0));
P.P_BE_Ex(position+1:ne)=P.P_BE_Ex(position);
position=min(find(P.P_BE_Ex~=0&isnan(P.P_BE_Ex)==0));
P.P_BE_Ex(1:position-1)=P.P_BE_Ex(position);
position=find(isnan(P.P_BE_Ex)==1);
for i=1:length(position)
    P.P_BE_Ex(position(i))=P.P_BE_Ex(position(i)-1);
end

position=max(find(P.P_GE_Ex~=0));
P.P_GE_Ex(position+1:ne)=P.P_GE_Ex(position);
position=min(find(P.P_GE_Ex~=0&isnan(P.P_GE_Ex)==0));
P.P_GE_Ex(1:position-1)=P.P_GE_Ex(position);
position=find(isnan(P.P_GE_Ex)==1);
for i=1:length(position)
    P.P_GE_Ex(position(i))=P.P_GE_Ex(position(i)-1);
end

position=max(find(P.P_BE_E~=0));
P.P_BE_E(position+1:ne)=P.P_BE_E(position);
position=min(find(P.P_BE_E~=0&isnan(P.P_BE_E)==0));
P.P_BE_E(1:position-1)=P.P_BE_E(position);
position=find(isnan(P.P_BE_E)==1);
for i=1:length(position)
    P.P_BE_E(position(i))=P.P_BE_E(position(i)-1);
end

position=max(find(P.P_GE_E~=0));
P.P_GE_E(position+1:ne)=P.P_GE_E(position);
position=min(find(P.P_GE_E~=0&isnan(P.P_GE_E)==0));
P.P_GE_E(1:position-1)=P.P_GE_E(position);
position=find(isnan(P.P_GE_E)==1);
for i=1:length(position)
    P.P_GE_E(position(i))=P.P_GE_E(position(i)-1);
end

position=max(find(P.P_GE_I~=0));
P.P_GE_I(position+1:ne)=P.P_GE_I(position);
position=min(find(P.P_GE_I~=0&isnan(P.P_GE_I)==0));
P.P_GE_I(1:position-1)=P.P_GE_I(position);
position=find(isnan(P.P_GE_I)==1);
for i=1:length(position)
    P.P_GE_I(position(i))=P.P_GE_I(position(i)-1);
end

position=max(find(P.P_BI_Ex~=0));
P.P_BI_Ex(position+1:ni)=P.P_BI_Ex(position);
position=min(find(P.P_BI_Ex~=0&isnan(P.P_BI_Ex)==0));
P.P_BI_Ex(1:position-1)=P.P_BI_Ex(position);
position=find(isnan(P.P_BI_Ex)==1);
for i=1:length(position)
    P.P_BI_Ex(position(i))=P.P_BI_Ex(position(i)-1);
end

position=max(find(P.P_GI_Ex~=0));
P.P_GI_Ex(position+1:ni)=P.P_GI_Ex(position);
position=min(find(P.P_GI_Ex~=0&isnan(P.P_GI_Ex)==0));
P.P_GI_Ex(1:position-1)=P.P_GI_Ex(position);
position=find(isnan(P.P_GI_Ex)==1);
for i=1:length(position)
    P.P_GI_Ex(position(i))=P.P_GI_Ex(position(i)-1);
end

position=max(find(P.P_BI_E~=0));
P.P_BI_E(position+1:ni)=P.P_BI_E(position);
position=min(find(P.P_BI_E~=0&isnan(P.P_BI_E)==0));
P.P_BI_E(1:position-1)=P.P_BI_E(position);
position=find(isnan(P.P_BI_E)==1);
for i=1:length(position)
    P.P_BI_E(position(i))=P.P_BI_E(position(i)-1);
end

position=max(find(P.P_GI_E~=0));
P.P_GI_E(position+1:ni)=P.P_GI_E(position);
position=min(find(P.P_GI_E~=0&isnan(P.P_GI_E)==0));
P.P_GI_E(1:position-1)=P.P_GI_E(position);
position=find(isnan(P.P_GI_E)==1);
for i=1:length(position)
    P.P_GI_E(position(i))=P.P_GI_E(position(i)-1);
end

position=max(find(P.P_GI_I~=0));
P.P_GI_I(position+1:ni)=P.P_GI_I(position);
position=min(find(P.P_GI_I~=0&isnan(P.P_GI_I)==0));
P.P_GI_I(1:position-1)=P.P_GI_I(position);
position=find(isnan(P.P_GI_I)==1);
for i=1:length(position)
    P.P_GI_I(position(i))=P.P_GI_I(position(i)-1);
end


end

