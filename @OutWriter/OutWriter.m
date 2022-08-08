classdef OutWriter < handle
  %UNTITLED5 Summary of this class goes here
  %   Detailed explanation goes here
 
  properties
    setupname@char='dummy';
    numtimesteps@double=0;
    mesh@Mesh
    anasol@function_handle
    
  end
  
  methods
    function this = OutWriter(mesh,setupname,numtimesteps,anasol)
      this.setupname=setupname;
      this.numtimesteps=numtimesteps;
      this.mesh=mesh;
      this.anasol=anasol;
    end
    
    
    
    
    
    function this = Write(this,U,L2mat,timevec)
      
      filedir=['./results/',this.setupname];
      if isdir(filedir)
        rmdir(filedir,'s');
      end
      mkdir(['./results/',this.setupname]);
      
      timestepselector=round(linspace(1,length(timevec),this.numtimesteps));
      
      
      for iterele=this.mesh.ele

        % Write Output
        dlmwrite([filedir,'/V_ele',num2str(iterele.ID),'.dat'],...
                 [...
                  0,timevec(timestepselector)
                  iterele.lagnodes',  U(iterele.dofs(1):2:iterele.dofs(end),timestepselector) ]);
                
        dlmwrite([filedir,'/P_ele',num2str(iterele.ID),'.dat'],...
                 [...
                  0,timevec(timestepselector)
                  iterele.lagnodes',  U(iterele.dofs(2):2:iterele.dofs(end),timestepselector) ]);
          
        %the analytic solution has to use more points, otherwise one would
        %not see the approsimation error
        xvec=linspace(iterele.lagnodes(1),iterele.lagnodes(end),100);
        [Vana,Pana] = this.CreateAnaSol(xvec,timevec(timestepselector));
                

        dlmwrite([filedir,'/Vana_ele',num2str(iterele.ID),'.dat'],...
                 [...
                  0,timevec(timestepselector)
                  xvec',  Vana(:,:) ]);
        dlmwrite([filedir,'/Pana_ele',num2str(iterele.ID),'.dat'],...
                 [...
                  0,timevec(timestepselector)
                  xvec',  Pana(:,:) ]);
      end
      
      dlmwrite([filedir,'/L2err_V.dat'],...
        [timevec(timestepselector);L2mat(1,:)]');
      dlmwrite([filedir,'/L2err_P.dat'],...
        [timevec(timestepselector);L2mat(2,:)]');
      

    end

    
    function [Vana,Pana] = CreateAnaSol(this,xvec,selectedtimes)
      
      Vana=zeros(length(xvec),length(selectedtimes));
      Pana=zeros(length(xvec),length(selectedtimes));
      for i=1:length(selectedtimes)
        sol=this.anasol(xvec,selectedtimes(i) );
        Vana(:,i)=sol(1,:);
        Pana(:,i)=sol(2,:);
      end
      
    end
    
    
    
  end
  
end

