unit NOT_FINISHED_PageSetup_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/NOT_FINISHED_PageSetup_Form.pas"
// Начат: 15.09.2009 16:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::PageSetup
//
// Настройка страницы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimPageSetupOptions_Form,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscPageControl
  {$IfEnd} //Nemesis
  ,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
  Ten_PageSetup = {final form} class(TPrimPageSetupOptionsForm)
   {* Настройка страницы }
  Entities : TvcmEntities;
  PreviewGroupBox: TvtGroupBox;
  SettingsPageControl: TnscPageControl;
  protected
  // realized methods
   {$If not defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сохранить }
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
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   procedure ReadPageFormats; override;
   procedure SetColontitulComboBoxItemIndex(aIndex: Integer); override;
   procedure ToGUIMargins; override;
   procedure Save(SaveAsDefault: Boolean = False); override;
   procedure SetPageFormat(aOrientation: Integer); override;
   procedure MacroAdd(const aString: AnsiString); override;
   procedure ToGUIColontituls; override;
  end;//Ten_PageSetup

  TPageSetupForm = Ten_PageSetup;
{$IfEnd} //not Admin

implementation

{$R *.DFM}

{$If not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PageSetupKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class Ten_PageSetup

{$If not defined(NoVCM)}
procedure Ten_PageSetup.File_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495235F401C0_4AAF86650309test_var*
//#UC END# *495235F401C0_4AAF86650309test_var*
begin
//#UC START# *495235F401C0_4AAF86650309test_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AAF86650309test_impl*
end;//Ten_PageSetup.File_Save_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495235F401C0_4AAF86650309exec_var*
//#UC END# *495235F401C0_4AAF86650309exec_var*
begin
//#UC START# *495235F401C0_4AAF86650309exec_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AAF86650309exec_impl*
end;//Ten_PageSetup.File_Save_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AAF86650309test_var*
//#UC END# *4A97EBE702F8_4AAF86650309test_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309test_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309test_impl*
end;//Ten_PageSetup.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AAF86650309getstate_var*
//#UC END# *4A97EBE702F8_4AAF86650309getstate_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309getstate_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309getstate_impl*
end;//Ten_PageSetup.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AAF86650309exec_var*
//#UC END# *4A97EBE702F8_4AAF86650309exec_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309exec_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309exec_impl*
end;//Ten_PageSetup.Result_Ok_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AC5D61E0284_4AAF86650309test_var*
//#UC END# *4AC5D61E0284_4AAF86650309test_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309test_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309test_impl*
end;//Ten_PageSetup.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4AC5D61E0284_4AAF86650309getstate_var*
//#UC END# *4AC5D61E0284_4AAF86650309getstate_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309getstate_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309getstate_impl*
end;//Ten_PageSetup.Result_Cancel_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Ten_PageSetup.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AC5D61E0284_4AAF86650309exec_var*
//#UC END# *4AC5D61E0284_4AAF86650309exec_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309exec_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309exec_impl*
end;//Ten_PageSetup.Result_Cancel_Execute
{$IfEnd} //not NoVCM

procedure Ten_PageSetup.ReadPageFormats;
//#UC START# *4AC608780164_4AAF86650309_var*
//#UC END# *4AC608780164_4AAF86650309_var*
begin
//#UC START# *4AC608780164_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC608780164_4AAF86650309_impl*
end;//Ten_PageSetup.ReadPageFormats

procedure Ten_PageSetup.SetColontitulComboBoxItemIndex(aIndex: Integer);
//#UC START# *4AC6089603D4_4AAF86650309_var*
//#UC END# *4AC6089603D4_4AAF86650309_var*
begin
//#UC START# *4AC6089603D4_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC6089603D4_4AAF86650309_impl*
end;//Ten_PageSetup.SetColontitulComboBoxItemIndex

procedure Ten_PageSetup.ToGUIMargins;
//#UC START# *4AC608AC03C7_4AAF86650309_var*
//#UC END# *4AC608AC03C7_4AAF86650309_var*
begin
//#UC START# *4AC608AC03C7_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC608AC03C7_4AAF86650309_impl*
end;//Ten_PageSetup.ToGUIMargins

procedure Ten_PageSetup.Save(SaveAsDefault: Boolean = False);
//#UC START# *4C88D996000B_4AAF86650309_var*
//#UC END# *4C88D996000B_4AAF86650309_var*
begin
//#UC START# *4C88D996000B_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D996000B_4AAF86650309_impl*
end;//Ten_PageSetup.Save

procedure Ten_PageSetup.SetPageFormat(aOrientation: Integer);
//#UC START# *4C88D9B60023_4AAF86650309_var*
//#UC END# *4C88D9B60023_4AAF86650309_var*
begin
//#UC START# *4C88D9B60023_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D9B60023_4AAF86650309_impl*
end;//Ten_PageSetup.SetPageFormat

procedure Ten_PageSetup.MacroAdd(const aString: AnsiString);
//#UC START# *4C88D9D30306_4AAF86650309_var*
//#UC END# *4C88D9D30306_4AAF86650309_var*
begin
//#UC START# *4C88D9D30306_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D9D30306_4AAF86650309_impl*
end;//Ten_PageSetup.MacroAdd

procedure Ten_PageSetup.ToGUIColontituls;
//#UC START# *4C88DCA000DD_4AAF86650309_var*
//#UC END# *4C88DCA000DD_4AAF86650309_var*
begin
//#UC START# *4C88DCA000DD_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88DCA000DD_4AAF86650309_impl*
end;//Ten_PageSetup.ToGUIColontituls

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PageSetup
 TtfwClassRef.Register(Ten_PageSetup);
{$IfEnd} //not Admin AND not NoScripts

end.