unit kwPopEditorGetParaByID;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetParaByID = class(TkwEditorFromStackWord)
  {* Получает от редактора параграф по его ID.

Пример:
[code]
 12 editor:GetParaByID
 IF
  Para:Text .
 ELSE
 'Параграф не найден' .
 ENDIF
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorGetParaByID
 
implementation

uses
 l3ImplUses
 , nevTools
;

end.
