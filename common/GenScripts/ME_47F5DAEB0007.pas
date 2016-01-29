unit k2ToolPrim;

interface

uses
 l3IntfUses
 , k2Tag
 , l3Variant
;

type
 Tk2ToolPrim = class(Tk2Tag, IUnknown)
  procedure Assign(Source: Tk2ToolPrim);
  function StoreToOldCache: Boolean;
  procedure SetTagQT(aTag: Tl3Variant);
 end;//Tk2ToolPrim
 
implementation

uses
 l3ImplUses
;

end.
