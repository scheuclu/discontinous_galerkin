
filesN1={... 
@config_task3_K5_N1_LF
@config_task3_K10_N1_LF
@config_task3_K20_N1_LF
@config_task3_K40_N1_LF
@config_task3_K80_N1_LF};

filesN2={... 
@config_task3_K5_N2_LF
@config_task3_K10_N2_LF
@config_task3_K20_N2_LF
@config_task3_K40_N2_LF
@config_task3_K80_N2_LF};

filesN3={... 
@config_task3_K5_N3_LF
@config_task3_K10_N3_LF
@config_task3_K20_N3_LF
@config_task3_K40_N3_LF
@config_task3_K80_N3_LF};

filesN4={... 
@config_task3_K5_N4_LF
@config_task3_K10_N4_LF
@config_task3_K20_N4_LF
@config_task3_K40_N4_LF
@config_task3_K80_N4_LF};

allfiles=[...
  filesN1
  filesN2
  filesN3
  filesN4];

for iter=allfiles'
  CalcSetup(iter{:})
end

numelevec=[5 10 20 40 80]';
convergenceN1_LF=[];
convergenceN2_LF=[];
convergenceN3_LF=[];
convergenceN4_LF=[];


for iter=filesN1'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN1_LF=[convergenceN1_LF;A(3,2)];
end
convergenceN1_LF=[numelevec,convergenceN1_LF]


for iter=filesN2'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN2_LF=[convergenceN2_LF;A(3,2)];
end
convergenceN2_LF=[numelevec,convergenceN2_LF]


for iter=filesN3'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN3_LF=[convergenceN3_LF;A(3,2)];
end
convergenceN3_LF=[numelevec,convergenceN3_LF]


for iter=filesN4'
  A=dlmread(['./results/',func2str(iter{:}),'/L2err_P.dat' ]);
  convergenceN4_LF=[convergenceN4_LF;A(3,2)];
end
convergenceN4_LF=[numelevec,convergenceN4_LF]

dlmwrite('./results/config_task3_convergence_N1_LF.dat' ,convergenceN1_LF);
dlmwrite('./results/config_task3_convergence_N2_LF.dat' ,convergenceN2_LF);
dlmwrite('./results/config_task3_convergence_N3_LF.dat' ,convergenceN3_LF);
dlmwrite('./results/config_task3_convergence_N4_LF.dat' ,convergenceN4_LF);




loglog(convergenceN1_LF(:,1),convergenceN1_LF(:,2),...
       convergenceN2_LF(:,1),convergenceN2_LF(:,2),...
       convergenceN3_LF(:,1),convergenceN3_LF(:,2),...
       convergenceN4_LF(:,1),convergenceN4_LF(:,2) )
     
grid on
     
 legend('N=1','N=2','N=3','N=4')
