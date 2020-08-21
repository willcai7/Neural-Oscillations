function [P] = P_generation_gaussian(param, res)
%==========================================================================
% A function to generate $P$ as a functions of $N_E, N_I$. Besides, we use
% gaussian distribution to approximate the distributions of $V_E$ and
% $V_I$.
% Inputs:
% * param: The parameters of a full model.
% * res: The results of a full model.
% Return:
% * P:
% *   P.P_BE_Ex: The effect of external source on a Base E-neuron.
% *   P.P_GE_Ex: The effect of external source on a Gate E-neuron.
% *   P.P_BI_Ex: The effect of external source on a Base I-neuron.
% *   P.P_GI_Ex: The effect of external source on a Gate I-neuron.
% *   P.P_GE_E: The effect of pending E-spike on a Gate E-neuron.
% *   P.P_GI_E: The effect of pending E-spike on a Gate I-neuron.
% *   P.P_BE_E: The effect of pending E-spike on a Base E-neuron.
% *   P.P_BI_E: The effect of pending E-spike on a Base I-neuron.
% *   P.P_GE_I: The effect of pending I-spike on a Gate E-neuron.
% *   P.P_GI_I: The effect of pending I-spike on a Gate I-neuron.
% *   P.P_BE_I: The effect of pending I-spike on a Base E-neuron.
% *   P.P_BI_I: The effect of pending I-spike on a Base I-neuron.
%==========================================================================
V_e = res.V_e_P;
V_i = res.V_i_P;
ne = param.ne;
ni = param.ni;
Mr = param.Mr;
M  = param.M;

mean_e = mean(V_e);
var_e = var(V_e);
mean_i = mean(V_i);
var_i = var(V_i);
PDF_e = zeros(1, Mr+M);
PDF_i = zeros(1, Mr+M);
for i =1:Mr+M
    x = i-70+ 0.5;
    PDF_e(i) = exp(-(x-mean_e)^2/(2*var_e))/sqrt(2*pi*var_e);
    PDF_i(i) = exp(-(x-mean_i)^2/(2*var_i))/sqrt(2*pi*var_i);
end

P.P_BE_Ex           = zeros(1,ne);
P.P_GE_Ex           = zeros(1,ne);
P.P_GE_E            = ones(1,ne);
P.P_BE_E            = zeros(1,ne);
P.P_GE_I            = ones(1,ne);


P.P_BI_Ex           = zeros(1,ni);
P.P_GI_Ex           = zeros(1,ni);
P.P_GI_E            = ones(1,ni);
P.P_BI_E            = zeros(1,ni);
P.P_GI_I            = ones(1,ni);

for i=1:ne
    j=Mr + M;
    probablity=0;
    if i==1 
        lim=0.5/ne; 
    else
        lim=(i-1)/ne;
    end
    while probablity <lim && j>1
        probablity=probablity + PDF_e(j);
        j=j-1;
    end
    P.P_BE_Ex(i) = PDF_e(j)/(1-probablity);
    P.P_GE_Ex(i) = sum(PDF_e(min(j+ param.s_ee, Mr+M):(M+Mr)))/probablity;
    P.P_BE_E(i) = sum(PDF_e(max(j- param.s_ee,1):j))/(1-probablity);
end

for i=1:ni
    j=Mr + M;
    probablity=0;
    if i==1 
        lim=0.5/ni; 
    else
        lim=(i-1)/ni;
    end
    while probablity <lim && j>1
        probablity=probablity + PDF_i(j);
        j=j-1;
    end
    P.P_BI_Ex(i) = PDF_i(j)/(1-probablity);
    P.P_GI_Ex(i) = sum(PDF_i(min(j+ param.s_ee, Mr+M):(M+Mr)))/probablity;
    P.P_BI_E(i) = sum(PDF_i(max(j- param.s_ie,1):j))/(1-probablity);
    P.P_GI_E(i) = sum(PDF_i(min(j+ param.s_ee-param.s_ie, Mr+M):(M+Mr)))/probablity;
end
end

