unit kwRuntimeWordWithCodeExecution;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "kwRuntimeWordWithCodeExecution.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TkwRuntimeWordWithCodeExecution
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwRuntimeWordWithCode,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwRuntimeWordWithCodeExecution = class(TkwRuntimeWordWithCode)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwRuntimeWordWithCodeExecution
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwRuntimeWordWithCodeExecution

procedure TkwRuntimeWordWithCodeExecution.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52D69DF30179_var*
//#UC END# *4DAEEDE10285_52D69DF30179_var*
begin
//#UC START# *4DAEEDE10285_52D69DF30179_impl*
 RunCode(aCtx);
//#UC END# *4DAEEDE10285_52D69DF30179_impl*
end;//TkwRuntimeWordWithCodeExecution.DoDoIt

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwRuntimeWordWithCodeExecution
 TkwRuntimeWordWithCodeExecution.RegisterClass;
{$IfEnd} //not NoScripts

end.