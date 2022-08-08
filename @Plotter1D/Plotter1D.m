classdef Plotter1D < handle
  %Plotter1D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    mesh   @Mesh
    params=struct(...
                  'PLOTMESH', true,...
                  'PLOTSOL',  true,...
                  'PLOTNODES',false,...
                  'PAUSETIME',0.1,...
                  'FIXAXIS',  false,...
                  'AXISV',    [-1 1 -1 1],...
                  'AXISP',    [-1 1 -1 1])%will be extended soon, currently unused
    anasol@function_handle
    xresolution@double=1000;
  end
  
  methods
    function this = Plotter1D(mesh,anasol)
      %comment
      
      this.mesh   =mesh;
      this.params.AXISV(1)=this.mesh.ele(1).verticepos(1);
      this.params.AXISV(2)=this.mesh.ele(end).verticepos(2);
      this.params.AXISP(1)=this.mesh.ele(1).verticepos(1);
      this.params.AXISP(2)=this.mesh.ele(end).verticepos(2);
      
      this.anasol=anasol;
      
    end
    
    
    function [] = Set(this, field, value)
      %comment
      
      if isfield(this.params,field)==0
        error(['<',field,'> is not a valid Parameter of Plotter']);
      else
        this.params_=setfield(this.params,field,value);
      end     
    end
    
    
    function this = PlotSol(this,fhandle,sol,totaltime)
      %comment
      
      x=this.mesh.nodevec;
      x2=linspace(0,1,1000);
      asol=this.anasol(x2,totaltime);
      figure(fhandle);
      clf
      
      subplot(2,1,1);%plot solution for v on the left side
      if this.params.FIXAXIS
        axis(this.params.AXISV)
      end
      for iterele=this.mesh.ele
        curvdofs=iterele.get_vDofs();
        curvsol=sol(curvdofs);
        this.PlotSolEle(fhandle,iterele,curvsol);
        title('v-solution');
      end
      p=plot(x2,asol(1,:),'-.k','LineWidth',1);
      text(0.05,0.8,['t=',num2str(totaltime)]);
      legend(p,'analytic solution');
      
      subplot(2,1,2);%plot solution for p on the right side
      if this.params.FIXAXIS
        axis(this.params.AXISP)
      end
      for iterele=this.mesh.ele
        curpdofs=iterele.get_pDofs();
        curpsol=sol(curpdofs);
        this.PlotSolEle(fhandle,iterele,curpsol);
        title('p-solution');
      end
      p=plot(x2,asol(2,:),'-.k','LineWidth',1);
      text(0.05,0.8,['t=',num2str(totaltime)]);
      legend(p,'analytic solution');
      
    end
    
    function PlotSol3D(this,f,xvec,timevec,solmat)

      figure(f)
      
      subplot(1,2,1);
      [X,T]=meshgrid(xvec,timevec);
      surf(X,T,solmat(1:2:end,:)');
      xlabel('x');
      ylabel('t');
      zlabel('v');
      title('v-solution');
      shading interp
      lighting gouraud
      hold on
      contour3(X,T,solmat(1:2:end,:)','k','LineWidth',2)
      
      subplot(1,2,2);
      [X,T]=meshgrid(xvec,timevec);
      surf(X,T,solmat(1:2:end,:)');
      xlabel('x');
      ylabel('t');
      zlabel('p');
      title('p-solution');
      shading interp
      lighting gouraud
      hold on
      contour3(X,T,solmat(1:2:end,:)','k','LineWidth',2)
      
      colorbar
    end
    
    function PlotSol2D(this,f,xvec,timevec,solmat)

      figure(f)
      
      maxsolv=max(max(solmat(1:2:end,:)))
      minsolv=min(min(solmat(1:2:end,:)))
      c1v=[0.3*maxsolv+0.7*minsolv  0.4*maxsolv+0.6*minsolv  0.45*maxsolv+0.55*minsolv]
      c2v=[0.7*maxsolv+0.3*minsolv  0.6*maxsolv+0.4*minsolv  0.55*maxsolv+0.45*minsolv]
      
      
      maxsolp=max(max(solmat(2:2:end,:)))
      minsolp=min(min(solmat(2:2:end,:)))
      c1p=[0.3*maxsolp+0.7*minsolp  0.4*maxsolp+0.6*minsolp  0.45*maxsolp+0.55*minsolp]
      c2p=[0.7*maxsolp+0.3*minsolp  0.6*maxsolp+0.4*minsolp  0.55*maxsolp+0.45*minsolp]

      
      [X,T]=meshgrid(xvec,timevec);
      
      subplot(1,2,1);
      imagesc('XData',xvec,'YData',timevec,'CData',solmat(1:2:end,:)')
      hold on
      %contour(X,T,solmat(1:2:end,:)',[-0.5 -0.3 -0.1 -0.05 0.05 0.1 0.3 0.5 ],'k','LineWidth',2,'ShowText','on');
      %contour(X,T,solmat(1:2:end,:)',[-0.5 -0.3 -0.1 -0.05 0.05 0.1 0.3 0.5 ],'k','LineWidth',1);
      contour(X,T,solmat(1:2:end,:)',[c1v c2v],'k','LineWidth',1);
      xlabel('x');
      ylabel('t');
      zlabel('v');
      colormap('hsv')
      title('v-solution');
      shading interp
      lighting gouraud
      colorbar
      axis([min(xvec), max(xvec), timevec(1), timevec(end)]);
      
      subplot(1,2,2);
      imagesc('XData',xvec,'YData',timevec,'CData',solmat(2:2:end,:)')
      hold on
      %contour(X,T,solmat(2:2:end,:)','k','LineWidth',2);
      %contour(X,T,solmat(2:2:end,:)',[-0.5 -0.3 -0.1 -0.05 0.05 0.1 0.3 0.5 ],'k','LineWidth',1);
      %contour(X,T,solmat(1:2:end,:)','k','LineWidth',1);
      contour(X,T,solmat(2:2:end,:)',[c1p c2p],'k','LineWidth',1);
      xlabel('x');
      ylabel('t');
      zlabel('v');
      title('p-solution');
      shading interp
      lighting gouraud
      axis([min(xvec), max(xvec), timevec(1), timevec(end)]);
      
      
      
      colorbar
    end
    
%     function PlotSol2D(this,f,xvec,timevec,solmat)
% 
%       figure(f)
%       hold on
%       
%       solmatv=solmat(1:2:end,:);
%       solmatp=solmat(2:2:end,:);
%       
%       
%       
%       
%       numele=length(this.mesh.ele);
%       ppele=floor(this.xresolution/numele);
%       if ppele<2
%         ppele=2;
%       end
%       
%       for curele=this.mesh.ele
%         
%         curx=linspace(curele.verticepos(1),curele.verticepos(end),ppele)
%         
%         
%         solmatelev=zeros(ppele,length(timevec));
%         solmatelep=zeros(ppele,length(timevec));
%         
%         for tstep=1:length(timevec)
%         
%           curv=curx*0;
%           curp=curx*0;
%           for ipoly = 1: curele.polygrad+1
%             for xi=curx
%               curv = curv+lagpol(curele.lagnodes,ipoly,curx)*solmatv(curele.nodeids(ipoly),tstep);
%               curp = curp+lagpol(curele.lagnodes,ipoly,curx)*solmatp(curele.nodeids(ipoly),tstep);
%             end
%           end
%           
%           solmatelev(:,tstep)=curv;
%           solmatelep(:,tstep)=curp;
%         end
%         
%         
%         [X,T]=meshgrid(curx,timevec);
%       
%         subplot(1,2,1);
%         imagesc('XData',curx,'YData',timevec,'CData',solmatelev');
%         hold on
%         contour(X,T,solmatelev','k','LineWidth',2);
%         xlabel('x');
%         ylabel('t');
%         zlabel('v');
%         title('v-solution');
%         shading interp
%         lighting gouraud
% 
%         subplot(1,2,2);
%         imagesc('XData',curx,'YData',timevec,'CData',solmatelep')
%         hold on
%         contour(X,T,solmatelep','k','LineWidth',2);
%         xlabel('x');
%         ylabel('t');
%         zlabel('p');
%         title('p-solution');
%         shading interp
%         lighting gouraud
%         
% 
%       end
%       
%       colorbar
%     end
    
    
    function [] = PlotAnimation(this,f,totaltimevec,U)
      
      figure(f)
      for k=1:length(totaltimevec)
        this.PlotSol(f,U(:,k),totaltimevec(k));
        drawnow;
        pause(0.01);
      end
    end
    
    
    
    function this = PlotSolEle(this,fhandle,ele,sol)
      %comment
      validateattributes(sol,{'double'},{'vector','numel',ele.polygrad+1},'Plot','sol',2);
      
      hold on
      grid on
      
      if this.params.PLOTNODES
        plot(ele.lagnodes,ele.lagnodes*0,'-ok');
      end
      
      numpoints=100;
      x=linspace(ele.verticepos(1),ele.verticepos(2),numpoints);
      
      y=zeros(1,numpoints);
      for ipoly = 1: ele.polygrad+1
        for xi=x
          y = y+lagpol(ele.lagnodes,ipoly,x)*sol(ipoly);
        end
      end
      
      y=y/numpoints;%TODO no idea why that is neccesary
      plot(x,y);
      
    end
    
    
    function this = PlotErr(this,fhandle,errmat,timevec)
      
      figure(fhandle)
      
      subplot(1,2,1)
      %semilogy(timevec,errmat(1,:));
      plot(timevec,errmat(1,:));
      grid on
      xlabel('time');
      ylabel('L2-error');
      title('v-error');
      
      subplot(1,2,2)
      %semilogy(timevec,errmat(2,:));
      plot(timevec,errmat(2,:));
      grid on
      xlabel('time');
      ylabel('L2-error');
      title('p-error');
      
    end
    
  end%end methods
  
end

