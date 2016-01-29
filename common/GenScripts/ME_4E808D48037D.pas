unit kwQueryCardFromStackWord;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evCustomEditorWindow
;

type
 TkwQueryCardFromStackWord = class(TkwEditorFromStackWord)
  {* Слово работающее с текущим редактором как с карточкой запроса }
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwQueryCardFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
