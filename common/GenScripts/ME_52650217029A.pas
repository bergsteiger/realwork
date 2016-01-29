unit kwInsertFromStreamCommon;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwInsertFromStreamCommon = class(TkwEditorFromStackWord)
  function GetFormat(const aCtx: TtfwContext): Integer;
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwInsertFromStreamCommon
 
implementation

uses
 l3ImplUses
 , evTypes
 , ActiveX
 , l3Base
 , l3Filer
 , nevInternalInterfaces
 , l3Types
;

end.
