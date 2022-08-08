classdef Flux < handle
  %UNTITLED4 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mesh@Mesh
    boundcond@char
  end
  
  methods
    function this = Flux(mesh,boundcond)
      this.mesh=mesh;
      this.boundcond=boundcond;
    end
    
    
    function [F,Fb] = EvaluateF(this,fluxtype)
      switch fluxtype
        case 'LF'
          [F,Fb] = this.F_LF();
        case 'HDG'
          [F,Fb] = this.F_HDG();
        otherwise
          error(['unknown flux type: ',fluxtype]);
      end
      [Fb]=this.ApplyBC(Fb);
    end
    
    
    function [F,Fb] = F_LF(this)
      F=zeros(this.mesh.numdof,this.mesh.numdof);
      Fb=zeros(this.mesh.numdof,this.mesh.numdof);
      
      %interior elements
      this.mesh
      for iele=2:length(this.mesh.ele)-1
        %evaluate flux on left node
        curele  =this.mesh.ele(iele);
        leftele =this.mesh.ele(iele-1);
        rightele=this.mesh.ele(iele+1);
        

        
        F(curele.get_ldofs(),curele.get_ldofs())  =- (curele.getA()-curele.getC()*eye(2))*0.5;
        F(curele.get_rdofs(),curele.get_rdofs())  =+ (curele.getA()+curele.getC()*eye(2))*0.5;
        
        F(curele.get_ldofs(),leftele.get_rdofs()) =- (leftele.getA()+leftele.getC()*eye(2))*0.5;
        F(curele.get_rdofs(),rightele.get_ldofs())=+ (rightele.getA()-rightele.getC()*eye(2))*0.5;
        
        %evaluate flux on right node
      end
      
      %leftmost element (only  the right node is considered here)
      curele  =this.mesh.ele(1);
      rightele=this.mesh.ele(2);

      F(curele.get_ldofs(),curele.get_ldofs())  =- (curele.getA()-curele.getC()*eye(2))*0.5;%%ABSORB
      F(curele.get_rdofs(),curele.get_rdofs())  =+ (curele.getA()+curele.getC()*eye(2))*0.5;

      Fb(curele.get_ldofs(),curele.get_ldofs()) =- (curele.getA()+curele.getC()*eye(2))*0.5;
      F(curele.get_rdofs(),rightele.get_ldofs())=+ (rightele.getA()-rightele.getC()*eye(2))*0.5;
      
      %rightmos element (only the left node is considered here)
      curele  =this.mesh.ele(end);
      leftele =this.mesh.ele(end-1);

      F(curele.get_ldofs(),curele.get_ldofs())  =- (curele.getA()-curele.getC()*eye(2))*0.5;
      F(curele.get_rdofs(),curele.get_rdofs())  =+ (curele.getA()+curele.getC()*eye(2))*0.5;%%ABSORB

      F(curele.get_ldofs(),leftele.get_rdofs()) =- (leftele.getA()+leftele.getC()*eye(2))*0.5;
      Fb(curele.get_rdofs(),curele.get_rdofs())=+ (curele.getA()-curele.getC()*eye(2))*0.5;
    
 
    end

    
    function [F,Fb] = F_HDG(this)
      F=zeros(this.mesh.numdof,this.mesh.numdof);
      Fb=zeros(this.mesh.numdof,this.mesh.numdof);
      
      %interior elements
      this.mesh
      for iele=2:length(this.mesh.ele)-1
        %evaluate flux on left node
        curele  =this.mesh.ele(iele);
        leftele =this.mesh.ele(iele-1);
        rightele=this.mesh.ele(iele+1);
        

        
        F(curele.get_ldofs(),curele.get_ldofs())  =- (curele.getA()-curele.get_c()*eye(2))*0.5;
        F(curele.get_rdofs(),curele.get_rdofs())  =+ (curele.getA()+curele.get_c()*eye(2))*0.5;
        
        F(curele.get_ldofs(),leftele.get_rdofs()) =- (leftele.getA()+leftele.get_c()*eye(2))*0.5;
        F(curele.get_rdofs(),rightele.get_ldofs())=+ (rightele.getA()-rightele.get_c()*eye(2))*0.5;
        
        %evaluate flux on right node
      end
      
      %leftmost element (only  the right node is considered here)
      curele  =this.mesh.ele(1);
      rightele=this.mesh.ele(2);

      F(curele.get_ldofs(),curele.get_ldofs())  =- (curele.getA()-curele.get_c()*eye(2))*0.5;%%ABSORB
      F(curele.get_rdofs(),curele.get_rdofs())  =+ (curele.getA()+curele.get_c()*eye(2))*0.5;

      Fb(curele.get_ldofs(),curele.get_ldofs()) =- (curele.getA()+curele.get_c()*eye(2))*0.5;
      F(curele.get_rdofs(),rightele.get_ldofs())=+ (rightele.getA()-rightele.get_c()*eye(2))*0.5;
      
      %rightmos element (only the left node is considered here)
      curele  =this.mesh.ele(end);
      leftele =this.mesh.ele(end-1);

      F(curele.get_ldofs(),curele.get_ldofs())  =- (curele.getA()-curele.get_c()*eye(2))*0.5;
      F(curele.get_rdofs(),curele.get_rdofs())  =+ (curele.getA()+curele.get_c()*eye(2))*0.5;%%ABSORB

      F(curele.get_ldofs(),leftele.get_rdofs()) =- (leftele.getA()+leftele.get_c()*eye(2))*0.5;
      Fb(curele.get_rdofs(),curele.get_rdofs())=+ (curele.getA()-curele.get_c()*eye(2))*0.5;
    
 
    end
    
    
    
    function Fb = ApplyBC(this,Fb)
      
      %% Boundary Conditions
      rhol=this.mesh.ele(1).get_rho;
      rhor=this.mesh.ele(end).get_rho;

      cl=this.mesh.ele(1).get_c;
      cr=this.mesh.ele(end).get_c;

      switch this.boundcond
        case 'dirichlet'
          Fb(:,2)=-Fb(:,2);%-rhol*cl*Fb(:,2);
          Fb(:,end)=-Fb(:,end);%-rhor*cr*Fb(:,2);
        case 'absorbing'
          Fb(:,2)*-rhol*cl;
          Fb(:,1)=Fb(:,1)+Fb(:,2)*-rhol*cl;
          Fb(:,end-1)=Fb(:,end-1)+Fb(:,end)*rhor*cr;
          Fb(:,2)=0;
          Fb(:,end)=0;
        otherwise
          error('unknown boundary condition');
      end
    end
    

  end
  
end

