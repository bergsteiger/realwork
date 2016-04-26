unit LogoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Logo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\LogoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "LogoKeywordsPack" MUID: (9B1AA5731794)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Logo_Form
 , tfwControlString
 , tfwScriptingTypes
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
;

type
 Tkw_Form_Logo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Logo
----
*������ �������������*:
[code]
'aControl' �����::Logo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Logo

function Tkw_Form_Logo.GetString: AnsiString;
begin
 Result := 'LogoForm';
end;//Tkw_Form_Logo.GetString

class procedure Tkw_Form_Logo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TLogoForm);
end;//Tkw_Form_Logo.RegisterInEngine

class function Tkw_Form_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Logo';
end;//Tkw_Form_Logo.GetWordNameForRegister

initialization
 Tkw_Form_Logo.RegisterInEngine;
 {* ����������� Tkw_Form_Logo }
{$IfEnd} // NOT Defined(NoScripts)

end.
