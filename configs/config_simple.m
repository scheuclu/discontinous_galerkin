p.mesh.domain   = [0 1];
p.mesh.polygrad = 1;
p.mesh.numele   = 10;

p.mat.rho = @(x)x*0+1.2;
p.mat.c   = @(x)x*0+14.2;

p.bc.init   = @initcond_task4;
p.bc.type   = 'absorbing';
p.bc.anasol = @anasol_task3;

p.timeint.step       = 0.000001;
p.timeint.tstart     = 0.0;
p.timeint.tend       = 0.2;
p.timeint.numselect  = 500;
p.timeint.method     = 'RK4';

p.fluxtype = 'LF';

setupname=mfilename;