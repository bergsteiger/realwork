unit nevStringItemPara;

interface

uses
 l3IntfUses
 , nevTextPara
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevStringItemPara = class(TnevTextPara)
  procedure Create(aTag: Tl3Variant;
   anIndex: Integer);
  function Make(aTag: Tl3Variant;
   anIndex: Integer): InevTextPara;
 end;//TnevStringItemPara
 
implementation

uses
 l3ImplUses
;

end.
