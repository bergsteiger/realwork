
{ *************************************************************************** }
{                                                                             }
{  Gnostice Shared Visual Component Library                                   }
{                                                                             }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited    }
{  http://www.gnostice.com                                                    }
{                                                                             }
{ *************************************************************************** }

{$I ..\gtSharedDefines.inc}

unit gtClasses3;

interface

uses
  Classes, SysUtils
  {$IFDEF gtActiveX}
    , Controls, Graphics, Buttons
  {$ENDIF};

 Type

  TgtException = class(Exception)
  public
    ErrorCode: Integer;
  end;

  CharSet = set of AnsiChar;

  EInvalidID = class(TgtException);
  EInvalidStream = class(TgtException);
  EReadError = class(TgtException);
  EWriteError = class(TgtException);



  TWString = record
    WString: WideString;
  end;

  TWideStrings = class
  private
    FWideStringList: TList;
    function Get(Index: Integer): WideString;
    procedure Put(Index: Integer; const S: WideString);
  public
    constructor Create;
    destructor Destroy; override;
    function  Count: Integer;
    procedure Clear;
    function Add(const S: WideString): Integer;
    function Delete(Index: Integer): WideString;
    function IndexOf(const S: WideString): Integer;
    function IndexOfIgnoreCase(const S: WideString): Integer;
    procedure Insert(Index: Integer; const S: WideString);
    procedure SetTextStr(const Value: WideString);
    procedure LoadFromFile(const FileName: WideString);
    procedure LoadFromStream(Stream: TStream);
    property Strings[Index: Integer]: WideString read Get write Put; default;
  end;

{ TgtExtMemStream }

  TgtExtMemStream = Class(TMemoryStream)
  private
    FPadSize : Int64;

  public
    property PadSize: Int64 read FPadSize write FPadSize;

    constructor Create;
    procedure PadTo4Bytes;
    function SkipBytes(ANumBytes : Integer) : Integer;
    function ReadByte : Byte;
    function ReadLong : Integer;
    function ReadULong : Cardinal;
    function ReadShort : SmallInt;
    function ReadUShort : Word;
    function ReadString(ALength : Integer) : AnsiString;
    procedure ReadByteArray(AByteArray : array of Byte; AOffset, ALength : Integer);
    procedure WriteByte(AByte: Byte);
    procedure WriteLong(ALong : Integer);
    procedure WriteULong(AULong : Cardinal);
    procedure WriteShort(AShort : SmallInt);
    procedure WriteUShort(AUShort : Word);
    procedure WriteString(AString : AnsiString);
    procedure WriteByteArray(AByteArray : array of Byte);
    procedure WriteUShortArray(AUShortArray: array of Word);
    procedure WriteULongArray(AULongArray : array of Cardinal);
  end;


{ TgtBaseComponent }

{$IFDEF gtActiveX}
  TgtBaseComponent = class(TCustomControl)
{$ELSE}
  TgtBaseComponent = class(TComponent)
{$ENDIF}
  private
    FAbout: String;
    FVersion: String;
  {$IFDEF gtActiveX}
    FIconBmp: TBitmap;
    function GetControlCanvas: TCanvas;
  {$ENDIF}
    procedure SetAbout(const Value: String);
    procedure SetVersion(const Value: String);
  protected
  {$IFDEF gtActiveX}
    property ControlCanvas: TCanvas read GetControlCanvas;
    property IconBmp: TBitmap read FIconBmp write FIconBmp;
  {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  {$IFDEF gtActiveX}
    procedure Paint; override;
  {$ENDIF}
  published
    property About: String read FAbout write SetAbout;
    property Version: String read FVersion write SetVersion;
  end;


{ TgtReadOnlyFilter }

  TgtReadOnlyFilter = class(TStream)
  private
    FSize: Longint;
    FStream: TStream;
  public
    constructor Create(aStream: TStream);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    property Stream: TStream read FStream;
  end;


{ TgtWriteOnlyFilter }

  TgtWriteOnlyFilter = class(TStream)
  private
    FStream: TStream;
  public
    constructor Create(aStream: TStream);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function CopyFrom(Source: TStream; Count: Int64): Int64;
    property Stream: TStream read FStream;
  end;


{ TgtRandomAccessFilter }

  TgtRandomAccessFilter = class(TgtReadOnlyFilter)
  private
    FPeekLastChar: Boolean;
  public
    function PeekChar: Char;
    function PeekString(Count: Longint): String;
    function ReadChar: Char;
    function ReadString(Count: Longint): String;
    function ReadOffset(var Buffer; FromOffset, ToOffset: Longint): Longint;
    function Skip(Count: Longint): Longint;
    procedure PushBackChar;
    procedure IncPos(Count: Integer);
    property PeekLastChar: Boolean read FPeekLastChar;
  end;


{ TgtObjectList }

  TgtObjectList = class;

  PObjectItem = ^TgtObjectItem;
  TgtObjectItem = record
    FInteger: Integer;
    FObject: TObject;
  end;

  PObjectItemList = ^TgtObjectItemList;
  {$IFDEF WIN32}
  TgtObjectItemList = array[0..MaxListSize] of TgtObjectItem;
  {$ENDIF}
  {$IFDEF WIN64}
  TgtObjectItemList = array[0..134217726] of TgtObjectItem;
  {$ENDIF}
  TgtObjectList = class(TPersistent)
  private
    FList: PObjectItemList;
    FCount: Integer;
    FCapacity: Integer;
    procedure Grow;
    function GetCapacity: Integer;
    function GetCount: Integer;
    function GetObject(Index: Integer): TObject;
    procedure SetCapacity(NewCapacity: Integer);
    function GetItem(Index: Integer): TgtObjectItem;
  public
    destructor Destroy; override;
    function Add(ANo: Integer; AObject: TObject): Integer; overload;
    procedure Add(AObjectList: TgtObjectList); overload;
    procedure Clear;
    procedure Delete(Index: Integer);
    function IndexOf(const ObjectNo: Integer): Integer;
    procedure InsertItem(Index: Integer; ANo: Integer; AObject: TObject);
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount;
    property Objects[Index: Integer]: TObject read GetObject; default;
    property Items[Index: Integer]: TgtObjectItem read GetItem;
  end;

//Exception type for improper image format and  Unsupported Background Display type

  EImageExceptions=class(Exception);

  ExInvalidImageFormat = class(EImageExceptions);
  ExUnsupportedBackgroundDisplayType = class(EImageExceptions);
resourcestring
  SInvalidID = 'Invalid unique ID (%d)';
  SNullStreamError = 'Invalid Stream! Cannot create with null stream';
  SWriteError = 'A read-only filter cannot write';
  SReadError = 'A write-only filter cannot read';
  SInvalidOffset = 'Invalid offset specified';
  SSkipCount = 'Skip count exceeds Stream Size';
  SListIndexOutOfBounds = 'List index out of bounds (%d)';

  ErrInvalidImageFormat = 'Invalid Image Format';
  ErrUnsupportedBackgroundDisplayType = 'Unsupported Background Display Type ';



//const AX_SIZE = 28;
//{$IFDEF gtDelphi5}
//  soBeginning = 0;
//  soCurrent = 1;
//  soEnd = 2;
//{$ENDIF}

implementation

function InOpSet(W: WideChar; const Sets: CharSet): Boolean;
begin
  if W <= #$FF then
    Result := AnsiChar(W) in Sets
  else
    Result := False;
end;

{ TgtBaseComponent }

constructor TgtBaseComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF gtActiveX}
  FIconBmp := TBitmap.Create;
  FIconBmp.Transparent := True;
  FIconBmp.TransparentMode := tmAuto;
  SetBounds(Left, Top, AX_SIZE, AX_SIZE);
  Constraints.MinHeight := AX_SIZE;
  Constraints.MinWidth := AX_SIZE;
  Constraints.MaxHeight := AX_SIZE;
  Constraints.MaxWidth := AX_SIZE;
{$ENDIF}
end;

destructor TgtBaseComponent.Destroy;
begin
{$IFDEF gtActiveX}
  FreeAndNil(FIconBmp);
{$ENDIF}
  inherited;
end;

{$IFDEF gtActiveX}
procedure TgtBaseComponent.Paint;
begin
  inherited;
  DrawButtonFace(Canvas, Rect(0, 0, AX_SIZE, AX_SIZE), 1, bsNew, False, False, True);
end;

function TgtBaseComponent.GetControlCanvas: TCanvas;
begin
  Result := Canvas;
end;

{$ENDIF}

procedure TgtBaseComponent.SetAbout(const Value: String);
begin

end;

procedure TgtBaseComponent.SetVersion(const Value: String);
begin

end;

{ TgtExtMemStream }

constructor TgtExtMemStream.Create;
begin
  inherited Create;
  Position := 0;
  PadSize := 0;
end;

procedure TgtExtMemStream.PadTo4Bytes;
var
  I : Integer;
  Zero : Integer;
begin
  Zero := 0; Position := Size;
  I := (4 - (Size mod 4));
  if I <> 4 then Write(Zero, I);
  if I = 4 then PadSize := 0
  else PadSize := I;
end;

function TgtExtMemStream.ReadByte: Byte;
begin
  Read(Result, 1);
end;

procedure TgtExtMemStream.ReadByteArray(AByteArray: array of Byte; AOffset,
  ALength: Integer);
var
  N, Cnt : Integer;
begin
  N := 0;
  repeat
    Position := Position + (AOffset + N);
    Cnt := Read(AByteArray, ALength - N);
    if (Cnt < 0) then Exit;
    N  := N + Cnt;
  until (N >= ALength);
end;

function TgtExtMemStream.ReadLong: Integer;
var I : array[0..3] of Byte;
begin
  Read(I, 4);
  Result := Integer(I[0] shl 24) + (I[1] shl 16) + (I[2] shl 8) + I[3];
end;

function TgtExtMemStream.ReadShort: SmallInt;
var I : array[0..1] of Byte;
begin
  Read(I, 2);
  Result := SmallInt((I[0] shl 8) + I[1]);
end;

function TgtExtMemStream.ReadString(ALength: Integer): AnsiString;
begin
  SetLength(Result, ALength);
  Read(Result[1], ALength);
end;

function TgtExtMemStream.ReadULong: Cardinal;
var I : array[0..3] of Byte;
begin
  Read(I, 4);
  Result := Cardinal((I[0] shl 24) + (I[1] shl 16) + (I[2] shl 8) + I[3]);
end;

function TgtExtMemStream.ReadUShort: Word;
var I : array[0..1] of Byte;
begin
  Read(I, 2);
  Result := Word((I[0] shl 8) + I[1]);
end;

function TgtExtMemStream.SkipBytes(ANumBytes: Integer): Integer;
var NewPos : Integer;
begin
  NewPos := Position + ANumBytes;
  if (NewPos > Size) then NewPos := Size
  else if (NewPos < 0) then NewPos := 0;
  Position := NewPos;
  Result := NewPos - Position;
end;

procedure TgtExtMemStream.WriteByte(AByte: Byte);
begin
  Write(AByte, 1);
end;

procedure TgtExtMemStream.WriteByteArray(AByteArray: array of Byte);
begin
  Write(AByteArray, SizeOf(AByteArray));
end;

procedure TgtExtMemStream.WriteLong(ALong: Integer);
var
  B : array[0..3] of Byte;
begin
  B[0] := Byte(ALong shr 24);
  B[1] := Byte((ALong shl 8) shr 24);
  B[2] := Byte((ALong shl 16) shr 24);
  B[3] := Byte((ALong shl 24) shr 24);
  WriteByteArray(B);
end;

procedure TgtExtMemStream.WriteShort(AShort: SmallInt);
var
  B : array[0..1] of Byte;
begin
  B[0] := Byte(AShort shr 8);
  B[1] := Byte((AShort shl 8) shr 8);
  WriteByteArray(B);
end;

procedure TgtExtMemStream.WriteString(AString: AnsiString);
var
  I : Integer;
begin
  for I := 1 to Length(AString) do WriteByte(Ord(AString[I]));
end;

procedure TgtExtMemStream.WriteULong(AULong: Cardinal);
var
  B : array[0..3] of Byte;
begin
  B[0] := Byte(AULong shr 24);
  B[1] := Byte((AULong shl 8) shr 24);
  B[2] := Byte((AULong shl 16) shr 24);
  B[3] := Byte((AULong shl 24) shr 24);
  WriteByteArray(B);
end;

procedure TgtExtMemStream.WriteULongArray(AULongArray: array of Cardinal);
var LI: Integer;
begin
  for LI := Low(AULongArray) to High(AULongArray) do
    WriteULong(AULongArray[LI]);
end;

procedure TgtExtMemStream.WriteUShortArray(AUShortArray: array of Word);
var LI: Integer;
begin
  for LI := Low(AUShortArray) to High(AUShortArray) do
    WriteUShort(AUShortArray[LI]);
end;

procedure TgtExtMemStream.WriteUShort(AUShort: Word);
var
  B : array[0..1] of Byte;
begin
  B[0] := Byte(AUShort shr 8);
  B[1] := Byte((AUShort shl 8) shr 8);
  WriteByteArray(B);
end;


{ TgtReadOnlyFilterStream }

constructor TgtReadOnlyFilter.Create(aStream: TStream);
begin
  inherited Create;
  if not Assigned(aStream) then
    raise EInvalidStream.Create(SNullStreamError)
  else
  begin
    FStream := aStream;
    FSize := FStream.Size;
  end;
end;

function TgtReadOnlyFilter.Read(var Buffer; Count: Integer): Longint;
begin
  Result := FStream.Read(Buffer, Count);
end;

function TgtReadOnlyFilter.Seek(Offset: Integer; Origin: Word): Longint;
begin
  if Offset = -1 then
    Result := Offset
  else
    Result := FStream.Seek(Offset, Origin);
end;

function TgtReadOnlyFilter.Write(const Buffer; Count: Integer): Longint;
begin
  raise EReadError.Create(SReadError);
  Result := 0;
end;


{ TgtRandomAccessFilter }

procedure TgtRandomAccessFilter.IncPos(Count: Integer);
begin
  FStream.Position := FStream.Position + Count;
end;

function TgtRandomAccessFilter.PeekChar: Char;
begin
  FStream.Read(Result, 1);
  FPeekLastChar := (FStream.Position = FStream.Size);
  FStream.Position := FStream.Position - 1;
end;

function TgtRandomAccessFilter.PeekString(Count: Integer): String;
begin
  SetLength(Result, Count);
  Count := FStream.Read(Result[1], Count);
  //FPeekLastChar := (FStream.Position = FStream.Size);
  FStream.Position := FStream.Position - Count;
end;

procedure TgtRandomAccessFilter.PushBackChar;
begin
  FStream.Position := FStream.Position - 1;
end;

function TgtRandomAccessFilter.ReadChar: Char;
begin
  FStream.Read(Result, 1);
end;

function TgtRandomAccessFilter.ReadOffset(var Buffer; FromOffset,
  ToOffset: Integer): Longint;
  function IsValidOffset(FromOffset, ToOffset: Longint): Boolean;
  begin
    Result := (FromOffset >= 0) and (ToOffset >= 0) and (ToOffset <= FSize);
  end;
var
  CurrentPos: Longint;
begin
  if not IsValidOffset(FromOffset, ToOffset) then
  begin
    raise Exception.Create(SInvalidOffset);
    Result := 0;
    Exit;
  end;

  Result := ToOffset - FromOffset;
  if Result > 0 then
  begin
    CurrentPos := FStream.Position;
    FStream.Position := FromOffset;
    Result := FStream.Read(Buffer, Result);
    FStream.Position := CurrentPos;
  end
  else Result := 0;
end;

function TgtRandomAccessFilter.ReadString(Count: Integer): String;
begin
  SetLength(Result, Count);
  Read(Result[1], Count);
end;

function TgtRandomAccessFilter.Skip(Count: Integer): Longint;
begin
  if (FStream.Position + Count)>FSize then
    raise Exception.Create(SSkipCount)
  else
  begin
    FStream.Position := (FStream.Position + Count);
    Result := Count;
  end;
end;


{ TgtWriteOnlyFilter }

function TgtWriteOnlyFilter.CopyFrom(Source: TStream; Count: Int64): Int64;
begin
  Result := FStream.CopyFrom(Source, Count);
end;

constructor TgtWriteOnlyFilter.Create(aStream: TStream);
begin
  inherited Create;
  if not Assigned(aStream) then raise EInvalidStream.Create(SNullStreamError)
  else FStream := aStream;
end;

function TgtWriteOnlyFilter.Read(var Buffer; Count: Integer): Longint;
begin
  raise EReadError.Create(SReadError);
  Result := 0;
end;

function TgtWriteOnlyFilter.Seek(Offset: Integer; Origin: Word): Longint;
begin
  Result := FStream.Seek(Offset, Origin);
end;

function TgtWriteOnlyFilter.Write(const Buffer; Count: Integer): Longint;
begin
  Result := FStream.Write(Buffer, Count);
end;


{ TgtObjectList }

destructor TgtObjectList.Destroy;
begin
  inherited Destroy;
  Clear;
end;

procedure TgtObjectList.Clear;
begin
  if FCount <> 0 then
  begin
    FCount := 0;
    SetCapacity(0);
  end;
end;

function TgtObjectList.Add(ANo: Integer; AObject: TObject): Integer;
begin
  Result := FCount;
  InsertItem(FCount, ANo, AObject);
end;

procedure TgtObjectList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    Exception.CreateFmt(SListIndexOutOfBounds, [Index]);
  FList^[Index].FObject.Free;
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(TStringItem));
end;

function TgtObjectList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then
    Exception.CreateFmt(SListIndexOutOfBounds, [Index]);
  Result := FList^[Index].FObject;
end;

function TgtObjectList.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TgtObjectList.GetCount: Integer;
begin
  Result := FCount;
end;

procedure TgtObjectList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TgtObjectList.IndexOf(
  const ObjectNo: Integer): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if (FList^[Result].FInteger = ObjectNo) then Exit;
  Result := -1;
end;

procedure TgtObjectList.InsertItem(Index: Integer; ANo: Integer;
  AObject: TObject);
begin
  if ANo < 0 then
    raise EInvalidID.CreateFmt(SInvalidID, [ANo]);

  if FCount = FCapacity then Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(TgtObjectItem));
  with FList^[Index] do
  begin
    FObject := AObject;
    FInteger := ANo;
  end;
  Inc(FCount);
end;

procedure TgtObjectList.SetCapacity(NewCapacity: Integer);
begin
  ReallocMem(FList, NewCapacity * SizeOf(TgtObjectItem));
  FCapacity := NewCapacity;
end;

procedure TgtObjectList.Add(AObjectList: TgtObjectList);
var
  LI: Integer;
  LIndex: Integer;
begin
  SetCapacity(FCount + AObjectList.Count);
  for LI := 0 to AObjectList.Count-1 do
  begin
    LIndex := IndexOf(AObjectList.Items[LI].FInteger);
    if LIndex = -1 then
    begin
      FList^[FCount] := AObjectList.Items[LI];
      Inc(FCount);
    end
    else
      AObjectList.Items[LI].FObject.Free;
  end;
end;

function TgtObjectList.GetItem(Index: Integer): TgtObjectItem;
begin
  Result := FList^[Index];
end;

{ TWideStrings implementation }
constructor TWideStrings.Create;
begin
  FWideStringList := TList.Create;
end;

destructor TWideStrings.Destroy;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  { TODO - BB Investigate : Could call Clear here }
  for Index := 0 to FWideStringList.Count-1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Dispose(PWStr);
  end;
  FWideStringList.Free;
  inherited Destroy;
end;

function TWideStrings.Delete(Index: Integer): WideString;
begin
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    FWideStringList.Delete(Index);
  end;
end;

function TWideStrings.Get(Index: Integer): WideString;
var
  PWStr: ^TWString;
begin
  Result := '';
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Result := PWStr^.WString;
  end;
end;

procedure TWideStrings.Put(Index: Integer; const S: WideString);
var
  PWStr: ^TWString;
begin
  if((Index < 0) or (Index > FWideStringList.Count)) then Exit;
    //raise Exception.Create(SWideStringOutofBounds);
  if Index < FWideStringList.Count then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      PWStr.WString := S;
  end
  else
    Add(S);
end;

function TWideStrings.Add(const S: WideString): Integer;
var
  PWStr: ^TWString;
begin
  New(PWStr);
  PWStr^.WString := S;
  Result := FWideStringList.Add(PWStr);
end;

function TWideStrings.IndexOfIgnoreCase(const S: WideString): Integer;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  Result := -1;
  for Index := 0 to FWideStringList.Count -1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
    begin
      if SameText(S, PWStr^.WString) then
      begin
        Result := Index;
        break;
      end;
    end;
  end;
end;

function TWideStrings.IndexOf(const S: WideString): Integer;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  Result := -1;
  for Index := 0 to FWideStringList.Count -1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
    begin
      if S = PWStr^.WString then
      begin
        Result := Index;
        break;
      end;
    end;
  end;
end;

function TWideStrings.Count: Integer;
begin
  Result := FWideStringList.Count;
end;

procedure TWideStrings.Clear;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  for Index := 0 to FWideStringList.Count-1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Dispose(PWStr);
  end;
  FWideStringList.Clear;
end;

procedure TWideStrings.Insert(Index: Integer; const S: WideString);
var
  PWStr: ^TWString;
  LIdx: Integer;
begin
  if((Index < 0) or (Index > FWideStringList.Count)) then Exit;
    //raise Exception.Create(SWideStringOutofBounds);
  if Index < FWideStringList.Count then
  begin
    Add(S);
    for LIdx := Count - 1 downto (Index + 1) do
    begin
      PWStr := FWideStringList.Items[LIdx];
      if PWStr <> nil then
        PWStr.WString := Strings[LIdx - 1];
    end;
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      PWStr.WString := S;
  end
  else
    Add(S);
end;

procedure TWideStrings.LoadFromFile(const FileName: WideString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TWideStrings.LoadFromStream(Stream: TStream);
var
  Size: Integer;
  S: WideString;
begin
    Size := Stream.Size - Stream.Position;
    SetString(S, nil, Size div SizeOf(WideChar));
    Stream.Read(Pointer(S)^, Size);
    SetTextStr(S);
end;

procedure TWideStrings.SetTextStr(const Value: WideString);
var
  P, Start: PwideChar;
  S: WideString;
begin
  Clear;
  P := Pointer(Value);
  if P <> nil then
    while P^ <> #0 do
    begin
      Start := P;
      while not InOpSet(P^, [AnsiChar(#0), AnsiChar(#10), AnsiChar(#13)]) do Inc(P);
      SetString(S, Start, P - Start);
      Add(S);
      if P^ = #13 then Inc(P);
      if P^ = #10 then Inc(P);
    end;
end;



end.
