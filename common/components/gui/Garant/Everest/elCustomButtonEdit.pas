unit elCustomButtonEdit;

// Модуль: "w:\common\components\gui\Garant\Everest\elCustomButtonEdit.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TelCustomButtonEdit" MUID: (482ACFA703C2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , elCustomEdit
 , Classes
 , CustomElGraphicButton
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , l3Core
;

type
 TelCustomButtonEdit = class(TelCustomEdit)
  private
   f_OnButtonClick: TNotifyEvent;
   f_Button: TCustomElGraphicButton;
  private
   procedure WMKeyDown(var Message: TWMKey); message WM_KEYDOWN;
   procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
   procedure ButtonClickTransfer(Sender: TObject);
    {* TNotifyEvent. }
   procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WindowPosChanged;
  protected
   function Get_ButtonWidth: Integer;
   procedure AdjustWidth; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure SetEditRect; override;
   {$If NOT Defined(NoVCL)}
   procedure KeyPress(var Key: Char); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  protected
   property OnButtonClick: TNotifyEvent
    read f_OnButtonClick
    write f_OnButtonClick;
   property ButtonWidth: Integer
    read Get_ButtonWidth;
   property Button: TCustomElGraphicButton
    read f_Button;
 end;//TelCustomButtonEdit

implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TElEditBtn = class(TCustomElGraphicButton)
 end;//TElEditBtn

function TelCustomButtonEdit.Get_ButtonWidth: Integer;
//#UC START# *482C46460006_482ACFA703C2get_var*
{ Returns the Width property from the FButton subcomponent. }
//#UC END# *482C46460006_482ACFA703C2get_var*
begin
//#UC START# *482C46460006_482ACFA703C2get_impl*
  Result := f_Button.Width;
//#UC END# *482C46460006_482ACFA703C2get_impl*
end;//TelCustomButtonEdit.Get_ButtonWidth

procedure TelCustomButtonEdit.AdjustWidth;
//#UC START# *4F2AA6F20181_482ACFA703C2_var*
//#UC END# *4F2AA6F20181_482ACFA703C2_var*
begin
//#UC START# *4F2AA6F20181_482ACFA703C2_impl*
 // - ничего не делаем
//#UC END# *4F2AA6F20181_482ACFA703C2_impl*
end;//TelCustomButtonEdit.AdjustWidth

procedure TelCustomButtonEdit.WMKeyDown(var Message: TWMKey);
//#UC START# *482C45BB0247_482ACFA703C2_var*
//#UC END# *482C45BB0247_482ACFA703C2_var*
begin
//#UC START# *482C45BB0247_482ACFA703C2_impl*
  with Message do
    if (CharCode = VK_ESCAPE) and (KeyDataToShiftState(KeyData) = []) then
    begin
      GetParentForm(Self).Perform(CM_DIALOGKEY, CharCode, KeyData);
      inherited;
    end
    else
    if (CharCode = VK_RETURN) and (KeyDataToShiftState(KeyData) = [ssCtrl]) then
    begin
      SendMessage(Handle, WM_CHAR, TMessage(Message).wParam, TMessage(Message).lParam);
      CharCode := 0;
    end
    else
      inherited;
//#UC END# *482C45BB0247_482ACFA703C2_impl*
end;//TelCustomButtonEdit.WMKeyDown

procedure TelCustomButtonEdit.CMEnabledChanged(var Msg: TMessage);
//#UC START# *482C45FF0183_482ACFA703C2_var*
//#UC END# *482C45FF0183_482ACFA703C2_var*
begin
//#UC START# *482C45FF0183_482ACFA703C2_impl*
  inherited;
  NotifyControls(CM_ENABLEDCHANGED);
  Invalidate;
//#UC END# *482C45FF0183_482ACFA703C2_impl*
end;//TelCustomButtonEdit.CMEnabledChanged

procedure TelCustomButtonEdit.ButtonClickTransfer(Sender: TObject);
 {* TNotifyEvent. }
//#UC START# *482C4664002B_482ACFA703C2_var*
{ Transfers f_Button OnClick event to the outside world. }
//#UC END# *482C4664002B_482ACFA703C2_var*
begin
//#UC START# *482C4664002B_482ACFA703C2_impl*
  if (assigned(f_OnButtonClick)) then
    f_OnButtonClick(Self); { Substitute Self for subcomponent's Sender. }
//#UC END# *482C4664002B_482ACFA703C2_impl*
end;//TelCustomButtonEdit.ButtonClickTransfer

procedure TelCustomButtonEdit.WMWindowPosChanged(var Message: TWMWindowPosChanged);
//#UC START# *4B6C695B0031_482ACFA703C2_var*
//#UC END# *4B6C695B0031_482ACFA703C2_var*
begin
//#UC START# *4B6C695B0031_482ACFA703C2_impl*
 inherited;
 {$If not defined(DesignTimeLibrary)}
 if afw.NeedFixWMSIZE(Self) then
  SetEditRect;
 {$IfEnd} 
//#UC END# *4B6C695B0031_482ACFA703C2_impl*
end;//TelCustomButtonEdit.WMWindowPosChanged

procedure TelCustomButtonEdit.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_482ACFA703C2_var*
//#UC END# *479731C50290_482ACFA703C2_var*
begin
//#UC START# *479731C50290_482ACFA703C2_impl*
  FreeAndNil(f_Button);
  inherited;
//#UC END# *479731C50290_482ACFA703C2_impl*
end;//TelCustomButtonEdit.Cleanup

constructor TelCustomButtonEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_482ACFA703C2_var*
//#UC END# *47D1602000C6_482ACFA703C2_var*
begin
//#UC START# *47D1602000C6_482ACFA703C2_impl*
  inherited Create(AOwner);
  f_Button := TElEditBtn.Create(nil);
  with TElEditBtn(f_Button) do
  begin
    Cursor := crArrow;
    ParentColor := false;
    Color := clBtnFace;
    Parent := Self;
    UseXPThemes := false;
    UseXPThemes := true;
    OnClick := ButtonClickTransfer;
    Width := 15;
    Flat := false;
    Visible := true;
    AdjustSpaceForGlyph := false;
    if csDesigning in ComponentState then
      Enabled := false;
  end; { f_Button }
  TabStop := true;
//#UC END# *47D1602000C6_482ACFA703C2_impl*
end;//TelCustomButtonEdit.Create

procedure TelCustomButtonEdit.SetEditRect;
//#UC START# *482BFA6D022D_482ACFA703C2_var*
var
  Loc : TRect;
  HOffs,
  VOffs: integer;
//#UC END# *482BFA6D022D_482ACFA703C2_var*
begin
//#UC START# *482BFA6D022D_482ACFA703C2_impl*
  if not HandleAllocated or (csDestroying in ComponentState) then
  begin
   inherited;
   exit;
  end;//not HandleAllocated..

  HOffs := 0;
  VOffs := 0;
  if (BorderStyle = bsSingle) and (not Ctl3D) then
  begin
   Hoffs := GetSystemMetrics(SM_CYBORDER);
   Voffs := GetSystemMetrics(SM_CXBORDER);
  end;//BorderStyle = bsSingle
  if f_Button.Visible then
   f_Button.BoundsRect := Rect(ClientWidth - f_Button.Width- HOffs, VOffs, ClientWidth - HOffs, ClientHeight - VOffs);

  SetRect(Loc, HOffs, VOffs, ClientWidth - HOffs, ClientHeight - VOffs);
  if f_Button.Visible then
  begin
   Dec(Loc.Right, f_Button.Width);
   //RMargin := Self.BoundsRect.Right - f_Button.BoundsRect.Left;
   RMargin := f_Button.Width + 1;
  end//f_Button.Visible
  else
   RMargin := 0;
  inherited{ SetEditRect(Loc)};
//#UC END# *482BFA6D022D_482ACFA703C2_impl*
end;//TelCustomButtonEdit.SetEditRect

{$If NOT Defined(NoVCL)}
procedure TelCustomButtonEdit.KeyPress(var Key: Char);
//#UC START# *482C4E0E01E4_482ACFA703C2_var*
//#UC END# *482C4E0E01E4_482ACFA703C2_var*
begin
//#UC START# *482C4E0E01E4_482ACFA703C2_impl*
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
  begin
    {if HandleDialogKeys then
       GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
    }if Key = Char(VK_RETURN) then
    begin
      inherited KeyPress(Key);
      if not false then
         Key := #0;
      Exit;
    end;
  end;
  inherited KeyPress(Key);
//#UC END# *482C4E0E01E4_482ACFA703C2_impl*
end;//TelCustomButtonEdit.KeyPress
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TelCustomButtonEdit);
 {* Регистрация TelCustomButtonEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
