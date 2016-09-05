unit kwPopEditorDP2LP;
 {* *Формат:* X Y anEditorControl pop:editor:DP2LP
*Описание:* Переводи значения точки из долей дюйма в пиксели.
*Пример:*
[code] 
100 100  focused:control:push pop:editor:DP2LP
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDP2LP.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_DP2LP" MUID: (503C650202E5)
// Имя типа: "TkwPopEditorDP2LP"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorDP2LP = {final} class(TkwEditorFromStackWord)
  {* *Формат:* X Y anEditorControl pop:editor:DP2LP
*Описание:* Переводи значения точки из долей дюйма в пиксели.
*Пример:*
[code] 
100 100  focused:control:push pop:editor:DP2LP
[code] }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorDP2LP
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Units
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *503C650202E5impl_uses*
 //#UC END# *503C650202E5impl_uses*
;

procedure TkwPopEditorDP2LP.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_503C650202E5_var*
var
 l_X, l_Y : Integer;
 l_SPoint : Tl3SPoint;
 l_Point  : Tl3Point;
//#UC END# *4F4CB81200CA_503C650202E5_var*
begin
//#UC START# *4F4CB81200CA_503C650202E5_impl*
 l_X := 0;
 l_Y := 0;
 if aCtx.rEngine.IsTopInt then
  l_Y := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задана координата Y.');
 if aCtx.rEngine.IsTopInt then
  l_X := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задана координата X.');
 l_SPoint.Init(l_X, l_Y);
 l_Point := anEditor.Canvas.DP2LP(l_SPoint);
 aCtx.rEngine.PushInt(l_Point.Y);
 aCtx.rEngine.PushInt(l_Point.X);
//#UC END# *4F4CB81200CA_503C650202E5_impl*
end;//TkwPopEditorDP2LP.DoWithEditor

class function TkwPopEditorDP2LP.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:DP2LP';
end;//TkwPopEditorDP2LP.GetWordNameForRegister

initialization
 TkwPopEditorDP2LP.RegisterInEngine;
 {* Регистрация pop_editor_DP2LP }
{$IfEnd} // NOT Defined(NoScripts)

end.
