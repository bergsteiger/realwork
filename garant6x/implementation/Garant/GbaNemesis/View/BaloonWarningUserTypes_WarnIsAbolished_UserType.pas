unit BaloonWarningUserTypes_WarnIsAbolished_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnIsAbolished_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnIsAbolished
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
  BaloonWarningUserTypes_WarnPreActive_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� WarnIsAbolished }
  WarnIsAbolishedName = 'WarnIsAbolished';
   { ��������� ������������� ����������������� ���� "" }
  WarnIsAbolished = TvcmUserType(WarnPreActive + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnIsAbolished = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� WarnIsAbolished }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnIsAbolished
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnIsAbolished

class function Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::WarnIsAbolished';
end;//Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister

function Tkw_FormUserType_WarnIsAbolished.GetInteger: Integer;
 {-}
begin
 Result := WarnIsAbolished;
end;//Tkw_FormUserType_WarnIsAbolished.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_WarnIsAbolished
 Tkw_FormUserType_WarnIsAbolished.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.