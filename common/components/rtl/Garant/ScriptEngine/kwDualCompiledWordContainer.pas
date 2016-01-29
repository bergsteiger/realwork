unit kwDualCompiledWordContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "kwDualCompiledWordContainer.pas"
// �����: 29.04.2011 17:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TkwDualCompiledWordContainer
//
// ��������� ��� �������� ������ ���������������� ���� (begin end)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  kwCompiledWordContainer
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDualCompiledWordContainer = {abstract} class(TkwCompiledWordContainer)
  {* ��������� ��� �������� ������ ���������������� ���� (begin end) }
 protected
 // property methods
   function pm_GetElseBranch: TtfwWord;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 protected
 // protected fields
   f_ElseBranch : TtfwWord;
 public
 // public methods
   constructor Create(aIf: TtfwWord;
     aElse: TtfwWord;
     const aCtx: TtfwContext); reintroduce;
 public
 // public properties
   property ElseBranch: TtfwWord
     read pm_GetElseBranch;
 end;//TkwDualCompiledWordContainer
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3Base,
  SysUtils,
  tfwClassRef
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwDualCompiledWordContainer

constructor TkwDualCompiledWordContainer.Create(aIf: TtfwWord;
  aElse: TtfwWord;
  const aCtx: TtfwContext);
//#UC START# *4DB6F4CB03BE_4DBAC27801EF_var*
//#UC END# *4DB6F4CB03BE_4DBAC27801EF_var*
begin
//#UC START# *4DB6F4CB03BE_4DBAC27801EF_impl*
 inherited Create(aIf, aCtx);
 aElse.SetRefTo(f_ElseBranch);
//#UC END# *4DB6F4CB03BE_4DBAC27801EF_impl*
end;//TkwDualCompiledWordContainer.Create

function TkwDualCompiledWordContainer.pm_GetElseBranch: TtfwWord;
//#UC START# *53DB68CF0124_4DBAC27801EFget_var*
//#UC END# *53DB68CF0124_4DBAC27801EFget_var*
begin
//#UC START# *53DB68CF0124_4DBAC27801EFget_impl*
 Result := f_ElseBranch;
//#UC END# *53DB68CF0124_4DBAC27801EFget_impl*
end;//TkwDualCompiledWordContainer.pm_GetElseBranch

procedure TkwDualCompiledWordContainer.Cleanup;
//#UC START# *479731C50290_4DBAC27801EF_var*
//#UC END# *479731C50290_4DBAC27801EF_var*
begin
//#UC START# *479731C50290_4DBAC27801EF_impl*
 FreeAndNil(f_ElseBranch);
 inherited;
//#UC END# *479731C50290_4DBAC27801EF_impl*
end;//TkwDualCompiledWordContainer.Cleanup

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwDualCompiledWordContainer
 TkwDualCompiledWordContainer.RegisterClass;
{$IfEnd} //not NoScripts

end.