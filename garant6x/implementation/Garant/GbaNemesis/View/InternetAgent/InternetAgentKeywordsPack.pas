unit InternetAgentKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� InternetAgent$F }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\InternetAgentKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "InternetAgentKeywordsPack" MUID: (A85B3F2265CC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , InternetAgent_Form
 , tfwControlString
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_InternetAgent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� InternetAgent$F
----
*������ �������������*:
[code]
'aControl' �����::InternetAgent TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_InternetAgent

function Tkw_Form_InternetAgent.GetString: AnsiString;
begin
 Result := 'InternetAgentForm';
end;//Tkw_Form_InternetAgent.GetString

class function Tkw_Form_InternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::InternetAgent';
end;//Tkw_Form_InternetAgent.GetWordNameForRegister

initialization
 Tkw_Form_InternetAgent.RegisterInEngine;
 {* ����������� Tkw_Form_InternetAgent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TInternetAgentForm));
 {* ����������� ���� TInternetAgentForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
