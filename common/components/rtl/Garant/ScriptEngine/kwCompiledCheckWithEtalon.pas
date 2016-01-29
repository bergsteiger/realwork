unit kwCompiledCheckWithEtalon;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwCompiledCheckWithEtalon.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::TkwCompiledCheckWithEtalon
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwCompiledWordWorker,
  evCustomEditorWindow,
  tfwScriptingInterfaces,
  nevTools,
  nevShapesPaintedSpy
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _kwCheckWithEtalonCommon_Parent_ = TkwCompiledWordWorker;
 {$Include ..\ScriptEngine\kwCheckWithEtalonCommon.imp.pas}
 TkwCompiledCheckWithEtalon = class(_kwCheckWithEtalonCommon_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   procedure DoRepaint(aText: TevCustomEditorWindow); override;
 end;//TkwCompiledCheckWithEtalon
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  StrUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\ScriptEngine\kwCheckWithEtalonCommon.imp.pas}

// start class TkwCompiledCheckWithEtalon

procedure TkwCompiledCheckWithEtalon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50F3D22D007B_var*
var
 l_Editor: TevCustomEditorWindow;
//#UC END# *4DAEEDE10285_50F3D22D007B_var*
begin
//#UC START# *4DAEEDE10285_50F3D22D007B_impl*
 if aCtx.rEngine.IsTopObj then
 begin
  l_Editor := aCtx.rEngine.PopObj as TevCustomEditorWindow;
  l_Editor.View.ClearShapes;
  try
   WordToWork.DoIt(aCtx);
  finally
   ExecuteWithEditor(aCtx, l_Editor);
  end;//try..finally
 end; // if aCtx.rEngine.IsTopObj then
//#UC END# *4DAEEDE10285_50F3D22D007B_impl*
end;//TkwCompiledCheckWithEtalon.DoDoIt

procedure TkwCompiledCheckWithEtalon.DoRepaint(aText: TevCustomEditorWindow);
//#UC START# *4EB100CE0160_50F3D22D007B_var*
//#UC END# *4EB100CE0160_50F3D22D007B_var*
begin
//#UC START# *4EB100CE0160_50F3D22D007B_impl*
//#UC END# *4EB100CE0160_50F3D22D007B_impl*
end;//TkwCompiledCheckWithEtalon.DoRepaint

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwCompiledCheckWithEtalon
 TkwCompiledCheckWithEtalon.RegisterClass;
{$IfEnd} //not NoScripts

end.