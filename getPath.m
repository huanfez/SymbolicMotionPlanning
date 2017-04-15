function[xPath, yPath,t] = getPath(output)
% function[xPath, yPath, cPath] = getPath(output, gridWidth, gridLength)
%   Takes NuSMV output and uses regexp to pull out path of cells.  Then
%   uses discretization (gridWidth, gridLength) to convert those cells to
%   x,y coordinates.
%       xPath - list of x-coordinates
%       yPath - list of y-coordinates
%       cPath - path listed as cell numbers

t= regexp(output, '  cPath = (\d*)', 'tokens');
pathNum=zeros(1,length(t));
for i=1:length(t)
    pathNum(1,i)=str2double(t{1,i});
end
xPath = mod(pathNum,10)+1;
yPath = floor(pathNum/10)+1;
% command that converts cell path to x,y path