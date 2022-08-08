function [] = CheckFmat(F)
  consoleline('Begin F-matrix consistency check',false);
%   Fv=F(3:2:end-2,:);
%   Fp=F(4:2:end-2,:);
  Fv=F(1:2:end,:);
  Fp=F(2:2:end,:);

  test_v=Fv(1:2:end,:)+Fv(2:2:end,:);
  test_p=Fp(1:2:end,:)+Fp(2:2:end,:);

  normtestv=norm(test_v);
  normtestp=norm(test_p);
  
  if normtestv>1e-14
    error('inconsistency in v-lines detected');
  else
    disp('v-lines are consistent');
  end
  
  if normtestp>1e-14
    error('inconsistency in p-lines detected');
  else
    disp('p-lines are consistent');
  end
  
  
  consoleline('Done F-matrix consistency check',true);
end