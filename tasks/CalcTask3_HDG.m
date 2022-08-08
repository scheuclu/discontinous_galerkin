
filesN1={... 
@config_task3_K5_N1_HDG
@config_task3_K10_N1_HDG
@config_task3_K20_N1_HDG
@config_task3_K40_N1_HDG
@config_task3_K80_N1_HDG};

filesN2={... 
@config_task3_K5_N2_HDG
@config_task3_K10_N2_HDG
@config_task3_K20_N2_HDG
@config_task3_K40_N2_HDG
@config_task3_K80_N2_HDG};

filesN3={... 
@config_task3_K5_N3_HDG
@config_task3_K10_N3_HDG
@config_task3_K20_N3_HDG
@config_task3_K40_N3_HDG
@config_task3_K80_N3_HDG};

filesN4={... 
@config_task3_K5_N4_HDG
@config_task3_K10_N4_HDG
@config_task3_K20_N4_HDG
@config_task3_K40_N4_HDG
@config_task3_K80_N4_HDG};

allfiles=[...
  filesN1
  filesN2
  filesN3
  filesN4];

for iter=allfiles'
  CalcSetup(iter{:})
end

numelevec=[5 10 20 40 80]';
convergenceN1_HDG=[];
convergenceN2_HDG=[];
convergenceN3_HDG=[];
convergenceN4_HDG=[];


for iter=filesN1'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN1_HDG=[convergenceN1_HDG;A(3,2)];
end
convergenceN1_HDG=[numelevec,convergenceN1_HDG]


for iter=filesN2'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN2_HDG=[convergenceN2_HDG;A(3,2)];
end
convergenceN2_HDG=[numelevec,convergenceN2_HDG]


for iter=filesN3'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN3_HDG=[convergenceN3_HDG;A(3,2)];
end
convergenceN3_HDG=[numelevec,convergenceN3_HDG]


for iter=filesN4'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN4_HDG=[convergenceN4_HDG;A(3,2)];
end
convergenceN4_HDG=[numelevec,convergenceN4_HDG]

dlmwrite('./results/config_task3_convergence_N1_HDG.dat' ,convergenceN1_HDG);
dlmwrite('./results/config_task3_convergence_N2_HDG.dat' ,convergenceN2_HDG);
dlmwrite('./results/config_task3_convergence_N3_HDG.dat' ,convergenceN3_HDG);
dlmwrite('./results/config_task3_convergence_N4_HDG.dat' ,convergenceN4_HDG);




loglog(convergenceN1_HDG(:,1),convergenceN1_HDG(:,2),...
       convergenceN2_HDG(:,1),convergenceN2_HDG(:,2),...
       convergenceN3_HDG(:,1),convergenceN3_HDG(:,2),...
       convergenceN4_HDG(:,1),convergenceN4_HDG(:,2) )
     
grid on
     
 legend('N=1','N=2','N=3','N=4')
