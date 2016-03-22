unit PrimSettings_Form;
 {* Настройка конфигурации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimSettings_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimSettings" MUID: (4AC63ADF023F)
// Имя типа: "TPrimSettingsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Settings_Strange_Controls
 , ConfigInterfaces
 , bsInterfaces
 , Classes
;

type
 TPrimSettingsForm = class(TvcmContainerForm)
  {* Настройка конфигурации }
  private
   f_Filled: Boolean;
  protected
   f_ManagerConf: InsConfigSettingsInfo;
  private
   procedure StartEdit;
   procedure vcmContainerFormKeyDown(Sender: TObject;
    var Key: Word;
    Shift: TShiftState);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   function CloseQuery: Boolean; override;
    {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure DoOnShowModal; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsConfigSettingsInfo): Il3CommandTarget; reintroduce;
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
   procedure Result_RestoreConf_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_RestoreConf_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Result_SaveAsDefaultConf_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_SaveAsDefaultConf_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Result_RestoreAllSettings_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimSettingsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsConfigurationList
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsAppConfig
 , OvcController
 , OvcCmd
 , Messages
 , OvcConst
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , afwFacade
 , SysUtils
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки cutSettingsLocalConstants }
 str_cutSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutSettingsCaption'; rValue : 'Настройка конфигурации');
  {* Заголовок пользовательского типа "Настройка конфигурации" }

procedure TPrimSettingsForm.StartEdit;
var l_Settings: InsSettings;
//#UC START# *4AC63BB001DA_4AC63ADF023F_var*
//#UC END# *4AC63BB001DA_4AC63ADF023F_var*
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

class function TPrimSettingsForm.Make(const aData: InsConfigSettingsInfo): Il3CommandTarget;
var
 l_Inst : TPrimSettingsForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimSettingsForm.Make

procedure TPrimSettingsForm.vcmContainerFormKeyDown(Sender: TObject;
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
end;//TPrimSettingsForm.vcmContainerFormKeyDown

procedure TPrimSettingsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC63ADF023Fexec_var*
//#UC END# *4A8AD46D0226_4AC63ADF023Fexec_var*
begin
//#UC START# *4A8AD46D0226_4AC63ADF023Fexec_impl*
 f_ManagerConf.Load(False);
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC63ADF023Fexec_impl*
end;//TPrimSettingsForm.Result_Cancel_Execute

procedure TPrimSettingsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC63ADF023Ftest_var*
//#UC END# *4A97EBE702F8_4AC63ADF023Ftest_var*
begin
//#UC START# *4A97EBE702F8_4AC63ADF023Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_ManagerConf.IsOverallModified;
//#UC END# *4A97EBE702F8_4AC63ADF023Ftest_impl*
end;//TPrimSettingsForm.Result_Ok_Test

procedure TPrimSettingsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
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
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(NoVCL)}
function TPrimSettingsForm.CloseQuery: Boolean;
 {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
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
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimSettingsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

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

initialization
 str_cutSettingsCaption.Init;
 {* Инициализация str_cutSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSettingsForm);
 {* Регистрация PrimSettings }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
