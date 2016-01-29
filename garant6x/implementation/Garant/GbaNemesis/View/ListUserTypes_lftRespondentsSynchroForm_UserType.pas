unit ListUserTypes_lftRespondentsSynchroForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftRespondentsSynchroForm_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftRespondentsSynchroForm
//
// ���������� �������� (������ �� ���������)
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
  ListUserTypes_lftCorrespondentsSynchroForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftRespondentsSynchroForm }
  lftRespondentsSynchroFormName = 'lftRespondentsSynchroForm';
   { ��������� ������������� ����������������� ���� "���������� �������� (������ �� ���������)" }
  lftRespondentsSynchroForm = TvcmUserType(lftCorrespondentsSynchroForm + 1);
   { ���������� �������� (������ �� ���������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftRespondentsSynchroForm = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftRespondentsSynchroForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftRespondentsSynchroForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftRespondentsSynchroForm

class function Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftRespondentsSynchroForm';
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger: Integer;
 {-}
begin
 Result := lftRespondentsSynchroForm;
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftRespondentsSynchroForm
 Tkw_FormUserType_lftRespondentsSynchroForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.