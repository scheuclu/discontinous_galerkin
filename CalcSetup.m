function [] = CalcSetup(configfile)

%% Input
doplot=false;%default
configfile()

CheckInput(p);

%% Create mesh
mesh=Mesh(p);

%p.timeint.step=0.005*mesh.get_h()/(mesh.get_cmax*p.mesh.polygrad^2);

%% Create flux matrix

fluxer = Flux(mesh,p.bc.type);
[F,Fbound] = fluxer.EvaluateF(p.fluxtype);

%% Create other matrices
[ M,S ] = AssembleAll( mesh );

%% Consistency chekc on F-matrix
%configfile
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
L2mat   =postproc.EvalL2(U_selected,time_selected);

%% Output Writer

outwriter=OutWriter(mesh,setupname,p.timeint.numselect,p.bc.anasol);
outwriter.Write(Useries,L2mat,timevec)

if doplot==true
  %% Plot Solution
  plotter=Plotter1D(mesh,p.bc.anasol);
  plotter.PlotSol2D(figure(),mesh.nodevec,time_selected,U_selected);
  plotter.PlotSol3D(figure(),mesh.nodevec,time_selected,U_selected);

  plotter.PlotErr(figure(),L2mat,time_selected)

  f=figure();
  plotter.PlotAnimation(f,time_selected,U_selected);
end

end
