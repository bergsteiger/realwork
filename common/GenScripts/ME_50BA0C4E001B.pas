unit kwEditorFromStackNextParaWord;

interface

uses
 l3IntfUses
 , kwEditorFromStackTextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwEditorFromStackNextParaWord = class(TkwEditorFromStackTextParaWord)
  procedure DoNextPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
  procedure DoPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
 end;//TkwEditorFromStackNextParaWord
 
implementation

uses
 l3ImplUses
;

end.
