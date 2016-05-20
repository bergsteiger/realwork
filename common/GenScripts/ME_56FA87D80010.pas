unit MainMenuWithProfNews_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuWithProfNews_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "MainMenuWithProfNews" MUID: (56FA87D80010)
// Имя типа: "Ten_MainMenuWithProfNews"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMainMenuWithProfNews_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_MainMenuWithProfNews = {final} class(TPrimMainMenuWithProfNewsForm, MainMenuWithProfNewsFormDef)
   Entities : TvcmEntities;
 end;//Ten_MainMenuWithProfNews
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainMenuWithProfNewsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MainMenuWithProfNews);
 {* Регистрация MainMenuWithProfNews }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MainMenuWithProfNews.SetFactory(Ten_MainMenuWithProfNews.Make);
 {* Регистрация фабрики формы MainMenuWithProfNews }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
