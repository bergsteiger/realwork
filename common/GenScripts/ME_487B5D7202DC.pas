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
  {* Курсор, привязанный к окну, которое имеет Handle }
  procedure Create(const aView: InevInputView;
   anOwner: TWinControl);
  procedure SetFocus;
   {* Окно получило фокус }
  procedure KillFocus;
   {* Окно потеряло фокус }
  procedure Refresh;
   {* Обновить курсор }
  function UpdateCursor(const aCursor: InevBasePoint): Boolean;
  procedure ShowCaret;
  function IsBlockCursor(const aCursor: InevBasePoint): Boolean;
  function Show: Boolean;
   {* Показать курсор }
 end;//TevWindowCursor
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3InterfacesMisc
 , nevBase
;

end.
