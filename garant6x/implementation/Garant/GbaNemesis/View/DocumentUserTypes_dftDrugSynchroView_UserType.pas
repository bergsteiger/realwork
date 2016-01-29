unit DocumentUserTypes_dftDrugSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftDrugSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftDrugSynchroView
//
// �������� ��������� (���������� ��������)
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
  DocumentUserTypes_dftMedicFirmSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� dftDrugSynchroView }
  dftDrugSynchroViewName = 'dftDrugSynchroView';
   { ��������� ������������� ����������������� ���� "�������� ��������� (���������� ��������)" }
  dftDrugSynchroView = TvcmUserType(dftMedicFirmSynchroView + 1);
   { �������� ��������� (���������� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftDrugSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftDrugSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftDrugSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftDrugSynchroView

class function Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftDrugSynchroView';
end;//Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftDrugSynchroView.GetInteger: Integer;
 {-}
begin
 Result := dftDrugSynchroView;
end;//Tkw_FormUserType_dftDrugSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftDrugSynchroView
 Tkw_FormUserType_dftDrugSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.