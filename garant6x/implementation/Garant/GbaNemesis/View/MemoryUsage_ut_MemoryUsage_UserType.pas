unit MemoryUsage_ut_MemoryUsage_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MemoryUsage_ut_MemoryUsage_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ��� �����������::F1 Without Usecases::View::Main::MemoryUsage::ut_MemoryUsage
//
// ������������ �������
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
   { ��������� ��� ���� ����� ut_MemoryUsage }
  ut_MemoryUsageName = 'ut_MemoryUsage';
   { ��������� ������������� ����������������� ���� "������������ �������" }
  ut_MemoryUsage = TvcmUserType(0);
   { ������������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_ut_MemoryUsage = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_MemoryUsage }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_MemoryUsage
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_MemoryUsage

class function Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_MemoryUsage';
end;//Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister

function Tkw_FormUserType_ut_MemoryUsage.GetInteger: Integer;
 {-}
begin
 Result := ut_MemoryUsage;
end;//Tkw_FormUserType_ut_MemoryUsage.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_MemoryUsage
 Tkw_FormUserType_ut_MemoryUsage.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.