unit Diction_Form;
 {* �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\Diction_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDictionOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TenDiction = {final} class(TPrimDictionOptionsForm, DictionFormDef)
  {* �������� ������� }
 end;//TenDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , DictionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenDiction);
 {* ����������� Diction }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enDiction.SetFactory(TenDiction.Make);
 {* ����������� ������� ����� Diction }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
