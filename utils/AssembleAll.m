function [ M,S ] = AssembleAll( mesh )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% create M Matrix
M=zeros(mesh.numdof,mesh.numdof);

for iterele=mesh.ele
  M(iterele.dofs,iterele.dofs)=M(iterele.dofs,iterele.dofs)+iterele.EvaluateM();
end

%create S Matrix
S=zeros(mesh.numdof,mesh.numdof);
for iterele=mesh.ele
  S(iterele.dofs,iterele.dofs)=S(iterele.dofs,iterele.dofs)+iterele.EvaluateS();
end

% % create F matrix
% global Fversion
% if strcmp(Fversion,'new')
%   F=mesh.EvaluateF;
% elseif strcmp(Fversion,'hdg')
%   F=mesh.EvaluateF_hdg;
% else
%   error(['unrecognized global variable Fversion: ',Fversion])
% end
% 
% Fbound=0;


end

