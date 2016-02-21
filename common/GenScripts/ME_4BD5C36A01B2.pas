unit PrimQueryCard_utqcLegislationReview_UserType;
 {* ����� ��������� ���������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcLegislationReview_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcPostingOrder_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utqcLegislationReview }
 utqcLegislationReviewName = 'utqcLegislationReview';
  {* ��������� ������������� ����������������� ���� "����� ��������� ����������������" }
 utqcLegislationReview = TvcmUserType(utqcPostingOrder + 1);
  {* ����� ��������� ���������������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcLegislationReview = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcLegislationReview }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utqcLegislationReview
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utqcLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcLegislationReview';
end;//Tkw_FormUserType_utqcLegislationReview.GetWordNameForRegister

function Tkw_FormUserType_utqcLegislationReview.GetInteger: Integer;
begin
 Result := utqcLegislationReview;
end;//Tkw_FormUserType_utqcLegislationReview.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcLegislationReview.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
