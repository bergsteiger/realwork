unit LogoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Logo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\LogoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_Logo

class function Tkw_Form_Logo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Logo';
end;//Tkw_Form_Logo.GetWordNameForRegister

function Tkw_Form_Logo.GetString: AnsiString;
begin
 Result := 'LogoForm';
end;//Tkw_Form_Logo.GetString

class procedure Tkw_Form_Logo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TLogoForm);
end;//Tkw_Form_Logo.RegisterInEngine

initialization
 Tkw_Form_Logo.RegisterInEngine;
 {* ����������� Tkw_Form_Logo }
{$IfEnd} // NOT Defined(NoScripts)

end.
