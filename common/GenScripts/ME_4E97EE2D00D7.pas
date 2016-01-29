unit CellSelectionByMouse.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
 , l3Units
 , nevTools
;

type
 _CellSelectionByMouse_ = class(_Para2Point_)
  function SelectCell(aText: TevCustomEditorWindow): Boolean;
 end;//_CellSelectionByMouse_
 
implementation

uses
 l3ImplUses
 , evConst
 , l3Base
;

end.
