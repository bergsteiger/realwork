unit kwPopEditorWheelScroll;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorWheelScroll = class(TkwEditorFromStackWord)
  {* *Формат:* aUp aVeritcal anEditorControl pop:editor:WheelScroll
*Описание:* Прокручивает документ к позиции скроллера. aVeritcal - если true, то скроллируем повертикали. aUp - сроллировать вверх, если true
*Пример:*
[code] 
false true focused:control:push anEditorControl pop:editor:WheelScroll
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorWheelScroll
 
implementation

uses
 l3ImplUses
;

end.
