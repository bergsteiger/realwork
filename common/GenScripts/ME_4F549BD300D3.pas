unit kwEditorGetTableFromCursor.imp;

interface

uses
 l3IntfUses
 , nevTools
 , tfwScriptingInterfaces
;

type
 _kwEditorGetTableFromCursor_ = class
  function GetTablePoint(const aCtx: TtfwContext;
   const aCursorPoint: InevBasePoint): InevBasePoint;
 end;//_kwEditorGetTableFromCursor_
 
implementation

uses
 l3ImplUses
 , Table_Const
;

end.
