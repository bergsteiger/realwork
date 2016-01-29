unit evWindowCursor;

interface

uses
 l3IntfUses
 , evCursorController
 , afwCaret
 , nevBasePointList
 , nevTools
 , Controls
 , l3Variant
;

type
 TevWindowCursor = class(TevCursorController)
  {* ������, ����������� � ����, ������� ����� Handle }
  procedure Create(const aView: InevInputView;
   anOwner: TWinControl);
  procedure SetFocus;
   {* ���� �������� ����� }
  procedure KillFocus;
   {* ���� �������� ����� }
  procedure Refresh;
   {* �������� ������ }
  function UpdateCursor(const aCursor: InevBasePoint): Boolean;
  procedure ShowCaret;
  function IsBlockCursor(const aCursor: InevBasePoint): Boolean;
  function Show: Boolean;
   {* �������� ������ }
 end;//TevWindowCursor
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3InterfacesMisc
 , nevBase
;

end.
