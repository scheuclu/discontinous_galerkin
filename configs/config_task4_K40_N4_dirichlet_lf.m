p.mesh.domain   = [0 1];
p.mesh.numele   = 100;
p.mesh.polygrad = 1;

p.mat.rho = @rho_task4;
p.mat.c   = @c_task4;

p.bc.init   = @initcond_task4;
p.bc.anasol = @anasol_dummy;
p.bc.type   = 'dirichlet';

p.timeint.step       = 1e-7;
p.timeint.tstart     = 0.0;
p.timeint.tend       = 3e-3;
p.timeint.numselect  = 6;
p.timeint.method     = 'RK4';

p.fluxtype = 'LF';

setupname=mfilename;