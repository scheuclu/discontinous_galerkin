classdef TimeInt < handle
  %UNTITLED3 Summary of this class goes here
  %   Detailed explanation goes here
  %   
  %   all of the implemented equations are basen on the differential Equation:
  %   
  %   M*du/dt=B*u
  %   or
  %   du/dt=D*u, where D=inv(M)*B;
  %
  %  in the wave eqaution:
  %  D=inv(M)*(S-F)
  
  properties
    %M@double
    %B@double
    %invM@double;
    timestep@double
    numstep@double
    method@char
    D@double
  end
  
  methods

    function this = TimeInt(method,D,numstep,timestep)
      validatestring(method,{'RK4','EEuler'},'TimeInt','methods',1)
%       this.M=M;
%       this.invM=inv(M);
%       this.B=B;
      this.D=D;
      this.numstep=numstep;
      this.timestep=timestep;
      this.method=method;
    end

      
    function [unew] = EEulerStep(this,uold,told,tnew)
      
      tstep=tnew-told;
      unew=uold+tstep*this.D*uold;

    end
    
  
    function [U] = Integrate(this,uinit,Fbound)
      
      consoleline('Begining time integration',false); tic;
      this.numstep+1
      length(uinit)
      U=zeros(length(uinit),this.numstep+1);
      U(:,1)=uinit;

      %D   =this.invM*this.B;%B will be time dependent soon
      
      switch this.method
        case 'RK4'
          stepsolve=@this.RK4Step;
          disp('Using Runge Kutta');
        case 'EEuler'
          stepsolve=@this.EEulerStep;
          disp('using Explicit Euler');
        otherwise
          error('unknown integration method');
      end
      
      progresstring=''; pcheck=round(this.numstep/80);
      for k=2:this.numstep+1
        
        %f=@(uold)D*u
        %this.f=@(u)this.invM*(this.B*u-Fbound*[-u(1) 0 -u(end-1) 0]' );
        
        if  rem(k,pcheck)==0
          progresstring=printprogress(k,this.numstep+1,progresstring);
        end
        U(:,k)=stepsolve(U(:,k-1),this.timestep*k,this.timestep*(k+1));
      end
      
      disp(' '); toc
      consoleline('Finished time integration',true);

    end
        
    
    function [unew] = RK4Step(this,uold,told,tnew)
      
      tstep=tnew-told;

      k1=this.D*( uold);
      k2=this.D*( uold+tstep/2*k1);
      k3=this.D*( uold+tstep/2*k2);
      k4=this.D*( uold+tstep  *k3);
      unew=uold+tstep/6*(k1+2*k2+2*k3+k4);

    end
    
    function [] = set_M(this,Mnew)
      this.M=Mnew;
    end
    
    function [] = set_B(this,Mnew)
      this.M=Mnew;
    end
    
  end
  
end

