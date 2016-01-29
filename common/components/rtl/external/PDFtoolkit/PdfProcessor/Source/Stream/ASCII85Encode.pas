{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit ASCII85Encode;

interface

uses
  Classes, gtObject, gtTypes, EncodeIntf, Stream;

//{$IFDEF ASCII85ENCODE}
type
  TgtASCII85Encode = class(TgtEncode)
  private
    { private declarations }
    Fstream: TgtStream;
    FLineBreak: Integer;
    FMaxLine: Integer;
    FCount: Integer;
    FInData: Bytes;
    FOutData: Bytes;

    procedure TransformASCII85;
  public
    { public declarations }
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; override;
    function WriteByte(AStream: TgtStream; ABuffer: Integer): Cardinal;
  end;
//{$ENDIF}

implementation

uses
  StreamExceptions, SysUtils;
{ TgtASCII85Encode }

constructor TgtASCII85Encode.Create(AStream: TgtStream);
begin
  Fstream := AStream;
  FLineBreak := 36 * 2;
  FMaxLine := 36 * 2;
  FCount := 0;
  try
    SetLength(FInData, 4);
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  try
    SetLength(FOutData, 5);
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
end;

//This will transform the next four ascii bytes.

destructor TgtASCII85Encode.Destroy;
begin
  SetLength(FInData, 0);
  SetLength(FOutData, 0);
  inherited;
end;

procedure TgtASCII85Encode.TransformASCII85;
var
  LWord: Integer;
  LX: Integer;
begin
  LWord := (Integer((Integer(FInData[0] shl 8) or (FInData[1] and $FF)) shl 16) or
    Integer((FInData[2] and $FF) shl 8) or (FInData[3] and $FF)) and $FFFFFFFF;

  if LWord = 0 then
  begin
    FOutData[0] := byte('z');
    FOutData[1] := 0;
    Exit;
  end;

  LX := (LWord div (85 * 85 * 85 * 85));

  FOutData[0] := LX + byte('!');
  LWord := LWord - LX * 85 * 85 * 85 * 85;
  LX := LWord div (85 * 85 * 85);

  FOutData[1] := LX + byte('!');
  LWord := LWord - LX * 85 * 85 * 85;
  LX := LWord div (85 * 85);

  FOutData[2] := LX + byte('!');
  LWord := LWord - LX * 85 * 85;
  LX := LWord div 85;

  FOutData[3] := LX + byte('!');
        // LWord-=LX*85L;

  FOutData[4] := (LWord mod 85) + byte('!');
end;

(**
 * This will write a single byte.
 * @return Total number of characters written
 * @exception ExInvalidStream if AStream is NULL
 *)

function TgtASCII85Encode.WriteByte(AStream: TgtStream; ABuffer: Integer): Cardinal;
var
  LI: Integer;
begin
  Result := 0;
  FInData[FCount] := ABuffer;
  Inc(FCount);
  if FCount < 4 then
    Exit;
  TransformASCII85;
  for LI := 0 to 4 do
  begin
    if Foutdata[LI] = 0 then
      break;
    try
      Result := Result + AStream.write(Foutdata[LI]);
    except
      on E: EAccessViolation do
        raise ExInvalidStream.Create(ErrInvalidStream);
    end;
    Dec(FLineBreak);
    if FLineBreak = 0 then
    begin
//      Result := Result + AStream.write(byte($13 + $10));
      FLineBreak := FMaxline;
    end;
  end;
  FCount := 0;
end;

(**
 * This will write a chunk of data to the stream.
 * @return Total number of characters written
 * @exception ExOutofMemory if memory is not sufficient
 *            ExInvalidStream if InStream is NULL
 *)

function TgtASCII85Encode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
var
  LBuffer: Bytes;
  LAmountRead, LI, LToRead: Integer;
begin
  Result := 0;
  try
    SetLength(LBuffer, 1024);
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;
  try
    FStream.SetPosition(0, soBeginning);
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  while True do
  begin
    if Count > 1024 then
    begin
      LToRead := 1024;
      Count := Count - 1024;
    end
    else
      LToRead := Count;
    LAmountRead := FStream.Read(LBuffer, LToRead);
    Count := Count - Cardinal(LAmountRead);
    if LAmountRead = 0 then
      Break;
    for LI := 0 to LAmountRead do
    begin
      if FCount < 3 then
      begin
        FInData[FCount] := LBuffer[LI];
        Inc(FCount);
      end
      else
      begin
        Result := Result + WriteByte(OutStream, LBuffer[LI]);
      end;
    end;
  end;
  SetLength(LBuffer, 0);
end;
end.
