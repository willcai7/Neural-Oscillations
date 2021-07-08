%This is a function to detect and simulate rare events.
%We pick the rare events in the res of normal full model, then do specific
%simulations for rare events.
function [rare_res] = rare_model_full(normal_res,param, bar)
rare_res.V_e = [];
rare_res.V_i = [];



res=normal_res;
V_e = res.V_e;
V_i = res.V_i;
H_ee = res.H_ee;
H_ei = res.H_ei;
H_ie = res.H_ie;
H_ii = res.H_ii;


check_times = length(res.N_GE);
V_e = reshape(V_e, param.ne, check_times);
V_i = reshape(V_i, param.ni ,check_times);
H_ee = reshape(H_ee, param.ne, check_times);
H_ei = reshape(H_ei, param.ne, check_times);
H_ie = reshape(H_ie, param.ni, check_times);
H_ii = reshape(H_ii, param.ni, check_times);
N_GE = sum(V_e>bar.e);
N_GI = sum(V_i>bar.i);
max_N_GE = max(N_GE);
max_N_GI = max(N_GI);

%If the N_GE is in the range [max_N_GE-3,max_N_GE] and on the rising period
%or N_GI is in the range [max_N_GI-1,max_N_GI] and on the rising period,
%we call it rare events.

ind1=N_GE>=max_N_GE-param.rare_range_e; %range
ind2=N_GE>[N_GE(2:check_times),N_GE(check_times)]; %rising
index=logical(ind1.*ind2);
rare_V_e = V_e(:, index);
rare_V_i = V_i(:, index);
rare_H_ee = H_ee(:, index);
rare_H_ei = H_ei(:, index);
rare_H_ie = H_ie(:, index);
rare_H_ii = H_ii(:, index);

ind1=N_GI>=max_N_GI-param.rare_range_i; %range
ind2=N_GI>[N_GI(2:check_times),N_GI(check_times)]; %rising
ind3=N_GE<=param.rare_range_e; %range
ind4=N_GE<[N_GE(2:check_times),N_GE(check_times)]; %decending

index=logical(ind1.*ind2+ind3.*ind4);
rare_V_e = [rare_V_e,V_e(:, index)];
rare_V_i = [rare_V_i,V_i(:, index)];
rare_H_ee = [rare_H_ee,H_ee(:, index)];
rare_H_ei = [rare_H_ei,H_ei(:, index)];
rare_H_ie = [rare_H_ie,H_ie(:, index)];
rare_H_ii = [rare_H_ii,H_ii(:, index)];


ind1=N_GI>=max_N_GI-param.rare_range_i; %range
ind2=N_GI>[N_GI(2:check_times),N_GI(check_times)]; %rising
ind3=N_GI<=param.rare_range_i; %range
ind4=N_GI<[N_GI(2:check_times),N_GI(check_times)]; %decending

index=logical(ind1.*ind2+ind3.*ind4);
rare_V_e = [rare_V_e,V_e(:, index)];
rare_V_i = [rare_V_i,V_i(:, index)];
rare_H_ee = [rare_H_ee,H_ee(:, index)];
rare_H_ei = [rare_H_ei,H_ei(:, index)];
rare_H_ie = [rare_H_ie,H_ie(:, index)];
rare_H_ii = [rare_H_ii,H_ii(:, index)];


row_size=size(rare_V_e);
row_size=row_size(2);

%randomly pick some initial states from 'rare'.
pick_index=ceil(rand(1,param.simulation_times)*row_size);
s=zeros(4,param.ne+param.ni);

param1 = param;
param1.duration = param.simulation_duration;
for i=1:param.simulation_times
    
    s(1,:)=[rare_V_e(:,pick_index(i))',rare_V_i(:,pick_index(i))'];
    s(2,:)=[rare_H_ee(:,pick_index(i))',rare_H_ie(:,pick_index(i))'];
    s(3,:)=[rare_H_ei(:,pick_index(i))',rare_H_ii(:,pick_index(i))'];
    short_simulation_res = model_full(s,param1);
    rare_res.V_e = [rare_res.V_e,short_simulation_res.V_e];
    rare_res.V_i = [rare_res.V_i,short_simulation_res.V_i];
end

end







