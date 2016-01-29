unit kwPopEditorDeleteUserComment;

interface

uses
 l3IntfUses
 , kwEditorFromStackNextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorDeleteUserComment = class(TkwEditorFromStackNextParaWord)
  procedure DoNextPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
 end;//TkwPopEditorDeleteUserComment
 
implementation

uses
 l3ImplUses
 , CommentPara_Const
;

end.
