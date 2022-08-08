function y = derivlagpol(lagnodes,ipol,x)

y=0;
numnodes=length(lagnodes);

for m=1:numnodes
  if m==ipol
    continue;
  end
  y=y+1./(x-lagnodes(m));
end

y=y.*lagpol(lagnodes,ipol,x);

end


% 
% 
% 
% function y = lagpol(lagnodes,ipol,x)
% 
% y=1;
% for k=1:length(lagnodes)
%   if k==ipol
%     continue
%   end
%   y=y.*(x-lagnodes(k))./(lagnodes(ipol)-lagnodes(k));
% end
% 
% 
% end