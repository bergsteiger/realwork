unit PrimMedicFirmList_mflMain_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/PrimMedicFirmList_mflMain_UserType.pas"
// �����: 27.01.2009 13:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Inpharm::View::Inpharm::PrimMedicFirmList::mflMain
//
// ���������������� ����� (������ ������)
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� mflMain }
  mflMainName = 'mflMain';
   { ��������� ������������� ����������������� ���� "���������������� ����� (������ ������)" }
  mflMain = TvcmUserType(0);
   { ���������������� ����� (������ ������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_mflMain = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� mflMain }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_mflMain
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_mflMain

class function Tkw_FormUserType_mflMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::mflMain';
end;//Tkw_FormUserType_mflMain.GetWordNameForRegister

function Tkw_FormUserType_mflMain.GetInteger: Integer;
 {-}
begin
 Result := mflMain;
end;//Tkw_FormUserType_mflMain.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_mflMain
 Tkw_FormUserType_mflMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.