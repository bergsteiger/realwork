unit ListUserTypes_lftProducedDrugsSynchroForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftProducedDrugsSynchroForm_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftProducedDrugsSynchroForm
//
// ���������� �������� (����������� ���������)
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
  ListUserTypes_lftProducedDrugs_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftProducedDrugsSynchroForm }
  lftProducedDrugsSynchroFormName = 'lftProducedDrugsSynchroForm';
   { ��������� ������������� ����������������� ���� "���������� �������� (����������� ���������)" }
  lftProducedDrugsSynchroForm = TvcmUserType(lftProducedDrugs + 1);
   { ���������� �������� (����������� ���������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftProducedDrugsSynchroForm = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftProducedDrugsSynchroForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftProducedDrugsSynchroForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftProducedDrugsSynchroForm

class function Tkw_FormUserType_lftProducedDrugsSynchroForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftProducedDrugsSynchroForm';
end;//Tkw_FormUserType_lftProducedDrugsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftProducedDrugsSynchroForm.GetInteger: Integer;
 {-}
begin
 Result := lftProducedDrugsSynchroForm;
end;//Tkw_FormUserType_lftProducedDrugsSynchroForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftProducedDrugsSynchroForm
 Tkw_FormUserType_lftProducedDrugsSynchroForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.