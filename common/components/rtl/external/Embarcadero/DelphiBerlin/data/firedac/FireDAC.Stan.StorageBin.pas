{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{        FireDAC binary streaming implementation        }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.StorageBin;

interface

uses
  System.Classes;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDStanStorageBinLink = class(TComponent)
  end;

implementation

uses
  System.SysUtils, System.TypInfo,
  Data.FMTBcd, Data.SQLTimSt, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Storage, FireDAC.Stan.SQLTimeInt,
    FireDAC.Stan.Factory, FireDAC.Stan.Error, FireDAC.Stan.Consts;

type
  TFDBinStorage = class(TFDStorage, IFDStanStorage)
  private
    FDictionary: TFDStringList;
    FDictionaryIndex: Integer;
    procedure InternalReadProperty(var AName: String);
    procedure InternalWriteProperty(const APropName: String;
      ApValue: Pointer; ALen: Cardinal);
    function InternalReadObject(var AName: String): Boolean;
    function InternalReadObjectEnd: Boolean;
    function LookupName(const AName: String): Word;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Close; override;
    function IsObjectEnd(const AObjectName: String): Boolean;
    procedure Open(AResOpts: TObject; AEncoder: TObject;
      const AFileName: String; AStream: TStream; AMode: TFDStorageMode); override;
    function ReadBoolean(const APropName: String; ADefValue: Boolean): Boolean;
    function ReadDate(const APropName: String; ADefValue: TDateTime): TDateTime;
    function ReadFloat(const APropName: String; ADefValue: Double): Double;
    function ReadInteger(const APropName: String; ADefValue: Integer): Integer;
    function ReadLongWord(const APropName: String; ADefValue: Cardinal): Cardinal;
    function ReadInt64(const APropName: String; ADefValue: Int64): Int64;
    function ReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): String; override;
    procedure ReadObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle); override;
    function ReadAnsiString(const APropName: String; const ADefValue: TFDAnsiString): TFDAnsiString;
    function ReadString(const APropName: String; const ADefValue: UnicodeString): UnicodeString;
    function ReadValue(const APropName: String; APropIndex: Word; ADataType: TFDDataType;
      out ABuff: Pointer; out ALen: Cardinal): Boolean;
    function ReadEnum(const APropName: String; ATypeInfo: PTypeInfo; ADefValue: Integer): Integer;
    function TestObject(const AObjectName: String): Boolean;
    function TestAndReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): Boolean;
    function TestProperty(const APropName: String): Boolean;
    function TestAndReadProperty(const APropName: String): Boolean;
    procedure WriteBoolean(const APropName: String; const AValue, ADefValue: Boolean);
    procedure WriteDate(const APropName: String; const AValue, ADefValue: TDateTime);
    procedure WriteFloat(const APropName: String; const AValue, ADefValue: Double);
    procedure WriteInteger(const APropName: String; const AValue, ADefValue: Integer);
    procedure WriteLongWord(const APropName: String; const AValue, ADefValue: Cardinal);
    procedure WriteInt64(const APropName: String; const AValue, ADefValue: Int64);
    procedure WriteObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle);
    procedure WriteObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
    procedure WriteAnsiString(const APropName: String; const AValue, ADefValue: TFDAnsiString);
    procedure WriteString(const APropName: String; const AValue, ADefValue: UnicodeString);
    procedure WriteValue(const APropName: String; APropIndex: Word; ADataType: TFDDataType;
      ABuff: Pointer; ALen: Cardinal);
    procedure WriteEnum(const APropName: String; ATypeInfo: PTypeInfo; const AValue,
      ADefValue: Integer);
    function GetBookmark: TObject;
    procedure SetBookmark(const AValue: TObject);
  end;

{-------------------------------------------------------------------------------}
{ TFDBinStorage                                                                 }
{-------------------------------------------------------------------------------}
type
  TFDBinStorageHeader = record
    FMagic: array[0..3] of Byte;
    FVersion: Word;
    FDictionaryOffset: Cardinal;
  end;

const
  C_Magic: array[0..3] of Byte = (Ord('A'), Ord('D'), Ord('B'), Ord('S'));
  C_ObjBegin = 255;
  C_ObjEnd = 254;

constructor TFDBinStorage.Create;
begin
  inherited Create;
  FDictionary := TFDStringList.Create(dupIgnore, False, True);
  FDictionary.UseLocale := False;
end;

{-------------------------------------------------------------------------------}
destructor TFDBinStorage.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FDictionary);
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.Open(AResOpts: TObject; AEncoder: TObject;
  const AFileName: String; AStream: TStream; AMode: TFDStorageMode);
var
  rHdr: TFDBinStorageHeader;
  iLen: Word;
  s: String;
begin
  inherited Open(AResOpts, AEncoder, AFileName, AStream, AMode);
  if FMode = smWrite then begin
    FillChar(rHdr, SizeOf(rHdr), 0);
    FStream.Write(rHdr, SizeOf(rHdr));
    FDictionary.Sorted := True;
    FDictionaryIndex := 0;
  end
  else begin
    if (FStream.Read(rHdr, SizeOf(rHdr)) <> SizeOf(rHdr)) or
       not CompareMem(@rHdr.FMagic[0], @C_Magic[0], SizeOf(C_Magic)) then
      FDException(Self, [S_FD_LStan], er_FD_StanStrgInvBinFmt, []);
    FStreamVersion := rHdr.FVersion;
    FStream.Seek(rHdr.FDictionaryOffset, soBeginning);
    FDictionary.Sorted := False;
    iLen := 0;
    while FStream.Read(iLen, SizeOf(iLen)) = SizeOf(iLen) do begin
      SetLength(s, iLen div SizeOf(WideChar));
      if iLen > 0 then
        FStream.Read(s[1], iLen);
      FDictionary.Add(s);
    end;
    FStream.Seek(SizeOf(rHdr), soBeginning);
  end;
end;

{-------------------------------------------------------------------------------}
function DoCompareObjects(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := Integer(TFDStringList(List).Ints[Index1]) -
    Integer(TFDStringList(List).Ints[Index2]);
end;

procedure TFDBinStorage.Close;
var
  i: Integer;
  iLen: Word;
  iPos: int64;
  rHdr: TFDBinStorageHeader;
  s: String;
begin
  if (FStream <> nil) and (FMode = smWrite) then begin
    iPos := FStream.Position;
    FDictionary.Sorted := False;
    FDictionary.CustomSort(DoCompareObjects);
    for i := 0 to FDictionary.Count - 1 do begin
      iLen := Word(Length(FDictionary[i]) * SizeOf(WideChar));
      FStream.Write(iLen, SizeOf(iLen));
      if iLen > 0 then begin
        s := FDictionary[i];
        FStream.Write(s[1], iLen);
      end;
    end;
    Move(C_Magic[0], rHdr.FMagic[0], SizeOf(C_Magic));
    rHdr.FVersion := FStreamVersion;
    rHdr.FDictionaryOffset := Cardinal(iPos);
    FStream.Seek(0, soBeginning);
    FStream.Write(rHdr, SizeOf(rHdr));
    FStream.Seek(0, soEnd);
  end;
  FDictionary.Clear;
  inherited Close;
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.InternalReadProperty(var AName: String);
var
  iDict: Word;
begin
  iDict := 0;
  FStream.Read(iDict, SizeOf(iDict));
  if (iDict and $FF) < C_ObjEnd then
    AName := FDictionary[iDict];
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.TestProperty(const APropName: String): Boolean;
var
  iPos: Int64;
  sName: String;
begin
  iPos := FStream.Position;
  InternalReadProperty(sName);
  Result := CompareText(sName, APropName) = 0;
  FStream.Position := iPos;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.TestAndReadProperty(const APropName: String): Boolean;
var
  iPos: Int64;
  sName: String;
begin
  iPos := FStream.Position;
  InternalReadProperty(sName);
  Result := CompareText(sName, APropName) = 0;
  if not Result then
    FStream.Position := iPos;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadBoolean(const APropName: String;
  ADefValue: Boolean): Boolean;
begin
  if TestAndReadProperty(APropName) then
    FStream.Read(Result, SizeOf(Result))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadDate(const APropName: String;
  ADefValue: TDateTime): TDateTime;
begin
  if TestAndReadProperty(APropName) then
    FStream.Read(Result, SizeOf(Result))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadEnum(const APropName: String; ATypeInfo: PTypeInfo;
  ADefValue: Integer): Integer;

  function DoReadEnum1: Integer;
  begin
    if TestAndReadProperty(APropName) then begin
      FStream.Read(Result, SizeOf(Result));
      if (FStreamVersion = 1) and (ATypeInfo = TypeInfo(TFDDataType)) then begin
        if Result >= Integer(dtXML) then
          Inc(Result);
        if Result >= Integer(dtTimeIntervalFull) then
          Inc(Result, 3);
        if Result >= Integer(dtExtended) then
          Inc(Result);
        if Result >= Integer(dtSingle) then
          Inc(Result);
      end;
    end
    else
      Result := ADefValue;
  end;

  function DoReadEnum3: Integer;
  var
    sStr: String;
  begin
    sStr := ReadString(APropName, '');
    if sStr = '' then
      Result := ADefValue
    else
      Result := GetEnumValue(ATypeInfo, Copy(
        GetCachedEnumName(ATypeInfo, Integer(ADefValue)), 1, 2) + sStr);
  end;

var
  iDict: Word;
begin
  if FStreamVersion >= 5 then begin
    if TestAndReadProperty(APropName) then begin
      FStream.Read(iDict, SizeOf(iDict));
      Result := GetEnumValue(ATypeInfo, FDictionary[iDict]);
    end
    else
      Result := ADefValue;
  end
  else if FStreamVersion >= 3 then
    Result := DoReadEnum3
  else
    Result := DoReadEnum1;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadFloat(const APropName: String;
  ADefValue: Double): Double;
begin
  if TestAndReadProperty(APropName) then
    FStream.Read(Result, SizeOf(Result))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadInteger(const APropName: String;
  ADefValue: Integer): Integer;
begin
  if TestAndReadProperty(APropName) then
    FStream.Read(Result, SizeOf(Result))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadLongWord(const APropName: String;
  ADefValue: Cardinal): Cardinal;
begin
  if TestAndReadProperty(APropName) then
    FStream.Read(Result, SizeOf(Result))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadInt64(const APropName: String; ADefValue: Int64): Int64;
begin
  if TestAndReadProperty(APropName) then
    FStream.Read(Result, SizeOf(Result))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.TestObject(const AObjectName: String): Boolean;
var
  sName: String;
  iPos: Int64;
begin
  iPos := FStream.Position;
  Result := InternalReadObject(sName);
  if Result then
    Result := CompareText(AObjectName, sName) = 0;
  FStream.Position := iPos;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.TestAndReadObjectBegin(const AObjectName: String;
  AStyle: TFDStorageObjectStyle): Boolean;
var
  sName: String;
  iPos: Int64;
begin
  iPos := FStream.Position;
  Result := InternalReadObject(sName);
  if Result then
    Result := CompareText(AObjectName, sName) = 0;
  if not Result then
    FStream.Position := iPos;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): String;
begin
  if not InternalReadObject(Result) then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, ['<unknown>']);
  if (Result <> '') and (AObjectName <> '') and (CompareText(Result, AObjectName) <> 0) then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, [AObjectName]);
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.InternalReadObject(var AName: String): Boolean;
var
  b: Byte;
  iDict: Byte;
begin
  Result := (FStream.Read(b, SizeOf(Byte)) = SizeOf(Byte)) and (b = C_ObjBegin);
  if Result then begin
    FStream.Read(iDict, SizeOf(iDict));
    AName := FDictionary[iDict];
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.InternalReadObjectEnd: Boolean;
var
  b: Byte;
begin
  Result := (FStream.Read(b, SizeOf(Byte)) = SizeOf(Byte)) and (b = C_ObjEnd);
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.IsObjectEnd(const AObjectName: String): Boolean;
var
  iPos: Int64;
begin
  iPos := FStream.Position;
  Result := InternalReadObjectEnd;
  FStream.Position := iPos;
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.ReadObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
begin
  InternalReadObjectEnd;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadAnsiString(const APropName: String;
  const ADefValue: TFDAnsiString): TFDAnsiString;
var
  iLen: Cardinal;
begin
  if TestAndReadProperty(APropName) then begin
    FStream.Read(iLen, SizeOf(iLen));
    SetLength(Result, iLen div SizeOf(TFDAnsiChar));
    if iLen <> 0 then
      FStream.Read(PFDAnsiString(Result)^, iLen);
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadString(const APropName: String;
  const ADefValue: UnicodeString): UnicodeString;
var
  iLen: Cardinal;
begin
  if TestAndReadProperty(APropName) then begin
    FStream.Read(iLen, SizeOf(iLen));
    SetLength(Result, iLen div SizeOf(WideChar));
    if iLen <> 0 then
      FStream.Read(Result[1], iLen);
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.ReadValue(const APropName: String; APropIndex: Word;
  ADataType: TFDDataType; out ABuff: Pointer; out ALen: Cardinal): Boolean;
var
  oMS: TMemoryStream;
  iProp: Word;
  iLen: Byte;
  iBmk: Int64;
begin
  ABuff := nil;
  ALen := 0;
  Result := False;
  if FStreamVersion >= 4 then begin
    iBmk := FStream.Position;
    FStream.Read(iProp, SizeOf(iProp));
    if iProp <> APropIndex then begin
      FStream.Position := iBmk;
      Exit;
    end;
  end
  else begin
    if not TestAndReadProperty(APropName) then
      Exit;
  end;
  Result := True;
  case ADataType of
  dtObject,
  dtRowSetRef,
  dtCursorRef,
  dtRowRef,
  dtArrayRef:
    ALen := 0;
  dtMemo,
  dtHMemo,
  dtWideMemo,
  dtXML,
  dtWideHMemo,
  dtByteString,
  dtBlob,
  dtHBlob,
  dtHBFile,
  dtAnsiString,
  dtWideString:
    FStream.Read(ALen, SizeOf(Cardinal));
  dtBoolean:
    ALen := SizeOf(WordBool);
  dtSByte:
    ALen := SizeOf(ShortInt);
  dtInt16:
    ALen := SizeOf(SmallInt);
  dtInt32:
    ALen := SizeOf(Integer);
  dtInt64:
    ALen := SizeOf(Int64);
  dtByte:
    ALen := SizeOf(Byte);
  dtUInt16:
    ALen := SizeOf(Word);
  dtUInt32,
  dtParentRowRef:
    ALen := SizeOf(Cardinal);
  dtUInt64:
    ALen := SizeOf(UInt64);
  dtSingle:
    ALen := SizeOf(Single);
  dtDouble:
    ALen := SizeOf(Double);
  dtExtended:
    begin
      ALen := SizeOf(Extended);
{$IF SizeOf(Extended) = 8}
      oMS := CheckBuffer(SizeOf(TExtended80Rec));
      ABuff := oMS.Memory;
      FStream.Read(ABuff^, SizeOf(TExtended80Rec));
      PExtended(ABuff)^ := Extended(PExtended80Rec(ABuff)^);
      Exit;
{$ENDIF}
    end;
  dtCurrency:
    ALen := SizeOf(Currency);
  dtBCD,
  dtFmtBCD:
    if FStreamVersion >= 4 then begin
      FStream.Read(iLen, SizeOf(iLen));
      ALen := SizeOf(TBcd);
      oMS := CheckBuffer(ALen);
      ABuff := oMS.Memory;
      if iLen <> 0 then
        FStream.Read(ABuff^, iLen);
      FillChar((PByte(ABuff) + iLen)^, ALen - iLen, 0);
      Exit;
    end
    else
      ALen := SizeOf(TBcd);
  dtDateTime:
    ALen := SizeOf(TDateTimeAlias);
  dtDateTimeStamp:
    ALen := SizeOf(TSQLTimeStamp);
  dtTimeIntervalFull,
  dtTimeIntervalYM,
  dtTimeIntervalDS:
    ALen := SizeOf(TFDSQLTimeInterval);
  dtTime,
  dtDate:
    ALen := SizeOf(Integer);
  dtGUID:
    ALen := SizeOf(TGUID);
  end;
  oMS := CheckBuffer(ALen);
  if ALen <> 0 then
    FStream.Read(oMS.Memory^, ALen);
  ABuff := oMS.Memory;
  if ADataType in [dtWideMemo, dtXML, dtWideHMemo, dtWideString] then
    ALen := ALen div SizeOf(WideChar);
end;

{-------------------------------------------------------------------------------}
function TFDBinStorage.LookupName(const AName: String): Word;
var
  i: Integer;
begin
  i := FDictionary.IndexOf(AName);
  if i = -1 then begin
    if FDictionaryIndex >= $FFFF then
      FDException(Self, [S_FD_LStan], er_FD_StanStrgDictOverflow, []);
    FDictionary.AddInt(AName, LongWord(FDictionaryIndex));
    Result := Word(FDictionaryIndex);
    Inc(FDictionaryIndex);
    if FDictionaryIndex = C_ObjEnd then begin
      LookupName('<end>');
      LookupName('<begin>');
    end;
  end
  else
    Result := Word(LongWord(FDictionary.Ints[i]));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.InternalWriteProperty(const APropName: String;
  ApValue: Pointer; ALen: Cardinal);
var
  iDict: Word;
begin
  iDict := LookupName(APropName);
  FStream.Write(iDict, SizeOf(iDict));
  if ApValue <> nil then
    FStream.Write(ApValue^, ALen);
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteBoolean(const APropName: String; const AValue,
  ADefValue: Boolean);
begin
  if AValue <> ADefValue then
    InternalWriteProperty(APropName, @AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteDate(const APropName: String; const AValue,
  ADefValue: TDateTime);
begin
  if AValue <> ADefValue then
    InternalWriteProperty(APropName, @AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteEnum(const APropName: String; ATypeInfo: PTypeInfo;
  const AValue, ADefValue: Integer);

  procedure DoWriteEnum1;
  var
    iVal: Integer;
  begin
    iVal := AValue;
    if (FStreamVersion = 1) and (ATypeInfo = TypeInfo(TFDDataType)) then begin
      if iVal > Integer(dtWideMemo) then
        Dec(iVal);
      if iVal > Integer(dtDateTimeStamp) then
        Dec(iVal, 3);
    end;
    InternalWriteProperty(APropName, @iVal, SizeOf(iVal));
  end;

  procedure DoWriteEnum3;
  begin
    WriteString(APropName, Copy(GetCachedEnumName(ATypeInfo, AValue), 3, MAXINT),
      Copy(GetCachedEnumName(ATypeInfo, ADefValue), 3, MAXINT))
  end;

var
  iDict: Word;
begin
  if AValue <> ADefValue then
    if FStreamVersion >= 5 then begin
      iDict := LookupName(GetCachedEnumName(ATypeInfo, AValue));
      InternalWriteProperty(APropName, @iDict, SizeOf(iDict));
    end
    else if FStreamVersion >= 3 then
      DoWriteEnum3()
    else
      DoWriteEnum1();
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteFloat(const APropName: String; const AValue,
  ADefValue: Double);
begin
  if AValue <> ADefValue then
    InternalWriteProperty(APropName, @AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteInteger(const APropName: String; const AValue,
  ADefValue: Integer);
begin
  if AValue <> ADefValue then
    InternalWriteProperty(APropName, @AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteLongWord(const APropName: String;
  const AValue, ADefValue: Cardinal);
var
  uiVal: Cardinal;
begin
  if AValue <> ADefValue then begin
    uiVal := AValue;
    InternalWriteProperty(APropName, @uiVal, SizeOf(uiVal));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteInt64(const APropName: String; const AValue,
  ADefValue: Int64);
begin
  if AValue <> ADefValue then
    InternalWriteProperty(APropName, @AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle);
var
  b: Byte;
  iDict: Byte;
begin
  b := C_ObjBegin;
  FStream.Write(b, SizeOf(Byte));
  iDict := LookupName(AObjectName);
  FStream.Write(iDict, SizeOf(iDict));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
var
  b: Byte;
begin
  b := C_ObjEnd;
  FStream.Write(b, SizeOf(Byte));
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteAnsiString(const APropName: String; const AValue,
  ADefValue: TFDAnsiString);
var
  iLen: Cardinal;
begin
  if AValue <> ADefValue then begin
    InternalWriteProperty(APropName, nil, 0);
    iLen := Length(AValue) * SizeOf(TFDAnsiChar);
    FStream.Write(iLen, SizeOf(iLen));
    if iLen <> 0 then
      FStream.Write(PFDAnsiString(AValue)^, iLen);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteString(const APropName: String;
  const AValue, ADefValue: UnicodeString);
var
  iLen: Cardinal;
begin
  if AValue <> ADefValue then begin
    InternalWriteProperty(APropName, nil, 0);
    iLen := Length(AValue) * SizeOf(WideChar);
    FStream.Write(iLen, SizeOf(iLen));
    if iLen <> 0 then
      FStream.Write(AValue[1], iLen);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.WriteValue(const APropName: String; APropIndex: Word;
  ADataType: TFDDataType; ABuff: Pointer; ALen: Cardinal);
var
  iLen: Byte;
{$IF SizeOf(Extended) = 8}
  rExt80: TExtended80Rec;
{$ENDIF}
begin
  if ABuff = nil then
    Exit;
  if FStreamVersion >= 4 then
    FStream.Write(APropIndex, SizeOf(APropIndex))
  else
    InternalWriteProperty(APropName, nil, 0);
  case ADataType of
  dtObject,
  dtRowSetRef,
  dtCursorRef,
  dtRowRef,
  dtArrayRef:
    ;
  dtMemo,
  dtHMemo,
  dtWideMemo,
  dtXML,
  dtWideHMemo,
  dtByteString,
  dtBlob,
  dtHBlob,
  dtHBFile,
  dtAnsiString,
  dtWideString:
    begin
      if ADataType in [dtWideMemo, dtXML, dtWideHMemo, dtWideString] then
        ALen := ALen * SizeOf(WideChar);
      FStream.Write(ALen, SizeOf(ALen));
      FStream.Write(ABuff^, ALen);
    end;
  dtBCD,
  dtFmtBCD:
    if FStreamVersion >= 4 then begin
      iLen := 2 + (PBcd(ABuff)^.Precision + 1) div 2;
      FStream.Write(iLen, SizeOf(iLen));
      FStream.Write(ABuff^, iLen);
    end
    else
      FStream.Write(ABuff^, ALen);
{$IF SizeOf(Extended) = 8}
  dtExtended:
    begin
      rExt80 := TExtended80Rec(PExtended(ABuff)^);
      FStream.Write(rExt80, SizeOf(rExt80));
    end;
{$ENDIF}
  else
    FStream.Write(ABuff^, ALen);
  end;
end;

{-------------------------------------------------------------------------------}
type
  TFDBinStorageBmk = class(TObject)
  private
    FPos: Int64;
  end;

function TFDBinStorage.GetBookmark: TObject;
begin
  Result := TFDBinStorageBmk.Create;
  TFDBinStorageBmk(Result).FPos := FStream.Position;
end;

{-------------------------------------------------------------------------------}
procedure TFDBinStorage.SetBookmark(const AValue: TObject);
begin
  FStream.Position := TFDBinStorageBmk(AValue).FPos;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDBinStorage, IFDStanStorage,
    'BIN;.FDS;.FDB;.BIN;.DAT;');

finalization
  FDReleaseFactory(oFact);

end.
