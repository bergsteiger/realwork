unit PrimSettings_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimSettings_Form.pas"
// Начат: 02.10.2009 21:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimSettings
//
// Настройка конфигурации
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
  l3InternalInterfaces,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  bsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  ,
  ConfigInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  Settings_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimSettings_cutSettings_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimSettingsForm = {form} class(TvcmContainerForm)
  {* Настройка конфигурации }
 private
 // private fields
   f_Filled : Boolean;
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure StartEdit;
   procedure VcmContainerFormKeyDown(Sender: TObject;
     var Key: Word;
     Shift: TShiftState);
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   procedure Result_RestoreConf_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_RestoreConf_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Result_SaveAsDefaultConf_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_SaveAsDefaultConf_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Result_RestoreAllSettings_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCL)}
   function CloseQuery: Boolean; override;
     {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} //not NoVCL
    {$If not defined(NoVCM)}
   procedure DoOnShowModal; override;
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_ManagerConf : InsConfigSettingsInfo;
 public
 // public methods
   class function Make(const aData: InsConfigSettingsInfo;
     const aParams : IvcmMakeParams = nil;
     aZoneType     : TvcmZoneType = vcm_ztAny;
     aUserType     : TvcmEffectiveUserType = 0;
     aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 end;//TPrimSettingsForm

 TvcmContainerFormRef = TPrimSettingsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  SysUtils,
  nsConfigurationList,
  nsAppConfig,
  OvcController,
  OvcCmd,
  Messages,
  OvcConst,
  Windows
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки cutSettingsLocalConstants }
  str_cutSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutSettingsCaption'; rValue : 'Настройка конфигурации');
   { Заголовок пользовательского типа "Настройка конфигурации" }

// start class TPrimSettingsForm

procedure TPrimSettingsForm.StartEdit;
//#UC START# *4AC63BB001DA_4AC63ADF023F_var*
//#UC END# *4AC63BB001DA_4AC63ADF023F_var*
var
 l_Settings : InsSettings;
begin
//#UC START# *4AC63BB001DA_4AC63ADF023F_impl*
 if f_ManagerConf.IsActive and
  (Supports(afw.Application.Settings, InsSettings, l_Settings)) then
 try
  l_Settings.StartEdit;
 finally
  l_Settings := nil;
 end;// try..finally
 // Создадим структуру:
 f_ManagerConf.Load(False);
//#UC END# *4AC63BB001DA_4AC63ADF023F_impl*
end;//TPrimSettingsForm.StartEdit

procedure TPrimSettingsForm.VcmContainerFormKeyDown(Sender: TObject;
  var Key: Word;
  Shift: TShiftState);
//#UC START# *5264FF0A0241_4AC63ADF023F_var*
var
 l_Controller : TOvcController;
 l_Msg: TWMKeyDown;
 l_Target: Il3CommandTarget;
//#UC END# *5264FF0A0241_4AC63ADF023F_var*
begin
//#UC START# *5264FF0A0241_4AC63ADF023F_impl*
 l_Controller := GetDefController;
 if l_Controller <> nil then
  with l_Controller.EntryCommands do
  begin
   l_Msg.CharCode := Key;
   l_Msg.KeyData := 0;
   if Supports(Self, Il3CommandTarget, l_Target) and
      (l_Controller.EntryCommands.TranslateUsing([OvcCmd.scDefaultTableName],
                                                 TMessage(l_Msg), GetTickCount,
                                                 l_Target) = ccShortCut) then
    Key := 0;
  end;
//#UC END# *5264FF0A0241_4AC63ADF023F_impl*
end;//TPrimSettingsForm.VcmContainerFormKeyDown

class function TPrimSettingsForm.Make(const aData: InsConfigSettingsInfo;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimSettingsForm);
 begin
  with aForm do
  begin
//#UC START# *4AE069110160_4AC63ADF023F_impl*
   f_ManagerConf := aData;
   if (f_ManagerConf = nil) then
    f_ManagerConf := ConfigurationList.ActiveConfig;
   StartEdit; 
//#UC END# *4AE069110160_4AC63ADF023F_impl*
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
procedure TPrimSettingsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AC63ADF023Fexec_var*
//#UC END# *4A8AD46D0226_4AC63ADF023Fexec_var*
begin
//#UC START# *4A8AD46D0226_4AC63ADF023Fexec_impl*
 f_ManagerConf.Load(False);
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC63ADF023Fexec_impl*
end;//TPrimSettingsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimSettingsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AC63ADF023Ftest_var*
//#UC END# *4A97EBE702F8_4AC63ADF023Ftest_var*
begin
//#UC START# *4A97EBE702F8_4AC63ADF023Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_ManagerConf.IsOverallModified;
//#UC END# *4A97EBE702F8_4AC63ADF023Ftest_impl*
end;//TPrimSettingsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimSettingsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AC63ADF023Fexec_var*
//#UC END# *4A97EBE702F8_4AC63ADF023Fexec_var*
begin
//#UC START# *4A97EBE702F8_4AC63ADF023Fexec_impl*
 try
  f_ManagerConf.Save(False);
  ModalResult := mrOk;
 except
  on E : EDuplicateConfName do
   Say(err_DublicateConfName, [E.ConfName]);
  on E : ECRSettingsAreEqual do
   Say(inf_SettingsAreEqual);
  on E : EConfigNotSaved do ;
 end;
//#UC END# *4A97EBE702F8_4AC63ADF023Fexec_impl*
end;//TPrimSettingsForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimSettingsForm.Result_RestoreConf_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4084490250_4AC63ADF023Ftest_var*
//#UC END# *4C4084490250_4AC63ADF023Ftest_var*
begin
//#UC START# *4C4084490250_4AC63ADF023Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_ManagerConf.Modified or f_ManagerConf.IsDifferFromDefault;
//#UC END# *4C4084490250_4AC63ADF023Ftest_impl*
end;//TPrimSettingsForm.Result_RestoreConf_Test

procedure TPrimSettingsForm.Result_RestoreConf_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4084490250_4AC63ADF023Fexec_var*
//#UC END# *4C4084490250_4AC63ADF023Fexec_var*
begin
//#UC START# *4C4084490250_4AC63ADF023Fexec_impl*
 if Ask(qr_RestoreDefaultValuesConf) then
  f_ManagerConf.Load(True);
//#UC END# *4C4084490250_4AC63ADF023Fexec_impl*
end;//TPrimSettingsForm.Result_RestoreConf_Execute

procedure TPrimSettingsForm.Result_SaveAsDefaultConf_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C40845C0212_4AC63ADF023Ftest_var*
//#UC END# *4C40845C0212_4AC63ADF023Ftest_var*
begin
//#UC START# *4C40845C0212_4AC63ADF023Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not f_ManagerConf.IsPredefined
  and (f_ManagerConf.Modified or f_ManagerConf.IsDifferFromDefault);
//#UC END# *4C40845C0212_4AC63ADF023Ftest_impl*
end;//TPrimSettingsForm.Result_SaveAsDefaultConf_Test

procedure TPrimSettingsForm.Result_SaveAsDefaultConf_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C40845C0212_4AC63ADF023Fexec_var*
//#UC END# *4C40845C0212_4AC63ADF023Fexec_var*
begin
//#UC START# *4C40845C0212_4AC63ADF023Fexec_impl*
 if Ask(qr_SaveAsDefaultValuesConf) then
  f_ManagerConf.Save(True);
//#UC END# *4C40845C0212_4AC63ADF023Fexec_impl*
end;//TPrimSettingsForm.Result_SaveAsDefaultConf_Execute

procedure TPrimSettingsForm.Result_RestoreAllSettings_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4084670039_4AC63ADF023Fexec_var*
//#UC END# *4C4084670039_4AC63ADF023Fexec_var*
begin
//#UC START# *4C4084670039_4AC63ADF023Fexec_impl*
 if Ask(qr_RestoreAllSettings) then
  f_ManagerConf.RestoreAllSettings;
//#UC END# *4C4084670039_4AC63ADF023Fexec_impl*
end;//TPrimSettingsForm.Result_RestoreAllSettings_Execute

procedure TPrimSettingsForm.Cleanup;
//#UC START# *479731C50290_4AC63ADF023F_var*
//#UC END# *479731C50290_4AC63ADF023F_var*
begin
//#UC START# *479731C50290_4AC63ADF023F_impl*
 if (f_ManagerConf <> nil) then
  f_ManagerConf.DoneEditing;
 f_Filled := False;
 f_ManagerConf := nil;
 inherited;
//#UC END# *479731C50290_4AC63ADF023F_impl*
end;//TPrimSettingsForm.Cleanup

procedure TPrimSettingsForm.InitFields;
//#UC START# *47A042E100E2_4AC63ADF023F_var*
//#UC END# *47A042E100E2_4AC63ADF023F_var*
begin
//#UC START# *47A042E100E2_4AC63ADF023F_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *47A042E100E2_4AC63ADF023F_impl*
end;//TPrimSettingsForm.InitFields

{$If not defined(NoVCL)}
function TPrimSettingsForm.CloseQuery: Boolean;
//#UC START# *4980403E021E_4AC63ADF023F_var*
//#UC END# *4980403E021E_4AC63ADF023F_var*
begin
//#UC START# *4980403E021E_4AC63ADF023F_impl*
 if (f_ManagerConf <> nil) then
  f_ManagerConf.DoneEditing;
 f_Filled := False;
 Result := inherited CloseQuery;
//#UC END# *4980403E021E_4AC63ADF023F_impl*
end;//TPrimSettingsForm.CloseQuery
{$IfEnd} //not NoVCL

{$If not defined(NoVCM)}
procedure TPrimSettingsForm.InitControls;
//#UC START# *4A8E8F2E0195_4AC63ADF023F_var*
//#UC END# *4A8E8F2E0195_4AC63ADF023F_var*
begin
//#UC START# *4A8E8F2E0195_4AC63ADF023F_impl*
 inherited;
 ClientHeight := 232;
 ClientWidth := 446;
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 OnKeyDown := vcmContainerFormKeyDown;
//#UC END# *4A8E8F2E0195_4AC63ADF023F_impl*
end;//TPrimSettingsForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
procedure TPrimSettingsForm.DoShow;
//#UC START# *4B321D1301DD_4AC63ADF023F_var*
var
 l_Swap: TCursor;
//#UC END# *4B321D1301DD_4AC63ADF023F_var*
begin
//#UC START# *4B321D1301DD_4AC63ADF023F_impl*
 // Делаем это здесь, т.к. необходимо чтобы toolbar-ы были созданы и мы могли
 // бы сообщить DocksHeight
 if not f_Filled then
 begin
  l_Swap := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
   f_ManagerConf.FillDialog(self.as_IvcmEntityForm, DocksHeight);
  finally
   Screen.Cursor := l_Swap;
  end;
  f_Filled := True;
 end;
 inherited;
//#UC END# *4B321D1301DD_4AC63ADF023F_impl*
end;//TPrimSettingsForm.DoShow
{$IfEnd} //not NoVCL

{$If not defined(NoVCM)}
procedure TPrimSettingsForm.DoOnShowModal;
//#UC START# *5445EA440078_4AC63ADF023F_var*
var
 l_WndForeground: HWND;
//#UC END# *5445EA440078_4AC63ADF023F_var*
begin
//#UC START# *5445EA440078_4AC63ADF023F_impl*
 inherited;
 if HandleAllocated and
  TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
   SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
 //http://mdp.garant.ru/pages/viewpage.action?pageId=567555348
//#UC END# *5445EA440078_4AC63ADF023F_impl*
end;//TPrimSettingsForm.DoOnShowModal
{$IfEnd} //not NoVCM

procedure TPrimSettingsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, true);
  ShowInToolbar(en_Result, op_Cancel, true);
  ContextMenuWeight(en_Result, op_Cancel, -1);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, nil);
  ShowInContextMenu(en_Result, op_Ok, true);
  ShowInToolbar(en_Result, op_Ok, true);
  ContextMenuWeight(en_Result, op_Ok, -2);
  {$IfEnd} //not NoVCM

  PublishOp(en_Result, op_RestoreConf, Result_RestoreConf_Execute, Result_RestoreConf_Test, nil);
  ShowInContextMenu(en_Result, op_RestoreConf, true);
  ShowInToolbar(en_Result, op_RestoreConf, true);
  PublishOp(en_Result, op_SaveAsDefaultConf, Result_SaveAsDefaultConf_Execute, Result_SaveAsDefaultConf_Test, nil);
  ShowInContextMenu(en_Result, op_SaveAsDefaultConf, true);
  ShowInToolbar(en_Result, op_SaveAsDefaultConf, true);
  PublishOp(en_Result, op_RestoreAllSettings, Result_RestoreAllSettings_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_RestoreAllSettings, true);
  ShowInToolbar(en_Result, op_RestoreAllSettings, true);
 end;//with Entities.Entities
end;

procedure TPrimSettingsForm.MakeControls;
begin
 inherited;
 with AddUsertype(cutSettingsName,
  str_cutSettingsCaption,
  str_cutSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cutSettingsName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_cutSettingsCaption
 str_cutSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimSettings
 TtfwClassRef.Register(TPrimSettingsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.