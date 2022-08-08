classdef PostProc < handle
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mesh@Mesh
    anasol@function_handle %anasol(x,t)
    timestep@double=0
  end
  
  methods
    function this = PostProc(mesh,anasol,timestep)
      this.mesh    =mesh;
      this.anasol  =anasol;
      this.timestep=timestep;
    end
    
    function Err = EvalL2(this,U,totaltimevec)
      
      consoleline('Begining Error Evaluation',false); tic;
      Err=zeros(2,size(U,2));
      
      for istep = 1:size(U,2)
        totaltime=totaltimevec(istep);
        temp1=this.anasol(this.mesh.nodevec,totaltime);
        temp2=reshape(temp1,numel(temp1),1);
        steperror=(U(:,istep)-temp2).^2;

        for iterele=this.mesh.ele(2:end-1)
          elesteperror=steperror(iterele.dofs);
          Err(:,istep)=Err(:,istep)+iterele.EvaluateL2(elesteperror);
        end
      end
      
      
      Err=sqrt(Err);
      toc;
      consoleline('Finished Error Evaluation',true);
      
    end
    
    
    function Err = EvalL22(this,U,totaltimevec)
      
      consoleline('Begining Error Evaluation',false); tic;
      Err=zeros(2,length(totaltimevec));
      
      for istep = 1:length(totaltimevec)
        totaltime=totaltimevec(istep);
        temp1=this.anasol(this.mesh.nodevec,totaltime);
        temp2=reshape(temp1,numel(temp1),1);
        steperror=(U(:,istep)-temp2).^2;
        steperror=steperror(3:end-2);
        maxp=max(steperror(2:2:end));
        maxv=max(steperror(1:2:end));
        
        Err(:,istep)=[maxv;maxp];
       
      end
      
      
      Err=sqrt(Err);
      %error('temp exit')
      toc;
      consoleline('Finished Error Evaluation',true);
      
    end
    
  end
  
end

