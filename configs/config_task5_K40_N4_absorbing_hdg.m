p.mesh.domain   = [0 1];
p.mesh.numele   = 120;
p.mesh.polygrad = 4;

p.mat.rho = @rho_task5;
p.mat.c   = @c_task5;

p.bc.init   = @initcond_task4;
p.bc.anasol = @anasol_dummy;
p.bc.type   = 'absorbing';

p.timeint.step       = 1e-5;
p.timeint.tstart     = 0.0;
p.timeint.tend       = 3e-3;
p.timeint.numselect  = 600;
p.timeint.method     = 'RK4';

p.fluxtype = 'HDG';

setupname=mfilename;

doplot=true;