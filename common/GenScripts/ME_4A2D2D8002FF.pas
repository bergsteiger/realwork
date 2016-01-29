unit evDocumentPartCursorPair;

interface

uses
 l3IntfUses
 , evParaListCursorPair
 , nevTools
 , k2Interfaces
 , nevBase
;

type
 TevDocumentPartCursorPair = class(TevParaListCursorPair)
  {* Выделение для блока }
 end;//TevDocumentPartCursorPair
 
implementation

uses
 l3ImplUses
 , LeafPara_Const
 , ContentsElement_Const
 , evParaTools
 , k2Tags
 , evdStyles
 , evdInterfaces
 , Block_Const
;

end.
