unit MainMenuNew_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuNew_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "MainMenuNew" MUID: (4ABB949D005E)
// Имя типа: "Ten_MainMenuNew"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMainMenuNew_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_MainMenuNew = {final} class(TPrimMainMenuNewForm, MainMenuNewFormDef)
   Entities : TvcmEntities;
 end;//Ten_MainMenuNew
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainMenuNewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmHistoryService
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , SysUtils
 , afwFacade
;

{$R *.DFM}

initialization
 fm_en_MainMenuNew.SetFactory(Ten_MainMenuNew.Make);
 {* Регистрация фабрики формы MainMenuNew }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MainMenuNew);
 {* Регистрация MainMenuNew }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
