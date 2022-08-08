p.mesh.domain   = [0 1];
p.mesh.numele   = 10;
p.mesh.polygrad = 3;

p.mat.rho = @rho_task3;
p.mat.c   = @c_task3;

p.bc.init   = @initcond_task3;
p.bc.anasol = @anasol_task3;
p.bc.type   = 'dirichlet';

p.timeint.step       = 0.0001;
p.timeint.tstart     = 0.0;
p.timeint.tend       = 2.0;
p.timeint.numselect  = 100;
p.timeint.method     = 'RK4';

p.fluxtype = 'HDG';

setupname=mfilename;