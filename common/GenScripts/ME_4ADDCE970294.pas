unit NOT_COMPLETED_OfficeLikeRes;

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\NOT_COMPLETED_OfficeLikeRes.pas"
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
  protected
   procedure Loaded; override;
 end;//TOfficeLikeRes
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , moToolbarMenu
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , OfficeLikeMain_Form
 , evExtFormat
;

procedure TOfficeLikeRes.Loaded;
begin
 inherited;
end;//TOfficeLikeRes.Loaded

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOfficeLikeRes);
 {* ����������� OfficeLike }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
