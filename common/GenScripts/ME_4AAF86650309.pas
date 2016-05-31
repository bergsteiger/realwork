unit NOT_FINISHED_PageSetup_Form;
 {* Настройка страницы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NOT_FINISHED_PageSetup_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "PageSetup" MUID: (4AAF86650309)
// Имя типа: "Ten_PageSetup"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPageSetupOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
 , vtGroupBox
 {$If Defined(Nemesis)}
 , nscPageControl
 {$IfEnd} // Defined(Nemesis)
;

type
 Ten_PageSetup = {final} class(TPrimPageSetupOptionsForm)
  {* Настройка страницы }
   Entities : TvcmEntities;
   PreviewGroupBox : TvtGroupBox;
   SettingsPageControl : TnscPageControl;
  protected
   procedure ReadPageFormats; override;
   procedure SetColontitulComboBoxItemIndex(aIndex: Integer); override;
   procedure ToGUIMargins; override;
   procedure Save(SaveAsDefault: Boolean = False); override;
   procedure SetPageFormat(aOrientation: Integer); override;
   procedure MacroAdd(const aString: AnsiString); override;
   procedure ToGUIColontituls; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сохранить }
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
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_PageSetup
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PageSetupKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.File_Save_Test(const aParams: IvcmTestParamsPrim);
 {* Сохранить }
//#UC START# *495235F401C0_4AAF86650309test_var*
//#UC END# *495235F401C0_4AAF86650309test_var*
begin
//#UC START# *495235F401C0_4AAF86650309test_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AAF86650309test_impl*
end;//Ten_PageSetup.File_Save_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сохранить }
//#UC START# *495235F401C0_4AAF86650309exec_var*
//#UC END# *495235F401C0_4AAF86650309exec_var*
begin
//#UC START# *495235F401C0_4AAF86650309exec_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AAF86650309exec_impl*
end;//Ten_PageSetup.File_Save_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AAF86650309test_var*
//#UC END# *4A97EBE702F8_4AAF86650309test_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309test_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309test_impl*
end;//Ten_PageSetup.Result_Ok_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AAF86650309exec_var*
//#UC END# *4A97EBE702F8_4AAF86650309exec_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309exec_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309exec_impl*
end;//Ten_PageSetup.Result_Ok_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AAF86650309getstate_var*
//#UC END# *4A97EBE702F8_4AAF86650309getstate_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309getstate_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309getstate_impl*
end;//Ten_PageSetup.Result_Ok_GetState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_4AAF86650309test_var*
//#UC END# *4AC5D61E0284_4AAF86650309test_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309test_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309test_impl*
end;//Ten_PageSetup.Result_Cancel_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_4AAF86650309exec_var*
//#UC END# *4AC5D61E0284_4AAF86650309exec_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309exec_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309exec_impl*
end;//Ten_PageSetup.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* Отмена }
//#UC START# *4AC5D61E0284_4AAF86650309getstate_var*
//#UC END# *4AC5D61E0284_4AAF86650309getstate_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309getstate_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309getstate_impl*
end;//Ten_PageSetup.Result_Cancel_GetState
{$IfEnd} // NOT Defined(NoVCM)

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PageSetup);
 {* Регистрация PageSetup }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
