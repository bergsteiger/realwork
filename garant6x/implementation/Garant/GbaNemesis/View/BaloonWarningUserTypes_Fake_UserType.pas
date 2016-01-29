unit BaloonWarningUserTypes_Fake_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_Fake_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::Fake
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
   { ��������� ��� ���� ����� Fake }
  FakeName = 'Fake';
   { ��������� ������������� ����������������� ���� "��������������" }
  Fake = TvcmUserType(0);
   { �������������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_Fake = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� Fake }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_Fake
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_Fake

class function Tkw_FormUserType_Fake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::Fake';
end;//Tkw_FormUserType_Fake.GetWordNameForRegister

function Tkw_FormUserType_Fake.GetInteger: Integer;
 {-}
begin
 Result := Fake;
end;//Tkw_FormUserType_Fake.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_Fake
 Tkw_FormUserType_Fake.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.