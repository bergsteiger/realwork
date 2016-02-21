unit evWindowCursor;
 {* Курсор, привязанный к окну, которое имеет Handle }

// Модуль: "w:\common\components\gui\Garant\Everest\evWindowCursor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCursorController
 , afwCaret
 , nevBasePointList
 , nevTools
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Variant
;

type
 TevWindowCursor = class(TevCursorController)
  {* Курсор, привязанный к окну, которое имеет Handle }
  private
   f_WasCollapsed: Boolean;
   f_Updates: TnevBasePointList;
   f_Caret: TafwCaret;
    {* Поле для свойства Caret }
   f_xxxLock: Integer;
    {* Поле для свойства xxxLock }
  protected
   function pm_GetCollapsed: Boolean; virtual;
   function pm_GetLocked: Boolean;
   procedure Refresh;
    {* Обновить курсор }
   function UpdateCursor(const aCursor: InevBasePoint): Boolean; virtual;
   procedure ShowCaret;
   function IsBlockCursor(const aCursor: InevBasePoint): Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoCursorChanged(const aCursor: InevBasePoint); override;
   procedure DoSetDocument(aValue: Tl3Tag); override;
  public
   constructor Create(const aView: InevInputView;
    anOwner: TWinControl); reintroduce;
   procedure SetFocus; virtual;
    {* Окно получило фокус }
   procedure KillFocus;
    {* Окно потеряло фокус }
   function Show: Boolean;
    {* Показать курсор }
   procedure Lock; override;
    {* Запретить нотификацию об изменениях }
   procedure Unlock; override;
    {* Разрешить нотификацию об изменениях }
  public
   property Caret: TafwCaret
    read f_Caret;
   property xxxLock: Integer
    read f_xxxLock
    write f_xxxLock;
   property Collapsed: Boolean
    read pm_GetCollapsed;
    {* Есть ли выделение? }
   property Locked: Boolean
    read pm_GetLocked;
    {* Запрещена нотификация об изменениях? }
 end;//TevWindowCursor

implementation

uses
 l3ImplUses
 , l3Base
 , l3InterfacesMisc
 , nevBase
;

function TevWindowCursor.pm_GetCollapsed: Boolean;
//#UC START# *48E3723E0107_487B5D7202DCget_var*
//#UC END# *48E3723E0107_487B5D7202DCget_var*
begin
//#UC START# *48E3723E0107_487B5D7202DCget_impl*
 Result := true;
//#UC END# *48E3723E0107_487B5D7202DCget_impl*
end;//TevWindowCursor.pm_GetCollapsed

function TevWindowCursor.pm_GetLocked: Boolean;
//#UC START# *48E378EC00FF_487B5D7202DCget_var*
//#UC END# *48E378EC00FF_487B5D7202DCget_var*
begin
//#UC START# *48E378EC00FF_487B5D7202DCget_impl*
 Result := (f_xxxLock > 0);
//#UC END# *48E378EC00FF_487B5D7202DCget_impl*
end;//TevWindowCursor.pm_GetLocked

constructor TevWindowCursor.Create(const aView: InevInputView;
 anOwner: TWinControl);
//#UC START# *48E37037038C_487B5D7202DC_var*
//#UC END# *48E37037038C_487B5D7202DC_var*
begin
//#UC START# *48E37037038C_487B5D7202DC_impl*
 inherited Create(aView);
 f_Caret := TafwCaret.Create(anOwner);
 f_Updates := TnevBasePointList.Make;
//#UC END# *48E37037038C_487B5D7202DC_impl*
end;//TevWindowCursor.Create

procedure TevWindowCursor.SetFocus;
 {* Окно получило фокус }
//#UC START# *48E370FF0359_487B5D7202DC_var*
//#UC END# *48E370FF0359_487B5D7202DC_var*
begin
//#UC START# *48E370FF0359_487B5D7202DC_impl*
 if (f_Caret <> nil) then
  with f_Caret do
  begin
   Linked := True;
   Refresh;
   Visible := True;
  end;//with f_Caret
//#UC END# *48E370FF0359_487B5D7202DC_impl*
end;//TevWindowCursor.SetFocus

procedure TevWindowCursor.KillFocus;
 {* Окно потеряло фокус }
//#UC START# *48E371100137_487B5D7202DC_var*
//#UC END# *48E371100137_487B5D7202DC_var*
begin
//#UC START# *48E371100137_487B5D7202DC_impl*
 if (f_Caret <> nil) then
  f_Caret.Linked := False;
//#UC END# *48E371100137_487B5D7202DC_impl*
end;//TevWindowCursor.KillFocus

procedure TevWindowCursor.Refresh;
 {* Обновить курсор }
//#UC START# *48E371FE00D8_487B5D7202DC_var*
//#UC END# *48E371FE00D8_487B5D7202DC_var*
begin
//#UC START# *48E371FE00D8_487B5D7202DC_impl*
 if (View <> nil) AND (View.Control <> nil) then
  View.Control.SetFlag(ev_uwfCursor);
//#UC END# *48E371FE00D8_487B5D7202DC_impl*
end;//TevWindowCursor.Refresh

function TevWindowCursor.UpdateCursor(const aCursor: InevBasePoint): Boolean;
//#UC START# *48E372190135_487B5D7202DC_var*
//#UC END# *48E372190135_487B5D7202DC_var*
begin
//#UC START# *48E372190135_487B5D7202DC_impl*
 if l3IEQ(aCursor, Cursor) then
 begin
  ShowCaret;
  Result := True;
 end//l3IEQ(aCursor, Cursor)
 else
  Result := False;
//#UC END# *48E372190135_487B5D7202DC_impl*
end;//TevWindowCursor.UpdateCursor

procedure TevWindowCursor.ShowCaret;
//#UC START# *48E373570156_487B5D7202DC_var*
//#UC END# *48E373570156_487B5D7202DC_var*
begin
//#UC START# *48E373570156_487B5D7202DC_impl*
 Refresh;
 if (View <> nil) then
 begin
  View.MakeCaretVisible;
  if (View.Control <> nil) then
   View.Control.CursorChanged;
 end;//View <> nil
//#UC END# *48E373570156_487B5D7202DC_impl*
end;//TevWindowCursor.ShowCaret

function TevWindowCursor.IsBlockCursor(const aCursor: InevBasePoint): Boolean;
//#UC START# *48E37364035C_487B5D7202DC_var*
//#UC END# *48E37364035C_487B5D7202DC_var*
begin
//#UC START# *48E37364035C_487B5D7202DC_impl*
 Result := false;
//#UC END# *48E37364035C_487B5D7202DC_impl*
end;//TevWindowCursor.IsBlockCursor

function TevWindowCursor.Show: Boolean;
 {* Показать курсор }
//#UC START# *48E375C200CF_487B5D7202DC_var*
//#UC END# *48E375C200CF_487B5D7202DC_var*
begin
//#UC START# *48E375C200CF_487B5D7202DC_impl*
 Result := (Cursor <> nil) AND UpdateCursor(Cursor);
//#UC END# *48E375C200CF_487B5D7202DC_impl*
end;//TevWindowCursor.Show

procedure TevWindowCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_487B5D7202DC_var*
//#UC END# *479731C50290_487B5D7202DC_var*
begin
//#UC START# *479731C50290_487B5D7202DC_impl*
 l3Free(f_Updates);
 l3Free(f_Caret);
 inherited;
//#UC END# *479731C50290_487B5D7202DC_impl*
end;//TevWindowCursor.Cleanup

procedure TevWindowCursor.DoCursorChanged(const aCursor: InevBasePoint);
//#UC START# *48E27228010F_487B5D7202DC_var*
var
 l_Cursor : InevBasePoint;
//#UC END# *48E27228010F_487B5D7202DC_var*
begin
//#UC START# *48E27228010F_487B5D7202DC_impl*
 inherited;
 if (aCursor <> nil) then
 begin
  l_Cursor := aCursor.TopParentPoint;
  if (f_xxxLock <= 0) then
   UpdateCursor(l_Cursor)
  else
  if (LockCaret <= 0) AND (f_Updates.IndexOf(l_Cursor) < 0) then
   f_Updates.Add(l_Cursor);
 end;//aCursor <> nil
//#UC END# *48E27228010F_487B5D7202DC_impl*
end;//TevWindowCursor.DoCursorChanged

procedure TevWindowCursor.Lock;
 {* Запретить нотификацию об изменениях }
//#UC START# *48E275700381_487B5D7202DC_var*
//#UC END# *48E275700381_487B5D7202DC_var*
begin
//#UC START# *48E275700381_487B5D7202DC_impl*
 inherited;
 Inc(f_xxxLock);
 if (f_xxxLock = 1) then
  f_WasCollapsed := Collapsed;
//#UC END# *48E275700381_487B5D7202DC_impl*
end;//TevWindowCursor.Lock

procedure TevWindowCursor.Unlock;
 {* Разрешить нотификацию об изменениях }
//#UC START# *48E27580037A_487B5D7202DC_var*
var
 BU : Boolean;
 BC : InevBasePoint;
//#UC END# *48E27580037A_487B5D7202DC_var*
begin
//#UC START# *48E27580037A_487B5D7202DC_impl*
 Dec(f_xxxLock);
 if (f_xxxLock <= 0) then
 begin
  f_xxxLock := 0;
  BU := False;
  while (f_Updates.Count > 0) do
  begin
   BC := f_Updates.Last;
   if not IsBlockCursor(BC) then
    CursorChanged(BC)
   else
   if not BU then
   begin
    BU := True;
    if not (f_WasCollapsed AND Collapsed) then
     CursorChanged(BC);
   end;//BC <> f_Start
   with f_Updates do
    if (Count > 0) then
     Delete(Hi)
    else
     Break;
  end;//while (Count..
 end;//f_xxxLock <= 0..
 inherited;
//#UC END# *48E27580037A_487B5D7202DC_impl*
end;//TevWindowCursor.Unlock

procedure TevWindowCursor.DoSetDocument(aValue: Tl3Tag);
//#UC START# *48E276B10286_487B5D7202DC_var*
//#UC END# *48E276B10286_487B5D7202DC_var*
begin
//#UC START# *48E276B10286_487B5D7202DC_impl*
 if (f_Updates <> nil) then
  f_Updates.Clear;
 inherited;
 {$IfDef Nemesis}
 f_xxxLock := 0;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=201491355
 // Это заплатка. Т.к. при переключении баз с двумя открытыми окнами
 // почему-то залипает  f_xxxLock := 1.
 // Где - трассировкой понять не удалось :-(
 {$EndIf Nemesis}
//#UC END# *48E276B10286_487B5D7202DC_impl*
end;//TevWindowCursor.DoSetDocument

end.
