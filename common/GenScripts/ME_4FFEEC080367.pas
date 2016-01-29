unit tfwKeyWordPrim;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
;

type
 TtfwKeyWordPrim = class(Tl3PrimString)
  procedure Create(const aKeyword: Il3CString);
 end;//TtfwKeyWordPrim
 
implementation

uses
 l3ImplUses
;

end.
