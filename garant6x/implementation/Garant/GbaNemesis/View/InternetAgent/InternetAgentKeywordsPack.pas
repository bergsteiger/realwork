unit InternetAgentKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/InternetAgentKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������� ��������::InternetAgent::View::InternetAgent::PrimInternetAgent$FP::InternetAgentKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� InternetAgent$F
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  InternetAgent_Form,
  tfwControlString
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;

type
  Tkw_Form_InternetAgent = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� InternetAgent$F
----
*������ �������������*:
[code]
'aControl' �����::InternetAgent TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_InternetAgent

// start class Tkw_Form_InternetAgent

class function Tkw_Form_InternetAgent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::InternetAgent';
end;//Tkw_Form_InternetAgent.GetWordNameForRegister

function Tkw_Form_InternetAgent.GetString: AnsiString;
 {-}
begin
 Result := 'InternetAgentForm';
end;//Tkw_Form_InternetAgent.GetString
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_InternetAgent
 Tkw_Form_InternetAgent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.