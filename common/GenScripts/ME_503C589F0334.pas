unit kwPopEditorLP2DP;
 {* *Формат:* X Y anEditorControl pop:editor:LP2DP
*Описание:* Переводи значения точки из долей дюйма в пиксели.
*Пример:*
[code] 
100 100  focused:control:push pop:editor:LP2DP
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorLP2DP.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorLP2DP = {final} class(TkwEditorFromStackWord)
  {* *Формат:* X Y anEditorControl pop:editor:LP2DP
*Описание:* Переводи значения точки из долей дюйма в пиксели.
*Пример:*
[code] 
100 100  focused:control:push pop:editor:LP2DP
[code] }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorLP2DP
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Units
;

procedure TkwPopEditorLP2DP.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_503C589F0334_var*
var
 l_X, l_Y : Integer;
 l_SPoint : Tl3SPoint;
//#UC END# *4F4CB81200CA_503C589F0334_var*
begin
//#UC START# *4F4CB81200CA_503C589F0334_impl*
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
 l_SPoint := anEditor.Canvas.LP2DP(l3Point(l_X, l_Y));
 aCtx.rEngine.PushInt(l_SPoint.Y);
 aCtx.rEngine.PushInt(l_SPoint.X);
//#UC END# *4F4CB81200CA_503C589F0334_impl*
end;//TkwPopEditorLP2DP.DoWithEditor

class function TkwPopEditorLP2DP.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:LP2DP';
end;//TkwPopEditorLP2DP.GetWordNameForRegister

initialization
 TkwPopEditorLP2DP.RegisterInEngine;
 {* Регистрация pop_editor_LP2DP }
{$IfEnd} // NOT Defined(NoScripts)

end.
