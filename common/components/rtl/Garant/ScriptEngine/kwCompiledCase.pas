unit kwCompiledCase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: ����� �.�.
// ������: "kwCompiledCase.pas"
// �����: 29.04.2011 21:01
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::TkwCompiledCase
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
 TkwCompiledCase = class(TkwRuntimeWordWithCode)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCompiledCase
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwClassRef
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwCompiledCase

procedure TkwCompiledCase.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAEEEC00CF_var*
var
 l_V : Integer;
 l_I : Integer;
 l_C : Integer;
//#UC END# *4DAEEDE10285_4DBAEEEC00CF_var*
begin
//#UC START# *4DAEEDE10285_4DBAEEEC00CF_impl*
 l_V := aCtx.rEngine.PopInt;
 l_I := 0;
 l_C := Code.Count - 1;
 while (l_I < l_C) do
 begin
  if Code[l_I].IsDefaultBranch then
  begin
   Code[l_I + 1].DoIt(aCtx);
   break;
  end//Code[l_I].IsDefaultBranch
  else
  begin
   Code[l_I].DoIt(aCtx);
   if (aCtx.rEngine.PopInt = l_V) then
   begin
    Code[l_I + 1].DoIt(aCtx);
    break;
   end;//aCtx.rEngine.PopInt = l_V
  end;//Code[l_I].IsDefaultBranch
  Inc(l_I, 2);
 end;//l_I < l_C
//#UC END# *4DAEEDE10285_4DBAEEEC00CF_impl*
end;//TkwCompiledCase.DoDoIt

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwCompiledCase
 TkwCompiledCase.RegisterClass;
{$IfEnd} //not NoScripts

end.