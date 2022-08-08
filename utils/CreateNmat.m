function [ Nmat ] = CreateNmat( Nvec )
  validateattributes(Nvec,{'double'},{'vector','row'},'CreateNmat','Nvec',1)

  Nmat=zeros(2,2*length(Nvec));

  for iter=1:length(Nvec)
    Nmat(1,(iter)*2-1)=Nvec(iter);
    Nmat(2,iter*2)=Nvec(iter);
  end


end

