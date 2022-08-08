function [progresstring] = printprogress(curstep,numstep,progresstring)

line='-------------------------------------------------------------------------------';

nums=ceil(curstep/numstep*80);


line(1:nums)='#';
fprintf(repmat('\b',1,length(progresstring)))
progresstring=line;
fprintf(progresstring);

end
