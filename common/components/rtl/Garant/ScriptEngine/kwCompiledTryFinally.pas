unit kwCompiledTryFinally;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: ����� �.�.
// ������: "kwCompiledTryFinally.pas"
// �����: 29.04.2011 18:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine::Scripting Axiomatics::TkwCompiledTryFinally
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
 TkwCompiledTryFinally = class(TkwDualCompiledWordContainer)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledTryFinally
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwClassRef
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwCompiledTryFinally

procedure TkwCompiledTryFinally.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAC56C017C_var*
//#UC END# *4DAEEDE10285_4DBAC56C017C_var*
begin
//#UC START# *4DAEEDE10285_4DBAC56C017C_impl*
 try
  WordToWork.DoIt(aCtx);
 finally
  f_ElseBranch.DoIt(aCtx);
 end;//try..finally
//#UC END# *4DAEEDE10285_4DBAC56C017C_impl*
end;//TkwCompiledTryFinally.DoDoIt

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwCompiledTryFinally
 TkwCompiledTryFinally.RegisterClass;
{$IfEnd} //not NoScripts

end.