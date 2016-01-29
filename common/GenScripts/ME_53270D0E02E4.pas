unit nevDocumentContainerPrimPrim;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 TnevDocumentContainerPrimPrim = class(Tl3Variant, IUnknown)
 end;//TnevDocumentContainerPrimPrim
 
implementation

uses
 l3ImplUses
 , DocumentContainer_Const
 , l3InterfacesMisc
 , k2NullTagImpl
 , l3String
;

end.
