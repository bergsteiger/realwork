unit l3FrameLinesSpy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
 , l3FrameObject
 , l3InternalInterfaces
;

type
 Il3FrameLinesLogger = interface
  function OpenLinesLog(const aCanvas: Il3InfoCanvas;
   aObjID: Integer): AnsiString;
  procedure CloseLinesLog(const aLogName: AnsiString);
  function GetPrecision: Integer;
 end;//Il3FrameLinesLogger
 
 Tl3FrameLinesSpy = class(Tl3ProtoObject)
  {* Сохранение информации по опечатанным линиям (для отрисовки не работает). }
  function Exists: Boolean;
  procedure LogLines(aLines: Tl3FrameObject;
   const aCanvas: Il3InfoCanvas;
   anIndex: Integer);
  procedure SetLogger(const aLogger: Il3FrameLinesLogger;
   aPrinting: Boolean);
  procedure RemoveLogger(const aLogger: Il3FrameLinesLogger);
 end;//Tl3FrameLinesSpy
 
implementation

uses
 l3ImplUses
 , l3FrameLine
 , l3Types
 , SysUtils
 , l3Interfaces
;

end.
