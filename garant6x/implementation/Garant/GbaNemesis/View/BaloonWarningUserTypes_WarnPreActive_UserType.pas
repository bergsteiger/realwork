unit BaloonWarningUserTypes_WarnPreActive_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnPreActive_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnPreActive
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
  BaloonWarningUserTypes_WarnJuror_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� WarnPreActive }
  WarnPreActiveName = 'WarnPreActive';
   { ��������� ������������� ����������������� ���� "" }
  WarnPreActive = TvcmUserType(WarnJuror + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnPreActive = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� WarnPreActive }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnPreActive
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnPreActive

class function Tkw_FormUserType_WarnPreActive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::WarnPreActive';
end;//Tkw_FormUserType_WarnPreActive.GetWordNameForRegister

function Tkw_FormUserType_WarnPreActive.GetInteger: Integer;
 {-}
begin
 Result := WarnPreActive;
end;//Tkw_FormUserType_WarnPreActive.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_WarnPreActive
 Tkw_FormUserType_WarnPreActive.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.