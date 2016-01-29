unit nevVScrollerSpy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
;

type
 InevVScrollerPosLogger = interface
  function OpenLog: AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
 end;//InevVScrollerPosLogger
 
 TnevVScrollerSpy = class(Tl3ProtoObject)
  procedure SetLogger(const aLogger: InevVScrollerPosLogger);
  procedure RemoveLogger(const aLogger: InevVScrollerPosLogger);
  procedure LogPos(aPos: Integer);
  function StartLog: Boolean;
  procedure FinishLog;
  function Exists: Boolean;
 end;//TnevVScrollerSpy
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
;

end.
