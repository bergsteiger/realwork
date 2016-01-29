unit csIdIOHandlerAdapter;

interface

uses
 l3IntfUses
 , csIdIOHandlerAbstractAdapter
 , IdIOHandler
 , Classes
;

type
 TcsIdIOHandlerAdapter = class(TcsIdIOHandlerAbstractAdapter)
  procedure Create(aIOHandler: TIdIOHandler);
  procedure WriteBufferFlush;
  function ReadChar: AnsiChar;
  function ReadCardinal: Cardinal;
  function ReadDateTime: TDateTime;
  function ReadLn: AnsiString;
  function ReadInt64: Int64;
  procedure ReadStream(aStream: TStream;
   aSize: Int64);
  function ReadInteger: Integer;
  function ReadSmallInt: SmallInt;
  procedure WriteLn(const aString: AnsiString);
  procedure WriteCardinal(aValue: Cardinal);
  procedure WriteInt64(aValue: Int64);
  procedure WriteStream(aStream: TStream;
   aByteCount: Int64);
  procedure WriteChar(aValue: AnsiChar);
  procedure WriteSmallInt(aValue: SmallInt);
  procedure WriteInteger(aValue: Integer);
  procedure WriteDateTime(aValue: TDateTime);
  function Connected: Boolean;
  procedure WriteFile(const aFile: AnsiString);
  procedure WriteBufferOpen(AThreshhold: Integer);
  procedure WriteBufferClose;
  procedure WriteBufferClear;
  function WaitForReadData(aTimeout: Integer): Boolean;
  procedure InputBufferClear;
  procedure WriteLargeStr(const aString: AnsiString);
  function ReadLargeStr: AnsiString;
 end;//TcsIdIOHandlerAdapter
 
implementation

uses
 l3ImplUses
 , IdGlobal
 , l3Base
 , l3Memory
 , SysUtils
;

end.
