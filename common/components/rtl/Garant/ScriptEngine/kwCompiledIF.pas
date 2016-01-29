unit kwCompiledIF;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwCompiledIF.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine::Scripting Axiomatics::TkwCompiledIF
//
// ���������� ���������������� ������ IF.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwDualCompiledWordContainer,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwCompiledIF = class(TkwDualCompiledWordContainer)
  {* ���������� ���������������� ������ IF. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledIF
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  l3Base
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwCompiledIF

procedure TkwCompiledIF.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB6EE250251_var*
//#UC END# *4DAEEDE10285_4DB6EE250251_var*
begin
//#UC START# *4DAEEDE10285_4DB6EE250251_impl*
 if aCtx.rEngine.PopBool then
  WordToWork.DoIt(aCtx)
 else
 if (f_ElseBranch <> nil) then
  f_ElseBranch.DoIt(aCtx);
//#UC END# *4DAEEDE10285_4DB6EE250251_impl*
end;//TkwCompiledIF.DoDoIt

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwCompiledIF
 TkwCompiledIF.RegisterClass;
{$IfEnd} //not NoScripts

end.