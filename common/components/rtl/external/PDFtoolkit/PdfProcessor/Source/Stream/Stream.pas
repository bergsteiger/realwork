{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit Stream;

interface

uses
  Classes, gtObject, gtTypes;

type
  TgtStream = class;

  TgtStreamType =
    (
    stFile,
    stASCIIHex,
    stASCII85,
    stLZW,
    stRunLength,
    stCCITTFax,
    stDCT,
    stFlate,
    stJBIG2,
    stJPX,
    stCrypt,
    stWeird // internal-use stream types
    );

  TgtStream = class(TgtObject)
  protected
    FRef: Integer;
  public
    function Write(const Buffer: Bytes; Count: Cardinal): Cardinal;
      overload; virtual; abstract;

    function LookChar: Integer; virtual; abstract;
    function GetChar: Integer; virtual; abstract;
    function GetPosition: Int64; virtual; abstract;
    function GetBaseStream: TgtStream; virtual; abstract;
    function GetUndecodedStream: TgtStream; virtual; abstract;
    function GetSize: Cardinal; virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure SetPosition(APosition: LongInt; ADirection: TSeekOrigin);
      virtual; abstract;

    function Read(var Buffer: AnsiString; Count: Cardinal): Cardinal; overload; virtual;
    function Read(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; virtual;
    function Read(var Buffer: Bytes; Count: Cardinal): Cardinal; overload; virtual;

    function Write(const Buffer: AnsiString): Cardinal; overload; virtual;
    function Write(AByte: Byte): Cardinal; overload; virtual;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; virtual;

    function CopyFrom(Stream: TgtStream; Count: Cardinal): Cardinal;

    function GetTStream: TStream; virtual;

    procedure Close; virtual;
    procedure ReadLine(var Buffer: Bytes; Count: Longint); virtual;
    function ReadRawChar: Integer; virtual;

    function GetType: TgtStreamType; virtual; abstract;

    function IncRef: Integer;
    function DecRef: Integer;
  end;

implementation

uses
  StreamConsts, StreamExceptions, SysUtils
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};


{ TgtStream }

procedure TgtStream.Close;
begin

end;

function TgtStream.CopyFrom(Stream: TgtStream; Count: Cardinal): Cardinal;
var
  LBuffer: Bytes;
  LChar, LI: Integer;
begin
  if Count = 0 then
    Count := Stream.GetTStream.Size;
  try
    SetLength(LBuffer, Integer(Count));
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  LChar := Stream.GetChar;
  LI := 0;
  while (LChar <> ENDOFFILE) do
  begin
    LBuffer[LI] := Byte(LChar);
    LChar := Stream.GetChar;
    Inc(LI);
    if LI = Count then
    begin
      //Increase the memory if passed count is not sufficient
      Count := Count + 100;
      try
        SetLength(LBuffer, Integer(Count));
      except
      // Catch Out of Memory Exception
        on E: EOutOfResources do
          raise ExOutofMemory.Create(ErrOutofMemory);
      end;
    end;
  end;
  Result := Write(LBuffer, LI);
  SetLength(LBuffer, 0);
end;

function TgtStream.DecRef: Integer;
begin
  Dec(FRef);
  Result := FRef;
end;

function TgtStream.GetTStream: TStream;
begin
  Result := nil;
end;

function TgtStream.IncRef: Integer;
begin
  Inc(FRef);
  Result := FRef;
end;

function TgtStream.Read(var Buffer: AnsiString; Count: Cardinal): Cardinal;
var
  LByteArray: Bytes;
  LI: Integer;
begin
  try
    SetLength(LByteArray, Integer(Count));
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  Result := Read(LByteArray, Count);
  try
    for LI := 0 to Length(LByteArray) - 1 do
      Buffer[LI + 1] := AnsiChar(LByteArray[LI]);
  except
  // Buffer is not assigned
    on E: EAccessViolation do
      raise ExInvalidBuffer.Create(ErrInvalidBuffer);
  end;
  SetLength(LByteArray, 0);
end;

function TgtStream.Read(OutStream: TgtStream; Count: Cardinal): Cardinal;
var
  LS: Bytes;
  I: Integer;
begin
  try
    SetLength(LS, Integer(Count));
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  I := Read(LS, Count);
  OutStream.Write(LS, I);
  SetLength(LS, 0);
  Result := I;
end;

function TgtStream.Read(var Buffer: Bytes; Count: Cardinal): Cardinal;
var
  I: Integer;
  LChar: Integer;
begin
  I := 0;
  if not (Count = 0) then
    for I := 0 to Count - 1 do
    begin
      LChar := GetChar;
      if LChar = ENDOFFILE then
        Break;
      try
        Buffer[I] := Byte(LChar);
      except
      // Buffer is not assigned
        on E: EAccessViolation do
          raise ExInvalidBuffer.Create(ErrInvalidBuffer);
      end;
    end;
  Result := I;
end;

procedure TgtStream.ReadLine(var Buffer: Bytes; Count: Integer);
var
  LIndex: Integer;
  LChar: Integer;
begin
  if LookChar = ENDOFFILE then
    Exit;
  for LIndex := 1 to Count do
  begin
    LChar := GetChar;
    if (LChar = LINEFEED) or (LChar = ENDOFFILE) then
      Exit;
    if LChar = CARRIAGERETURN then
      if LookChar = LINEFEED then
        Exit;
    try
      Buffer[LIndex] := LChar;
    except
    // Buffer is not assigned
      on E: EAccessViolation do
        raise ExInvalidBuffer.Create(ErrInvalidBuffer);
    end;
  end;
end;

function TgtStream.ReadRawChar: Integer;
begin
  Result := ENDOFFILE;
{$IFDEF DEBUG}
  Logger.LogError(ErrStrReadRawChar);
{$ENDIF}
end;

function TgtStream.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
{$IFDEF DEBUG}
  Logger.LogError(ErrStrWrite);
{$ENDIF}
  Result := 0;
end;

function TgtStream.Write(AByte: Byte): Cardinal;
begin
{$IFDEF DEBUG}
  Logger.LogError(ErrStrWrite);
{$ENDIF}
  Result := 0;
  //Internal Error must have been define in child
end;

function TgtStream.Write(const Buffer: AnsiString): Cardinal;
var
  LByteArray: Bytes;
  LI: Integer;
begin
  try
    SetLength(LByteArray, Length(Buffer));
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  try
    for LI := 0 to Length(Buffer) - 1 do
      LByteArray[LI] := Ord(Buffer[LI + 1]);
  except
    // Buffer is not assigned
    on E: EAccessViolation do
      raise ExInvalidBuffer.Create(ErrInvalidBuffer);
  end;
  Result := Write(LByteArray, Length(LByteArray));
end;

end.
