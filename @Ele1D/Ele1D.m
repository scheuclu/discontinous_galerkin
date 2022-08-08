classdef Ele1D < handle
  %UNTITLED2 Summary of this class goes here
  %   Detailed explanation goes here
  
  % dof numbering scheme:
  % 
  %       o---o---o---o
  %  vdof 1   3   5   7
  %  pdof 2   4   6   8
  
  properties
    polygrad  @double
    verticepos@double
    ID        @double
    dofs      @double
    lagnodes  @double
    rho       @double=0
    c         @double=0
    numnode   @double=0
    nodeids   @double=0
    %neighs@Ele1D
    
    
    
  end
  
  methods
    function this = Ele1D(ID,dofs,nodeids,verticepos,polygrad)
      this.ID        =ID;
      this.dofs      =dofs;
      this.polygrad  =polygrad;
      this.verticepos=verticepos;
      
      
      lagnodesref  =GaussLobatto1D(polygrad+1);
      this.lagnodes=lagnodesref*(verticepos(2)-verticepos(1))/2+(verticepos(2)+verticepos(1))/2;
      this.numnode=length(this.lagnodes);
      this.nodeids=nodeids;
      
    end
    
    function Mmat = EvaluateM(this)
      numgp=plolygrad2numgp(this.polygrad);
      numdof=length(this.dofs);
      [gpr,gpw]=gaussrule(numgp);
   
      Mmat=zeros(numdof,numdof);

      for igp=1:numgp

%         [ J,detJ,invJ ] = this.getJacobian();
        J=(this.verticepos(2)-this.verticepos(1))/2;
        detJ=(this.verticepos(2)-this.verticepos(1))/2;
        inv=2/(this.verticepos(2)-this.verticepos(1));

        %N_xi=shapefunctions(gpr);
        for ipol=1:this.polygrad+1
          Nvec(ipol)=lagpol(this.lagnodes,ipol,this.loc2glob(gpr(igp)) );
        end
        Nmat=CreateNmat(Nvec)';

        Mmat=Mmat+Nmat*Nmat'*detJ*gpw(igp);
      end%end gausspoint loop
      
    end
    
    function Smat = EvaluateS(this)
      numgp=plolygrad2numgp(this.polygrad);
      numdof=length(this.dofs);
      [gpr,gpw]=gaussrule(numgp);
   
      global Sversion
      Smat=zeros(numdof,numdof);

      for igp=1:numgp

%         [ J,detJ,invJ ] = this.getJacobian();
        J=(this.verticepos(2)-this.verticepos(1))/2;
        detJ=(this.verticepos(2)-this.verticepos(1))/2;
        invJ=2/(this.verticepos(2)-this.verticepos(1));

        %N_xi=shapefunctions(gpr);
        for ipol=1:this.polygrad+1
          Nvec(ipol)=lagpol(this.lagnodes,ipol,this.loc2glob(gpr(igp)) );
          derivNvec(ipol)=derivlagpol(this.lagnodes,ipol,this.loc2glob(gpr(igp)) );
        end

        Nmat=CreateNmat(Nvec)';
        derivNmat=CreateNmat(derivNvec)';

        Smat=Smat+derivNmat*this.getA()*Nmat'*detJ*gpw(igp);

      end%end gausspoint loop
      
    end
    
    
    function l2err = EvaluateL2(this,errvec)
      %comment
      validateattributes(errvec,{'numeric'},{'vector','column','numel',length(this.lagnodes)*2},'EvaluateL2','errvec',1);
      
      numgp=plolygrad2numgp(this.polygrad);
      numdof= length(this.dofs);
      [gpr,gpw]=gaussrule(numgp);
   
      l2err=0;

      for igp=1:numgp
%         [ J,detJ,invJ ] = this.getJacobian();
        J   =(this.verticepos(2)-this.verticepos(1))/2;
        detJ=(this.verticepos(2)-this.verticepos(1))/2;
        invJ=2/(this.verticepos(2)-this.verticepos(1));

        %N_xi=shapefunctions(gpr);
        for ipol=1:this.polygrad+1
          Nvec(ipol)=lagpol(this.lagnodes,ipol,this.loc2glob(gpr(igp)) );
          %%%derivNvec(ipol)=derivlagpol(this.lagnodes,ipol,this.loc2glob(gpr(igp)) );
        end

        Nmat=CreateNmat(Nvec)';
        %%%derivNmat=CreateNmat(derivNvec)';

        %l2err=Smat+Nmat*this.getA()*derivNmat'*detJ*gpw(igp);
        l2err=l2err+Nmat'*errvec*detJ*gpw(igp);
        %error('check Nmat shape please');
      end%end gausspoint loop
      
      
    end
    
    function [A] = getA(this)
      A=[0 1/this.rho; this.rho*this.c^2 0];
    end
    
    function [C] = getC(this)
      C=norm(this.getA())*10;
    end
    
    function Xglob=loc2glob(this,r)
      %affine transformation
      Xglob=(this.verticepos(2)-this.verticepos(1))*0.5*r+(this.verticepos(2)+this.verticepos(1))*0.5;
    end

    function this=set_LeftNeigh(this,ele)
      this.neighs(2)=ele;
    end
    
    function this=set_RightNeigh(this,ele)
      this.neighs(2)=ele;
    end
    
    function vdofs = get_vDofs(this)
      vdofs=this.dofs(rem(this.dofs,2)==1);
    end
    
    function pdofs = get_pDofs(this)
      pdofs=this.dofs(rem(this.dofs,2)==0);
    end
    
    function ldofs = get_ldofs(this)
      ldofs=this.dofs([1,2]);
    end
    
    function rdofs = get_rdofs(this)
      rdofs=this.dofs([end-1,end]);
    end
    
    function [] = set_rho(this,rho)
      this.rho=rho;
    end
    
    function [] = set_c(this,c)
      this.c=c;
    end
    
    function result = get_rho(this)
      result=this.rho;
    end
    
    function result = get_c(this)
      result=this.c;
    end

  end
  
end

