prepare
set(0,'defaultlinelinewidth',4)
set(0,'defaultaxesfontsize',12)

%% Input

%config_simple;
%config_simple
%config_task4_K40_N4_absorbing_hdg
%config_task4_K40_N4_dirichlet_hdg
%config_task4_K40_N4_absorbing_lf
%config_task4_K40_N4_dirichlet_lf
%config_task5_K40_N4_dirichlet_hdg

%config_task3_K5_N1_HDG
%config_task3_K10_N1_HDG
%config_task3_K20_N1_HDG
%config_task3_K40_N1_HDG
config_task3_K80_N1_HDG

CheckInput(p);

%% Create mesh
mesh=Mesh(p);

% p.timeint.step=0.001*mesh.get_h()/(mesh.get_cmax*p.mesh.polygrad^2);
% p.timeint.step
%error('asdasd')

%% Create flux matrix

fluxer = Flux(mesh,p.bc.type);
[F,Fbound] = fluxer.EvaluateF(p.fluxtype);

%% Create other matrices
[ M,S ] = AssembleAll( mesh );

%% Consistency chekc on F-matrix
%CheckFmat(F);

%% Initial conditions
uinit=p.bc.init(mesh.nodevec);
uinit=reshape(uinit,numel(uinit),1);


%% Time Integration

%creating timesteps
numstep  = floor((p.timeint.tend-0)/p.timeint.step);
timevec  = (0:numstep)*p.timeint.step;

% creating selector for subset of timesteps
timestepselector=round(linspace(1,length(timevec),p.timeint.numselect));

inverseM=inv(M);
D=inverseM*(S-F-Fbound);

integrator=TimeInt(p.timeint.method,D,numstep,p.timeint.step);
Useries   =integrator.Integrate(uinit,Fbound);

%select solution subset
U_selected=   Useries(:,timestepselector);
time_selected=timevec(timestepselector)';

%% Error Evaluation
postproc=PostProc(mesh,p.bc.anasol,p.timeint.step);
L2mat   =postproc.EvalL22(U_selected,time_selected);

%% Output Writer

outwriter=OutWriter(mesh,setupname,p.timeint.numselect,p.bc.anasol);
outwriter.Write(Useries,L2mat,timevec)
%outwriter.WriteErr(L2mat,timevec)
%% Plot Solution
plotter=Plotter1D(mesh,p.bc.anasol);
plotter.PlotSol2D(figure(),mesh.nodevec,time_selected,U_selected);
%plotter.PlotSol3D(figure(),mesh.nodevec,time_selected,U_selected);

plotter.PlotErr(figure(),L2mat,time_selected)

f=figure();
plotter.PlotAnimation(f,time_selected,U_selected);


