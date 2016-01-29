unit l3SearchNodePrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 Tl3SearchNodePrim = class(Tl3ProtoObject)
  procedure Create(const aText: Il3CString;
   const aData: IUnknown);
 end;//Tl3SearchNodePrim
 
implementation

uses
 l3ImplUses
;

end.
