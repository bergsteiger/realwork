unit kwPopEditorRepaintTableLinesAndCheckWithEtalon;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorRepaintTableLinesAndCheckWithEtalon = class(TkwEditorFromStackWord)
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
  procedure DoCloseLog(const aLogName: AnsiString);
 end;//TkwPopEditorRepaintTableLinesAndCheckWithEtalon
 
implementation

uses
 l3ImplUses
 , StrUtils
 , SysUtils
;

end.
