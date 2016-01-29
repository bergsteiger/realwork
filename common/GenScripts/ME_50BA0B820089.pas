unit kwEditorFromStackTextParaWord;

interface

uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwEditorFromStackTextParaWord = class(TkwEditorFromStackCursorWord)
  procedure DoPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
  procedure DoCursor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPoint: InevBasePoint);
 end;//TkwEditorFromStackTextParaWord
 
implementation

uses
 l3ImplUses
 , LeafPara_Const
;

end.
