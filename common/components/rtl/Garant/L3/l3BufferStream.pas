unit l3BufferStream;

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Бабанин Вова }
{ Модуль: l3BufferStream - Поппытка допилить напильником l3Stream.Tl3BufferStream}
{ Начат: 01.01.1999 18:24             }
{ $Id: l3BufferStream.pas,v 1.1 2016/06/09 08:48:57 voba Exp $ }

// $Log: l3BufferStream.pas,v $
// Revision 1.1  2016/06/09 08:48:57  voba
// -k:623267081
//

{$Include l3Define.inc }

interface

uses
  Windows,
  Classes,

  l3Types,
  l3IID,
  l3InternalInterfaces,
  l3Memory,
  l3BaseStream
  ;

const
 {$IfDef Nemesis}
 Cl3FileStreamDefaultTimeOut = 3000;
 {$Else  Nemesis}
 Cl3FileStreamDefaultTimeOut = 300000;
 {$EndIf Nemesis}

{$IfDef XE}
 {.$Define l3NoBufferStream}
{$EndIf XE}

type
{$IfNDef l3NoBufferStream}
  Tl3BufferState = (bsUnknown, bsRead, bsWrite);
   {* Состояние буфера. }
  Tl3NewBufferStream = class(Tl3Stream, Il3Flush)
   {* Буферизованный поток. }
    private
      fStream  : TStream;
      fBuffer : Tl3MemoryPoolPrim;
      fBufPos  : Cardinal; // позиция в файле с которой считали буфер
      fNeedSeekPos : int64; // "отложенный" seek (оптимизирует несколько сииков подряд без чтения/записи)
      fBufLen  : Cardinal; // длина считанного буфера
      fBufOffs : Cardinal; // текущее смещение относительно начала буфера
      fState   : Tl3BufferState;
        {-}
    protected
      function FillBuffer(aFromPosition : int64 = -1): Boolean;
      function FlushBuffer : boolean;
        {* - сбросить буфер. }

      procedure CheckNeedSeek;

      procedure PutBack(Ch: AnsiChar);
        {* - вернуть символ в поток. }
      procedure SetSize(const NewSize: Int64);
        override;
        {-}
      function GetSize : Int64;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
      property State: Tl3BufferState
        read fState;
        {* - состояние буфера. }
    public
      constructor Create(aStream : TStream);
        reintroduce;
        {* - создает буферизованный поток для другого потока. }
      function Read(var aBuffer; aCount: LongInt): LongInt;
        override;
        {-}
      function Write(const aBuffer; aCount: LongInt): LongInt;
        override;
        {-}
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
        override;
        {-}
      function Flush : boolean;

      function IsEof: Boolean;
        {* - достигнут конец потока? }
      property InnerStream : TStream read fStream;

  end;//Tl3NewBufferStream

{$ELSE}
  (*   // это для отладки проблем, фактически выключенный буфер
  Tl3NewBufferStream = class(Tl3Stream, Il3Flush)
   {* Буферизованный поток. }
    private
      fStream  : TStream;
    protected
      function FlushBuffer: Boolean;
        {* - сбросить буфер. }
      function Il3Flush.Flush = FlushBuffer;
        {-}
      procedure PutBack(Ch: AnsiChar);
        {* - вернуть символ в поток. }
      procedure SetSize(const NewSize: Int64);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
      constructor Create(aStream : TStream);
        reintroduce;
        {* - создает буферизованный поток для другого потока. }
      function Read(var Buffer; Count: LongInt): LongInt;
        override;
        {-}
      function Write(const Buffer; Count: LongInt): LongInt;
        override;
        {-}
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
        override;
        {-}
      function IsEof: Boolean;
  end;//Tl3NewBufferStream
    *)
{$EndIf l3NoBufferStream}

implementation

uses
  SysConst,
  {$IfDef Delphi6}
  RTLConsts,
  {$Else  Delphi6}
  Consts,
  {$EndIf Delphi6}
  SysUtils,
  ActiveX,
  ComObj,

  l3Const,
  l3Chars,
  l3MinMax,
  l3String,
  l3Base,
  l3InterfacesMisc,
  l3Filer,
  l3SysUtils,

  m2InternalInterfaces,
  m2COMLib
  ;

const
 cNotNeedSeekPos = Low(Int64);
type
 TInt64Rec = packed record
  Lo : DWord;
  Hi : DWord;
 end;

{$IfNDef l3NoBufferStream}

{ Create and initialize a buffer stream. }
constructor Tl3NewBufferStream.Create(aStream : TStream);
begin
  inherited Create;
  l3Set(fStream, aStream);
  { Allocate the buffer. }
  fBuffer := Tl3BufferStreamMemoryPool.Create;
  //fBuffer.Size := 256;
  //fBufEnd := fBuffer.AsPointer + fBuffer.Size;
  fState := bsUnknown;
  fNeedSeekPos := cNotNeedSeekPos;
end;

{ Destroy the buffer stream. If the buffer is in write mode, then
  make sure the last bufferful is written to the stream. }
procedure Tl3NewBufferStream.Cleanup;
begin
 if (State = bsWrite) then
  FlushBuffer;
 FreeAndNil(fBuffer);
 inherited;
 FreeAndNil(fStream);
end;

{ Fill the input buffer. }
function Tl3NewBufferStream.FillBuffer(aFromPosition : int64 = -1): Boolean;
var
 lNumBytes : Cardinal;
begin
 FlushBuffer;
 { Read from the actual stream. }
 if aFromPosition >= 0 then
  fStream.Position := aFromPosition;
 fBufPos  := fStream.Position;
 lNumBytes := fStream.Read(fBuffer.AsPointer^, fBuffer.Size);
 { Set the buffer pointer and end. }
 fBufOffs := 0;
 fBufLen := lNumBytes;

 { If nothing was read, it must be the end of file. }
 Result := lNumBytes > 0;
 //if Result then
 fState := bsRead;
 //else
 // fState := bsUnknown;
end;

{ Write the output buffer to the stream. When done, the
  buffer is empty, so set the state back to bsUnknown. }
function Tl3NewBufferStream.FlushBuffer : boolean;
begin
 Result := true;
 if (State <> bsWrite) then Exit;

 { Determine the number of bytes in the buffer. }
 //if (fBufPtr = nil) OR (fBuffer.AsPointer = nil) then
 // Result := (0 = fStream.Write((nil)^, 0))
 //else
 begin
  { Write the buffer contents. }
  fStream.Position := fBufPos;
  Result := fBufLen = fStream.Write(fBuffer.AsPointer^, fBufLen);
 end;//fBufPtr = nil..
 { The buffer is empty, so reset the state. }
 //fBufPtr := fBuffer.AsPointer;
 fState := bsRead;
end;

function Tl3NewBufferStream.Flush : boolean;
begin
 Result := FlushBuffer;
 fState := bsUnknown;
end;

{ Seek to a new position. Calling Seek to learn the current
  position is a common idiom, so do not disturb the buffers
  and just return the position, taking the current buffer
  position into account. If the Seek is to _move to a different
  position in the stream, the dump the buffer and reset the state. }
function Tl3NewBufferStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin

 case Origin of
  soBeginning:
   Result := Offset;

  soCurrent:
   if fNeedSeekPos <> cNotNeedSeekPos then  // есть запомненное перемещение
    Result := fNeedSeekPos + Offset
   else
    if fState = bsUnknown then
     Result := fStream.Position + Offset
    else
     Result := fBufPos + fBufOffs + Offset;

  soEnd:
   Result := GetSize + Offset; // Offset MUST be <= 0
  else
   raise Exception.Create(l3ErrInvalidOrigin);
 end;

 if Result > GetSize then
  l3System.Msg2Log('Tl3NewBufferStream.Seek out of range');

 fNeedSeekPos := Result;
end;

procedure Tl3NewBufferStream.CheckNeedSeek;
begin
 if fNeedSeekPos = cNotNeedSeekPos then Exit;

 if fState = bsUnknown then
  fStream.Position := fNeedSeekPos
 else
  if (fNeedSeekPos > fBufPos) and (fNeedSeekPos - fBufPos <= fBufLen) then // смещение в пределах буфера
   fBufOffs := fNeedSeekPos - fBufPos
  else
   FillBuffer(fNeedSeekPos);

 fNeedSeekPos := cNotNeedSeekPos;
end;

{ Read Count bytes. Copy first from the input buffer, and then
  fill the input buffer repeatedly, until fetching all Count bytes.
  Return the number of bytes read. If the state was Write, then
  flush the output buffer before reading. }
function Tl3NewBufferStream.Read(var aBuffer; aCount: LongInt): LongInt;
var
 lPtr: PAnsiChar;
 lNumBytes: Long;
begin
 if (aCount < 0) then
  raise EStreamError.Create('Пытаемся читать отрицательное количество байт');

 CheckNeedSeek;

 if fState = bsUnknown then
  FillBuffer;

 { The user might ask for more than one bufferful.
   Prepare to loop until all the requested bytes have been read. }
 lPtr := @aBuffer;
 Result := 0;
 while aCount > 0 do
 begin
   lNumBytes := fBufLen - fBufOffs;
   if lNumBytes = 0 then
   begin
    if not FillBuffer(fBufPos + fBufLen) then
     Break; // файл кончился
    lNumBytes := fBufLen - fBufOffs;
   end;
   if aCount < lNumBytes then
     lNumBytes := aCount;

   { Copy the buffer to the user's memory. }
   l3Move((fBuffer.AsPointer + fBufOffs)^, lPtr^, lNumBytes);

   { Increment the pointers. The stream’s buffer is always within a single
     segment, but the user's buffer might cross segment boundaries. }
   Dec(aCount, lNumBytes);
   Inc(fBufOffs, lNumBytes);
   Inc(Result, lNumBytes);
   lPtr := lPtr + lNumBytes;
 end;
end;

{ Write Count bytes from Buffer to the stream. If the state was
  bsRead, then reposition the stream to match. }
function Tl3NewBufferStream.Write(const aBuffer; aCount: LongInt): LongInt;
var
 lPtr: PAnsiChar;
 lNumBytes: Long;
begin
 if (aCount < 0) then
  raise EStreamError.Create('Пытаемся читать отрицательное количество байт');

 CheckNeedSeek;

 if fState = bsUnknown then
  FillBuffer;

 { The user might ask for more than one bufferful.
   Prepare to loop until all the requested bytes have been read. }
 lPtr := @aBuffer;
 Result := 0;
 while aCount > 0 do
 begin
   lNumBytes := fBuffer.Size - fBufOffs;
   if lNumBytes = 0 then
   begin
    FillBuffer(fBufPos + fBufLen);
    lNumBytes := fBuffer.Size - fBufOffs;
   end;
   if aCount < lNumBytes then
     lNumBytes := aCount;

   { Copy the buffer to the user's memory. }
   l3Move(lPtr^, (fBuffer.AsPointer + fBufOffs)^, lNumBytes);
   fState := bsWrite;

   { Increment the pointers. The stream’s buffer is always within a single
     segment, but the user's buffer might cross segment boundaries. }
   Dec(aCount, lNumBytes);
   Inc(fBufOffs, lNumBytes);
   Inc(Result, lNumBytes);
   if fBufLen < fBufOffs then fBufLen := fBufOffs;
   lPtr := lPtr + lNumBytes;
 end;

end;

{ Push a character back onto the input buffer. }
procedure Tl3NewBufferStream.PutBack(Ch: AnsiChar);
begin
 if fBufOffs <= 0 then
  raise EStreamError.Create(l3ErrPutbackOverflow);

 Dec(fBufOffs);
 fBuffer.AsPointer[fBufOffs] := Ch;
end;

{ Return whether the current position is at the end of the file. }
function Tl3NewBufferStream.IsEof: Boolean;
begin
 if (fNeedSeekPos <> cNotNeedSeekPos) then
  Result := fNeedSeekPos = fStream.Size
 else
 if fState = bsUnknown then
  Result := fStream.Position = fStream.Size
 else
  Result := fBufPos + fBufOffs = Size;
end;

procedure Tl3NewBufferStream.SetSize(const NewSize: Int64);
  //override;
  {-}
begin
 FlushBuffer;
 fStream.Size := NewSize;
 if (fNeedSeekPos <> cNotNeedSeekPos) and (fNeedSeekPos > fStream.Size) then
  fNeedSeekPos := fStream.Size;
end;

function Tl3NewBufferStream.GetSize : Int64;
begin
 Result := fStream.Size;
 if fState = bsWrite then
  Result := Max(Result, fBufPos + fBufLen);
end;


{$else}
   (*
   { Create and initialize a buffer stream. }
   constructor Tl3NewBufferStream.Create(aStream : TStream);
   begin
     inherited Create;
     l3Set(fStream, aStream);
   end;

   { Destroy the buffer stream. If the buffer is in write mode, then
     make sure the last bufferful is written to the stream. }
   procedure Tl3NewBufferStream.Cleanup;
   begin
    inherited;
    FreeAndNil(fStream);
   end;

   function Tl3NewBufferStream.FlushBuffer: Boolean;
   begin
   end;

   function Tl3NewBufferStream.Read(var Buffer; Count: LongInt): LongInt;
   begin
    Result := fStream.Read(Buffer, Count);
   end;

   function Tl3NewBufferStream.Write(const Buffer; Count: LongInt): LongInt;
   begin
    Result := fStream.Write(Buffer, Count);
   end;

   function Tl3NewBufferStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
   begin
    Result := fStream.Seek(Offset, Origin);
   end;

   procedure Tl3NewBufferStream.PutBack(Ch: AnsiChar);
   begin
    assert(false);
   end;

   { Return whether the current position is at the end of the file. }
   function Tl3NewBufferStream.IsEof: Boolean;
   begin
    Result := fStream.Position = fStream.Size;
   end;

   procedure Tl3NewBufferStream.SetSize(const NewSize: Int64);
   begin
    fStream.Size := NewSize;
   end;
   *)
{$EndIf l3NoBufferStream}
end.

