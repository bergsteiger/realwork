unit kwCompiledWordContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "kwCompiledWordContainer.pas"
// �����: 26.04.2011 19:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TkwCompiledWordContainer
//
// ��������� ��� ����������������� ����.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  kwSourcePointWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwCompiledWordContainer = {abstract} class(TkwSourcePointWord)
  {* ��������� ��� ����������������� ����. }
 private
 // private fields
   f_WordToWork : TtfwWord;
    {* ���� ��� �������� WordToWork}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(aCompiled: TtfwWord;
     const aCtx: TtfwContext); reintroduce;
 public
 // public properties
   property WordToWork: TtfwWord
     read f_WordToWork;
 end;//TkwCompiledWordContainer
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  l3Base
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwCompiledWordContainer

constructor TkwCompiledWordContainer.Create(aCompiled: TtfwWord;
  const aCtx: TtfwContext);
//#UC START# *4DB6E4AB01B1_4DB6E4630256_var*
//#UC END# *4DB6E4AB01B1_4DB6E4630256_var*
begin
//#UC START# *4DB6E4AB01B1_4DB6E4630256_impl*
 inherited Create(aCtx);
 aCompiled.SetRefTo(f_WordToWork);
//#UC END# *4DB6E4AB01B1_4DB6E4630256_impl*
end;//TkwCompiledWordContainer.Create

procedure TkwCompiledWordContainer.Cleanup;
//#UC START# *479731C50290_4DB6E4630256_var*
//#UC END# *479731C50290_4DB6E4630256_var*
begin
//#UC START# *479731C50290_4DB6E4630256_impl*
 FreeAndNil(f_WordToWork);
 inherited;
//#UC END# *479731C50290_4DB6E4630256_impl*
end;//TkwCompiledWordContainer.Cleanup

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwCompiledWordContainer
 TkwCompiledWordContainer.RegisterClass;
{$IfEnd} //not NoScripts

end.