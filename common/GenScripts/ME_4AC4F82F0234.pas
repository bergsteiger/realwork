unit PrimTurnOffTimeMachine_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTurnOffTimeMachine_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimTurnOffTimeMachine" MUID: (4AC4F82F0234)
// Имя типа: "TPrimTurnOffTimeMachineForm"

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
 TPrimTurnOffTimeMachineForm = class(TvcmEntityForm)
  private
   f_rb_totmChangeDate: TvtRadioButton;
    {* Поле для свойства rb_totmChangeDate }
   f_rb_totmStayInCurrentRedaction: TvtRadioButton;
    {* Поле для свойства rb_totmStayInCurrentRedaction }
   f_rb_totmGotoActualRedaction: TvtRadioButton;
    {* Поле для свойства rb_totmGotoActualRedaction }
   f_deChangeDate: TvtDblClickDateEdit;
    {* Поле для свойства deChangeDate }
   f_pbDialogIcon: TPaintBox;
    {* Поле для свойства pbDialogIcon }
   f_lblTurnOnTimeMachineInfo: TvtLabel;
    {* Поле для свойства lblTurnOnTimeMachineInfo }
   f_btnOk: TvtButton;
    {* Поле для свойства btnOk }
   f_btnCancel: TvtButton;
    {* Поле для свойства btnCancel }
   f_Controller: InsTurnOffTimeMachine;
    {* Поле для свойства Controller }
  private
   procedure CheckControls;
   procedure btnOkClick(Sender: TObject);
   procedure deChangeDateChange(Sender: TObject);
   procedure pbDialogIconPaint(Sender: TObject);
  protected
   procedure DoOk;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* Тут можно настроить внешний вид формы }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsTurnOffTimeMachine): BadFactoryType; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
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
    {* Изменить дату в Машине времени }
   property rb_totmStayInCurrentRedaction: TvtRadioButton
    read f_rb_totmStayInCurrentRedaction;
    {* Выключить Машину времени и остаться в данной редакции }
   property rb_totmGotoActualRedaction: TvtRadioButton
    read f_rb_totmGotoActualRedaction;
    {* Выключить Машину времени и перейти в актуальную редакцию }
   property deChangeDate: TvtDblClickDateEdit
    read f_deChangeDate;
   property pbDialogIcon: TPaintBox
    read f_pbDialogIcon;
   property lblTurnOnTimeMachineInfo: TvtLabel
    read f_lblTurnOnTimeMachineInfo;
    {* Выберите вариант выключения Машины времени или измените дату в Машине времени: }
   property btnOk: TvtButton
    read f_btnOk;
    {* OK }
   property btnCancel: TvtButton
    read f_btnCancel;
    {* Отмена }
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
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

class function TPrimTurnOffTimeMachineForm.Make(const aData: InsTurnOffTimeMachine): BadFactoryType;
var
 l_Inst : TPrimTurnOffTimeMachineForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimTurnOffTimeMachineForm.Make

procedure TPrimTurnOffTimeMachineForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC4F82F0234test_var*
//#UC END# *4A8AD46D0226_4AC4F82F0234test_var*
begin
//#UC START# *4A8AD46D0226_4AC4F82F0234test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A8AD46D0226_4AC4F82F0234test_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Cancel_Test

procedure TPrimTurnOffTimeMachineForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
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
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4F82F0234getstate_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_GetState

procedure TPrimTurnOffTimeMachineForm.Cleanup;
 {* Функция очистки полей объекта. }
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
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimTurnOffTimeMachineForm.ClearFields;
begin
 f_Controller := nil;
 inherited;
end;//TPrimTurnOffTimeMachineForm.ClearFields

procedure TPrimTurnOffTimeMachineForm.SetupFormLayout;
 {* Тут можно настроить внешний вид формы }
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOffTimeMachineForm);
 {* Регистрация PrimTurnOffTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
