unit nsOpenDialog;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsOpenDialog.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsOpenDialog" MUID: (4DDD468D0131)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsSaveDialog
 , vtPanel
 , vtCheckBox
 , Classes
 //#UC START# *4DDD468D0131intf_uses*
 //#UC END# *4DDD468D0131intf_uses*
;

type
 //#UC START# *4DDD468D0131ci*
{$R *.res}
 //#UC END# *4DDD468D0131ci*
 //#UC START# *4DDD468D0131cit*
 //#UC END# *4DDD468D0131cit*
 TnsOpenDialog = class(TnsSaveDialog)
  private
   f_ExtraPanel: TvtPanel;
   f_InnerNumbersCheckBox: TvtCheckBox;
   f_InnerNumbersEnabled: Boolean;
    {* Поле для свойства InnerNumbersEnabled }
  protected
   procedure pm_SetInnerNumbersEnabled(aValue: Boolean);
   function pm_GetInnerNumbersChecked: Boolean;
   procedure pm_SetInnerNumbersChecked(aValue: Boolean);
   {$If NOT Defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   {$If NOT Defined(NoVCL)}
   function Execute: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property InnerNumbersEnabled: Boolean
    read f_InnerNumbersEnabled
    write pm_SetInnerNumbersEnabled;
   property InnerNumbersChecked: Boolean
    read pm_GetInnerNumbersChecked
    write pm_SetInnerNumbersChecked;
 //#UC START# *4DDD468D0131publ*
 //#UC END# *4DDD468D0131publ*
 end;//TnsOpenDialog
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , eeCheckBox
 , SysUtils
 , l3Base
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , CommDlg
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 //#UC START# *4DDD468D0131impl_uses*
 //#UC END# *4DDD468D0131impl_uses*
;

type
 THackWinControl = class(TWinControl)
 end;//THackWinControl

const
 {* Локализуемые строки OpenDialog }
 str_OpenDialogInnerNumbers: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OpenDialogInnerNumbers'; rValue : 'Внутренний номер в базе');
  {* 'Внутренний номер в базе' }

procedure TnsOpenDialog.pm_SetInnerNumbersEnabled(aValue: Boolean);
//#UC START# *4DE67223009E_4DDD468D0131set_var*
//#UC END# *4DE67223009E_4DDD468D0131set_var*
begin
//#UC START# *4DE67223009E_4DDD468D0131set_impl*
 if f_InnerNumbersEnabled <> aValue then
 begin
  f_InnerNumbersEnabled := aValue;
  if f_InnerNumbersEnabled then
  begin
   f_ExtraPanel := TvtPanel.Create(Self);
   with f_ExtraPanel do
   begin
    Caption := '';
    BevelOuter := bvNone;
    BorderWidth := 2;
    TabOrder := 1;
   end;//with f_ExtraPanel do

   //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
   f_InnerNumbersCheckBox := TvtCheckBox1.Create(f_ExtraPanel);
   with f_InnerNumbersCheckBox do
   begin
    Parent := f_ExtraPanel;
    Height := (Abs(Font.Height) * 3) div 2;
    Left := Abs(Font.Height) div 2;
   end;
  end
  else
  begin
    FreeAndNil(f_ExtraPanel);
  end;
 end;
//#UC END# *4DE67223009E_4DDD468D0131set_impl*
end;//TnsOpenDialog.pm_SetInnerNumbersEnabled

function TnsOpenDialog.pm_GetInnerNumbersChecked: Boolean;
//#UC START# *4DE675B0034F_4DDD468D0131get_var*
//#UC END# *4DE675B0034F_4DDD468D0131get_var*
begin
//#UC START# *4DE675B0034F_4DDD468D0131get_impl*
 Assert(InnerNumbersEnabled);
 if Assigned(f_InnerNumbersCheckBox) then
  result := f_InnerNumbersCheckBox.Checked
 else
  result := false;
//#UC END# *4DE675B0034F_4DDD468D0131get_impl*
end;//TnsOpenDialog.pm_GetInnerNumbersChecked

procedure TnsOpenDialog.pm_SetInnerNumbersChecked(aValue: Boolean);
//#UC START# *4DE675B0034F_4DDD468D0131set_var*
//#UC END# *4DE675B0034F_4DDD468D0131set_var*
begin
//#UC START# *4DE675B0034F_4DDD468D0131set_impl*
 Assert(InnerNumbersEnabled);
 if Assigned(f_InnerNumbersCheckBox) and (f_InnerNumbersCheckBox.Checked <> aValue) then
  f_InnerNumbersCheckBox.Checked := aValue;
//#UC END# *4DE675B0034F_4DDD468D0131set_impl*
end;//TnsOpenDialog.pm_SetInnerNumbersChecked

constructor TnsOpenDialog.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4DDD468D0131_var*
//#UC END# *47D1602000C6_4DDD468D0131_var*
begin
//#UC START# *47D1602000C6_4DDD468D0131_impl*
 inherited Create(AOwner);
//#UC END# *47D1602000C6_4DDD468D0131_impl*
end;//TnsOpenDialog.Create

destructor TnsOpenDialog.Destroy;
//#UC START# *48077504027E_4DDD468D0131_var*
//#UC END# *48077504027E_4DDD468D0131_var*
begin
//#UC START# *48077504027E_4DDD468D0131_impl*
 l3Free(f_ExtraPanel);
 inherited Destroy;
//#UC END# *48077504027E_4DDD468D0131_impl*
end;//TnsOpenDialog.Destroy

{$If NOT Defined(NoVCL)}
procedure TnsOpenDialog.DoShow;
//#UC START# *4DCC1FEE0352_4DDD468D0131_var*
var
 l_ExtRect: TRect;
 l_MergeLeft: Integer;
//#UC END# *4DCC1FEE0352_4DDD468D0131_var*
begin
//#UC START# *4DCC1FEE0352_4DDD468D0131_impl*
 if InnerNumbersEnabled and Assigned(f_ExtraPanel) then
 begin
  f_ExtraPanel.ParentWindow := Handle;
  GetClientRect(Handle, l_ExtRect);
  with GetStaticRect do begin
   l_ExtRect.Top := Bottom;
   l_ExtRect.Left := Left;
   l_ExtRect.Right := Right;
  end;
  f_ExtraPanel.BoundsRect := l_ExtRect;
  f_InnerNumbersCheckBox.Width := f_ExtraPanel.ClientWidth - f_InnerNumbersCheckBox.Top*2;
  f_InnerNumbersCheckBox.Caption := str_OpenDialogInnerNumbers.AsStr;
 end; {if..}
 inherited DoShow;
//#UC END# *4DCC1FEE0352_4DDD468D0131_impl*
end;//TnsOpenDialog.DoShow
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
function TnsOpenDialog.Execute: Boolean;
//#UC START# *4DCC20C10116_4DDD468D0131_var*
var
 l_Cursor: TCursor;
 l_OwnerHandle: HWND;
 l_FocusedWnd: HWND;
//#UC END# *4DCC20C10116_4DDD468D0131_var*
begin
//#UC START# *4DCC20C10116_4DDD468D0131_impl*
 if InnerNumbersEnabled then
  Template := 'INNERNUMBERS'
 else
  Template := nil;
 l_Cursor := Screen.Cursor;
 if Assigned(f_ExtraPanel) then
  Screen.Cursor := f_ExtraPanel.Cursor;
 try
  l_OwnerHandle := 0;
  l_FocusedWnd := 0;
  if (vcmBase.g_Dispatcher <> nil) then
  begin
   l_OwnerHandle := vcmBase.g_Dispatcher.FormDispatcher.CurrentMainForm.VCLWinControl.Handle;
   l_FocusedWnd := Windows.GetFocus;
  end;//vcmBase.g_Dispatcher <> nil
  Result := DoExecute(@GetOpenFileName, l_OwnerHandle);
  if (l_OwnerHandle <> 0) AND (l_FocusedWnd <> 0) then
   SetFocus(l_FocusedWnd);
 finally
  Screen.Cursor := l_Cursor;
 end;
//#UC END# *4DCC20C10116_4DDD468D0131_impl*
end;//TnsOpenDialog.Execute
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *4DDD468D0131impl*
//#UC END# *4DDD468D0131impl*

initialization
 str_OpenDialogInnerNumbers.Init;
 {* Инициализация str_OpenDialogInnerNumbers }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
