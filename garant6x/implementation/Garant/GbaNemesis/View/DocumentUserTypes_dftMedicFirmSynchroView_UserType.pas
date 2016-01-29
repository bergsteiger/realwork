unit DocumentUserTypes_dftMedicFirmSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftMedicFirmSynchroView
//
// �������� ����� (���������� ��������)
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
  DocumentUserTypes_dftMedicFirm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� dftMedicFirmSynchroView }
  dftMedicFirmSynchroViewName = 'dftMedicFirmSynchroView';
   { ��������� ������������� ����������������� ���� "�������� ����� (���������� ��������)" }
  dftMedicFirmSynchroView = TvcmUserType(dftMedicFirm + 1);
   { �������� ����� (���������� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftMedicFirmSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftMedicFirmSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftMedicFirmSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftMedicFirmSynchroView

class function Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftMedicFirmSynchroView';
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger: Integer;
 {-}
begin
 Result := dftMedicFirmSynchroView;
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftMedicFirmSynchroView
 Tkw_FormUserType_dftMedicFirmSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.