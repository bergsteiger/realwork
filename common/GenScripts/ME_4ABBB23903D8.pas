unit Navigator_Form;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\Navigator_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNavigatorOptions_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_Navigator = {final} class(TPrimNavigatorOptionsForm, NavigatorFormDef)
  {* ���� }
 end;//Ten_Navigator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , NavigatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_Navigator);
 {* ����������� Navigator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_Navigator.SetFactory(Ten_Navigator.Make);
 {* ����������� ������� ����� Navigator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
