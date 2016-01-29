unit evQueryCardProcessor;

interface

uses
 l3IntfUses
 , evEditorWindowProcessor
 , l3Variant
 , l3Types
 , nevBase
;

type
 TevQueryCardProcessor = class(TevEditorWindowProcessor)
  function NeedAdd(Parent: Tl3Variant;
   Child: Tl3Variant;
   var aIndex: Integer): Boolean;
 end;//TevQueryCardProcessor
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evControlParaConst
 , k2Except
 , k2Tags
 , ReqRow_Const
 , ReqCell_Const
 , nevTools
;

end.
