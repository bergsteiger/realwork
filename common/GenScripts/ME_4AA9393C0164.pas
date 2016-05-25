unit QueryCard_Form;
 {* �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\QueryCard_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "QueryCard" MUID: (4AA9393C0164)
// ��� ����: "TenQueryCard"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCardOptions_Form
 , Search_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenQueryCard = {final} class(TPrimQueryCardOptionsForm, QueryCardFormDef)
  {* �������� �������� }
   Entities : TvcmEntities;
 end;//TenQueryCard
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , QueryCardKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_enQueryCard.SetFactory(TenQueryCard.Make);
 {* ����������� ������� ����� QueryCard }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenQueryCard);
 {* ����������� QueryCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
