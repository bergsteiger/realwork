unit PrimTurnOffTimeMachine_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTurnOffTimeMachine_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimTurnOffTimeMachine" MUID: (4AC4F82F0234)
// ��� ����: "TPrimTurnOffTimeMachineForm"

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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimTurnOffTimeMachineForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_rb_totmChangeDate: TvtRadioButton;
    {* �������� ���� � ������ ������� }
   f_rb_totmStayInCurrentRedaction: TvtRadioButton;
    {* ��������� ������ ������� � �������� � ������ �������� }
   f_rb_totmGotoActualRedaction: TvtRadioButton;
    {* ��������� ������ ������� � ������� � ���������� �������� }
   f_deChangeDate: TvtDblClickDateEdit;
   f_pbDialogIcon: TPaintBox;
   f_lblTurnOnTimeMachineInfo: TvtLabel;
    {* �������� ������� ���������� ������ ������� ��� �������� ���� � ������ �������: }
   f_btnOk: TvtButton;
    {* OK }
   f_btnCancel: TvtButton;
    {* ������ }
   f_Controller: InsTurnOffTimeMachine;
  private
   procedure CheckControls;
   procedure btnOkClick(Sender: TObject);
   procedure deChangeDateChange(Sender: TObject);
   procedure pbDialogIconPaint(Sender: TObject);
  protected
   procedure DoOk;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* ��� ����� ��������� ������� ��� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsTurnOffTimeMachine;
    const aParams: IvcmMakeParams = nil;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aUserType: TvcmEffectiveUserType = 0;
    const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
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
  protected
   property Controller: InsTurnOffTimeMachine
    read f_Controller;
  public
   property rb_totmChangeDate: TvtRadioButton
    read f_rb_totmChangeDate;
    {* �������� ���� � ������ ������� }
   property rb_totmStayInCurrentRedaction: TvtRadioButton
    read f_rb_totmStayInCurrentRedaction;
    {* ��������� ������ ������� � �������� � ������ �������� }
   property rb_totmGotoActualRedaction: TvtRadioButton
    read f_rb_totmGotoActualRedaction;
    {* ��������� ������ ������� � ������� � ���������� �������� }
   property deChangeDate: TvtDblClickDateEdit
    read f_deChangeDate;
   property pbDialogIcon: TPaintBox
    read f_pbDialogIcon;
   property lblTurnOnTimeMachineInfo: TvtLabel
    read f_lblTurnOnTimeMachineInfo;
    {* �������� ������� ���������� ������ ������� ��� �������� ���� � ������ �������: }
   property btnOk: TvtButton
    read f_btnOk;
    {* OK }
   property btnCancel: TvtButton
    read f_btnCancel;
    {* ������ }
 end;//TPrimTurnOffTimeMachineForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , DataAdapter
 , bsConvert
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsConst
 , Graphics
 , Windows
 , vtCombo
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AC4F82F0234impl_uses*
 //#UC END# *4AC4F82F0234impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.CheckControls;
//#UC START# *4AC5DC1900CE_4AC4F82F0234_var*

 procedure lp_DisableOps;
 var
  l_DisableOps: TnsTurnOffTimeMachineOperations;
 begin
  l_DisableOps := Controller.DisableOps;
  rb_totmChangeDate.Enabled := not (ns_offtmChangeDate in l_DisableOps);
  deChangeDate.Enabled := not (ns_offtmChangeDate in l_DisableOps);
  rb_totmStayInCurrentRedaction.Enabled := not (ns_offtmStayInCurrentRedaction in l_DisableOps);
  rb_totmGotoActualRedaction.Checked := not (ns_offtmGotoActualRedaction in l_DisableOps);
 end;

//#UC END# *4AC5DC1900CE_4AC4F82F0234_var*
begin
//#UC START# *4AC5DC1900CE_4AC4F82F0234_impl*
 Assert(f_Controller <> nil);
 deChangeDate.Date := bsAdapterToBusiness(DefDataAdapter.TimeMachine.Date);
 rb_totmChangeDate.Checked := False;
 lp_DisableOps;
//#UC END# *4AC5DC1900CE_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.CheckControls

procedure TPrimTurnOffTimeMachineForm.DoOk;
//#UC START# *4AC5DDF603C3_4AC4F82F0234_var*
//#UC END# *4AC5DDF603C3_4AC4F82F0234_var*
begin
//#UC START# *4AC5DDF603C3_4AC4F82F0234_impl*
 if rb_totmChangeDate.Checked then
 begin
  if deChangeDate.IsEmpty then
  begin
   Say(inf_tmooDateNotEntered);
   Exit;
  end//deChangeDate.IsEmpty
  else
  if not deChangeDate.IsValid then
  begin
   Say(err_InvalidDate, [DateToStr(deChangeDate.Date)]);
   Exit;
  end;//not deChangeDate.IsValid
  Controller.ChangeDate(deChangeDate.Date);
 end//rb_totmChangeDate.Checked
 else
 if rb_totmStayInCurrentRedaction.Checked then
  Controller.StayInCurrentRedaction
 else
 if rb_totmGotoActualRedaction.Checked then
  Controller.GotoActualRedaction
 else
 begin
  Say(inf_tmooItemNotSelected);
  Exit;
 end;//rb_totmGotoActualRedaction.Checked
 ModalResult := mrOk;
//#UC END# *4AC5DDF603C3_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.DoOk

procedure TPrimTurnOffTimeMachineForm.btnOkClick(Sender: TObject);
//#UC START# *527914350245_4AC4F82F0234_var*
//#UC END# *527914350245_4AC4F82F0234_var*
begin
//#UC START# *527914350245_4AC4F82F0234_impl*
 DoOk;
//#UC END# *527914350245_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.btnOkClick

procedure TPrimTurnOffTimeMachineForm.deChangeDateChange(Sender: TObject);
//#UC START# *527914590396_4AC4F82F0234_var*
//#UC END# *527914590396_4AC4F82F0234_var*
begin
//#UC START# *527914590396_4AC4F82F0234_impl*
 rb_totmChangeDate.Checked := True;
//#UC END# *527914590396_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.deChangeDateChange

procedure TPrimTurnOffTimeMachineForm.pbDialogIconPaint(Sender: TObject);
//#UC START# *527914660245_4AC4F82F0234_var*
//#UC END# *527914660245_4AC4F82F0234_var*
begin
//#UC START# *527914660245_4AC4F82F0234_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, Width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cTimeMachineOff);
//#UC END# *527914660245_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.pbDialogIconPaint

class function TPrimTurnOffTimeMachineForm.Make(const aData: InsTurnOffTimeMachine;
 const aParams: IvcmMakeParams = nil;
 aZoneType: TvcmZoneType = vcm_ztAny;
 aUserType: TvcmEffectiveUserType = 0;
 const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimTurnOffTimeMachineForm);
 begin
  with aForm do
  begin
  //#UC START# *4AC4F87001FB_4AC4F82F0234_impl*
   f_Controller := aData;
   CheckControls;
  //#UC END# *4AC4F87001FB_4AC4F82F0234_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;//TPrimTurnOffTimeMachineForm.Make

procedure TPrimTurnOffTimeMachineForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* ������ }
//#UC START# *4A8AD46D0226_4AC4F82F0234test_var*
//#UC END# *4A8AD46D0226_4AC4F82F0234test_var*
begin
//#UC START# *4A8AD46D0226_4AC4F82F0234test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A8AD46D0226_4AC4F82F0234test_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Cancel_Test

procedure TPrimTurnOffTimeMachineForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������ }
//#UC START# *4A8AD46D0226_4AC4F82F0234exec_var*
//#UC END# *4A8AD46D0226_4AC4F82F0234exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4F82F0234exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4F82F0234exec_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Cancel_Execute

procedure TPrimTurnOffTimeMachineForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4F82F0234test_var*
//#UC END# *4A97EBE702F8_4AC4F82F0234test_var*
begin
//#UC START# *4A97EBE702F8_4AC4F82F0234test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A97EBE702F8_4AC4F82F0234test_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_Test

procedure TPrimTurnOffTimeMachineForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4F82F0234exec_var*
//#UC END# *4A97EBE702F8_4AC4F82F0234exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4F82F0234exec_impl*
 DoOk;
//#UC END# *4A97EBE702F8_4AC4F82F0234exec_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_Execute

procedure TPrimTurnOffTimeMachineForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4F82F0234getstate_var*
//#UC END# *4A97EBE702F8_4AC4F82F0234getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4F82F0234getstate_impl*
 // - ������ �� ������
//#UC END# *4A97EBE702F8_4AC4F82F0234getstate_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_GetState

procedure TPrimTurnOffTimeMachineForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AC4F82F0234_var*
//#UC END# *479731C50290_4AC4F82F0234_var*
begin
//#UC START# *479731C50290_4AC4F82F0234_impl*
 f_Controller := nil;
 inherited;
//#UC END# *479731C50290_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.Cleanup

procedure TPrimTurnOffTimeMachineForm.InitFields;
//#UC START# *47A042E100E2_4AC4F82F0234_var*
//#UC END# *47A042E100E2_4AC4F82F0234_var*
begin
//#UC START# *47A042E100E2_4AC4F82F0234_impl*
 inherited;                                                    
 rb_totmChangeDate.Font.Charset := RUSSIAN_CHARSET;
 rb_totmStayInCurrentRedaction.Font.Charset := RUSSIAN_CHARSET;
 rb_totmGotoActualRedaction.Font.Charset := RUSSIAN_CHARSET;
//#UC END# *47A042E100E2_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.InitFields

procedure TPrimTurnOffTimeMachineForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AC4F82F0234_var*
//#UC END# *4A8E8F2E0195_4AC4F82F0234_var*
begin
//#UC START# *4A8E8F2E0195_4AC4F82F0234_impl*
 inherited;

 BorderStyle := bsSingle;

 with pbDialogIcon do
 begin
  Left := 15;
  Top := 10;
  Width := 31;
  Height := 32;
  OnPaint := pbDialogIconPaint;
 end;
 with lblTurnOnTimeMachineInfo do
 begin
  WordWrap := True;
  Left := 64;
  Top := 16;
  Width := 247;
  Height := 39;
  Font.Style := [fsBold];
 end;
 with rb_totmGotoActualRedaction do
 begin
  WordWrap := True;
  Left := 57;
  Top := 70;
  Width := 273;
  Height := 33;
  TabOrder := 0;
 end;
 with rb_totmStayInCurrentRedaction do
 begin
  WordWrap := True;
  Left := 57;
  Top := 115;
  Width := 280;
  Height := 33;
  TabOrder := 1;
 end;
 with rb_totmChangeDate do
 begin
  Left := 57;
  Top := 161;
  Width := 288;
  Height := 17;
  TabOrder := 2;
 end;
 with deChangeDate do
 begin
  Left := 76;
  Top := 185;
  Width := 121;
  Height := 21;
  ParentFont := True;
  Style := vtCombo.csDropDown;
  TabOrder := 3;
  OnChange := deChangeDateChange;
 end;
 with btnOk do
 begin
  Left := 199;
  Top := 225;
  Width := 74;
  Height := 25;
  TabOrder := 4;
  OnClick := btnOkClick;
 end;
 with btnCancel do
 begin
  Left := 287;
  Top := 225;
  Width := 74;
  Height := 25;
  Cancel := True;
  TabOrder := 5;
  ModalResult := mrCancel;
 end;

 rb_totmGotoActualRedaction.Top := lblTurnOnTimeMachineInfo.Top + lblTurnOnTimeMachineInfo.Height + 15;
 rb_totmStayInCurrentRedaction.Top := rb_totmGotoActualRedaction.Top + rb_totmGotoActualRedaction.Height + 12;
 rb_totmChangeDate.Top := rb_totmStayInCurrentRedaction.Top + rb_totmStayInCurrentRedaction.Height + 12;
 deChangeDate.Top := rb_totmChangeDate.Top + rb_totmChangeDate.Height + 7;
 btnOk.Top := deChangeDate.Top + deChangeDate.Height + 19;
 btnCancel.Top := btnOk.Top;
 Self.ClientHeight := btnOk.Top + btnOk.Height + 17;
//#UC END# *4A8E8F2E0195_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.InitControls

procedure TPrimTurnOffTimeMachineForm.SetupFormLayout;
 {* ��� ����� ��������� ������� ��� ����� }
//#UC START# *529332B40230_4AC4F82F0234_var*
//#UC END# *529332B40230_4AC4F82F0234_var*
begin
//#UC START# *529332B40230_4AC4F82F0234_impl*
 inherited;
 ClientHeight := 277;
 ClientWidth := 379;
 Position := poScreenCenter;
//#UC END# *529332B40230_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.SetupFormLayout

procedure TPrimTurnOffTimeMachineForm.ClearFields;
begin
 f_Controller := nil;
 inherited;
end;//TPrimTurnOffTimeMachineForm.ClearFields

procedure TPrimTurnOffTimeMachineForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
 end;//with Entities.Entities
end;//TPrimTurnOffTimeMachineForm.InitEntities

procedure TPrimTurnOffTimeMachineForm.MakeControls;
begin
 inherited;
 f_rb_totmChangeDate := TvtRadioButton.Create(Self);
 f_rb_totmChangeDate.Name := 'rb_totmChangeDate';
 f_rb_totmChangeDate.Parent := Self;
 f_rb_totmChangeDate.Caption := '�������� ���� � ������ �������';
 f_rb_totmStayInCurrentRedaction := TvtRadioButton.Create(Self);
 f_rb_totmStayInCurrentRedaction.Name := 'rb_totmStayInCurrentRedaction';
 f_rb_totmStayInCurrentRedaction.Parent := Self;
 f_rb_totmStayInCurrentRedaction.Caption := '��������� ������ ������� � �������� � ������ ��������';
 f_rb_totmGotoActualRedaction := TvtRadioButton.Create(Self);
 f_rb_totmGotoActualRedaction.Name := 'rb_totmGotoActualRedaction';
 f_rb_totmGotoActualRedaction.Parent := Self;
 f_rb_totmGotoActualRedaction.Caption := '��������� ������ ������� � ������� � ���������� ��������';
 f_deChangeDate := TvtDblClickDateEdit.Create(Self);
 f_deChangeDate.Name := 'deChangeDate';
 f_deChangeDate.Parent := Self;
 f_pbDialogIcon := TPaintBox.Create(Self);
 f_pbDialogIcon.Name := 'pbDialogIcon';
 f_pbDialogIcon.Parent := Self;
 f_lblTurnOnTimeMachineInfo := TvtLabel.Create(Self);
 f_lblTurnOnTimeMachineInfo.Name := 'lblTurnOnTimeMachineInfo';
 f_lblTurnOnTimeMachineInfo.Parent := Self;
 f_lblTurnOnTimeMachineInfo.Caption := '�������� ������� ���������� ������ ������� ��� �������� ���� � ������ �������:';
 f_btnOk := TvtButton.Create(Self);
 f_btnOk.Name := 'btnOk';
 f_btnOk.Parent := Self;
 f_btnOk.Caption := 'OK';
 f_btnCancel := TvtButton.Create(Self);
 f_btnCancel.Name := 'btnCancel';
 f_btnCancel.Parent := Self;
 f_btnCancel.Caption := '������';
end;//TPrimTurnOffTimeMachineForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOffTimeMachineForm);
 {* ����������� PrimTurnOffTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
