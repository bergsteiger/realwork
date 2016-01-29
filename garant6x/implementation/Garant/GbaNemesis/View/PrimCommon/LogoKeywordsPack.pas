unit LogoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/LogoKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::LogoKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Logo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Logo_Form,
  tfwControlString
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes
  ;

type
 Tkw_Form_Logo = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Logo
----
*������ �������������*:
[code]
'aControl' �����::Logo TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_Logo

// start class Tkw_Form_Logo

class function Tkw_Form_Logo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Logo';
end;//Tkw_Form_Logo.GetWordNameForRegister

function Tkw_Form_Logo.GetString: AnsiString;
 {-}
begin
 Result := 'LogoForm';
end;//Tkw_Form_Logo.GetString

class procedure Tkw_Form_Logo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TLogoForm);
end;//Tkw_Form_Logo.RegisterInEngine
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_Logo
 Tkw_Form_Logo.RegisterInEngine;
{$IfEnd} //not NoScripts

end.