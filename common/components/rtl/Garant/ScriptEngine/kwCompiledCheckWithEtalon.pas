unit kwCompiledCheckWithEtalon;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledCheckWithEtalon.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
 , nevShapesPaintedSpy
;

type
 _kwCheckWithEtalonCommon_Parent_ = TkwCompiledWordWorker;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwCheckWithEtalonCommon.imp.pas}
 TkwCompiledCheckWithEtalon = class(_kwCheckWithEtalonCommon_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure DoRepaint(aText: TevCustomEditorWindow); override;
 end;//TkwCompiledCheckWithEtalon
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwCheckWithEtalonCommon.imp.pas}

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

initialization
 TkwCompiledCheckWithEtalon.RegisterClass;
 {* Регистрация TkwCompiledCheckWithEtalon }
{$IfEnd} // NOT Defined(NoScripts)

end.
