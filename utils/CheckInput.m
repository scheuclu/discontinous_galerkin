function [] = CheckInput(p)

  %% p
  if ~isfield(p,'mesh')
    error('Section "mesh" missing in input parameters');
  end
  
  if ~isfield(p,'mat')
    error('Section "mat" missing in input parameters');
  end  
  
  if ~isfield(p,'bc')
    error('Section "bc" missing in input parameters');
  end
  
  if ~isfield(p,'timeint')
    error('Section "timeint" missing in input parameters');
  end
  
  if ~isfield(p,'fluxtype')
    error('Section "fluxtype" missing in input parameters');
  end
  
  %% p.mesh
  if ~isfield(p.mesh,'domain')
    error('Parameter "domain" missing in section mesh');
  end
  
  if ~isfield(p.mesh,'polygrad')
    error('Parameter "polygrad" missing in section mesh');
  end
  
  if ~isfield(p.mesh,'numele')
    error('Parameter "numele" missing in section mesh');
  end
  
  
  %% p.mat
  if ~isfield(p.mat,'rho')
    error('Parameter "rho" missing in section mat');
  end
  
  
  if ~isfield(p.mat,'c')
    error('Parameter "c" missing in section mat');
  end
  
  %% p.bc
  if ~isfield(p.bc,'init')
    error('Parameter "init" missing in section bc');
  end
  
  if ~isfield(p.bc,'type')
    error('Parameter "type" missing in section bc');
  end
  
  if ~isfield(p.bc,'anasol')
    error('Parameter "anasol" missing in section bc');
  end

  
  %% timeint
  if ~isfield(p.timeint,'step')
    error('Parameter "step" missing in section timeint')
  end
  
  if ~isfield(p.timeint,'tstart')
    error('Parameter "tstart" missing in section timeint')
  end
  
  if ~isfield(p.timeint,'tend')
    error('Parameter "tend" missing in section timeint')
  end
  
  if ~isfield(p.timeint,'numselect')
    error('Parameter "numselect" missing in section timeint')
  end
  
  if ~isfield(p.timeint,'method')
    error('Parameter "method" missing in section timeint')
  end
 
  
  
end