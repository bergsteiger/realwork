unit NOT_FINISHED_PageSetup_Form;
 {* Настройка страницы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NOT_FINISHED_PageSetup_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPageSetupOptions_Form
;

type
 Ten_PageSetup = {final} class(TPrimPageSetupOptionsForm)
  {* Настройка страницы }
  protected
   procedure ReadPageFormats; override;
   procedure SetColontitulComboBoxItemIndex(aIndex: Integer); override;
   procedure ToGUIMargins; override;
   procedure Save(SaveAsDefault: Boolean); override;
   procedure SetPageFormat(aOrientation: Integer); override;
   procedure MacroAdd(const aString: AnsiString); override;
   procedure ToGUIColontituls; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_PageSetup
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PageSetupKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Save;
 {* Сохранить }
//#UC START# *495235F401C0_4AAF86650309_var*
//#UC END# *495235F401C0_4AAF86650309_var*
begin
//#UC START# *495235F401C0_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AAF86650309_impl*
end;//Ten_PageSetup.Save
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4AAF86650309_var*
//#UC END# *4A97EBE702F8_4AAF86650309_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309_impl*
end;//Ten_PageSetup.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_4AAF86650309_var*
//#UC END# *4AC5D61E0284_4AAF86650309_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309_impl*
end;//Ten_PageSetup.Cancel
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

procedure Ten_PageSetup.Save(SaveAsDefault: Boolean);
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
