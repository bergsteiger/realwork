unit evDelayedPaintersSpy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
 , evSelectedParts
 , l3LongintList
;

type
 IevDelayedPainterLogger = interface
  function OpenSelectionLog: AnsiString;
  procedure CloseSelectionLog(const aLogName: AnsiString);
 end;//IevDelayedPainterLogger
 
 TevDelayedPaintersSpy = class(Tl3ProtoObject)
  procedure SetLogger(const aLogger: IevDelayedPainterLogger);
  procedure RemoveLogger(const aLogger: IevDelayedPainterLogger);
  function Exists: Boolean;
  procedure LogSelections(const aSelParts: TevSelectedParts;
   const aRowHeights: Tl3LongintList);
 end;//TevDelayedPaintersSpy
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
;

end.
