unit LinesDrawOutput.imp;

interface

uses
 l3IntfUses
 , l3FrameLinesSpy
 , evCustomEditorWindow
 , l3InternalInterfaces
;

type
 _LinesDrawOutput_ = class(Il3FrameLinesLogger)
  procedure DoCloseLog(const aLogName: AnsiString);
  procedure SaveDrawing(anEditor: TevCustomEditorWindow;
   aPrinting: Boolean);
  function OpenLinesLog(const aCanvas: Il3InfoCanvas;
   aObjID: Integer): AnsiString;
  procedure CloseLinesLog(const aLogName: AnsiString);
  function GetPrecision: Integer;
 end;//_LinesDrawOutput_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
