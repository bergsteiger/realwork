unit kwPopEditorGetSelectionTextInFormat;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetSelectionTextInFormat = class(TkwEditorFromStackWord)
  {* �������� ����� ��������� � ��������� ������� }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorGetSelectionTextInFormat
 
implementation

uses
 l3ImplUses
 , l3Utils
 , nevBase
 , evParaTools
 , evdBlockNameAdder
 , evdDocumentMarksEliminator
 , evdMarkEliminator
 , ddPicturePathListner
 , evTypes
;

end.
