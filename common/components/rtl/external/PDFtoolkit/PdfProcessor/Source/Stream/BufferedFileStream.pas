unit BufferedFileStream;

interface

uses Classes, SysUtils;

type
  TgtBufferedFileStream = class(TFileStream)
  private
    FUseByteArrayAsBuffer: Boolean;
    // Instantiate/use appropriate buffer variable based on value passed for
    // AUseByteArrayAsBuffer parameter on Create
    FStreamBuffer: TMemoryStream;
    FByteBuffer: array of Byte; // This will be our dynamic array used as buffer
    FBufferPosition: Integer; // Relevant only when FUseByteArrayAsBuffer is True

    FBufferSize: Integer;
    procedure FillBuffer;
    procedure PrepareBuffer;
    procedure SetBufferSize(const Value: Integer);

  public
//    procedure AfterConstruction; override; // not used in new implementation

    constructor Create(const FileName: AnsiString; Mode: Word;
      AUseByteArrayAsBuffer: Boolean = True); overload;
    constructor Create(const FileName: AnsiString; Mode: Word;
      Rights: Cardinal; AUseByteArrayAsBuffer: Boolean = True); overload;
    destructor Destroy; override;

    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;

    procedure ClearBuffer;

    property BufferSize: Integer read FBufferSize write SetBufferSize
      default 2000;
  end;

implementation

// uses Math;

{ TgtBufferedFileStream }

{ Using AfterConstruction was the earlier implementation. Can't use this if we
  are providing a choice for the user to opt for memory stream or byte array as
  buffer. We can't provide this choice through a property as it won't be
  appropriate to change buffer in the middle. So we accept this setting in the
  constructor and create our buffer there.

// So we don't have to override all constructors of TFileStream that are there
// and new ones that come up. We need a sure point immediately after object
// instance to initialize our class members, and this seems to be a good point.
procedure TgtBufferedFileStream.AfterConstruction;
begin
  inherited;
  FStreamBuffer := TMemoryStream.Create;
end;
}

constructor TgtBufferedFileStream.Create(const FileName: AnsiString;
  Mode: Word; AUseByteArrayAsBuffer: Boolean);
begin
  inherited Create(FileName, Mode);
  FUseByteArrayAsBuffer := AUseByteArrayAsBuffer;
  PrepareBuffer;
end;

constructor TgtBufferedFileStream.Create(const FileName: AnsiString;
  Mode: Word; Rights: Cardinal; AUseByteArrayAsBuffer: Boolean);
begin
  inherited Create(FileName, Mode, Rights);
  FUseByteArrayAsBuffer := AUseByteArrayAsBuffer;
  PrepareBuffer;
end;

destructor TgtBufferedFileStream.Destroy;
begin
  if FUseByteArrayAsBuffer then
    // Deallocate buffer (dynamic array) by assigning nil or passing it
    // to Finalize
    FByteBuffer := nil
  else
    FreeAndNil(FStreamBuffer);
  inherited;
end;

function TgtBufferedFileStream.Read(var Buffer; Count: Integer): Longint;
var
  LRemain: Integer;

begin
  if FUseByteArrayAsBuffer then
  begin
    Result := Length(FByteBuffer) - FBufferPosition;
    if Result > Count then
      Result := Count;

    // Move to Buffer var bytes available in byte buff or
    // as many bytes as requested in Count, whichever is lesser
    if Result > 0 then
      Move(Pointer(Longint(FByteBuffer) + FBufferPosition)^, Buffer, Result);
      // For byte buffer we need to manage the (pointer) position ourselves

    // Find out remaining # of bytes to be served, from total requested and
    // bytes served from byte buffer
    LRemain := Count - Result;

    // Served less than requested?
    if LRemain > 0 then
    begin
      // Clear buffer so fresh data can be filled in and we can make sure
      // no more that BufferSize bytes are held in buffer at any time
      ClearBuffer;

      // if read size is equal or greater than buffer size then no need to buffer
      // just take bytes already in buffer (by advancing pointer by bytes already read),
      // read the rest from file and serve directly
      if LRemain >= BufferSize then
        Result := Result + inherited Read(
          PByteArray(Addr(Buffer))[Result], LRemain)
      else // Otherwise, read into buffer and supply remaining bytes
      begin
        FillBuffer;
        if Length(FByteBuffer) > 0 then // if not EOF
        begin
          Move(Pointer(Longint(FByteBuffer) + FBufferPosition)^,
            PByteArray(Addr(Buffer))[Result], LRemain);
          Result := Result + LRemain; // Actual bytes returned
        end;
      end;
    end;
    Inc(FBufferPosition, Result);
  end
  else
  begin
    // Try supplying requested # of bytes from buffer. No worry if buffer is empty.
    // We'll know how many bytes were actually supplied, through Result
    Result := FStreamBuffer.Read(Buffer, Count);

    // Find out remaining # of bytes to be served, from total requested and
    // bytes served from buffer
    LRemain := Count - Result;

    // Served less than requested
    if LRemain > 0 then
    begin
      // Clear buffer so fresh data can be filled in and we can make sure
      // no more that BufferSize bytes are held in buffer at any time
      ClearBuffer;

      // if read size is equal or greater than buffer size then no need to buffer
      // just take bytes already in buffer (by advancing pointer by bytes already read),
      // read the rest from file and serve directly
      if LRemain >= BufferSize then
        Result := Result + inherited Read(
          PByteArray(Addr(Buffer))[Result], LRemain)
      else // Otherwise, read into buffer and supply remaining bytes
      begin
        FillBuffer;
        Result := Result + FStreamBuffer.Read(
          PByteArray(Addr(Buffer))[Result], LRemain);
      end;
    end;
  end;
  // Result will finally contain total bytes served
  // If Result is still less than Count, it means EOF was reached
end;

function TgtBufferedFileStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  Result := inherited Seek(Offset, Origin);
  // Buffer needs to be cleared as read calls will need to serve data from a
  // new position in file
  ClearBuffer;
end;

procedure TgtBufferedFileStream.SetBufferSize(const Value: Integer);
begin
{  if FBufferSize <> Value then
  begin
    SetLength(FStreamBuffer, FBufferSize;);

  end;
}
  FBufferSize := Value;

end;

function TgtBufferedFileStream.Write(const Buffer;
  Count: Integer): Longint;
begin
  Result := inherited Write(Buffer, Count);
  // Buffer needs to be cleared as position is changing and read calls after
  // this will be looking for fresh data
  ClearBuffer;
end;

procedure TgtBufferedFileStream.ClearBuffer;
begin
  if FUseByteArrayAsBuffer then
  begin
    FBufferPosition := 0;
    SetLength(FByteBuffer, 0); // Setting the size to 0 deallocates the memory
  end
  else
    FStreamBuffer.Clear;
end;

procedure TgtBufferedFileStream.FillBuffer;
var
  LReadCount: Integer;
  LBuf: array of Byte;
begin
  // Read from file BufferSize bytes and write into buffer. Position buffer to
  // start serving from begining
  if FUseByteArrayAsBuffer then
  begin
    // Allocate memory (create array in memory) for our buffer (dynamic array)
    // passing it to SetLength
    SetLength(FByteBuffer, BufferSize);
    LReadCount := inherited Read(FByteBuffer[0], BufferSize);
    SetLength(FByteBuffer, LReadCount); // reset buffer size to # of bytes read
    FBufferPosition := 0;
  end
  else // using memory stream
  begin
    SetLength(LBuf, BufferSize);
    LReadCount := inherited Read(LBuf[0], BufferSize);
    FStreamBuffer.Write(LBuf[0], LReadCount);
    FStreamBuffer.Position := 0;
  end;
end;

procedure TgtBufferedFileStream.PrepareBuffer;
begin
  // If FUseByteArrayAsBuffer is true, memory will be allocated in FillBuffer
  if not FUseByteArrayAsBuffer then
    FStreamBuffer := TMemoryStream.Create;
end;

end.
