unit ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftDrugInternationalNameSynonymsSynchroForm
//
// ���������� �������� (�������� �� �������������� ��������)
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
  ListUserTypes_lftProducedDrugsSynchroForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftDrugInternationalNameSynonymsSynchroForm }
  lftDrugInternationalNameSynonymsSynchroFormName = 'lftDrugInternationalNameSynonymsSynchroForm';
   { ��������� ������������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" }
  lftDrugInternationalNameSynonymsSynchroForm = TvcmUserType(lftProducedDrugsSynchroForm + 1);
   { ���������� �������� (�������� �� �������������� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftDrugInternationalNameSynonymsSynchroForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm

class function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftDrugInternationalNameSynonymsSynchroForm';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger: Integer;
 {-}
begin
 Result := lftDrugInternationalNameSynonymsSynchroForm;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm
 Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.