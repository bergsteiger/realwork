unit kwPopEditorSetTextParaStyle;

interface

uses
 l3IntfUses
 , kwEditorFromStackTextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorSetTextParaStyle = class(TkwEditorFromStackTextParaWord)
  {* StyleID textpara:SetStyleByID }
  procedure DoPara(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow;
   const aPara: InevPara);
 end;//TkwPopEditorSetTextParaStyle
 
implementation

uses
 l3ImplUses
;

end.
