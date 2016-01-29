unit ddTextParaString;

interface

uses
 l3IntfUses
 , l3Base
 , ddTextParagraph
;

type
 TddTextParaString = class(Tl3String)
  procedure Create(const aTextPara: TddTextParagraph);
 end;//TddTextParaString
 
implementation

uses
 l3ImplUses
 , ddTextSegment
;

end.
