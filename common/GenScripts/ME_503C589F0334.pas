unit kwPopEditorLP2DP;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorLP2DP = class(TkwEditorFromStackWord)
  {* *Формат:* X Y anEditorControl pop:editor:LP2DP
*Описание:* Переводи значения точки из долей дюйма в пиксели.
*Пример:*
[code] 
100 100  focused:control:push pop:editor:LP2DP
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorLP2DP
 
implementation

uses
 l3ImplUses
 , l3Units
;

end.
