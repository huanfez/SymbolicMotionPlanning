function [CtainObs,FndObsPos]=ObsCheck(CurPos,ObsPos)

CtainObs=0;
FndObsPos=zeros(1,2);
FndObs=1;

for i=1:length(ObsPos)
    switch(FndObs)
        case (ObsPos(i,1)==CurPos(1,1)-1)&&(ObsPos(i,2)==CurPos(1,2)-1)
            FndObsPos(CtainObs+1,1)=CurPos(1,1)-1; FndObsPos(CtainObs+1,2)=CurPos(1,2)-1; CtainObs=CtainObs+1;
        case (ObsPos(i,1)==CurPos(1,1)  )&&(ObsPos(i,2)==CurPos(1,2)-1)
            FndObsPos(CtainObs+1,1)=CurPos(1,1)  ; FndObsPos(CtainObs+1,2)=CurPos(1,2)-1; CtainObs=CtainObs+1;
        case (ObsPos(i,1)==CurPos(1,1)+1)&&(ObsPos(i,2)==CurPos(1,2)-1)
            FndObsPos(CtainObs+1,1)=CurPos(1,1)+1; FndObsPos(CtainObs+1,2)=CurPos(1,2)-1; CtainObs=CtainObs+1;
        case (ObsPos(i,1)==CurPos(1,1)-1)&&(ObsPos(i,2)==CurPos(1,2)  )
            FndObsPos(CtainObs+1,1)=CurPos(1,1)-1; FndObsPos(CtainObs+1,2)=CurPos(1,2)  ; CtainObs=CtainObs+1;
        case (ObsPos(i,1)==CurPos(1,1)+1)&&(ObsPos(i,2)==CurPos(1,2)  )
            FndObsPos(CtainObs+1,1)=CurPos(1,1)+1; FndObsPos(CtainObs+1,2)=CurPos(1,2)  ; CtainObs=CtainObs+1;
        case (ObsPos(i,1)==CurPos(1,1)-1)&&(ObsPos(i,2)==CurPos(1,2)+1)
            FndObsPos(CtainObs+1,1)=CurPos(1,1)-1; FndObsPos(CtainObs+1,2)=CurPos(1,2)+1; CtainObs=CtainObs+1;
        case (ObsPos(i,1)==CurPos(1,1)  )&&(ObsPos(i,2)==CurPos(1,2)+1)
            FndObsPos(CtainObs+1,1)=CurPos(1,1)  ; FndObsPos(CtainObs+1,2)=CurPos(1,2)+1; CtainObs=CtainObs+1;      
        case (ObsPos(i,1)==CurPos(1,1)+1)&&(ObsPos(i,2)==CurPos(1,2)+1)
            FndObsPos(CtainObs+1,1)=CurPos(1,1)+1; FndObsPos(CtainObs+1,2)=CurPos(1,2)+1; CtainObs=CtainObs+1;
    end
end


        
        