function [] = consoleline(text,linebreak)

line='-------------------------------------------------------------------------------';
line(1:length(text))=text;
disp(line);
if linebreak
  disp(' ');
end

end