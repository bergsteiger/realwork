unit kwRAISE;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: ����� �.�.
// ������: "kwRAISE.pas"
// �����: 29.04.2011 20:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::RAISE
//
// ����������������� ����� RAISE. ���������� raise �� Delphi. ���� �� ���� ����������, ��
// ������������ EtfwScriptException.
// ������:
// {code}
// TRY
// '�������� ����������' RAISE
// EXCEPT
// true >>> WasException
// END
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwRAISE = {scriptword} class(TtfwRegisterableWord)
  {* ����������������� ����� RAISE. ���������� raise �� Delphi. ���� �� ���� ����������, �� ������������ EtfwScriptException.
������:
[code]
TRY
 '�������� ����������' RAISE
EXCEPT
 true >>> WasException
END
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwRAISE
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwRAISE

procedure TkwRAISE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAE64F02F7_var*
type
 RException = class of Exception;
//#UC END# *4DAEEDE10285_4DBAE64F02F7_var*
begin
//#UC START# *4DAEEDE10285_4DBAE64F02F7_impl*
 if (aCtx.rException <> nil) then
  raise RException(aCtx.rException.ClassType).Create(aCtx.rException.Message)
 else
  raise EtfwScriptException.Create(aCtx.rEngine.PopDelphiString);
//#UC END# *4DAEEDE10285_4DBAE64F02F7_impl*
end;//TkwRAISE.DoDoIt

class function TkwRAISE.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'RAISE';
end;//TkwRAISE.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� RAISE
 TkwRAISE.RegisterInEngine;
{$IfEnd} //not NoScripts

end.