unit PrimRememberPassword_Form;
 {* ������ ������? }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimRememberPassword_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimRememberPassword" MUID: (4A93EC4B03CC)
// ��� ����: "TPrimRememberPasswordForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , vtLabel
 , ElPopBtn
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnsSendAction = function(aSender: TCustomForm): TModalResult of object;

 TPrimRememberPasswordForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ ������? }
  private
   f_EMailLabel: TvtLabel;
    {* ���� ��� �������� EMailLabel }
   f_HintLabel: TvtLabel;
    {* ���� ��� �������� HintLabel }
   f_btnCancel: TElPopupButton;
    {* ���� ��� �������� btnCancel }
   f_btnSend: TElPopupButton;
    {* ���� ��� �������� btnSend }
   f_edEmail: TnscEdit;
    {* ���� ��� �������� edEmail }
   f_SendAction: TnsSendAction;
    {* ���� ��� �������� SendAction }
  private
   procedure EMailEditChange(Sender: TObject);
   procedure btnSendClick(Sender: TObject);
   procedure DoSend;
  protected
   function pm_GetEMail: Il3CString;
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make: BadFactoryType; reintroduce;
   {$If NOT Defined(NoVCL)}
   function IsRealInstance: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property EMailLabel: TvtLabel
    read f_EMailLabel;
    {* *����������� �����: }
   property HintLabel: TvtLabel
    read f_HintLabel;
    {* *����� ����������� �����, ��������� ��� �����������. �� ���� ����� ����� ������� ������, ���������� ���� ��������������� ��� � ������. }
   property btnCancel: TElPopupButton
    read f_btnCancel;
    {* ������ }
   property btnSend: TElPopupButton
    read f_btnSend;
    {* ��������� ������ }
   property edEmail: TnscEdit
    read f_edEmail;
   property EMail: Il3CString
    read pm_GetEMail;
   property SendAction: TnsSendAction
    read f_SendAction
    write f_SendAction;
 end;//TPrimRememberPasswordForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 , nsVerifyValue
 , Windows
 , Graphics
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
function TPrimRememberPasswordForm.pm_GetEMail: Il3CString;
//#UC START# *525D1318002B_4A93EC4B03CCget_var*
//#UC END# *525D1318002B_4A93EC4B03CCget_var*
begin
//#UC START# *525D1318002B_4A93EC4B03CCget_impl*
 Result := edEmail.Text;
//#UC END# *525D1318002B_4A93EC4B03CCget_impl*
end;//TPrimRememberPasswordForm.pm_GetEMail

procedure TPrimRememberPasswordForm.EMailEditChange(Sender: TObject);
//#UC START# *525D12A30273_4A93EC4B03CC_var*
//#UC END# *525D12A30273_4A93EC4B03CC_var*
begin
//#UC START# *525D12A30273_4A93EC4B03CC_impl*
 btnSend.Enabled := nsEmailVerify.Verify(edEmail.Text);
 if btnSend.Enabled then
  edEmail.Font.Color := clWindowText
 else
  edEmail.Font.Color := clRed;
//#UC END# *525D12A30273_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.EMailEditChange

procedure TPrimRememberPasswordForm.btnSendClick(Sender: TObject);
//#UC START# *525D12C2011A_4A93EC4B03CC_var*
//#UC END# *525D12C2011A_4A93EC4B03CC_var*
begin
//#UC START# *525D12C2011A_4A93EC4B03CC_impl*
 DoSend;
//#UC END# *525D12C2011A_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.btnSendClick

procedure TPrimRememberPasswordForm.DoSend;
//#UC START# *525D13F30292_4A93EC4B03CC_var*
//#UC END# *525D13F30292_4A93EC4B03CC_var*
begin
//#UC START# *525D13F30292_4A93EC4B03CC_impl*
 if Assigned(SendAction) then
  ModalResult := SendAction(self);
//#UC END# *525D13F30292_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.DoSend

class function TPrimRememberPasswordForm.Make: BadFactoryType;
var
 l_Inst : TPrimRememberPasswordForm;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimRememberPasswordForm.Make

procedure TPrimRememberPasswordForm.InitFields;
//#UC START# *47A042E100E2_4A93EC4B03CC_var*
//#UC END# *47A042E100E2_4A93EC4B03CC_var*
begin
//#UC START# *47A042E100E2_4A93EC4B03CC_impl*
 inherited;
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 Position := poScreenCenter;
//#UC END# *47A042E100E2_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.InitFields

{$If NOT Defined(NoVCL)}
procedure TPrimRememberPasswordForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4A93EC4B03CC_var*
//#UC END# *48C7925A02E5_4A93EC4B03CC_var*
begin
//#UC START# *48C7925A02E5_4A93EC4B03CC_impl*
 inherited;
 with Params do
 begin
  ExStyle := ExStyle or WS_EX_APPWINDOW and not WS_EX_TOOLWINDOW;
  WndParent := GetDesktopWindow;
 end;
//#UC END# *48C7925A02E5_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimRememberPasswordForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4A93EC4B03CC_var*
//#UC END# *4A8E8F2E0195_4A93EC4B03CC_var*
begin
//#UC START# *4A8E8F2E0195_4A93EC4B03CC_impl*
 inherited;

 ActiveControl := edEmail;

 ClientHeight := 127;
 ClientWidth := 423;

 with EMailLabel do
 begin
  AutoSize := False;
  Left := 8;
  Top := 7;
  Width := 125;
  Height := 17;
  Alignment := taRightJustify;
 end;

 with HintLabel do
 begin
  AutoSize := False;
  Left := 8;
  Top := 32;
  Width := 409;
  Height := 56;
  Alignment := taCenter;
  WordWrap := True;
 end;

 with btnCancel do
 begin
  Left := 342;
  Top := 94;
  Width := 75;
  Height := 25;
  DrawDefaultFrame := False;
  Cancel := True;
  ModalResult := mrCancel;
  NumGlyphs := 1;
  ThinFrame := True;
  TabOrder := 0;
  ParentFont := True;
  DockOrientation := doNoOrient;
 end;

 with btnSend do
 begin
  Left := 210;
  Top := 94;
  Width := 122;
  Height := 25;
  DrawDefaultFrame := False;
  Default := True;
  ModalResult := mrCancel;
  NumGlyphs := 1;
  ThinFrame := True;
  Enabled := False;
  TabOrder := 1;
  ParentFont := True;
  OnClick := btnSendClick;
  DockOrientation := doNoOrient;
 end;

 with edEmail do
 begin
  Left := 146;
  Top := 6;
  Width := 267;
  Height := 21;
  OnChange := EMailEditChange;
  TabOrder := 2;
 end;
//#UC END# *4A8E8F2E0195_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.InitControls

{$If NOT Defined(NoVCL)}
function TPrimRememberPasswordForm.IsRealInstance: Boolean;
//#UC START# *4B0E846D022B_4A93EC4B03CC_var*
//#UC END# *4B0E846D022B_4A93EC4B03CC_var*
begin
//#UC START# *4B0E846D022B_4A93EC4B03CC_impl*
 Result := True;
//#UC END# *4B0E846D022B_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.IsRealInstance
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimRememberPasswordForm);
 {* ����������� PrimRememberPassword }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
