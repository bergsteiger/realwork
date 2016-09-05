unit kwPopEditorWheelScroll;
 {* *Формат:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*Описание:* Прокручивает документ к позиции скроллера. aVeritcal - если true, то скроллируем повертикали. aUp - сроллировать вверх, если true
*Пример:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorWheelScroll.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_WheelScroll" MUID: (4F4F5A730085)
// Имя типа: "TkwPopEditorWheelScroll"

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
 TkwPopEditorWheelScroll = {final} class(TkwEditorFromStackWord)
  {* *Формат:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*Описание:* Прокручивает документ к позиции скроллера. aVeritcal - если true, то скроллируем повертикали. aUp - сроллировать вверх, если true
*Пример:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorWheelScroll
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4F4F5A730085impl_uses*
 //#UC END# *4F4F5A730085impl_uses*
;

procedure TkwPopEditorWheelScroll.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F4F5A730085_var*
var
 l_Up       : Boolean;
 l_Vertical : Boolean;
//#UC END# *4F4CB81200CA_4F4F5A730085_var*
begin
//#UC START# *4F4CB81200CA_4F4F5A730085_impl*
 if aCtx.rEngine.IsTopBool then
  l_Vertical := aCtx.rEngine.PopBool
 else
  Assert(False, 'Не задана ориентация прокрукти!');
 if aCtx.rEngine.IsTopBool then
  l_Up := aCtx.rEngine.PopBool
 else
  Assert(False, 'Не задано направление прокрукти!');
 with anEditor.View.Scroller[l_Vertical] do
  if l_Up then
   WheelUp
  else
   WheelDown;
//#UC END# *4F4CB81200CA_4F4F5A730085_impl*
end;//TkwPopEditorWheelScroll.DoWithEditor

class function TkwPopEditorWheelScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:WheelScroll';
end;//TkwPopEditorWheelScroll.GetWordNameForRegister

initialization
 TkwPopEditorWheelScroll.RegisterInEngine;
 {* Регистрация pop_editor_WheelScroll }
{$IfEnd} // NOT Defined(NoScripts)

end.
