unit StartupTips_ut_StartupTips_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DayTips/Forms/StartupTips_ut_StartupTips_UserType.pas"
// �����: 04.09.2009 12:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������������ ��������::DayTips::View::DayTips::DayTips::StartupTips::ut_StartupTips
//
// ����� ���
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
    { ��������� ��� ���� ����� ut_StartupTips }
   ut_StartupTipsName = 'ut_StartupTips';
    { ��������� ������������� ����������������� ���� "����� ���" }
   ut_StartupTips = TvcmUserType(0);
    { ����� ��� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_StartupTips = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_StartupTips }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_StartupTips
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_StartupTips

class function Tkw_FormUserType_ut_StartupTips.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_StartupTips';
end;//Tkw_FormUserType_ut_StartupTips.GetWordNameForRegister

function Tkw_FormUserType_ut_StartupTips.GetInteger: Integer;
 {-}
begin
 Result := ut_StartupTips;
end;//Tkw_FormUserType_ut_StartupTips.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_StartupTips
 Tkw_FormUserType_ut_StartupTips.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.