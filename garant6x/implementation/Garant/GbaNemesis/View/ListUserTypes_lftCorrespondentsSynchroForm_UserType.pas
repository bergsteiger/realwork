unit ListUserTypes_lftCorrespondentsSynchroForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftCorrespondentsSynchroForm_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftCorrespondentsSynchroForm
//
// ���������� �������� (������ �� ��������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftCorrespondentsSynchroForm }
  lftCorrespondentsSynchroFormName = 'lftCorrespondentsSynchroForm';
   { ��������� ������������� ����������������� ���� "���������� �������� (������ �� ��������)" }
  lftCorrespondentsSynchroForm = TvcmUserType(lftSimilarDocumentsSynchroView + 1);
   { ���������� �������� (������ �� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftCorrespondentsSynchroForm = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftCorrespondentsSynchroForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftCorrespondentsSynchroForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftCorrespondentsSynchroForm

class function Tkw_FormUserType_lftCorrespondentsSynchroForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftCorrespondentsSynchroForm';
end;//Tkw_FormUserType_lftCorrespondentsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftCorrespondentsSynchroForm.GetInteger: Integer;
 {-}
begin
 Result := lftCorrespondentsSynchroForm;
end;//Tkw_FormUserType_lftCorrespondentsSynchroForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftCorrespondentsSynchroForm
 Tkw_FormUserType_lftCorrespondentsSynchroForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.