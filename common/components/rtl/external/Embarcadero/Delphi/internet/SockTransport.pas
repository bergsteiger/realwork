{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SockTransport;

{$R-}

interface

uses
  System.Classes, System.SysUtils, System.Variants;

type

  { IDataBlock }

  IDataBlock = interface(IUnknown)
  ['{CA6564C2-4683-11D1-88D4-00A0248E5091}']
    function GetBytesReserved: Integer;
    function GetMemory: Pointer;
    function GetSize: Integer;
    procedure SetSize(Value: Integer);
    function GetStream: TStream;
    function GetSignature: Integer;
    procedure SetSignature(Value: Integer);
    procedure Clear;
    function Write(const Buffer; Count: Integer): Integer;
    function Read(var Buffer; Count: Integer): Integer;
    procedure IgnoreStream;
    property BytesReserved: Integer read GetBytesReserved;
    property Memory: Pointer read GetMemory;
    property Signature: Integer read GetSignature write SetSignature;
    property Size: Integer read GetSize write SetSize;
    property Stream: TStream read GetStream;
  end;

  { ISendDataBlock }

  ISendDataBlock = interface
  ['{87AD1043-470E-11D1-88D5-00A0248E5091}']
    function Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; stdcall;
  end;

  { ITransport }

  ITransport = interface(IUnknown)
  ['{CA6564C1-4683-11D1-88D4-00A0248E5091}']
    function GetWaitEvent: THandle;
    function GetConnected: Boolean;
    procedure SetConnected(Value: Boolean);
    function Receive(WaitForInput: Boolean; Context: Integer): IDataBlock;
    function Send(const Data: IDataBlock): Integer;
    property Connected: Boolean read GetConnected write SetConnected;
  end;

  { TDataBlock }

  TDataBlock = class(TInterfacedObject, IDataBlock)
  private
    FStream: TMemoryStream;
    FReadPos: Integer;
    FWritePos: Integer;
    FIgnoreStream: Boolean;
  protected
    { IDataBlock }
    function GetBytesReserved: Integer;
    function GetMemory: Pointer;
    function GetSize: Integer;
    procedure SetSize(Value: Integer);
    function GetStream: TStream;
    function GetSignature: Integer;
    procedure SetSignature(Value: Integer);
    procedure Clear;
    function Write(const Buffer; Count: Integer): Integer;
    function Read(var Buffer; Count: Integer): Integer;
    procedure IgnoreStream;
    property BytesReserved: Integer read GetBytesReserved;
    property Memory: Pointer read GetMemory;
    property Signature: Integer read GetSignature write SetSignature;
    property Size: Integer read GetSize write SetSize;
    property Stream: TStream read GetStream;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  PIntArray = ^TIntArray;
  TIntArray = array[0..0] of Integer;

  PVariantArray = ^TVariantArray;
  TVariantArray = array[0..0] of OleVariant;

  TVarFlag = (vfByRef, vfVariant);
  TVarFlags = set of TVarFlag;

  TCustomDataBlockInterpreter = class(TObject)
  protected
    FSendDataBlock: ISendDataBlock;
    function ReadVariant(out Flags: TVarFlags;
      const Data: IDataBlock): Variant;
    procedure DoException(const Data: IDataBlock);
    procedure WriteVariant(const Value: Variant;
      const Data: IDataBlock);
  public
    procedure InterpretData(const Data: IDataBlock); virtual;
    constructor Create(ASendDataBlock: ISendDataBlock);
  end;

  TSendDataBlock = class(TInterfacedObject, ISendDataBlock)
  protected
    FTransport: ITransport;
    { ISendDataBlock }
    function Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; virtual; stdcall;
  public
    constructor Create(ATransport: ITransport);
  end;

const

  { Action Signatures }

  CallSig         = $D800; // Call signature
  ResultSig       = $D400; // Result signature
  asMask          = $00FF;   // Mask for action

type

  EInterpreterError = class(Exception);

  { TSocketTransport }

  ESocketConnectionError = class(Exception);

  procedure CheckSignature(Sig: Integer);

implementation

uses
  System.RTLConsts, SockConst;

{ Utility functions }

procedure CheckSignature(Sig: Integer);
begin
  if (Sig and $FF00 <> CallSig) and
     (Sig and $FF00 <> ResultSig) then
    raise Exception.Create(sInvalidDataPacket);
end;

{ TDataBlock }

constructor TDataBlock.Create;
begin
  inherited Create;
  FIgnoreStream := False;
  FStream := TMemoryStream.Create;
  Clear;
end;

destructor TDataBlock.Destroy;
begin
  if not FIgnoreStream then
    FStream.Free;
  inherited Destroy;
end;

{ TDataBlock.IDataBlock }

function TDataBlock.GetBytesReserved: Integer;
begin
  Result := SizeOf(Integer) * 2;
end;

function TDataBlock.GetMemory: Pointer;
var
  DataSize: Integer;
begin
  FStream.Position := 4;
  DataSize := FStream.Size - BytesReserved;
  FStream.Write(DataSize, SizeOf(DataSize));
  Result := FStream.Memory;
end;

function TDataBlock.GetSize: Integer;
begin
  Result := FStream.Size - BytesReserved;
end;

procedure TDataBlock.SetSize(Value: Integer);
begin
  FStream.Size := Value + BytesReserved;
end;

function TDataBlock.GetStream: TStream;
var
  DataSize: Integer;
begin
  FStream.Position := 4;
  DataSize := FStream.Size - BytesReserved;
  FStream.Write(DataSize, SizeOf(DataSize));
  FStream.Position := 0;
  Result := FStream;
end;

function TDataBlock.GetSignature: Integer;
begin
  FStream.Position := 0;
  FStream.Read(Result, SizeOf(Result));
end;

procedure TDataBlock.SetSignature(Value: Integer);
begin
  FStream.Position := 0;
  FStream.Write(Value, SizeOf(Value));
end;

procedure TDataBlock.Clear;
begin
  FStream.Size := BytesReserved;
  FReadPos := BytesReserved;
  FWritePos := BytesReserved;
end;

function TDataBlock.Write(const Buffer; Count: Integer): Integer;
begin
  FStream.Position := FWritePos;
  Result := FStream.Write(Buffer, Count);
  FWritePos := FStream.Position;
end;

function TDataBlock.Read(var Buffer; Count: Integer): Integer;
begin
  FStream.Position := FReadPos;
  Result := FStream.Read(Buffer, Count);
  FReadPos := FStream.Position;
end;

procedure TDataBlock.IgnoreStream;
begin
  FIgnoreStream := True;
end;


{ TCustomDataBlockInterpreter }

procedure TCustomDataBlockInterpreter.InterpretData(
  const Data: IDataBlock);
begin
  Assert(False, 'Must be implemented by descendent'); { Do not localize }
end;

constructor TCustomDataBlockInterpreter.Create(ASendDataBlock: ISendDataBlock);
begin
  FSendDataBlock := ASendDataBlock;
  inherited create;
end;

{ TSendDataBlock }

constructor TSendDataBlock.Create(ATransport: ITransport);
begin
  FTransport := ATransport;
  inherited Create;
end;

function TSendDataBlock.Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock;
var
  Context: Integer;
begin
  Assert(FTransport <> nil);
  Context := FTransport.Send(Data);
  Result := FTransport.Receive(WaitForResult, Context);
end;

var
  VariantSize: array[0..varLongWord] of Word  = (0, 0, SizeOf(SmallInt), SizeOf(Integer),
    SizeOf(Single), SizeOf(Double), SizeOf(Currency), SizeOf(TDateTime), 0, 0,
    SizeOf(Integer), SizeOf(WordBool), 0, 0, 0, 0, SizeOf(ShortInt), SizeOf(Byte),
    SizeOf(Word), SizeOf(LongWord));

function TCustomDataBlockInterpreter.ReadVariant(out Flags: TVarFlags;
  const Data: IDataBlock): Variant;
var
  I, VType: Integer;
  W: WideString;
  S: AnsiString;
  TmpFlags: TVarFlags;
begin
  VarClear(Result);
  Flags := [];
  Data.Read(VType, SizeOf(VType));
  if VType and varByRef = varByRef then Include(Flags, vfByRef);
  if VType = varByRef then
  begin
    Include(Flags, vfVariant);
    Result := ReadVariant(TmpFlags, Data);
    Exit;
  end;
  if vfByRef in Flags then VType := VType xor varByRef;
  if (VType and varArray) = varArray then
    Assert(False, 'Arrays not supported') else { Do not localize }
  case VType and varTypeMask of
    varEmpty: VarClear(Result);
    varNull: Result := NULL;
    varString:
    begin
      Data.Read(I, SizeOf(Integer));
      SetLength(S, I);
      Data.Read(S[1], I);
      Result := S;
    end;
    varOleStr:
    begin
      Data.Read(I, SizeOf(Integer));
      SetLength(W, I);
      Data.Read(W[1], I * 2);
      Result := W;
    end;
    varDispatch:
    begin
      Assert(False, 'varDispatch not supported'); { Do not localize }
      (* jmt.!!!
      Data.Read(I, SizeOf(Integer));
      Result := TDataDispatch.Create(Self, I) as IDispatch;
      *)
    end;
    varUnknown:
      raise EInterpreterError.CreateFmt(sBadVariantType,[IntToHex(VType,4)]);
  else
    TVarData(Result).VType := VType;
    Data.Read(TVarData(Result).VPointer, VariantSize[VType and varTypeMask]);
  end;
end;

procedure TCustomDataBlockInterpreter.WriteVariant(const Value: Variant;
  const Data: IDataBlock);
var
  I, VType: Integer;
  W: WideString;
  S: AnsiString;
begin
                                                                         
  VType := VarType(Value);
  if VarIsArray(Value) then
    Assert(False, 'Arrays not supported') else{ Do not localize }
  case (VType and varTypeMask) of
    varEmpty, varNull: Data.Write(VType, SizeOf(Integer));
    varString:
    begin
      S := AnsiString(Value);
      I := Length(S);
      Data.Write(VType, SizeOf(Integer));
      Data.Write(I,SizeOf(Integer));
      Data.Write(S[1], I);
    end;
    varOleStr:
    begin
      W := WideString(Value);
      I := Length(W);
      Data.Write(VType, SizeOf(Integer));
      Data.Write(I,SizeOf(Integer));
      Data.Write(W[1], I * 2);
    end;
    varDispatch:
    begin
      Assert(False, 'varDispatch not supported'); { Do not localize }
      (* jmt.!!!
      if VType and varByRef = varByRef then
        raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
      I := StoreObject(Value);
      Data.Write(VType, SizeOf(Integer));
      Data.Write(I, SizeOf(Integer));
      *)
    end;
    varVariant:
    begin
      if VType and varByRef <> varByRef then
        raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
      I := varByRef;
      Data.Write(I, SizeOf(Integer));
      WriteVariant(Variant(TVarData(Value).VPointer^), Data);
    end;
    varUnknown:
      raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
  else
    Data.Write(VType, SizeOf(Integer));
    if VType and varByRef = varByRef then
      Data.Write(TVarData(Value).VPointer^, VariantSize[VType and varTypeMask]) else
      Data.Write(TVarData(Value).VPointer, VariantSize[VType and varTypeMask]);
  end;
end;

procedure TCustomDataBlockInterpreter.DoException(const Data: IDataBlock);
var
  VarFlags: TVarFlags;
begin
  raise Exception.Create(ReadVariant(VarFlags, Data));
end;

end.



