unit PrimQueryCard_utqcLegislationReview_UserType;
 {* ����� ��������� ���������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcLegislationReview_UserType.pas"
// ���������: "UserType"
// ������� ������: "utqcLegislationReview" MUID: (4BD5C36A01B2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcPostingOrder_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ utqcLegislationReviewLocalConstants }
 str_utqcLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcLegislationReviewCaption'; rValue : '����� ��������� ����������������');
  {* ��������� ����������������� ���� "����� ��������� ����������������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utqcLegislationReview = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcLegislationReview }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcLegislationReview
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcLegislationReview.GetInteger: Integer;
begin
 Result := utqcLegislationReview;
end;//Tkw_FormUserType_utqcLegislationReview.GetInteger

class function Tkw_FormUserType_utqcLegislationReview.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcLegislationReview';
end;//Tkw_FormUserType_utqcLegislationReview.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utqcLegislationReviewCaption.Init;
 {* ������������� str_utqcLegislationReviewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcLegislationReview.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcLegislationReview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
