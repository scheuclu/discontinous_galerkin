function y = lagpol(lagnodes,ipol,x)

  y=1;
  for k=1:length(lagnodes)
    if k==ipol
      continue
    end
    y=y.*(x-lagnodes(k))./(lagnodes(ipol)-lagnodes(k));
  end


end