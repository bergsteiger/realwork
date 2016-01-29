unit CsDataPipePrim;

interface

uses
 l3IntfUses
 , csIdIOHandlerAbstractAdapterPrim
 , CsCommon
 , csIdIOHandlerAbstractAdapter
 , IdIOHandler
 , Classes
;

type
 TCsDataPipePrim = class(TcsIdIOHandlerAbstractAdapterPrim)
  procedure Create(aIOHandler: TcsIdIOHandlerAbstractAdapter); overload;
  procedure Create(aIOHandler: TIdIOHandler); overload;
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
 end;//TCsDataPipePrim
 
implementation

uses
 l3ImplUses
 , csIdIOHandlerAdapter
 , SysUtils
 , StrUtils
;

end.
