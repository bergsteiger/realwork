unit PrimTurnOffTimeMachine_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimTurnOffTimeMachine_Form.pas"
// Начат: 01.10.2009 22:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimTurnOffTimeMachine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  PresentationInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  vtDblClickDateEdit,
  vtLabel,
  vtButton,
  vtRadioButton,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimTurnOffTimeMachineForm = {form} class(TvcmEntityForm)
 private
 // private fields
   f_rb_totmChangeDate : TvtRadioButton;
    {* Поле для свойства rb_totmChangeDate}
   f_rb_totmStayInCurrentRedaction : TvtRadioButton;
    {* Поле для свойства rb_totmStayInCurrentRedaction}
   f_rb_totmGotoActualRedaction : TvtRadioButton;
    {* Поле для свойства rb_totmGotoActualRedaction}
   f_deChangeDate : TvtDblClickDateEdit;
    {* Поле для свойства deChangeDate}
   f_pbDialogIcon : TPaintBox;
    {* Поле для свойства pbDialogIcon}
   f_lblTurnOnTimeMachineInfo : TvtLabel;
    {* Поле для свойства lblTurnOnTimeMachineInfo}
   f_btnOk : TvtButton;
    {* Поле для свойства btnOk}
   f_btnCancel : TvtButton;
    {* Поле для свойства btnCancel}
   f_Controller : InsTurnOffTimeMachine;
    {* Поле для свойства Controller}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure CheckControls;
     {* Сигнатура метода CheckControls }
   procedure BtnOkClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure DeChangeDateChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure PbDialogIconPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure DoOk;
     {* Сигнатура метода DoOk }
 public
 // public methods
   class function Make(const aData: InsTurnOffTimeMachine;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 protected
 // protected properties
   property Controller: InsTurnOffTimeMachine
     read f_Controller;
 public
 // public properties
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  DataAdapter,
  bsConvert
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nsConst,
  Graphics,
  Windows,
  vtCombo
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimTurnOffTimeMachineForm

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

procedure TPrimTurnOffTimeMachineForm.BtnOkClick(Sender: TObject);
//#UC START# *527914350245_4AC4F82F0234_var*
//#UC END# *527914350245_4AC4F82F0234_var*
begin
//#UC START# *527914350245_4AC4F82F0234_impl*
 DoOk;
//#UC END# *527914350245_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.BtnOkClick

procedure TPrimTurnOffTimeMachineForm.DeChangeDateChange(Sender: TObject);
//#UC START# *527914590396_4AC4F82F0234_var*
//#UC END# *527914590396_4AC4F82F0234_var*
begin
//#UC START# *527914590396_4AC4F82F0234_impl*
 rb_totmChangeDate.Checked := True;
//#UC END# *527914590396_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.DeChangeDateChange

procedure TPrimTurnOffTimeMachineForm.PbDialogIconPaint(Sender: TObject);
//#UC START# *527914660245_4AC4F82F0234_var*
//#UC END# *527914660245_4AC4F82F0234_var*
begin
//#UC START# *527914660245_4AC4F82F0234_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, Width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cTimeMachineOff);
//#UC END# *527914660245_4AC4F82F0234_impl*
end;//TPrimTurnOffTimeMachineForm.PbDialogIconPaint

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

class function TPrimTurnOffTimeMachineForm.Make(const aData: InsTurnOffTimeMachine;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

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
end;

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD46D0226_4AC4F82F0234test_var*
//#UC END# *4A8AD46D0226_4AC4F82F0234test_var*
begin
//#UC START# *4A8AD46D0226_4AC4F82F0234test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A8AD46D0226_4AC4F82F0234test_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AC4F82F0234exec_var*
//#UC END# *4A8AD46D0226_4AC4F82F0234exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4F82F0234exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4F82F0234exec_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AC4F82F0234test_var*
//#UC END# *4A97EBE702F8_4AC4F82F0234test_var*
begin
//#UC START# *4A97EBE702F8_4AC4F82F0234test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A97EBE702F8_4AC4F82F0234test_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AC4F82F0234getstate_var*
//#UC END# *4A97EBE702F8_4AC4F82F0234getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4F82F0234getstate_impl*
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4F82F0234getstate_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AC4F82F0234exec_var*
//#UC END# *4A97EBE702F8_4AC4F82F0234exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4F82F0234exec_impl*
 DoOk;
//#UC END# *4A97EBE702F8_4AC4F82F0234exec_impl*
end;//TPrimTurnOffTimeMachineForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimTurnOffTimeMachineForm.Cleanup;
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

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimTurnOffTimeMachineForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Controller := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimTurnOffTimeMachineForm.ClearFields

{$If not defined(NoVCM)}
procedure TPrimTurnOffTimeMachineForm.SetupFormLayout;
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
{$IfEnd} //not NoVCM

procedure TPrimTurnOffTimeMachineForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimTurnOffTimeMachineForm.MakeControls;
begin
 inherited;
 f_rb_totmChangeDate := TvtRadioButton.Create(Self);
 f_rb_totmChangeDate.Name := 'rb_totmChangeDate';
 f_rb_totmChangeDate.Parent := Self;
 f_rb_totmChangeDate.Caption := 'Изменить дату в Машине времени';
 f_rb_totmStayInCurrentRedaction := TvtRadioButton.Create(Self);
 f_rb_totmStayInCurrentRedaction.Name := 'rb_totmStayInCurrentRedaction';
 f_rb_totmStayInCurrentRedaction.Parent := Self;
 f_rb_totmStayInCurrentRedaction.Caption := 'Выключить Машину времени и остаться в данной редакции';
 f_rb_totmGotoActualRedaction := TvtRadioButton.Create(Self);
 f_rb_totmGotoActualRedaction.Name := 'rb_totmGotoActualRedaction';
 f_rb_totmGotoActualRedaction.Parent := Self;
 f_rb_totmGotoActualRedaction.Caption := 'Выключить Машину времени и перейти в актуальную редакцию';
 f_deChangeDate := TvtDblClickDateEdit.Create(Self);
 f_deChangeDate.Name := 'deChangeDate';
 f_deChangeDate.Parent := Self;
 f_pbDialogIcon := TPaintBox.Create(Self);
 f_pbDialogIcon.Name := 'pbDialogIcon';
 f_pbDialogIcon.Parent := Self;
 f_lblTurnOnTimeMachineInfo := TvtLabel.Create(Self);
 f_lblTurnOnTimeMachineInfo.Name := 'lblTurnOnTimeMachineInfo';
 f_lblTurnOnTimeMachineInfo.Parent := Self;
 f_lblTurnOnTimeMachineInfo.Caption := 'Выберите вариант выключения Машины времени или измените дату в Машине времени:';
 f_btnOk := TvtButton.Create(Self);
 f_btnOk.Name := 'btnOk';
 f_btnOk.Parent := Self;
 f_btnOk.Caption := 'OK';
 f_btnCancel := TvtButton.Create(Self);
 f_btnCancel.Name := 'btnCancel';
 f_btnCancel.Parent := Self;
 f_btnCancel.Caption := 'Отмена';
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimTurnOffTimeMachine
 TtfwClassRef.Register(TPrimTurnOffTimeMachineForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.