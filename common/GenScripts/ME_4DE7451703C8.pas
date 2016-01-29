unit ClickOnCommentHeader.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
 , l3Units
 , nevTools
;

type
 _ClickOnCommentHeader_ = class(_MouseClickOnPoint_)
  function CheckCollapsed(aText: TevCustomEditorWindow): Boolean;
 end;//_ClickOnCommentHeader_
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
