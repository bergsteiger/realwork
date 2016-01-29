unit ColumnResizeByMouse.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
 , Classes
 , nevTools
 , l3Units
;

type
 _ColumnResizeByMouse_ = class(_Para2Point_)
  procedure SelectColumn(aText: TevCustomEditorWindow);
  function GetKeys: TShiftState;
  procedure GetColumnAndRow(var aCol: Integer;
   var aRow: Integer);
  function GetDelta: Integer;
 end;//_ColumnResizeByMouse_
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
