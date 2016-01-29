unit evMultiSelectEditorWindow;

interface

uses
 l3IntfUses
 , evCustomEditorWindowModelPart
 , evCustomEditorWindow
;

type
 TevMultiSelectEditorWindow = class(TevCustomEditorWindowModelPart)
  {* Редактор с возможностью множественного выделения }
 end;//TevMultiSelectEditorWindow
 
implementation

uses
 l3ImplUses
 , evMultiSelection
 , evMultiSelectEditorWindowHotSpot
 , TtfwClassRef_Proxy
;

end.
