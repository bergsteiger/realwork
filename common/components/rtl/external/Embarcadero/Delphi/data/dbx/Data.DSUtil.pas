{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DSUtil;

interface

uses
  System.Classes
;

// Conversion functions for DBX DataSnap support

procedure StrListToVarArray(const StrList: string; out VarArray: OleVariant);
procedure VarArrayToStrings(const VarData: OleVariant; List: TStrings);

procedure VariantToStream(const VariantValue: OleVariant; const Stream: TStream);
procedure StreamToVariant(const Stream: TStream; out VariantValue: OleVariant);

implementation

uses
  System.Variants,
  System.VarUtils,
  System.SysUtils,
  Data.DBXCommonResStrs
;

type
  THeader = class
  const
    Empty = 1;
    Variant = 2;
    DataPacket = 3;
  end;

{ TVariantStreamer }
{ Code copied, and slightly modifed, from db\SConnect.pas }

  TVarFlag = (vfByRef, vfVariant);
  TVarFlags = set of TVarFlag;

  EInterpreterError = class(Exception);

  TVariantStreamer = class
  private
    class function ReadArray(VType: Integer; const Data: TStream): OleVariant;
    class procedure WriteArray(const Value: OleVariant; const Data: TStream);
  public
    class function ReadVariant(out Flags: TVarFlags; const Data: TStream): OleVariant;
    class procedure WriteVariant(const Value: OleVariant; const Data: TStream);
  end;


const

  EasyArrayTypes = [varSmallInt, varInteger, varSingle, varDouble, varCurrency,
                    varDate, varBoolean, varShortInt, varByte, varWord, varLongWord];

  VariantSize: array[0..varLongWord] of Word  = (0, 0, SizeOf(SmallInt), SizeOf(Integer),
    SizeOf(Single), SizeOf(Double), SizeOf(Currency), SizeOf(TDateTime), 0, 0,
    SizeOf(Integer), SizeOf(WordBool), 0, 0, 0, 0, SizeOf(ShortInt), SizeOf(Byte),
    SizeOf(Word), SizeOf(LongWord));

class function TVariantStreamer.ReadArray(VType: Integer; const Data: TStream): OleVariant;
var
  Flags: TVarFlags;
  Bounds, HiDim, Indices, LoDim: array of Integer;
  PIndices: PVarArrayCoorArray;
  DimCount, I, VSize: Integer;
  V: OleVariant;
  LSafeArray: PVarArray;
  P: Pointer;
begin
  VarClear(Result);
  Data.Read(DimCount, SizeOf(DimCount));
  VSize := DimCount * SizeOf(Integer);
  SetLength(LoDim,DimCount);
  try
    SetLength(HiDim,DimCount);
    try
      Data.Read(LoDim[0], VSize);
      Data.Read(HiDim[0], VSize);
      SetLength(Bounds, DimCount * 2);
      try
        for I := 0 to DimCount - 1 do
        begin
          Bounds[I * 2] := LoDim[I];
          Bounds[I * 2 + 1] := HiDim[I];
        end;
        Result := VarArrayCreate(Bounds, VType and varTypeMask);
      finally
        Finalize(Bounds);
      end;
      if VType and varTypeMask in EasyArrayTypes then
      begin
        Data.Read(VSize, SizeOf(VSize));
        P := VarArrayLock(Result);
        try
          Data.Read(P^, VSize);
        finally
          VarArrayUnlock(Result);
        end;
      end else
      begin
        LSafeArray := TVarData(Result).VArray; // PSafeArray(TVarData(Result).VArray);
        SetLength(Indices,DimCount);
        try
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          PIndices := @Indices[0];
          while True do
          begin
            V := ReadVariant(Flags, Data);
            if VType and varTypeMask = varVariant then
              SafeArrayCheck(SafeArrayPutElement(LSafeArray, PIndices, @V))
            else
              SafeArrayCheck(SafeArrayPutElement(LSafeArray, PIndices, TVarData(V).VPointer));
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for I := DimCount - 1 downto 0 do
                if Indices[I] > HiDim[I] then
                begin
                  if I = 0 then Exit;
                  Inc(Indices[I - 1]);
                  Indices[I] := LoDim[I];
                end;
          end;
        finally
          Finalize(Indices);
        end;
      end;
    finally
      Finalize(HiDim);
    end;
  finally
    Finalize(LoDim);
  end;
end;

class function TVariantStreamer.ReadVariant(out Flags: TVarFlags; const Data: TStream): OleVariant;
var
  I, VType: Integer;
{$IFNDEF NEXTGEN}
  W: WideString;
{$ELSE}
  W: string;
{$ENDIF !NEXTGEN}
  ByteArray: TArray<Byte>;
  TmpFlags: TVarFlags;
begin
  VarClear(Result);
  Flags := [];
  Data.Read(VType, SizeOf(VType));
  if VType and varByRef = varByRef then
    Include(Flags, vfByRef);
  if VType = varByRef then
  begin
    Include(Flags, vfVariant);
    Result := ReadVariant(TmpFlags, Data);
    Exit;
  end;
  if vfByRef in Flags then
    VType := VType xor varByRef;
  if (VType and varArray) = varArray then
    Result := ReadArray(VType, Data)
  else
    case VType and varTypeMask of
      varEmpty: VarClear(Result);
      varNull: Result := NULL;
      varOleStr:
      begin
        Data.Read(I, SizeOf(Integer));
        SetLength(ByteArray, I * SizeOf(Char));
        Data.Read(ByteArray[0], I * SizeOf(Char));
        W := TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(ByteArray), I);
        Result := W;
      end;
      varDispatch, varUnknown:
        raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
    else
      TVarData(Result).VType := VType;
      Data.Read(TVarData(Result).VPointer, VariantSize[VType and varTypeMask]);
    end;
end;

class procedure TVariantStreamer.WriteArray(const Value: OleVariant; const Data: TStream);
var
  LVarData: TVarData;
  DimCount, ElemSize, I, VSize, VType: Integer;
  LSafeArray: PVarArray;
  LoDim, HiDim, Indices: array of Integer;
  PIndices: PVarArrayCoorArray;
  V: OleVariant;
  P: Pointer;
begin
  LVarData := FindVarData(Value)^;
  VType := LVarData.VType;
  LSafeArray := PVarArray(LVarData.VPointer);

  Data.Write(VType, SizeOf(Integer));
  DimCount := VarArrayDimCount(Value);
  Data.Write(DimCount, SizeOf(DimCount));
  VSize := SizeOf(Integer) * DimCount;
  SetLength(LoDim, DimCount);
  try
    SetLength(HiDim, DimCount);
    try
      for I := 1 to DimCount do
      begin
        LoDim[I - 1] := VarArrayLowBound(Value, I);
        HiDim[I - 1] := VarArrayHighBound(Value, I);
      end;
      Data.Write(LoDim[0],VSize);
      Data.Write(HiDim[0],VSize);
      if VType and varTypeMask in EasyArrayTypes then
      begin
        ElemSize := SafeArrayGetElemSize(LSafeArray);
        VSize := 1;
        for I := 0 to DimCount - 1 do
          VSize := (HiDim[I] - LoDim[I] + 1) * VSize;
        VSize := VSize * ElemSize;
        P := VarArrayLock(Value);
        try
          Data.Write(VSize, SizeOf(VSize));
          Data.Write(P^,VSize);
        finally
          VarArrayUnlock(Value);
        end;
      end else
      begin
        SetLength(Indices, DimCount);
        try
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          PIndices := @Indices[0];
          while True do
          begin
            if VType and varTypeMask <> varVariant then
            begin
              SafeArrayCheck(SafeArrayGetElement(LSafeArray, PIndices, TVarData(V).VPointer));
              TVarData(V).VType := VType and varTypeMask;
            end else
              SafeArrayCheck(SafeArrayGetElement(LSafeArray, PIndices, @V));
            try
              WriteVariant(V, Data);
            finally
              VarClear(V);
            end;
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for I := DimCount - 1 downto 0 do
                if Indices[I] > HiDim[I] then
                begin
                  if I = 0 then Exit;
                  Inc(Indices[I - 1]);
                  Indices[I] := LoDim[I];
                end;
          end;
        finally
          Finalize(Indices);
        end;
      end;
    finally
      Finalize(HiDim);
    end;
  finally
    Finalize(LoDim);
  end;
end;

class procedure TVariantStreamer.WriteVariant(const Value: OleVariant; const Data: TStream);
var
  I, VType: Integer;
  ByteArray: TArray<Byte>;
begin
  VType := VarType(Value);
  if VType and varArray <> 0 then
    WriteArray(Value, Data)
  else
    case (VType and varTypeMask) of
      varEmpty, varNull:
        Data.Write(VType, SizeOf(Integer));
      varOleStr:
      begin
        ByteArray := TEncoding.Unicode.GetBytes(Value);
        I := Length(ByteArray) div SizeOf(Char);
        Data.Write(VType, SizeOf(Integer));
        Data.Write(I,SizeOf(Integer));
        Data.Write(ByteArray[0], I * SizeOf(Char));
      end;
      varVariant:
      begin
        if VType and varByRef <> varByRef then
          raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
        I := varByRef;
        Data.Write(I, SizeOf(Integer));
        WriteVariant(Variant(TVarData(Value).VPointer^), Data);
      end;
      varDispatch,
      varUnknown:
        raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
    else
      Data.Write(VType, SizeOf(Integer));
      if VType and varByRef = varByRef then
        Data.WriteData(TVarData(Value).VPointer, VariantSize[VType and varTypeMask])
      else
        Data.WriteData(@(TVarData(Value).VPointer), VariantSize[VType and varTypeMask]);
    end;
end;

// String Lists

procedure StrListToVarArray(const StrList: string; out VarArray: OleVariant);
  // From Datasnap.Provider.pas
  function VarArrayFromStrings(Strings: TStrings): Variant;
  var
    I: Integer;
  begin
    Result := Null;
    if Strings.Count > 0 then
    begin
      Result := VarArrayCreate([0, Strings.Count - 1], varOleStr);
{$IFNDEF NEXTGEN}
      for I := 0 to Strings.Count - 1 do Result[I] := WideString(Strings[I]);
{$ELSE}
      for I := 0 to Strings.Count - 1 do Result[I] := Strings[I];
{$ENDIF !NEXTGEN}
    end;
  end;
var
  List: TStringList;
begin
  if StrList <> '' then
  begin
    List := TStringList.Create;
    try
      List.StrictDelimiter := True;
      List.CommaText := StrList;
      VarArray := VarArrayFromStrings(List);
    finally
      List.Free;
    end
  end
  else
    VarArray := Null;
end;

procedure VarArrayToStrings(const VarData: OleVariant; List: TStrings);
var
  I, LowBound, HighBound: Integer;
begin
  List.BeginUpdate;
  try
    List.Clear;
    if VarIsArray(VarData) and (VarArrayDimCount(VarData) = 1) then
    begin
      LowBound := VarArrayLowBound(VarData, 1);
      HighBound := VarArrayHighBound(VarData, 1);
      List.Capacity := HighBound - LowBound + 1;
      for I := LowBound to HighBound do
        List.Add(VarData[I]);
    end;
  finally
    List.EndUpdate;
  end;
end;


// DataPacket

procedure DataPacketToStream(const DataPacket: OleVariant; const Stream: TStream);
var
  P: Pointer;
  Size: Int64;
begin
  if not (VarIsNull(DataPacket) or VarIsEmpty(DataPacket)) then
  begin
    Size := VarArrayHighBound(DataPacket, 1) - VarArrayLowBound(DataPacket, 1) + 1;
    TMemoryStream(Stream).SetSize(Size+8+Stream.Position);
    Stream.Write(Size, 8);
    P := VarArrayLock(DataPacket);
    try
      Stream.Write(P^, Size);
    finally
      VarArrayUnlock(DataPacket);
    end;
  end else
  begin
    Size := 0;
    Stream.Write(Size, 8);
  end;
end;


procedure StreamToDataPacket(const Stream: TStream; out VarBytes: OleVariant);
var
  P: Pointer;
  ByteCount: Integer;
  Size: Int64;
begin
  Stream.Read(Size, 8);
  ByteCount := Integer(Size);
  if ByteCount > 0 then
  begin
    VarBytes := VarArrayCreate([0, ByteCount-1], varByte);
    P := VarArrayLock(VarBytes);
    try
      Stream.Read(P^, ByteCount);
      Stream.Position := 0;
    finally
      VarArrayUnlock(VarBytes);
    end;
  end
  else
    VarBytes := Null;
end;

procedure VariantToStream(const VariantValue: OleVariant; const Stream: TStream);
var
  VType:  Integer;
  Header: Byte;
begin
  Stream.Position := 0;
  VType := VarType(VariantValue);
  if VType and (varArray or varByte) = (varArray or varByte) then
  begin
    Header := Byte(THeader.DataPacket);
    Stream.Write(Header, 1);
    DataPacketToStream(VariantValue, Stream);
  end else
  begin
    Header := Byte(THeader.Variant);
    Stream.Write(Header, 1);
    Assert(Stream.Position = 1);
    TVariantStreamer.WriteVariant(VariantValue, Stream);
    if Stream.Position = 1 then
    begin
      Stream.Position := 0;
      Header := Byte(THeader.Empty);
      Stream.Write(Header, 1);
    end;
  end;
  Stream.Position := 0;
end;

procedure StreamToVariant(const Stream: TStream; out VariantValue: OleVariant);
var
  Flags: TVarFlags;
  Header: Byte;
begin
  if Assigned(Stream) then
  begin
    Stream.Position := 0;
    Stream.Read(Header, 1);
    if Header = THeader.Variant then
      VariantValue := TVariantStreamer.ReadVariant(Flags, Stream)
    else if Header = THeader.DataPacket then
      StreamToDataPacket(Stream, VariantValue)
    else
      Assert(false);
  end;
end;

end.

