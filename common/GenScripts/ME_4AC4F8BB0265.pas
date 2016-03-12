unit PrimTurnOnTimeMachine_Form;
 {* �������� ������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimTurnOnTimeMachine_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , PresentationInterfaces
 , vtRadioButton
 , vtDblClickDateEdit
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtButton
;

type
 TPrimTurnOnTimeMachineForm = class(TvcmEntityForm)
  {* �������� ������ ������� }
  private
   f_rb_totmOnDate: TvtRadioButton;
    {* ���� ��� �������� rb_totmOnDate }
   f_rb_totmOnCurrentRedation: TvtRadioButton;
    {* ���� ��� �������� rb_totmOnCurrentRedation }
   f_deDate: TvtDblClickDateEdit;
    {* ���� ��� �������� deDate }
   f_pbDialogIcon: TPaintBox;
    {* ���� ��� �������� pbDialogIcon }
   f_lblTurnOnTimeMachineInfo: TvtLabel;
    {* ���� ��� �������� lblTurnOnTimeMachineInfo }
   f_btnOk: TvtButton;
    {* ���� ��� �������� btnOk }
   f_btnCancel: TvtButton;
    {* ���� ��� �������� btnCancel }
   f_Controller: InsTurnOnTimeMachine;
    {* ���� ��� �������� Controller }
  private
   procedure CheckControls;
   procedure btnOkClick(Sender: TObject);
   procedure deDateChange(Sender: TObject);
   procedure pbDialogIconPaint(Sender: TObject);
  protected
   procedure DoOk;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* ��� ����� ��������� ������� ��� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsTurnOnTimeMachine): Result; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  private
   property Controller: InsTurnOnTimeMachine
    read f_Controller;
  public
   property rb_totmOnDate: TvtRadioButton
    read f_rb_totmOnDate;
    {* �������� ������ ������� � ����������� ���� }
   property rb_totmOnCurrentRedation: TvtRadioButton
    read f_rb_totmOnCurrentRedation;
    {* �������� ������ ������� � ������ �������� ������� �������� }
   property deDate: TvtDblClickDateEdit
    read f_deDate;
   property pbDialogIcon: TPaintBox
    read f_pbDialogIcon;
   property lblTurnOnTimeMachineInfo: TvtLabel
    read f_lblTurnOnTimeMachineInfo;
    {* �������� ������� ��������� ������ �������: }
   property btnOk: TvtButton
    read f_btnOk;
    {* OK }
   property btnCancel: TvtButton
    read f_btnCancel;
    {* ������ }
 end;//TPrimTurnOnTimeMachineForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , vtCombo
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.DoOk;
//#UC START# *4AC5E0A802CA_4AC4F8BB0265_var*
//#UC END# *4AC5E0A802CA_4AC4F8BB0265_var*
begin
//#UC START# *4AC5E0A802CA_4AC4F8BB0265_impl*
 if rb_totmOnDate.Checked then
 begin
  if deDate.IsEmpty then
  begin
   Say(inf_tmooDateNotEntered);
   Exit;
  end// deDate.IsEmpty
  else
  if not deDate.IsValid then
  begin
   Say(err_InvalidDate, [DateToStr(deDate.Date)]);
   Exit;
  end//not deDate.IsValid
  else
   Controller.OnDate(deDate.Date);
 end//rb_totmOnDate.Checked
 else
 if rb_totmOnCurrentRedation.Checked then
  Controller.OnCurrentRedaction
 else
 begin
  Say(inf_tmooItemNotSelected);
  Exit;
 end;//rb_totmOnCurrentRedation.Checked
 ModalResult := mrOk;
//#UC END# *4AC5E0A802CA_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.DoOk

procedure TPrimTurnOnTimeMachineForm.CheckControls;
//#UC START# *4AC5E0C000D5_4AC4F8BB0265_var*

 procedure lp_DisableOps;
 var
  l_DisableOps: TnsTurnOnTimeMachineOperations;
 begin
  l_DisableOps := Controller.DisableOps;
  rb_totmOnDate.Enabled := not (ns_ontmDateOp in l_DisableOps);
  deDate.Enabled := not (ns_ontmDateOp in l_DisableOps);
  rb_totmOnCurrentRedation.Enabled := not (ns_ontmCurrentRedactionOp in l_DisableOps);
 end;

//#UC END# *4AC5E0C000D5_4AC4F8BB0265_var*
begin
//#UC START# *4AC5E0C000D5_4AC4F8BB0265_impl*
 Assert(f_Controller <> nil);
 lp_DisableOps;
//#UC END# *4AC5E0C000D5_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.CheckControls

procedure TPrimTurnOnTimeMachineForm.btnOkClick(Sender: TObject);
//#UC START# *527A2289012E_4AC4F8BB0265_var*
//#UC END# *527A2289012E_4AC4F8BB0265_var*
begin
//#UC START# *527A2289012E_4AC4F8BB0265_impl*
 DoOk;
//#UC END# *527A2289012E_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.btnOkClick

procedure TPrimTurnOnTimeMachineForm.deDateChange(Sender: TObject);
//#UC START# *527A22980348_4AC4F8BB0265_var*
//#UC END# *527A22980348_4AC4F8BB0265_var*
begin
//#UC START# *527A22980348_4AC4F8BB0265_impl*
 rb_totmOnDate.Checked := True;
//#UC END# *527A22980348_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.deDateChange

procedure TPrimTurnOnTimeMachineForm.pbDialogIconPaint(Sender: TObject);
//#UC START# *527A22A30368_4AC4F8BB0265_var*
//#UC END# *527A22A30368_4AC4F8BB0265_var*
begin
//#UC START# *527A22A30368_4AC4F8BB0265_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, Width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cTimeMachineOn);
//#UC END# *527A22A30368_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.pbDialogIconPaint

class function TPrimTurnOnTimeMachineForm.Make(const aData: InsTurnOnTimeMachine): Result;
var
 l_Inst : TPrimTurnOnTimeMachineForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimTurnOnTimeMachineForm.Make

procedure TPrimTurnOnTimeMachineForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* ������ }
//#UC START# *4A8AD46D0226_4AC4F8BB0265test_var*
//#UC END# *4A8AD46D0226_4AC4F8BB0265test_var*
begin
//#UC START# *4A8AD46D0226_4AC4F8BB0265test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A8AD46D0226_4AC4F8BB0265test_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Cancel_Test

procedure TPrimTurnOnTimeMachineForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������ }
//#UC START# *4A8AD46D0226_4AC4F8BB0265exec_var*
//#UC END# *4A8AD46D0226_4AC4F8BB0265exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4F8BB0265exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4F8BB0265exec_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Cancel_Execute

procedure TPrimTurnOnTimeMachineForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4F8BB0265test_var*
//#UC END# *4A97EBE702F8_4AC4F8BB0265test_var*
begin
//#UC START# *4A97EBE702F8_4AC4F8BB0265test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A97EBE702F8_4AC4F8BB0265test_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Ok_Test

procedure TPrimTurnOnTimeMachineForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4F8BB0265exec_var*
//#UC END# *4A97EBE702F8_4AC4F8BB0265exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4F8BB0265exec_impl*
 DoOk;
//#UC END# *4A97EBE702F8_4AC4F8BB0265exec_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Ok_Execute

procedure TPrimTurnOnTimeMachineForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4F8BB0265getstate_var*
//#UC END# *4A97EBE702F8_4AC4F8BB0265getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4F8BB0265getstate_impl*
 // - ������ �� ������
//#UC END# *4A97EBE702F8_4AC4F8BB0265getstate_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Ok_GetState

procedure TPrimTurnOnTimeMachineForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AC4F8BB0265_var*
//#UC END# *479731C50290_4AC4F8BB0265_var*
begin
//#UC START# *479731C50290_4AC4F8BB0265_impl*
 f_Controller := nil;
 inherited;
//#UC END# *479731C50290_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.Cleanup

procedure TPrimTurnOnTimeMachineForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AC4F8BB0265_var*
//#UC END# *4A8E8F2E0195_4AC4F8BB0265_var*
begin
//#UC START# *4A8E8F2E0195_4AC4F8BB0265_impl*
 inherited;

 BorderStyle := bsSingle;
 BorderIcons := [];
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564750166

 with pbDialogIcon do
 begin
  Left := 15;
  Top := 10;
  Width := 32;
  Height := 32;
  OnPaint := pbDialogIconPaint;
 end;
 with lblTurnOnTimeMachineInfo do
 begin
  AutoSize := False;
  WordWrap := True;
  Left := 64;
  Top := 16;
  Width := 265;
  Height := 30;
  Font.Style := [fsBold];
  AutoSize := True;
 end;
 with rb_totmOnDate do
 begin
  WordWrap := True;
  Left := 64;
  Top := 53;
  Width := 289;
  Height := 32;
  TabOrder := 0;
 end;
 with deDate do
 begin
  Left := 83;
  Top := 96;
  Width := 121;
  Height := 24;
  Style := csDropDown;
  TabOrder := 1;
  OnChange := deDateChange;
 end;
 with rb_totmOnCurrentRedation do
 begin
  WordWrap := True;
  Left := 64;
  Top := 127;
  Width := 281;
  Height := 33;
  TabOrder := 2;
 end;
 with btnOk do
 begin
  Left := 210;
  Top := 184;
  Width := 75;
  Height := 25;
  TabOrder := 3;
  OnClick := btnOkClick;
 end;
 with btnCancel do
 begin
  Left := 298;
  Top := 184;
  Width := 75;
  Height := 25;
  Cancel := True;
  ModalResult := mrCancel;
  TabOrder := 4;
 end;

 rb_totmOnDate.Top := lblTurnOnTimeMachineInfo.Top + lblTurnOnTimeMachineInfo.Height + 11;
 deDate.Top := rb_totmOnDate.Top + rb_totmOnDate.Height + 11;
 rb_totmOnCurrentRedation.Top := deDate.Top + deDate.Height + 10;
 btnOk.Top := rb_totmOnCurrentRedation.Top + rb_totmOnCurrentRedation.Height + 24;
 btnCancel.Top := btnOk.Top;
 Self.ClientHeight := btnOk.Top + btnOk.Height + 18;
//#UC END# *4A8E8F2E0195_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.InitControls

procedure TPrimTurnOnTimeMachineForm.ClearFields;
begin
 f_Controller := nil;
 inherited;
end;//TPrimTurnOnTimeMachineForm.ClearFields

procedure TPrimTurnOnTimeMachineForm.SetupFormLayout;
 {* ��� ����� ��������� ������� ��� ����� }
//#UC START# *529332B40230_4AC4F8BB0265_var*
//#UC END# *529332B40230_4AC4F8BB0265_var*
begin
//#UC START# *529332B40230_4AC4F8BB0265_impl*
 inherited;

 rb_totmOnDate.Font.Charset := RUSSIAN_CHARSET;
 rb_totmOnCurrentRedation.Font.Charset := RUSSIAN_CHARSET;

 ClientHeight := 232;
 ClientWidth := 388;
 Position := poScreenCenter;
//#UC END# *529332B40230_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.SetupFormLayout

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOnTimeMachineForm);
 {* ����������� PrimTurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
