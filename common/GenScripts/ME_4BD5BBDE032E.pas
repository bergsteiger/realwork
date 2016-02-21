unit PrimSaveLoadUserTypes_slqtLegislationReview_UserType;
 {* �����: �����. ����� ��������� ���������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� slqtLegislationReview }
 slqtLegislationReviewName = 'slqtLegislationReview';
  {* ��������� ������������� ����������������� ���� "�����: �����. ����� ��������� ����������������" }
 slqtLegislationReview = TvcmUserType(slqtFilters + 1);
  {* �����: �����. ����� ��������� ���������������� }
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
 Tkw_FormUserType_slqtLegislationReview = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtLegislationReview }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtLegislationReview
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtLegislationReview';
end;//Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister

function Tkw_FormUserType_slqtLegislationReview.GetInteger: Integer;
begin
 Result := slqtLegislationReview;
end;//Tkw_FormUserType_slqtLegislationReview.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtLegislationReview.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
