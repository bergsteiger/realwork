unit MainMenuNew_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuNew_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMainMenuNew_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_MainMenuNew = {final} class(TPrimMainMenuNewForm, MainMenuNewFormDef)
 end;//Ten_MainMenuNew
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MainMenuNewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , SysUtils
 , afwFacade
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MainMenuNew);
 {* ����������� MainMenuNew }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MainMenuNew.SetFactory(Ten_MainMenuNew.Make);
 {* ����������� ������� ����� MainMenuNew }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
