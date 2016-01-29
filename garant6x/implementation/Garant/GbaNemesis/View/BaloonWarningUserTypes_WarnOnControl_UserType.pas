unit BaloonWarningUserTypes_WarnOnControl_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnOnControl_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnOnControl
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
  BaloonWarningUserTypes_WarnIsAbolished_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� WarnOnControl }
  WarnOnControlName = 'WarnOnControl';
   { ��������� ������������� ����������������� ���� "" }
  WarnOnControl = TvcmUserType(WarnIsAbolished + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnOnControl = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� WarnOnControl }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnOnControl
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnOnControl

class function Tkw_FormUserType_WarnOnControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::WarnOnControl';
end;//Tkw_FormUserType_WarnOnControl.GetWordNameForRegister

function Tkw_FormUserType_WarnOnControl.GetInteger: Integer;
 {-}
begin
 Result := WarnOnControl;
end;//Tkw_FormUserType_WarnOnControl.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_WarnOnControl
 Tkw_FormUserType_WarnOnControl.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.