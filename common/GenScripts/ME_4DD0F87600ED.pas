unit kwPopEditorHasComment;

interface

uses
 l3IntfUses
 , kwEditorFromStackNextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorHasComment = class(TkwEditorFromStackNextParaWord)
  {* editor:HasComment. Помещает в стек true, если текущий параграф содержит комментарий. }
  procedure DoNextPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
 end;//TkwPopEditorHasComment
 
implementation

uses
 l3ImplUses
;

end.
