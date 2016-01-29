unit kwPopEditorTextToFile;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorTextToFile = class(TkwEditorFromStackWord)
  {* Сохраняет содержимое редактора в evd-файл. 
Пример:
'C:\MyFile.evd' editor:TextToFile }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorTextToFile
 
implementation

uses
 l3ImplUses
 , evTypes
 , l3Interfaces
 , l3Stream
 , l3Types
 , SysUtils
 , evdMarkEliminator
 , evdDocumentMarksEliminator
 , l3Variant
 , evdDocumentBookmarksEliminator
 , evdDocumentSubsEliminator
 , evDocumentSubsChildrenCountEliminator
 , evdHypelinkDocIDEliminator
 , evdEmptySubsEliminator
 , evdStartAndTimeEliminator
 , evBitmapEliminator4Tests
;

end.
