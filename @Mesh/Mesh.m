classdef Mesh < handle
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    ele@Ele1D
    numdof@double=0
    C@double=1;
    numnode@double=0;
    nodevec@double=[];
  end
  
  methods
    function this = Mesh(params)
      
      this.nodevec=zeros(1,this.numnode);
      
      %verticepos=@(domain,numele,iele) domain(1)+(domain(2)-domain(1))/numele*[iele-1,iele];
      for iele=1:params.mesh.numele
        verticepos=params.mesh.domain(1)+(params.mesh.domain(2)-params.mesh.domain(1))/params.mesh.numele*[iele-1,iele];
        curdofs=this.numdof+1:this.numdof+2*(params.mesh.polygrad+1);
        
        curnodeids=this.numnode+1:this.numnode+1+params.mesh.polygrad;
        this.ele(iele)=Ele1D(iele,curdofs,curnodeids,verticepos,params.mesh.polygrad);
        
        %set material parameters
        elecenter=(verticepos(2)+verticepos(1))*0.5;
        this.ele(iele).set_rho(params.mat.rho(elecenter));
        this.ele(iele).set_c(params.mat.c(elecenter));
        
        this.numdof=this.numdof+length(curdofs);
        this.numnode=this.numnode+this.ele(iele).numnode;
        
        this.nodevec(this.numnode-this.ele(iele).numnode+1:this.numnode)=this.ele(iele).lagnodes;
      end
     
      
    end% end function Mesh1D
    
    function vdofs = get_vDofs(this)
      vdofs=[];
      for iterele=this.ele
        vdofs=[vdofs,iterele.get_vDofs()];%TODO ugly due to memory allocation
      end
    end
    
    function pdofs = get_pDofs(this)
      pdofs=[];
      for iterele=this.ele
        pdofs=[pdofs,iterele.get_pDofs()];%TODO ugly due to memory allocation
      end
    end
    
    function h = get_h(this)
      h=( this.nodevec(end)-this.nodevec(1) )/length(this.ele);
    end
    
    
    function cmax = get_cmax(this)
      cmax=max([this.ele.c]);
    end


    
  end
  
end

