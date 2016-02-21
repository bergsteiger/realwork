unit MedicMainMenu_Form;
 {* справочник ГАРАНТ-ИнФарм: Лекарства и фирмы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicMainMenu_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InpharmMainMenu_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_MedicMainMenu = {final} class(TInpharmMainMenuForm, MedicMainMenuFormDef)
  {* справочник ГАРАНТ-ИнФарм: Лекарства и фирмы }
 end;//Ten_MedicMainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MedicMainMenuKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , SysUtils
 , afwFacade
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicMainMenu);
 {* Регистрация MedicMainMenu }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicMainMenu.SetFactory(Ten_MedicMainMenu.Make);
 {* Регистрация фабрики формы MedicMainMenu }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
