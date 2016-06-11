{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{

  Author:
    Ondrej Pokorny, http://www.kluug.net
    All Rights Reserved.

  License:
    MPL 1.1 / GPLv2 / LGPLv2 / FPC modified LGPLv2

}

{
  OBufferedStreams.pas

  TOBufferedReadStream -> read streams with buffer.
    Can be used e.g. for reading data from a file stream.
    Supports seeking within the temp buffer range and also outside the temp buffer.

  TOBufferedWriteStream -> write data to a destination stream with buffer.
    E.g. to a file stream.
}

unit Xml.Internal.OBufferedStreams;

{$IF SizeOf(LongInt) = 8}
  {$DEFINE LONGINT64}
{$ENDIF}

interface

uses
  System.SysUtils, System.Classes;

const
  OBUFFEREDSTREAMS_DEFBUFFERSIZE = 16*1024;//16 KB
  OBUFFEREDSTREAMS_DEFCHARBUFFERSIZE = OBUFFEREDSTREAMS_DEFBUFFERSIZE div SizeOf(Char);//16 KB

type

  TOBufferedWriteStream = class(TStream)
  private
    fStream: TStream;
    fStreamPosition: NativeInt;
    fStreamSize: NativeInt;
    fTempBuffer: TBytes;
    fTempBufferUsedLength: NativeInt;
    fBufferSize: NativeInt;
  protected
    function GetSize: Int64; override;
  public
    constructor Create(const aStream: TStream; const aBufferSize: NativeInt = OBUFFEREDSTREAMS_DEFBUFFERSIZE);
    destructor Destroy; override;
    function Write(const Buffer; Count: LongInt): LongInt; override;
    function Write(const Buffer: TBytes; Offset, Count: LongInt): LongInt; override;
    function Read(var {%H-}Buffer; {%H-}Count: LongInt): LongInt; override;
    function Read(Buffer: TBytes; Offset, Count: LongInt): LongInt; override;
                                                                                          
{$IFDEF LONGINT64}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
{$ELSE !LONGINT64}
    function Seek(Offset: LongInt; Origin: Word): LongInt; override;
{$ENDIF !LONGINT64}
  public
    //write the whole temporary buffer to the destination stream
    procedure EnsureTempBufferWritten;
  end;

  TOBufferedReadStream = class(TStream)
  private
    fStream: TStream;
    fStreamPosition: NativeInt;
    fStreamSize: NativeInt;
    fTempBuffer: TBytes;
    fTempBufferPosition: NativeInt;
    fTempBufferUsedLength: NativeInt;
    fBlockFlushTempBuffer: Integer;
    fBufferSize: NativeInt;

    procedure CheckTempBuffer;
  protected
    function GetSize: Int64; override;
  public
    constructor Create(const aStream: TStream; const aBufferSize: NativeInt = OBUFFEREDSTREAMS_DEFBUFFERSIZE);

    function Write(const {%H-}Buffer; {%H-}Count: LongInt): LongInt; override;
    function Write(const Buffer: TBytes; Offset, Count: LongInt): LongInt; override;
    function Read(var Buffer; Count: LongInt): LongInt; override;
    function Read(Buffer: TBytes; Offset, Count: LongInt): LongInt; override;
                                                                                         
{$IFDEF LONGINT64}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
{$ELSE !LONGINT64}
    function Seek(Offset: LongInt; Origin: Word): LongInt; override;
{$ENDIF !LONGINT64}
  public
    //disallow clearing temporary buffer -> use if you need to seek back within the temp buffer.
    //use if you read from original streams that do not support seeking (e.g. a zip stream).
    procedure BlockFlushTempBuffer;
    procedure UnblockFlushTempBuffer;
  end;

  EOBufferedWriteStream = class(Exception);
  EOBufferedReadStream = class(Exception);

implementation

{$ZEROBASEDSTRINGS OFF}

resourcestring
  OBufferedStreams_NilStream = 'The aStream parameter must be assigned when creating a buffered stream.';
  OBufferedStreams_ReadingNotPossible = 'You can''t read from TOBufferedWriteStream';
  OBufferedStreams_SeekingNotPossible = 'You can''t use seek in TOBufferedWriteStream';
  OBufferedStreams_WritingNotPossible = 'You can''t write to TOBufferedReadStream';

{ TOBufferedWriteStream }

constructor TOBufferedWriteStream.Create(const aStream: TStream;
  const aBufferSize: NativeInt);
begin
  inherited Create;

  if aStream = nil then
    raise EOBufferedWriteStream.Create(OBufferedStreams_NilStream);

  fStream := aStream;
  fStreamPosition := fStream.Position;
  fStreamSize := fStream.Size;

  fBufferSize := aBufferSize;
  SetLength(fTempBuffer, fBufferSize);
end;

destructor TOBufferedWriteStream.Destroy;
begin
  EnsureTempBufferWritten;

  inherited;
end;

procedure TOBufferedWriteStream.EnsureTempBufferWritten;
begin
  if fTempBufferUsedLength > 0 then begin
    fStream.WriteBuffer(fTempBuffer[0], fTempBufferUsedLength);
    fStreamSize := fStreamSize + fTempBufferUsedLength;
    fStreamPosition := fStreamPosition + fTempBufferUsedLength;
    fTempBufferUsedLength := 0;
  end;
end;

function TOBufferedWriteStream.GetSize: Int64;
begin
  Result {%H-}:= fStreamSize + fTempBufferUsedLength;
end;

function TOBufferedWriteStream.Read(var Buffer; Count: LongInt): LongInt;
begin
  raise EOBufferedWriteStream.Create(OBufferedStreams_ReadingNotPossible);
end;

function TOBufferedWriteStream.Read(Buffer: TBytes; Offset,
  Count: LongInt): LongInt;
begin
  Result := Self.Read(Buffer[Offset], Count);
end;

                                                                                          
{$IFDEF LONGINT64}
function TOBufferedWriteStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$ELSE !LONGINT64}
function TOBufferedWriteStream.Seek(Offset: Integer; Origin: Word): LongInt;
{$ENDIF !LONGINT64}
begin
{$IFDEF LONGINT64}
  if (Origin = soCurrent) and (Offset = 0) then
{$ELSE}
  if (Origin = soFromCurrent) and (Offset = 0) then
{$ENDIF}
  begin
    Result := fStreamPosition + fTempBufferUsedLength;
  end
  else
  begin
    raise EOBufferedWriteStream.Create(OBufferedStreams_SeekingNotPossible);
  end;
end;

function TOBufferedWriteStream.Write(const Buffer; Count: LongInt): LongInt;
begin
  Result := Count;
  if fTempBufferUsedLength+Result > fBufferSize then
    EnsureTempBufferWritten;//WRITE TEMP BUFFER

  if Result > fBufferSize then begin
    //count to write bigger then buffer -> write directly
    fStream.WriteBuffer(Buffer, Result);
  end else if Result > 0 then begin
    //store to temp!
    if Result > fBufferSize-fTempBufferUsedLength then//store only what has space in buffer
      Result := fBufferSize-fTempBufferUsedLength;

    Move(Buffer, fTempBuffer[fTempBufferUsedLength], Result);
    fTempBufferUsedLength := fTempBufferUsedLength + Result;
  end;
  //older delphi versions need to return Result = Count !!!
  if (0 < Result) and (Result < Count) then begin
    Result := Write({%H-}Pointer({%H-}NativeInt(@Buffer)+NativeInt(Result))^, Count-Result) + Result;
  end;
end;

function TOBufferedWriteStream.Write(const Buffer: TBytes; Offset,
  Count: LongInt): LongInt;
begin
  Result := Self.Write(Buffer[Offset], Count);
end;

{ TOBufferedReadStream }

procedure TOBufferedReadStream.BlockFlushTempBuffer;
begin
  Inc(fBlockFlushTempBuffer);
end;

procedure TOBufferedReadStream.CheckTempBuffer;
var
  xReadBytes, xRemainingTempLength, xNewLength: NativeInt;
begin
  if fTempBufferPosition = fTempBufferUsedLength then begin
    //we reached end of the tempbuffer, clear or grow and read from stream
    if fBlockFlushTempBuffer = 0 then begin
      fTempBufferPosition := 0;
      fTempBufferUsedLength := 0;
    end;

    xReadBytes := fBufferSize;
    if xReadBytes > fStreamSize-fStreamPosition then//don't read from stream more than possible
      xReadBytes := fStreamSize-fStreamPosition;

    //CHECK THAT WE HAVE ALL NECESSARY BYTES IN TEMP BUFFER
    xRemainingTempLength := Length(fTempBuffer)-fTempBufferPosition;
    if xRemainingTempLength < xReadBytes then begin
      //tempbuffer has to grow
      xNewLength := Length(fTempBuffer) + xReadBytes - xRemainingTempLength;
      SetLength(fTempBuffer, xNewLength);
    end;

    fStream.ReadBuffer(fTempBuffer[fTempBufferPosition], xReadBytes);
    fStreamPosition := fStreamPosition + xReadBytes;
    fTempBufferUsedLength := fTempBufferUsedLength + xReadBytes;
  end;
end;

constructor TOBufferedReadStream.Create(const aStream: TStream;
  const aBufferSize: NativeInt);
begin
  inherited Create;

  if aStream = nil then
    raise EOBufferedReadStream.Create(OBufferedStreams_NilStream);

  fStream := aStream;
  fStreamPosition := fStream.Position;
  fStreamSize := fStream.Size;

  fBufferSize := aBufferSize;

  SetLength(fTempBuffer, fBufferSize);
end;

function TOBufferedReadStream.GetSize: Int64;
begin
  Result := fStreamSize;
end;

function TOBufferedReadStream.Read(Buffer: TBytes; Offset,
  Count: LongInt): LongInt;
begin
  Result := Self.Read(Buffer[Offset], Count);
end;

function TOBufferedReadStream.Read(var Buffer; Count: LongInt): LongInt;
begin
  if Count < 0 then begin
    Result := 0;
    Exit;
  end;

  CheckTempBuffer;

  Result := fTempBufferUsedLength - fTempBufferPosition;
  if Result > Count then
    Result := Count;

  if Result > 0 then begin
    Move(fTempBuffer[fTempBufferPosition], Buffer, Result);
    fTempBufferPosition := fTempBufferPosition + Result;
  end;

  //older delphi versions need to return Result = Count !!!
  if (0 < Result) and (Result < Count) then begin
    Result := Read({%H-}Pointer({%H-}NativeInt(@Buffer)+NativeInt(Result))^, Count-Result) + Result;
  end;
end;

                                                                                         
{$IFDEF LONGINT64}
function TOBufferedReadStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
var
  xAbsolutePosition: Int64;
{$ELSE !LONGINT64}
function TOBufferedReadStream.Seek(Offset: Integer; Origin: Word): LongInt;
var
  xAbsolutePosition: NativeInt;
{$ENDIF !LONGINT64}
begin
{$IFDEF LONGINT64}
  if (Origin = soCurrent) and (Offset = 0) then begin
{$ELSE}
  if (Origin = soFromCurrent) and (Offset = 0) then begin
{$ENDIF}
    //CURRENT POSITION
    Result := fStreamPosition - fTempBufferUsedLength + fTempBufferPosition;
  end else begin
    //SEEK TO POSITION AND CLEAR TEMP STREAM

{$IFDEF LONGINT64}
    case Origin of
      soCurrent: xAbsolutePosition := fStreamPosition - fTempBufferUsedLength + fTempBufferPosition + Offset;
      soEnd: xAbsolutePosition := fStreamSize + Offset;
    else
      //soBeginning
      xAbsolutePosition := Offset;
    end;
{$ELSE}
    case Origin of
      soFromCurrent: xAbsolutePosition := fStreamPosition - fTempBufferUsedLength + fTempBufferPosition + Offset;
      soFromEnd: xAbsolutePosition := fStreamSize + Offset;
    else
      //soFromBeginning
      xAbsolutePosition := Offset;
    end;
{$ENDIF}

    if (xAbsolutePosition >= (fStreamPosition - fTempBufferUsedLength))
    then begin
      //WITHIN TEMP RANGE
      fTempBufferPosition := xAbsolutePosition - (fStreamPosition - fTempBufferUsedLength);
      Result := fStreamPosition - fTempBufferUsedLength + fTempBufferPosition;
    end else begin
      //OUTSIDE TEMP RANGE, CLEAR TEMP STREAM
{$IFDEF LONGINT64}
      Result := fStream.Seek(xAbsolutePosition, soBeginning);
{$ELSE !LONGINT64}
                                                                                                                                   
      Result := fStream.Seek(soFromBeginning, xAbsolutePosition);
{$ENDIF !LONGINT64}
      fStreamPosition := Result;
      fTempBufferUsedLength := 0;
      fTempBufferPosition := 0;
    end;
  end;
end;

procedure TOBufferedReadStream.UnblockFlushTempBuffer;
begin
  if fBlockFlushTempBuffer > 0 then
    Dec(fBlockFlushTempBuffer);
end;

function TOBufferedReadStream.Write(const Buffer: TBytes; Offset,
  Count: LongInt): LongInt;
begin
  Result := Self.Write(Buffer[Offset], Count);
end;

function TOBufferedReadStream.Write(const Buffer; Count: LongInt): LongInt;
begin
  raise EOBufferedReadStream.Create(OBufferedStreams_WritingNotPossible);
end;

end.
