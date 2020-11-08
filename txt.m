fop = fopen('P3_stat_noref_E.txt','wt');
for i =1:76
fprintf(fop, ' %s', num2str(P3_stat_noref.P_BE_Ex(i)));
end
fprintf(fop, '\n' );
for i =1:76
fprintf(fop, ' %s', num2str(P3_stat_noref.P_GE_Ex(i)));
end
fprintf(fop, '\n' );
for i =1:76
fprintf(fop, ' %s', num2str(P3_stat_noref.P_BE_E(i)));
end
fprintf(fop, '\n' );
for i =1:76
fprintf(fop, ' %s', num2str(P3_stat_noref.P_GE_E(i)));
end
fprintf(fop, '\n' );
for i =1:76
fprintf(fop,  ' %s', num2str(P3_stat_noref.P_GE_I(i)));
end
back = fclose( fop ) ;
%%
fop = fopen('P3_stat_noref_I.txt','wt');
for i =1:26
fprintf(fop, ' %s', num2str(P3_stat_noref.P_BI_Ex(i)));
end
fprintf(fop, '\n' );
for i =1:26
fprintf(fop, ' %s', num2str(P3_stat_noref.P_GI_Ex(i)));
end
fprintf(fop, '\n' );
for i =1:26
fprintf(fop, ' %s', num2str(P3_stat_noref.P_BI_E(i)));
end
fprintf(fop, '\n' );
for i =1:26
fprintf(fop, ' %s', num2str(P3_stat_noref.P_GI_E(i)));
end
fprintf(fop, '\n' );
for i =1:26
fprintf(fop,  ' %s', num2str(P3_stat_noref.P_GI_I(i)));
end
back = fclose( fop ) ;

%%
fop=fopen('status.txt','wt');
for j =1:4
for i =1:369732
fprintf(fop, ' %s', num2str(res.status(j,i)));
end
fprintf(fop, '\n' );
end
back = fclose( fop ) ;

%%
fop = fopen('full_model_status.txt', 'wt');
res = P_res3_noref;
num_t = length(res.t);
H_ie = reshape(res.H_ie, 25, num_t);
H_ii = reshape(res.H_ii, 25, num_t);
H_ee = reshape(res.H_ee, 75, num_t);
H_ei = reshape(res.H_ei, 75, num_t);
H_ee = sum(H_ee);
H_ie = sum(H_ie);
H_ei = sum(H_ei);
H_ii = sum(H_ii);
H_i = H_ei + H_ii;
H_e = H_ie + H_ee;
N_GE = reshape(res.V_e, 75, num_t);
N_GI = reshape(res.V_i, 25, num_t);
N_GE = sum(N_GE > 45);
N_GI = sum(N_GI > 45);
for i=1:num_t
    fprintf(fop, ' %s', num2str(N_GE(i)));
    fprintf(fop, ' %s', num2str(N_GI(i)));
    fprintf(fop, ' %s', num2str(H_e(i)));
    fprintf(fop, ' %s', num2str(H_i(i)));
    fprintf(fop, '\n' );
end
back = fclose( fop ) ;
%%
fop = fopen('cg_model_status.txt', 'wt');
res = res6;
num_t = length(res.rec(1,:));
N_GE = res.rec(1, :);
N_GI = res.rec(2, :);
H_e = res.rec(3, :);
H_i = res.rec(4, :);
for i=1:num_t
    fprintf(fop, ' %s', num2str(N_GE(i)));
    fprintf(fop, ' %s', num2str(N_GI(i)));
    fprintf(fop, ' %s', num2str(H_e(i)));
    fprintf(fop, ' %s', num2str(H_i(i)));
    fprintf(fop, '\n' );
end
back = fclose( fop ) ;

%%
fop = fopen('scg2_model_status.txt', 'wt');
res = res7;
num_t = length(res.rec(1,:));
N_GE = res.rec(1, :);
N_GI = res.rec(2, :);
H_e = res.rec(3, :);
H_i = res.rec(4, :);
for i=1:num_t
    fprintf(fop, ' %s', num2str(N_GE(i)));
    fprintf(fop, ' %s', num2str(N_GI(i)));
    fprintf(fop, ' %s', num2str(H_e(i)));
    fprintf(fop, ' %s', num2str(H_i(i)));
    fprintf(fop, '\n' );
end
back = fclose( fop ) ;