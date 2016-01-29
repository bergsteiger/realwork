unit PrimTurnOnTimeMachine_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimTurnOnTimeMachine_Form.pas"
// Начат: 01.10.2009 22:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::TimeMachine::PrimTurnOnTimeMachine
//
// Включить Машину времени
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
 TPrimTurnOnTimeMachineForm = {form} class(TvcmEntityForm)
  {* Включить Машину времени }
 private
 // private fields
   f_rb_totmOnDate : TvtRadioButton;
    {* Поле для свойства rb_totmOnDate}
   f_rb_totmOnCurrentRedation : TvtRadioButton;
    {* Поле для свойства rb_totmOnCurrentRedation}
   f_deDate : TvtDblClickDateEdit;
    {* Поле для свойства deDate}
   f_pbDialogIcon : TPaintBox;
    {* Поле для свойства pbDialogIcon}
   f_lblTurnOnTimeMachineInfo : TvtLabel;
    {* Поле для свойства lblTurnOnTimeMachineInfo}
   f_btnOk : TvtButton;
    {* Поле для свойства btnOk}
   f_btnCancel : TvtButton;
    {* Поле для свойства btnCancel}
   f_Controller : InsTurnOnTimeMachine;
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
   procedure DeDateChange(Sender: TObject);
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
   class function Make(const aData: InsTurnOnTimeMachine;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 private
 // private properties
   property Controller: InsTurnOnTimeMachine
     read f_Controller;
 public
 // public properties
   property rb_totmOnDate: TvtRadioButton
     read f_rb_totmOnDate;
     {* Включить Машину времени с календарной даты }
   property rb_totmOnCurrentRedation: TvtRadioButton
     read f_rb_totmOnCurrentRedation;
     {* Включить Машину времени с начала действия текущей редакции }
   property deDate: TvtDblClickDateEdit
     read f_deDate;
   property pbDialogIcon: TPaintBox
     read f_pbDialogIcon;
   property lblTurnOnTimeMachineInfo: TvtLabel
     read f_lblTurnOnTimeMachineInfo;
     {* Выберите вариант включения Машины времени: }
   property btnOk: TvtButton
     read f_btnOk;
     {* OK }
   property btnCancel: TvtButton
     read f_btnCancel;
     {* Отмена }
 end;//TPrimTurnOnTimeMachineForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsConst,
  Windows
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Graphics,
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

// start class TPrimTurnOnTimeMachineForm

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

procedure TPrimTurnOnTimeMachineForm.BtnOkClick(Sender: TObject);
//#UC START# *527A2289012E_4AC4F8BB0265_var*
//#UC END# *527A2289012E_4AC4F8BB0265_var*
begin
//#UC START# *527A2289012E_4AC4F8BB0265_impl*
 DoOk;
//#UC END# *527A2289012E_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.BtnOkClick

procedure TPrimTurnOnTimeMachineForm.DeDateChange(Sender: TObject);
//#UC START# *527A22980348_4AC4F8BB0265_var*
//#UC END# *527A22980348_4AC4F8BB0265_var*
begin
//#UC START# *527A22980348_4AC4F8BB0265_impl*
 rb_totmOnDate.Checked := True;
//#UC END# *527A22980348_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.DeDateChange

procedure TPrimTurnOnTimeMachineForm.PbDialogIconPaint(Sender: TObject);
//#UC START# *527A22A30368_4AC4F8BB0265_var*
//#UC END# *527A22A30368_4AC4F8BB0265_var*
begin
//#UC START# *527A22A30368_4AC4F8BB0265_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, Width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cTimeMachineOn);
//#UC END# *527A22A30368_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.PbDialogIconPaint

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

class function TPrimTurnOnTimeMachineForm.Make(const aData: InsTurnOnTimeMachine;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimTurnOnTimeMachineForm);
 begin
  with aForm do
  begin
//#UC START# *4AC4F912037B_4AC4F8BB0265_impl*
   f_Controller := aData;
   CheckControls;
//#UC END# *4AC4F912037B_4AC4F8BB0265_impl*
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
procedure TPrimTurnOnTimeMachineForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD46D0226_4AC4F8BB0265test_var*
//#UC END# *4A8AD46D0226_4AC4F8BB0265test_var*
begin
//#UC START# *4A8AD46D0226_4AC4F8BB0265test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A8AD46D0226_4AC4F8BB0265test_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AC4F8BB0265exec_var*
//#UC END# *4A8AD46D0226_4AC4F8BB0265exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4F8BB0265exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4F8BB0265exec_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AC4F8BB0265test_var*
//#UC END# *4A97EBE702F8_4AC4F8BB0265test_var*
begin
//#UC START# *4A97EBE702F8_4AC4F8BB0265test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A97EBE702F8_4AC4F8BB0265test_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AC4F8BB0265getstate_var*
//#UC END# *4A97EBE702F8_4AC4F8BB0265getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4F8BB0265getstate_impl*
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4F8BB0265getstate_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AC4F8BB0265exec_var*
//#UC END# *4A97EBE702F8_4AC4F8BB0265exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4F8BB0265exec_impl*
 DoOk;
//#UC END# *4A97EBE702F8_4AC4F8BB0265exec_impl*
end;//TPrimTurnOnTimeMachineForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimTurnOnTimeMachineForm.Cleanup;
//#UC START# *479731C50290_4AC4F8BB0265_var*
//#UC END# *479731C50290_4AC4F8BB0265_var*
begin
//#UC START# *479731C50290_4AC4F8BB0265_impl*
 f_Controller := nil;
 inherited;
//#UC END# *479731C50290_4AC4F8BB0265_impl*
end;//TPrimTurnOnTimeMachineForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimTurnOnTimeMachineForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Controller := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimTurnOnTimeMachineForm.ClearFields

{$If not defined(NoVCM)}
procedure TPrimTurnOnTimeMachineForm.SetupFormLayout;
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
{$IfEnd} //not NoVCM

procedure TPrimTurnOnTimeMachineForm.InitEntities;
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

procedure TPrimTurnOnTimeMachineForm.MakeControls;
begin
 inherited;
 f_rb_totmOnDate := TvtRadioButton.Create(Self);
 f_rb_totmOnDate.Name := 'rb_totmOnDate';
 f_rb_totmOnDate.Parent := Self;
 f_rb_totmOnDate.Caption := 'Включить Машину времени с календарной даты';
 f_rb_totmOnCurrentRedation := TvtRadioButton.Create(Self);
 f_rb_totmOnCurrentRedation.Name := 'rb_totmOnCurrentRedation';
 f_rb_totmOnCurrentRedation.Parent := Self;
 f_rb_totmOnCurrentRedation.Caption := 'Включить Машину времени с начала действия текущей редакции';
 f_deDate := TvtDblClickDateEdit.Create(Self);
 f_deDate.Name := 'deDate';
 f_deDate.Parent := Self;
 f_pbDialogIcon := TPaintBox.Create(Self);
 f_pbDialogIcon.Name := 'pbDialogIcon';
 f_pbDialogIcon.Parent := Self;
 f_lblTurnOnTimeMachineInfo := TvtLabel.Create(Self);
 f_lblTurnOnTimeMachineInfo.Name := 'lblTurnOnTimeMachineInfo';
 f_lblTurnOnTimeMachineInfo.Parent := Self;
 f_lblTurnOnTimeMachineInfo.Caption := 'Выберите вариант включения Машины времени:';
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
// Регистрация PrimTurnOnTimeMachine
 TtfwClassRef.Register(TPrimTurnOnTimeMachineForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.