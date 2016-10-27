unit PrimSaveLoadUserTypes_slqtLegislationReview_UserType;
 {* �����: �����. ����� ��������� ���������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtLegislationReview" MUID: (4BD5BBDE032E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ slqtLegislationReviewLocalConstants }
 str_slqtLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtLegislationReviewCaption'; rValue : '�����: �����. ����� ��������� ����������������');
  {* ��������� ����������������� ���� "�����: �����. ����� ��������� ����������������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtLegislationReview = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtLegislationReview }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtLegislationReview
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtLegislationReview.GetInteger: Integer;
begin
 Result := slqtLegislationReview;
end;//Tkw_FormUserType_slqtLegislationReview.GetInteger

class function Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtLegislationReview';
end;//Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtLegislationReviewCaption.Init;
 {* ������������� str_slqtLegislationReviewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtLegislationReview.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
