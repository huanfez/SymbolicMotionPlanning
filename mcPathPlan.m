%%modeal checking based path planning
function [xPath,yPath,t]=mcPathPlan(NewInitPos,NewLtlspec)
LabelPos=NewInitPos(1,1)-1+10*(NewInitPos(1,2)-1);

%%%%%%rewrite line10 on new initial position
chanLn10=['sed -i "10s/.*/  init(cPath):=',num2str(LabelPos),';/" TarReach_revisedtest.smv '];
system(chanLn10);

%%%%%%%Rewrite line25 on new ltl specification
% chanLn25=['sed -i "25s/.*/',NewLtlspec,'/" TarReach_revisedtest.smv '];
% system(chanLn25);

fid=fopen('TarReach_revisedtest.smv','r+');
count=1;
while ~feof(fid)
    tline = fgetl(fid);
    str{count}=tline;
    if count==25
        str{count}=NewLtlspec;
    end
    count=count+1;
end
fclose(fid);

fid1=fopen('TarReach_revisedtest.smv','w+');
for j=1:1:count-1
    fprintf(fid1,'%s\n',str{j});
end
fclose(fid1);

%% Running&Planning
% run model checking to get path
% Change this path according to your system
% pathNuSMV = '/opt/NuSMV-2.6.0/bin/NuSMV'; % used to path to NuSMV.exe

% run the cmd window command to run the NuSMV model and ouptut the terminal
% result as a long string.
[~,output] = system('NuSMV TarReach_revisedtest.smv','-echo');

[xPath,yPath,t] = getPath(output);
