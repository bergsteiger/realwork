unit MouseClickOnPoint.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
;

type
 _MouseClickOnPoint_ = class
  {* ўелчок мышью на точке в редакторе }
  procedure ClickOnPoint(aText: TevCustomEditorWindow;
   aNeedMouseUp: Boolean);
 end;//_MouseClickOnPoint_
 
implementation

uses
 l3ImplUses
 , nevTools
 , l3Base
;

end.
