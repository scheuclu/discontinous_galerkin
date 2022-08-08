function [numdof] = numele2numdof(pgrad,numele)

numdof=numele.*(pgrad+1);

end