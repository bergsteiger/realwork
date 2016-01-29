unit csIdIOHandlerAbstractAdapterPrim;

interface

uses
 l3IntfUses
 , CsObject
 , Classes
;

type
 TcsIdIOHandlerAbstractAdapterPrim = class(TCsObject)
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
  function WaitForReadData(aTimeout: Integer): Boolean;
  procedure WriteLargeStr(const aString: AnsiString);
  function ReadLargeStr: AnsiString;
 end;//TcsIdIOHandlerAbstractAdapterPrim
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
