unit PrimSaveLoadUserTypes_slqtLegislationReview_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtLegislationReview_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtLegislationReview
//
// �����: �����. ����� ��������� ����������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimSaveLoadUserTypes_slqtFilters_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtLegislationReview }
  slqtLegislationReviewName = 'slqtLegislationReview';
   { ��������� ������������� ����������������� ���� "�����: �����. ����� ��������� ����������������" }
  slqtLegislationReview = TvcmUserType(slqtFilters + 1);
   { �����: �����. ����� ��������� ���������������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtLegislationReview = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtLegislationReview }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtLegislationReview
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtLegislationReview

class function Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtLegislationReview';
end;//Tkw_FormUserType_slqtLegislationReview.GetWordNameForRegister

function Tkw_FormUserType_slqtLegislationReview.GetInteger: Integer;
 {-}
begin
 Result := slqtLegislationReview;
end;//Tkw_FormUserType_slqtLegislationReview.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtLegislationReview
 Tkw_FormUserType_slqtLegislationReview.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.