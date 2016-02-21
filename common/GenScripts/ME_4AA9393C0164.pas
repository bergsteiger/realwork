unit QueryCard_Form;
 {* �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\QueryCard_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCardOptions_Form
 , Search_FormDefinitions_Controls
;

type
 TenQueryCard = {final} class(TPrimQueryCardOptionsForm, QueryCardFormDef)
  {* �������� �������� }
 end;//TenQueryCard
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , QueryCardKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenQueryCard);
 {* ����������� QueryCard }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enQueryCard.SetFactory(TenQueryCard.Make);
 {* ����������� ������� ����� QueryCard }
{$IfEnd} // NOT Defined(Admin)

end.
