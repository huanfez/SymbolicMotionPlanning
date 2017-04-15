
%%%%%%%%%%%%%%%%%%%%%%%%Initialization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Be careful when change the value of targets, it should not overlap%%%
%%%%%with obstacles, and modify the bscSpec in the meantime%%%%%%%%%%%%%%%
TargetPos=[6,4; 8,8; 2,2];%%Targets' position
ObsPos=[3,3; 3,4; 4,3; 5,3; 4,2; 7,6; 8,6; 9,6];%%Obstacles' position
currentPos=[1,2];%%Initial position
bscSpec='LTLSPEC !(F(cPath=35)& F(cPath=77)& F(cPath=11))';%%original LTL specification

%%%%%%%%%%%%%%%%%%plot targets
figure(1)
plot(TargetPos(:,1), TargetPos(:,2), 'o','MarkerSize',20, 'MarkerFaceColor', [1 1 0.5]);
hold on
plot(ObsPos(:,1), ObsPos(:,2), 's','MarkerSize',25, 'MarkerFaceColor', [1 0.95 0.95])

%%%%%%%%%%%%%%%%%%grid partition
xG=0.5:11;
yG=0.5:11;
xyG=meshgrid(xG,yG);
plot(xG,xyG,'k')
plot(xyG,yG,'k')

%%%%%%%%%%%%%%%%%make the first planning
plot1=plot(currentPos(1,1),currentPos(1,2), 'o','MarkerSize',20, 'MarkerFaceColor', [0 1 1]);%%show initial position
plot(currentPos(1,1),currentPos(1,2), 'o','MarkerSize',20, 'MarkerFaceColor', [0 1 1]);
%%Show detected area
cirl=viscircles(currentPos,1.2);

%%make first path planning
[xPathP,yPathP,t]=mcPathPlan(currentPos,bscSpec);
plot(xPathP,yPathP,'-. ')

%%Check whether task has been finished, and make path planning%%%%%%%%%%%%%
%%1.Whenever meet with an target, change it into an obstacle to avoid%%%%%%
%%collision; stop once the targets have been reached over%%%%%%%%%%%%%%%%%%
%%2.whenever meet with an obstacle, remake motion planning%%%%%%%%%%%%%%%%%
CurSpec=bscSpec;
counterTarget=length(TargetPos);%%used as counter of targets' amout
while(counterTarget>0)
    IsNotTarget=1;
    PlanNum=2;

    %%%if not reach a target position, just check obstacle and make
    %%%planning
    while(IsNotTarget==1)
        
        [FndObsNum,FndObsPos]= ObsCheck(currentPos,ObsPos);
        if FndObsNum>=1&&FndObsPos(1,1)~=0
            for i=1:FndObsNum
                CurSpec=NewObsLTLSpec(FndObsPos(i,:),CurSpec);
            end
            plot(FndObsPos(:,1), FndObsPos(:,2), 's','MarkerSize', 30, 'MarkerFaceColor', [1 0 0])%%%%%show dected obstacles
            PlanNum=2;
            [xPathP,yPathP,t]=mcPathPlan(currentPos,CurSpec);
            plot(xPathP,yPathP,'-. ')
        end
        pause(1)
        set(cirl,'Visible','off')
        set(plot1,'marker','none')

        currentPos=[xPathP(PlanNum),yPathP(PlanNum)];
        
        %%%show and update robot position
        plot1=plot(currentPos(1,1),currentPos(1,2), 'o','MarkerSize',20, 'MarkerFaceColor', [0 1 0]);
        cirl=viscircles(currentPos,1.2);
  
        
        PlanNum=PlanNum+1;%%%important for deciding where next position go 
        
        %%%if reached the target, change into the other specification
        %%%generation method
        for i=1:length(TargetPos)
             if currentPos(1,1)==TargetPos(i,1)&&currentPos(1,2)==TargetPos(i,2)
                 IsNotTarget=0;
                 plot(currentPos(1,1),currentPos(1,2), 'o','MarkerSize',20, 'MarkerFaceColor', [1 0 1])
             end
        end
        
    end
    
    counterTarget=counterTarget-1;
    if counterTarget==0
        break;
    end
    
    %%%%%%%%%%%IMPORTANT sequence%%%%%%%%%%%%%%%%%%%%%
    [FndObsNum,FndObsPos]= ObsCheck(currentPos,ObsPos);%%%%%%%%%%check if there are onstacles%%%
    if FndObsNum>=1&&FndObsPos(1,1)~=0
         for i=1:FndObsNum
                CurSpec=NewObsLTLSpec(FndObsPos(i,:),CurSpec);
         end
         plot(FndObsPos(:,1), FndObsPos(:,2), 's','MarkerSize', 30, 'MarkerFaceColor', [1 0 0])%%%%%show dected obstacle
    end
    [xPathP,yPathP,t]=mcPathPlan(currentPos,CurSpec);%%%%%%%%%obstacle based motion planning new path
    plot(xPathP,yPathP,'-. ')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    CurSpec=NewTarLTLSpec(currentPos,CurSpec);%%%%%%change target into obstacle spec%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    pause(2)   
    set(cirl,'Visible','off')
    set(plot1,'marker','none')   
    currentPos=[xPathP(2),yPathP(2)];%%%%%%move forward
    plot1=plot(currentPos(1,1),currentPos(1,2), 'o','MarkerSize',20, 'MarkerFaceColor', [0 1 0]);    
    cirl=viscircles(currentPos,1.2);
    
    [xPathP,yPathP,t]=mcPathPlan(currentPos,CurSpec);%%%%%%%%%motion planning new path
    plot(xPathP,yPathP,'-. ')

end
set(cirl,'Visible','off')
%plot(currentPos(1,1),currentPos(1,2),'o','MarkerSize',20, 'MarkerFaceColor', [0 0.8 0.8])
hold off
