unit kwPopEditorCurrentText;

interface

uses
 l3IntfUses
 , kwEditorFromStackTextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorCurrentText = class(TkwEditorFromStackTextParaWord)
  procedure DoPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
 end;//TkwPopEditorCurrentText
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
;

end.
