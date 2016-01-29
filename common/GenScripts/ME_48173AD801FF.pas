unit nevFormatPoolBase;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevTools
;

type
 TnevFormatPoolBase = class(Tl3CProtoObject)
  procedure Create(const aDocument: InevObjectHolder);
 end;//TnevFormatPoolBase
 
implementation

uses
 l3ImplUses
;

end.
