function TSpec=NewTarLTLSpec(TarPos,ltlspec)

%%%%add 
BeRepPos=TarPos(1,1)-1+10*(TarPos(1,2)-1);

%%%%%%%%find the string 'F (cPath=LabelPos)'
%%%%%%%%%%change the 'F' into " G !"
BeRepOne=['F(cPath=',num2str(BeRepPos),')'];
RepOne=['G!(cPath=',num2str(BeRepPos),')'];
TSpec=strrep(ltlspec,BeRepOne,RepOne);