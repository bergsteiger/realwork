unit kwTemporaryCompiledCode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "kwTemporaryCompiledCode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TkwTemporaryCompiledCode
//
// ��������� �������� ����������������� ����, ������� ���� ����� ����������. �� ������� ������
// ������� "������" ������. �������� ��� Caller
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
 TkwTemporaryCompiledCode = class(TkwRuntimeWordWithCode)
  {* ��������� �������� ����������������� ����, ������� ���� ����� ����������. �� ������� ������ ������� "������" ������. �������� ��� Caller }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetAsCaller(const aCtx: TtfwContext): TtfwWord; override;
 end;//TkwTemporaryCompiledCode
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwTemporaryCompiledCode

procedure TkwTemporaryCompiledCode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52DFE4E403E7_var*
//#UC END# *4DAEEDE10285_52DFE4E403E7_var*
begin
//#UC START# *4DAEEDE10285_52DFE4E403E7_impl*
 RunnerError('��������� ��� �� ����� �����������', aCtx);
//#UC END# *4DAEEDE10285_52DFE4E403E7_impl*
end;//TkwTemporaryCompiledCode.DoDoIt

function TkwTemporaryCompiledCode.GetAsCaller(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52DFE48500BB_52DFE4E403E7_var*
//#UC END# *52DFE48500BB_52DFE4E403E7_var*
begin
//#UC START# *52DFE48500BB_52DFE4E403E7_impl*
 CompilerAssert(ParentWord <> nil, '����� �� ����� ��������', aCtx);
 Result := ParentWord;
//#UC END# *52DFE48500BB_52DFE4E403E7_impl*
end;//TkwTemporaryCompiledCode.GetAsCaller

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwTemporaryCompiledCode
 TkwTemporaryCompiledCode.RegisterClass;
{$IfEnd} //not NoScripts

end.