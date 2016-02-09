unit kwPopEditorBlockResizeEX;
 {* *Формат:
aDelta aTop aLevel anEditor  pop:editor:BlockResizeEX
* aDelta - смещение блока
* aTop - true чтобы двигать верхнюю границу
* aLevel - уровень изменяемого блока.
* anEditor - редактор, в котором изменяется блок. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResizeEX.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwBlockResize
 , tfwScriptingInterfaces
 , nevTools
;

type
 TkwPopEditorBlockResizeEX = {final} class(TkwBlockResize)
  {* *Формат:
aDelta aTop aLevel anEditor  pop:editor:BlockResizeEX
* aDelta - смещение блока
* aTop - true чтобы двигать верхнюю границу
* aLevel - уровень изменяемого блока.
* anEditor - редактор, в котором изменяется блок. }
  protected
   procedure CorrectBlockPoint(const aCtx: TtfwContext;
    var aMap: InevMap;
    var aCursor: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorBlockResizeEX
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 , CommentPara_Const
 , TextPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorBlockResizeEX.CorrectBlockPoint(const aCtx: TtfwContext;
 var aMap: InevMap;
 var aCursor: InevBasePoint);
//#UC START# *514BFC55039E_514BFA8902C0_var*
var
 i      : Integer;
 l_Count: Integer;
//#UC END# *514BFC55039E_514BFA8902C0_var*
begin
//#UC START# *514BFC55039E_514BFA8902C0_impl*
 if aCtx.rEngine.IsTopInt then
 begin
  l_Count := aCtx.rEngine.PopInt;
  for i := 0 to l_Count do
  begin
   aMap := aMap.Outer as InevMap;
   aCursor := aCursor.ParentPoint;
  end; // for i := 0 to l_Count do
 end // if aCtx.rEngine.IsTopInt then
 else
  Assert(False, 'Не задан уровень блока!');
//#UC END# *514BFC55039E_514BFA8902C0_impl*
end;//TkwPopEditorBlockResizeEX.CorrectBlockPoint

class function TkwPopEditorBlockResizeEX.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:BlockResizeEX';
end;//TkwPopEditorBlockResizeEX.GetWordNameForRegister

initialization
 TkwPopEditorBlockResizeEX.RegisterInEngine;
 {* Регистрация pop_editor_BlockResizeEX }
{$IfEnd} // NOT Defined(NoScripts)

end.
