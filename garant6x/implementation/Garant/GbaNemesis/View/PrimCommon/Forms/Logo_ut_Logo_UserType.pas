unit Logo_ut_Logo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/Logo_ut_Logo_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::Logo::ut_Logo
//
// Logo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
   { ��������� ��� ���� ����� ut_Logo }
  ut_LogoName = 'ut_Logo';
   { ��������� ������������� ����������������� ���� "Logo" }
  ut_Logo = TvcmUserType(0);
   { Logo }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_ut_Logo = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_Logo }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_Logo
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_ut_Logo

class function Tkw_FormUserType_ut_Logo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_Logo';
end;//Tkw_FormUserType_ut_Logo.GetWordNameForRegister

function Tkw_FormUserType_ut_Logo.GetInteger: Integer;
 {-}
begin
 Result := ut_Logo;
end;//Tkw_FormUserType_ut_Logo.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_Logo
 Tkw_FormUserType_ut_Logo.RegisterInEngine;
{$IfEnd} //not NoScripts

end.