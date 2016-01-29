unit kwTestResolveInputFilePath;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwTestResolveInputFilePath.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::EtalonsWorking::test_ResolveInputFilePath
//
// *��������:* ��������� � ����� ����� ���� � ���������� TestSet, ��� �������� �������� �����.
// *������*
// {code}
// aFileName test:ResolveInputFilePath
// {code}
// ��� aFileName - ��� ����� ��� ���� (!).
// ��������� ���������� � ����.
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
 TkwTestResolveInputFilePath = {final scriptword} class(TtfwRegisterableWord)
  {* *��������:* ��������� � ����� ����� ���� � ���������� TestSet, ��� �������� �������� �����.
*������*
[code]
aFileName test:ResolveInputFilePath
[code]
��� aFileName - ��� ����� ��� ���� (!).
��������� ���������� � ����. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTestResolveInputFilePath
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwTestResolveInputFilePath

procedure TkwTestResolveInputFilePath.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53FC3551023F_var*
//#UC END# *4DAEEDE10285_53FC3551023F_var*
begin
//#UC START# *4DAEEDE10285_53FC3551023F_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ��� �����!', aCtx);
 aCtx.rEngine.PushString(aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_53FC3551023F_impl*
end;//TkwTestResolveInputFilePath.DoDoIt

class function TkwTestResolveInputFilePath.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'test:ResolveInputFilePath';
end;//TkwTestResolveInputFilePath.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� test_ResolveInputFilePath
 TkwTestResolveInputFilePath.RegisterInEngine;
{$IfEnd} //not NoScripts

end.