unit WarningUserTypes_Warning_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WarningUserTypes_Warning_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::WarningUserTypes::Warning
//
// ��������������
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
   { ��������� ��� ���� ����� Warning }
  WarningName = 'Warning';
   { ��������� ������������� ����������������� ���� "��������������" }
  Warning = TvcmUserType(0);
   { �������������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_Warning = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� Warning }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_Warning
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_Warning

class function Tkw_FormUserType_Warning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::Warning';
end;//Tkw_FormUserType_Warning.GetWordNameForRegister

function Tkw_FormUserType_Warning.GetInteger: Integer;
 {-}
begin
 Result := Warning;
end;//Tkw_FormUserType_Warning.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_Warning
 Tkw_FormUserType_Warning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.