unit NOT_FINISHED_vcmUserTypesCollectionItem;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmUserTypesCollectionItem.pas"
// ���������: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseUserTypesCollectionItem
;

type
 TvcmUserTypesCollectionItem = class(TvcmBaseUserTypesCollectionItem)
 end;//TvcmUserTypesCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmUserTypesCollectionItem);
 {* ����������� TvcmUserTypesCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
