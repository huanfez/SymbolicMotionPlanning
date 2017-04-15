function OSpec=NewObsLTLSpec(ObsPos,ltlspec)

%%%%add & G !(cPath=ObsPos(1,1)-1+10*(ObsPos(1,2)-1))
LabelPos=ObsPos(1,1)-1+10*(ObsPos(1,2)-1);

addOne=[')','& G !(cPath=',num2str(LabelPos),'))'];
OSpec=strrep(ltlspec,'))',addOne);