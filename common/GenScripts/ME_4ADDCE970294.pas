unit OfficeLikeRes;

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas"
// ���������: "VCMApplication"
// ������� ������: "OfficeLike" MUID: (4ADDCE970294)
// ��� ����: "TOfficeLikeRes"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmApplication
;

type
 TOfficeLikeRes = {abstract} class(TvcmApplication)
 end;//TOfficeLikeRes
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , moToolbarMenu
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
;
{$IfEnd} // NOT Defined(NoVCM)

end.
