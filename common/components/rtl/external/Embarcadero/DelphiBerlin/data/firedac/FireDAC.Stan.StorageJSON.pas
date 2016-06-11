{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC JSON streaming implementation        }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.StorageJSON;

interface

uses
  System.Classes;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDStanStorageJSONLink = class(TComponent)
  end;

implementation

uses
  System.SysUtils, System.TypInfo, System.DateUtils,
  Data.FMTBcd, Data.SQLTimSt, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Storage, FireDAC.Stan.SQLTimeInt,
    FireDAC.Stan.Factory, FireDAC.Stan.Error, FireDAC.Stan.Consts;

type
  TFDJSONState = record
    FFirst: Boolean;
    FStyle: TFDStorageObjectStyle;
  end;

  TFDJSONToken = (jtEOF, jtPairSep, jtValSep, jtObjBegin, jtObjEnd, jtArrBegin,
    jtArrEnd, jtTrue, jtFalse, jtNull, jtString, jtNumber);

  TFDJSONStorage = class(TFDStorage, IFDStanStorage)
  private
    FStack: array of TFDJSONState;
    FStackIndex: Integer;
    FToken: TFDJSONToken;
    FTokenString: String;
    FReader: TBytes;
    FReaderCur,
    FReaderTop: PByte;
    FReaderSize: Integer;
    procedure AddToStack(AFirst: Boolean; AStyle: TFDStorageObjectStyle);
    procedure RemFromStack;
    procedure WriteStringBase(ApStr: PChar; ALen: Integer; AQuote: Boolean);
    procedure AddAttribute(const AAttrName: String; ApVal: PChar; ALen: Integer;
      AQuote: Boolean); overload;
    procedure AddAttribute(const AAttrName, AValue: String; AQuote: Boolean); overload; inline;
    procedure WritePairSep;
    procedure WriteValSep; inline;
    procedure WriteFmt;
    procedure NextToken;
    procedure ErrInvalidFormat;
    function InternalReadProperty(const APropName: String): Boolean;
    procedure InternalReadPropertyValue;
    function InternalReadObject(out AName: String): Boolean;
    function InternalReadObjectEnd: Boolean;
    function ReadByte(var AByte: Byte): Boolean;
    procedure ReadBack;
    function GetReadPos: Int64;
    procedure SetReadPos(AValue: Int64);
  public
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

const
  C_Class: String = 'class';
  C_Bools: array[Boolean] of String = ('false', 'true');
  C_PairSep: Byte = Ord(',');
  C_ValSep: Byte = Ord(':');
  C_ObjBegin: Byte = Ord('{');
  C_ObjEnd: Byte = Ord('}');
  C_ArrBegin: Byte = Ord('[');
  C_ArrEnd: Byte = Ord(']');
  C_Indent: array[0 .. 1] of Byte = (Ord(' '), Ord(' '));
var
  C_EOL: array of Byte;

{-------------------------------------------------------------------------------}
{ TFDJSONStorage                                                                }
{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.ErrInvalidFormat;
begin
  FDException(Self, [S_FD_LStan], er_FD_StanStrgInvJSONFmt, [GetReadPos]);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.Open(AResOpts: TObject; AEncoder: TObject;
  const AFileName: String; AStream: TStream; AMode: TFDStorageMode);
const
  C_UTF8: array [0 .. 2] of Byte = ($EF, $BB, $BF);
var
  aUtf8: array [0 .. 2] of Byte;
  iPos: Int64;
begin
  inherited Open(AResOpts, AEncoder, AFileName, AStream, AMode);
  if FStreamVersion < 11 then
    ErrInvalidFormat;
  if AMode = smWrite then begin
    SetLength(FStack, 0);
    FStackIndex := -1;
    if (AFileName <> '') and (AStream = nil) then
      FStream.Write(C_UTF8[0], SizeOf(C_UTF8));
    FStream.Write(C_ObjBegin, 1);
    WriteObjectBegin('FDBS', osObject);
    WriteInteger('Version', GetStreamVersion, -1);
  end
  else begin
    SetLength(FReader, 1024);
    FReaderSize := 0;
    FReaderCur := PByte(FReader);
    FReaderTop := nil;
    if (AFileName <> '') and (AStream = nil) then begin
      iPos := FStream.Position;
      FStream.Read(aUtf8[0], SizeOf(aUtf8));
      if not CompareMem(@aUtf8[0], @C_UTF8[0], SizeOf(aUtf8)) then
        FStream.Position := iPos;
    end;
    NextToken;
    if FToken <> jtObjBegin then
      ErrInvalidFormat;
    if TestObject('FDBS') then begin
      ReadObjectBegin('FDBS', osObject);
      FStreamVersion := ReadInteger('Version', C_FD_StorageVer);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.Close;
begin
  if IsOpen then
    try
      if FMode = smWrite then begin
        WriteObjectEnd('FDBS', osObject);
        FStream.Write(C_ObjEnd, 1);
      end
      else if TestObject('FDBS') then begin
        ReadObjectEnd('FDBS', osObject);
        NextToken;
        if FToken <> jtObjEnd then
          ErrInvalidFormat;
      end;
    finally
      inherited Close;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadByte(var AByte: Byte): Boolean;
begin
  if FReaderCur < FReaderTop then begin
    Result := True;
    AByte := FReaderCur^;
    Inc(FReaderCur);
  end
  else begin
    FReaderSize := FStream.Read(FReader, Length(FReader));
    FReaderCur := PByte(FReader);
    FReaderTop := FReaderCur + FReaderSize;
    Result := FReaderSize > 0;
    if Result then
      Result := ReadByte(AByte)
    else
      AByte := 0;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.ReadBack;
begin
  if FReaderCur > PByte(FReader) then
    Dec(FReaderCur);
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.GetReadPos: Int64;
begin
  Result := (FStream.Position - FReaderSize) + (FReaderCur - PByte(FReader));
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.SetReadPos(AValue: Int64);
begin
  if (AValue < FStream.Position - FReaderSize) or (AValue > FStream.Position) then begin
    FStream.Position := AValue;
    FReaderSize := 0;
    FReaderCur := PByte(FReader);
    FReaderTop := nil;
  end
  else
    FReaderCur := PByte(FReader) + AValue - (FStream.Position - FReaderSize);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.NextToken;
var
  b: Byte;

  function HexToDec(const AValue: Byte): Integer;
  begin
    if AValue > Ord('9') then
      if AValue > Ord('F') then
        Exit(AValue - Ord('a') + 10)
      else
        Exit(AValue - Ord('A') + 10)
    else
      Exit(AValue - Ord('0'));
  end;

  procedure ExtractString;
  var
    oMS: TMemoryStream;
    pRes: PChar;
    c: Char;
    b: Byte;
    w: Word;
    iPos: Integer;
    pTop: PByte;
  begin
    oMS := CheckBuffer(1024);
    pRes := PChar(oMS.Memory);
    pTop := PByte(oMS.Memory) + oMS.Size;
    while ReadByte(b) and (b <> Ord('"')) do begin
      c := Char(b);
      if c = '\' then begin
        if not ReadByte(b) then
          ErrInvalidFormat;
        case b of
          Ord('"'):
            c := '"';
          Ord('\'):
            c := '\';
          Ord('b'):
            c := #$8;
          Ord('f'):
            c := #$c;
          Ord('n'):
            c := #$a;
          Ord('r'):
            c := #$d;
          Ord('t'):
            c := #$9;
          Ord('u'):
            begin
              ReadByte(b);
              c := Char(HexToDec(b) shl 12);
              ReadByte(b);
              c := Char(Ord(c) or (HexToDec(b) shl 8));
              ReadByte(b);
              c := Char(Ord(c) or (HexToDec(b) shl 4));
              ReadByte(b);
              c := Char(Ord(c) or HexToDec(b));
            end;
          else
            ErrInvalidFormat;
        end;
      end
      else if (Ord(c) and $80) <> 0 then begin
        w := b and $3F;
        if (w and $20) <> 0 then begin
          if not ReadByte(b) then
            ErrInvalidFormat;
          if (b and $C0) <> $80 then
            ErrInvalidFormat;
          w := (w shl 6) or (b and $3F);
        end;
        if not ReadByte(b) then
          ErrInvalidFormat;
        if (b and $C0) <> $80 then
          ErrInvalidFormat;
        c := WideChar((w shl 6) or (b and $3F));
      end;
      pRes^ := c;
      Inc(pRes);
      if PByte(pRes) >= pTop then begin
        iPos := NativeUInt(pRes) - NativeUInt(oMS.Memory);
        oMS := CheckBuffer(oMS.Size * 2);
        pTop := PByte(oMS.Memory) + oMS.Size;
        pRes := PChar(PByte(oMS.Memory) + iPos);
      end;
    end;
    if b <> Ord('"') then
      ErrInvalidFormat;
    SetString(FTokenString, PChar(oMS.Memory), (NativeUInt(pRes) - NativeUInt(oMS.Memory)) div SizeOf(Char));
  end;

  procedure ExtractMatch(const AMatch: String);
  var
    i: Integer;
    b: Byte;
  begin
    for i := 1 to Length(AMatch) do
      if not ReadByte(b) or (AMatch[i] <> Char(b)) then
        ErrInvalidFormat;
  end;

  procedure ExtractNumber(b: Byte);
  var
    oMS: TMemoryStream;
    pRes: PChar;
    c: Char;
  begin
    oMS := CheckBuffer(1024);
    pRes := PChar(oMS.Memory);
    repeat
      c := Char(b);
      pRes^ := c;
      Inc(pRes);
    until not ReadByte(b) or
          not (b in [Ord('0') .. Ord('9'), Ord('-'), Ord('+'), Ord('.'), Ord('e'), Ord('E')]);
    if b <> 0 then
      ReadBack;
    SetString(FTokenString, PChar(oMS.Memory), (NativeUInt(pRes) - NativeUInt(oMS.Memory)) div SizeOf(Char));
  end;

  procedure SkipWS;
  begin
    FToken := jtEOF;
    while ReadByte(b) and (b in [Ord(' '), Ord(#$9), Ord(#$a), Ord(#$d)]) do
      ;
    if b <> 0 then begin
      ReadBack;
      NextToken;
    end;
  end;

begin
  FTokenString := '';
  if not ReadByte(b) then
    FToken := jtEOF
  else
    case b of
      Ord('{'):
        FToken := jtObjBegin;
      Ord('}'):
        FToken := jtObjEnd;
      Ord('"'):
        begin
          FToken := jtString;
          ExtractString;
        end;
      Ord(':'):
        FToken := jtValSep;
      Ord(','):
        FToken := jtPairSep;
      Ord('['):
        FToken := jtArrBegin;
      Ord(']'):
        FToken := jtArrEnd;
      Ord('t'):
        begin
          FToken := jtTrue;
          ExtractMatch('rue');
        end;
      Ord('f'):
        begin
          FToken := jtFalse;
          ExtractMatch('alse');
        end;
      Ord('n'):
        begin
          FToken := jtNull;
          ExtractMatch('ull');
        end;
      Ord('0') .. Ord('9'),
      Ord('-'),
      Ord('+'),
      Ord('.'),
      Ord('e'),
      Ord('E'):
        begin
          FToken := jtNumber;
          ExtractNumber(b);
        end;
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):
        SkipWS;
      else
        ErrInvalidFormat;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.InternalReadProperty(const APropName: String): Boolean;
begin
  NextToken;
  if FToken = jtPairSep then
    NextToken;
  Result := (FToken = jtString) and (CompareText(FTokenString, APropName) = 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.InternalReadPropertyValue;
begin
  NextToken;
  if FToken <> jtValSep then
    ErrInvalidFormat;
  NextToken;
end;

{-------------------------------------------------------------------------------}
(*
  1  , {
  2  , { class : ObjName
  3  , ObjName : {
  4  , ObjName : [
  5  , [
*)
function TFDJSONStorage.InternalReadObject(out AName: String): Boolean;
var
  iPos: Int64;
begin
  Result := False;
  NextToken;
  if FToken = jtPairSep then
    NextToken;
  case FToken of
    jtObjBegin:
      begin
        iPos := GetReadPos;
        NextToken;
        if (FToken = jtString) and (CompareText(FTokenString, C_Class) = 0) then begin
          NextToken;
          if FToken = jtValSep then begin
            NextToken;
            if FToken = jtString then begin
              AName := FTokenString;
              Result := True;
            end;
          end;
        end
        else begin
          SetReadPos(iPos);
          Result := True;
        end;
      end;
    jtArrBegin:
      Result := True;
    jtString:
      begin
        AName := FTokenString;
        NextToken;
        if FToken = jtValSep then begin
          NextToken;
          if FToken in [jtObjBegin, jtArrBegin] then
            Result := True;
        end;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.InternalReadObjectEnd: Boolean;
begin
  NextToken;
  Result := FToken in [jtObjEnd, jtArrEnd];
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.TestProperty(const APropName: String): Boolean;
var
  iPos: Int64;
begin
  iPos := GetReadPos;
  Result := InternalReadProperty(APropName);
  SetReadPos(iPos);
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.TestAndReadProperty(const APropName: String): Boolean;
var
  iPos: Int64;
begin
  iPos := GetReadPos;
  Result := InternalReadProperty(APropName);
  if not Result then
    SetReadPos(iPos);
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadBoolean(const APropName: String;
  ADefValue: Boolean): Boolean;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtTrue:  Result := True;
    jtFalse: Result := False;
    jtNull:  Result := ADefValue;
    else     begin Result := False; ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadDate(const APropName: String;
  ADefValue: TDateTime): TDateTime;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtString:
      Result := EncodeDateTime(
        StrToInt(Copy(FTokenString, 1, 4)),
        StrToInt(Copy(FTokenString, 5, 2)),
        StrToInt(Copy(FTokenString, 7, 2)),
        StrToInt(Copy(FTokenString, 10, 2)),
        StrToInt(Copy(FTokenString, 12, 2)),
        StrToInt(Copy(FTokenString, 14, 2)), 0);
    jtNull:
      Result := ADefValue;
    else
      Result := 0.0;
      ErrInvalidFormat;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadEnum(const APropName: String; ATypeInfo: PTypeInfo;
  ADefValue: Integer): Integer;
var
  sEnum: String;
begin
  sEnum := GetEnumName(ATypeInfo, Integer(ADefValue));
  Result := GetEnumValue(ATypeInfo, Copy(sEnum, 1, 2) +
    ReadString(APropName, Copy(sEnum, 3, MAXINT)));
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadFloat(const APropName: String;
  ADefValue: Double): Double;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtNumber: Result := FDStr2Float(FTokenString, '.');
    jtNull:   Result := ADefValue;
    else      begin Result := 0.0; ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadInteger(const APropName: String;
  ADefValue: Integer): Integer;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtNumber: Result := StrToInt(FTokenString);
    jtNull:   Result := ADefValue;
    else      begin Result := 0; ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadLongWord(const APropName: String;
  ADefValue: Cardinal): Cardinal;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtNumber: Result := StrToInt(FTokenString);
    jtNull:   Result := ADefValue;
    else      begin Result := 0; ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadInt64(const APropName: String; ADefValue: Int64): Int64;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtNumber: Result := StrToInt64(FTokenString);
    jtNull:   Result := ADefValue;
    else      begin Result := 0; ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.TestObject(const AObjectName: String): Boolean;
var
  sName: String;
  iPos: Int64;
begin
  iPos := GetReadPos;
  Result := InternalReadObject(sName);
  if Result then
    Result := CompareText(AObjectName, sName) = 0;
  SetReadPos(iPos);
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.TestAndReadObjectBegin(const AObjectName: String;
  AStyle: TFDStorageObjectStyle): Boolean;
var
  sName: String;
  iPos: Int64;
begin
  iPos := GetReadPos;
  Result := InternalReadObject(sName);
  if Result then
    Result := CompareText(AObjectName, sName) = 0;
  if not Result then
    SetReadPos(iPos);
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): String;
begin
  if not InternalReadObject(Result) then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, ['<unknown>']);
  if (Result <> '') and (AObjectName <> '') and (CompareText(Result, AObjectName) <> 0) then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, [AObjectName]);
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.IsObjectEnd(const AObjectName: String): Boolean;
var
  iPos: Int64;
begin
  iPos := GetReadPos;
  Result := InternalReadObjectEnd;
  SetReadPos(iPos);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.ReadObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
begin
  InternalReadObjectEnd;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadAnsiString(const APropName: String;
  const ADefValue: TFDAnsiString): TFDAnsiString;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtString: Result := TFDAnsiString(FTokenString);
    jtNull:   Result := ADefValue;
    else      begin Result := TFDAnsiString(''); ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadString(const APropName: String;
  const ADefValue: UnicodeString): UnicodeString;
begin
  if TestAndReadProperty(APropName) then begin
    InternalReadPropertyValue;
    case FToken of
    jtString: Result := FTokenString;
    jtNull:   Result := ADefValue;
    else      begin Result := ''; ErrInvalidFormat; end;
    end;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDJSONStorage.ReadValue(const APropName: String; APropIndex: Word;
  ADataType: TFDDataType; out ABuff: Pointer; out ALen: Cardinal): Boolean;
var
  oMS: TMemoryStream;
  rTS: TSQLTimeStamp;
  pCh: PChar;
  iSign: Integer;
  eIntKind: TFDSQLTimeIntervalKind;
  pTS: PSQLTimeStamp;
  pInt: PFDSQLTimeInterval;

  function ScanInt(var AVal: Cardinal; AType: Char): Boolean;
  var
    pStCh: PChar;
  begin
    if pCh^ = '-' then begin
      iSign := -1;
      Inc(pCh);
    end
    else if pCh^ = '+' then
      Inc(pCh);
    pStCh := pCh;
    while (pCh^ >= '0') and (pCh^ <= '9') do
      Inc(pCh);
    if pCh^ = AType then begin
      FDStr2Int(pCh, pCh - pStCh, @AVal, SizeOf(AVal), True);
      Result := True;
    end
    else begin
      pCh := pStCh;
      Result := False;
    end;
  end;

  procedure DateIntError;
  begin
    FDException(Self, [S_FD_LStan], er_FD_StanStrgUnknownFmt, [FTokenString]);
  end;

begin
  ABuff := nil;
  ALen := 0;
  Result := False;
  if not TestAndReadProperty(APropName) then
    Exit;
  InternalReadPropertyValue;
  if FToken = jtNull then
    Exit;
  ABuff := CheckBuffer(C_FD_MaxFixedSize).Memory;
  Result := True;
  case ADataType of
  dtObject,
  dtRowSetRef,
  dtCursorRef,
  dtRowRef,
  dtArrayRef:
    ;
  dtWideMemo,
  dtWideHMemo,
  dtXML,
  dtWideString:
    begin
      ALen := Length(FTokenString);
      ABuff := PChar(FTokenString);
    end;
  dtMemo,
  dtHMemo,
  dtAnsiString:
    begin
      ABuff := nil;
      ALen := FEncoder.Encode(PChar(FTokenString), Length(FTokenString), ABuff, ecUTF16, ecANSI);
    end;
  dtByteString,
  dtBlob,
  dtHBlob,
  dtHBFile:
    begin
      oMS := CheckBuffer(0);
      Hex2BinStream(FTokenString, oMS);
      ABuff := oMS.Memory;
      ALen := oMS.Size;
    end;
  dtBoolean:
    PWordBool(ABuff)^ := FToken = jtTrue;
  dtSByte:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(ShortInt), False);
  dtInt16:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(SmallInt), False);
  dtInt32:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Integer), False);
  dtInt64:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Int64), False);
  dtByte:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Byte), True);
  dtUInt16:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Word), True);
  dtUInt32,
  dtParentRowRef:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Cardinal), True);
  dtUInt64:
    FDStr2Int(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(UInt64), True);
  dtSingle:
    FDStr2Float(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Single), '.');
  dtDouble:
    FDStr2Float(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Double), '.');
  dtExtended:
    FDStr2Float(PChar(FTokenString), Length(FTokenString), ABuff, SizeOf(Extended), '.');
  dtCurrency:
    FDStr2Curr(PChar(FTokenString), Length(FTokenString), PCurrency(ABuff)^, '.');
  dtBCD,
  dtFmtBCD:
    FDStr2BCD(PChar(FTokenString), Length(FTokenString), PBcd(ABuff)^, Char('.'));
  dtDateTime:
    begin
      FDStr2Int(PChar(FTokenString) + 0, 4, @rTS.Year, SizeOf(rTS.Year), True);
      FDStr2Int(PChar(FTokenString) + 4, 2, @rTS.Month, SizeOf(rTS.Month), True);
      FDStr2Int(PChar(FTokenString) + 6, 2, @rTS.Day, SizeOf(rTS.Day), True);
      if (PChar(FTokenString) + 8)^ = 'T' then begin
        FDStr2Int(PChar(FTokenString) + 9, 2, @rTS.Hour, SizeOf(rTS.Hour), True);
        FDStr2Int(PChar(FTokenString) + 11, 2, @rTS.Minute, SizeOf(rTS.Minute), True);
        FDStr2Int(PChar(FTokenString) + 13, 2, @rTS.Second, SizeOf(rTS.Second), True);
      end
      else begin
        rTS.Hour := 0;
        rTS.Minute := 0;
        rTS.Second := 0;
      end;
      rTS.Fractions := 0;
      PDateTimeRec(ABuff)^.DateTime := FDDateTime2MSecs(SQLTimeStampToDateTime(rTS));
    end;
  dtDateTimeStamp:
    begin
      pTS := PSQLTimeStamp(ABuff);
      FDStr2Int(PChar(FTokenString) + 0, 4, @pTS^.Year, SizeOf(pTS^.Year), True);
      FDStr2Int(PChar(FTokenString) + 4, 2, @pTS^.Month, SizeOf(pTS^.Month), True);
      FDStr2Int(PChar(FTokenString) + 6, 2, @pTS^.Day, SizeOf(pTS^.Day), True);
      if (PChar(FTokenString) + 8)^ = 'T' then begin
        FDStr2Int(PChar(FTokenString) + 9, 2, @pTS^.Hour, SizeOf(pTS^.Hour), True);
        FDStr2Int(PChar(FTokenString) + 11, 2, @pTS^.Minute, SizeOf(pTS^.Minute), True);
        FDStr2Int(PChar(FTokenString) + 13, 2, @pTS^.Second, SizeOf(pTS^.Second), True);
      end
      else begin
        pTS^.Hour := 0;
        pTS^.Minute := 0;
        pTS^.Second := 0;
      end;
      pTS^.Fractions := 0;
    end;
  dtTimeIntervalFull,
  dtTimeIntervalYM,
  dtTimeIntervalDS:
    begin
      pInt := PFDSQLTimeInterval(ABuff);
      pCh := PChar(FTokenString);
      if pCh^ = '-' then begin
        iSign := -1;
        Inc(pCh);
      end
      else
        iSign := 1;
      eIntKind := itUnknown;
      if pCh^ <> 'P' then
        DateIntError;
      Inc(pCh); // P
      if (pCh^ <> 'T') and ScanInt(pInt^.Years, 'Y') then
        eIntKind := itYear;
      if (pCh^ <> 'T') and ScanInt(pInt^.Months, 'M') then
        if eIntKind = itYear then
          eIntKind := itYear2Month
        else
          eIntKind := itMonth;
      if (pCh^ <> 'T') and ScanInt(pInt^.Days, 'D') then begin
        if eIntKind <> itUnknown then
          DateIntError;
        eIntKind := itDay;
      end;
      if pCh^ = 'T' then begin
        Inc(pCh); // T
        if ScanInt(pInt^.Hours, 'H') then
          if eIntKind = itDay then
            eIntKind := itDay2Hour
          else if eIntKind = itUnknown then
            eIntKind := itHour
          else
            DateIntError;
        if ScanInt(pInt^.Minutes, 'M') then
          if eIntKind = itDay2Hour then
            eIntKind := itDay2Minute
          else if eIntKind = itHour then
            eIntKind := itHour2Minute
          else if eIntKind = itUnknown then
            eIntKind := itMinute
          else
            DateIntError;
        if ScanInt(pInt^.Seconds, 'S') then begin
          if eIntKind = itDay2Minute then
            eIntKind := itDay2Second
          else if eIntKind = itHour2Minute then
            eIntKind := itHour2Second
          else if eIntKind = itMinute then
            eIntKind := itMinute2Second
          else if eIntKind = itUnknown then
            eIntKind := itSecond
          else
            DateIntError;
          ScanInt(pInt^.Fractions, 'F');
        end;
      end;
      pInt^.Sign := iSign;
      pInt^.Kind := eIntKind;
    end;
  dtTime:
    begin
      rTS.Year := 0;
      rTS.Month := 0;
      rTS.Day := 0;
      FDStr2Int(PChar(FTokenString) + 0, 2, @rTS.Hour, SizeOf(rTS.Hour), True);
      FDStr2Int(PChar(FTokenString) + 2, 2, @rTS.Minute, SizeOf(rTS.Minute), True);
      FDStr2Int(PChar(FTokenString) + 4, 2, @rTS.Second, SizeOf(rTS.Second), True);
      rTS.Fractions := 0;
      PInteger(ABuff)^ := FDSQLTimeStamp2Time(rTS);
    end;
  dtDate:
    begin
      FDStr2Int(PChar(FTokenString) + 0, 4, @rTS.Year, SizeOf(rTS.Year), True);
      FDStr2Int(PChar(FTokenString) + 4, 2, @rTS.Month, SizeOf(rTS.Month), True);
      FDStr2Int(PChar(FTokenString) + 6, 2, @rTS.Day, SizeOf(rTS.Day), True);
      rTS.Hour := 0;
      rTS.Minute := 0;
      rTS.Second := 0;
      rTS.Fractions := 0;
      PInteger(ABuff)^ := FDSQLTimeStamp2Date(rTS);
    end;
  dtGUID:
    PGUID(ABuff)^ := StringToGUID(FTokenString);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.AddToStack(AFirst: Boolean; AStyle: TFDStorageObjectStyle);
begin
  if Length(FStack) = 0 then
    SetLength(FStack, 16)
  else if FStackIndex + 1 >= Length(FStack) then
    SetLength(FStack, Length(FStack) * 2);
  Inc(FStackIndex);
  FStack[FStackIndex].FFirst := AFirst;
  FStack[FStackIndex].FStyle := AStyle;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.RemFromStack;
begin
  Dec(FStackIndex);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteStringBase(ApStr: PChar; ALen: Integer; AQuote: Boolean);
const
  C_Hex: array [0 .. 15] of Byte = (Ord('0'), Ord('1'), Ord('2'), Ord('3'),
    Ord('4'), Ord('5'), Ord('6'), Ord('7'), Ord('8'), Ord('9'), Ord('A'),
    Ord('B'), Ord('C'), Ord('D'), Ord('E'), Ord('F'));
var
  oMS: TMemoryStream;
  pRes: PByte;
  c: Char;
  iLen: Integer;
begin
  oMS := CheckBuffer(ALen * 6 + 2);
  pRes := oMS.Memory;
  if AQuote then begin
    pRes^ := Ord('"');
    Inc(pRes);
  end;
  while ALen > 0 do begin
    c := ApStr^;
    Inc(ApStr);
    Dec(ALen);
    case Word(Ord(c)) of
    $0:
      Break;
    Ord('"'):
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('"');
        Inc(pRes, 2);
      end;
    Ord('\'):
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('\');
        Inc(pRes, 2);
      end;
    $8:
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('b');
        Inc(pRes, 2);
      end;
    $9:
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('t');
        Inc(pRes, 2);
      end;
    $a:
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('n');
        Inc(pRes, 2);
      end;
    $c:
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('f');
        Inc(pRes, 2);
      end;
    $d:
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('r');
        Inc(pRes, 2);
      end;
    $1 .. $7,
    $b, $e .. $1f:
      begin
        pRes^ := Ord('\');
        (pRes + 1)^ := Ord('u');
        (pRes + 2)^ := C_Hex[(Ord(c) and 61440) shr 12];
        (pRes + 3)^ := C_Hex[(Ord(c) and 3840) shr 8];
        (pRes + 4)^ := C_Hex[(Ord(c) and 240) shr 4];
        (pRes + 5)^ := C_Hex[(Ord(c) and 15)];
        Inc(pRes, 6);
      end;
    $20, $21, $23 .. $5b, $5d .. $7f:
      begin
        pRes^ := Ord(c);
        Inc(pRes);
      end;
    $0080 .. $07FF:
      begin
        pRes^ := $C0 or (Ord(c) shr 6);
        (pRes + 1)^ := $80 or (Ord(c) and $3F);
        Inc(pRes, 2);
      end;
    $0800 .. $ffff:
      begin
        pRes^ := $E0 or (Ord(c) shr 12);
        (pRes + 1)^ := $80 or ((Ord(c) shr 6) and $3F);
        (pRes + 2)^ := $80 or (Ord(c) and $3F);
        Inc(pRes, 3);
      end;
    end;
  end;
  if AQuote then begin
    pRes^ := Ord('"');
    iLen := NativeUInt(pRes) - NativeUInt(oMS.Memory) + 1;
  end
  else
    iLen := NativeUInt(pRes) - NativeUInt(oMS.Memory);
  FStream.Write(oMS.Memory^, iLen);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteFmt;
var
  i: Integer;
begin
  if not FFormat then
    Exit;
  FStream.Write(C_EOL[0], Length(C_EOL));
  for i := 0 to FStackIndex do
    FStream.Write(C_Indent[0], SizeOf(C_Indent));
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WritePairSep;
begin
  if FStackIndex >= 0 then
    if not FStack[FStackIndex].FFirst then
      FStream.Write(C_PairSep, 1)
    else
      FStack[FStackIndex].FFirst := False;
  WriteFmt;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteValSep;
begin
  FStream.Write(C_ValSep, 1);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.AddAttribute(const AAttrName: String;
  ApVal: PChar; ALen: Integer; AQuote: Boolean);
begin
  WritePairSep;
  WriteStringBase(PChar(AAttrName), Length(AAttrName), True);
  WriteValSep;
  WriteStringBase(ApVal, ALen, AQuote);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.AddAttribute(const AAttrName, AValue: String; AQuote: Boolean);
begin
  AddAttribute(AAttrName, PChar(AValue), Length(AValue), AQuote);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteBoolean(const APropName: String; const AValue,
  ADefValue: Boolean);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, C_Bools[AValue], False);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteDate(const APropName: String; const AValue,
  ADefValue: TDateTime);
const
  CShortDateTimeISO8601Format = 'yyyymmddThhnnss';
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, FormatDateTime(CShortDateTimeISO8601Format, AValue), True)
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteEnum(const APropName: String; ATypeInfo: PTypeInfo;
  const AValue, ADefValue: Integer);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, Copy(GetCachedEnumName(ATypeInfo, AValue), 3, MAXINT), True);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteFloat(const APropName: String; const AValue,
  ADefValue: Double);
begin
  if Abs(AValue - ADefValue) >= 1e-14 then
    AddAttribute(APropName, FDFloat2Str(AValue, '.'), False);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteInteger(const APropName: String; const AValue,
  ADefValue: Integer);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, IntToStr(AValue), False);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteLongWord(const APropName: String;
  const AValue, ADefValue: Cardinal);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, IntToStr(AValue), False);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteInt64(const APropName: String; const AValue,
  ADefValue: Int64);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, IntToStr(AValue), False);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle);
var
  eParent: TFDStorageObjectStyle;
  iMode: Integer;
begin
(*
  1  , {
  2  , { class : ObjName
  3  , ObjName : {
  4  , ObjName : [
  5  , [

  p a  use
  - -  ---
  O O  3
  O F  4
  O T  4
  F O  1
  F F  5
  F T  5
  T O  2
  T F  5
  T T  5
*)
  WritePairSep;
  if FStackIndex = -1 then
    eParent := osObject
  else
    eParent := FStack[FStackIndex].FStyle;
  iMode := 3;
  case eParent of
  osObject:
    if AStyle = osObject then
      iMode := 3
    else
      iMode := 4;
  osFlatArray:
    if AStyle = osObject then
      iMode := 1
    else
      iMode := 5;
  osTypedArray:
    if AStyle = osObject then
      iMode := 2
    else
      iMode := 5;
  end;
  case iMode of
  1:
    FStream.Write(C_ObjBegin, 1);
  2:
    begin
      FStream.Write(C_ObjBegin, 1);
      WriteStringBase(PChar(C_Class), Length(C_Class), True);
      WriteValSep;
      WriteStringBase(PChar(AObjectName), Length(AObjectName), True);
    end;
  3:
    begin
      WriteStringBase(PChar(AObjectName), Length(AObjectName), True);
      WriteValSep;
      FStream.Write(C_ObjBegin, 1);
    end;
  4:
    begin
      WriteStringBase(PChar(AObjectName), Length(AObjectName), True);
      WriteValSep;
      FStream.Write(C_ArrBegin, 1);
    end;
  5:
    FStream.Write(C_ArrBegin, 1);
  end;
  AddToStack(iMode <> 2, AStyle);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
begin
  if AStyle = osObject then
    FStream.Write(C_ObjEnd, 1)
  else
    FStream.Write(C_ArrEnd, 1);
  RemFromStack;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteAnsiString(const APropName: String; const AValue,
  ADefValue: TFDAnsiString);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, String(AValue), True);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteString(const APropName: String;
  const AValue, ADefValue: UnicodeString);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, AValue, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.WriteValue(const APropName: String; APropIndex: Word;
  ADataType: TFDDataType; ABuff: Pointer; ALen: Cardinal);
const
  CDateTimeISO8601Format: String = '%.4d%.2d%.2dT%.2d%.2d%.2d';
  CTimeFormat: String = '%.2d%.2d%.2d';
  CDateFormat: String = '%.4d%.2d%.2d';
var
  sVal: String;
  sSign: String;
  iLen: Integer;
  y, mo, d, h, mi, se, ms: Word;
  dt: TDateTime;
  pTS: PSQLTimeStamp;
  pInt: PFDSQLTimeInterval;
  rTS: TSQLTimeStamp;
  pDest: PChar;
  aFixed: array [0 .. C_FD_MaxFixedSize] of Char;
begin
  if ABuff = nil then
    Exit;
  pDest := @aFixed[0];
  iLen := SizeOf(aFixed) div SizeOf(Char);
  case ADataType of
  dtObject,
  dtRowSetRef,
  dtCursorRef,
  dtRowRef,
  dtArrayRef:
    ;
  dtWideMemo,
  dtWideHMemo,
  dtXML,
  dtWideString:
    AddAttribute(APropName, PWideChar(ABuff), ALen, True);
  dtMemo,
  dtHMemo,
  dtAnsiString:
    begin
      pDest := nil;
      iLen := FEncoder.Decode(ABuff, ALen, Pointer(pDest), ecUTF16, ecANSI);
      AddAttribute(APropName, pDest, iLen, True);
    end;
  dtByteString,
  dtBlob,
  dtHBlob,
  dtHBFile:
    AddAttribute(APropName, FDBin2Hex(ABuff, ALen), True);
  dtBoolean:
    AddAttribute(APropName, C_Bools[PWord(ABuff)^ <> 0], False);
  dtSByte:
    begin
      FDInt2Str(ABuff, SizeOf(ShortInt), pDest, iLen, False, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtInt16:
    begin
      FDInt2Str(ABuff, SizeOf(SmallInt), pDest, iLen, False, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtInt32:
    begin
      FDInt2Str(ABuff, SizeOf(Integer), pDest, iLen, False, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtInt64:
    begin
      FDInt2Str(ABuff, SizeOf(Int64), pDest, iLen, False, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtByte:
    begin
      FDInt2Str(ABuff, SizeOf(Byte), pDest, iLen, True, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtUInt16:
    begin
      FDInt2Str(ABuff, SizeOf(Word), pDest, iLen, True, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtUInt32,
  dtParentRowRef:
    begin
      FDInt2Str(ABuff, SizeOf(Cardinal), pDest, iLen, True, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtUInt64:
    begin
      FDInt2Str(ABuff, SizeOf(UInt64), pDest, iLen, True, 0);
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtSingle:
    AddAttribute(APropName, FDFloat2Str(PSingle(ABuff)^, '.'), False);
  dtDouble:
    AddAttribute(APropName, FDFloat2Str(PDouble(ABuff)^, '.'), False);
  dtExtended:
    AddAttribute(APropName, FDFloat2Str(PExtended(ABuff)^, '.'), False);
  dtCurrency:
    AddAttribute(APropName, FDCurr2Str(PCurrency(ABuff)^, '.'), False);
  dtBCD,
  dtFmtBCD:
    begin
      FDBCD2Str(pDest, iLen, PBcd(ABuff)^, '.');
      AddAttribute(APropName, pDest, iLen, False);
    end;
  dtDateTime:
    begin
      dt := TimeStampToDateTime(MSecsToTimeStamp(PDateTimeRec(ABuff)^.DateTime));
      DecodeDate(dt, y, mo, d);
      DecodeTime(dt, h, mi, se, ms);
      iLen := WideFormatBuf(pDest^, iLen, Pointer(CDateTimeISO8601Format)^,
        Length(CDateTimeISO8601Format), [y, mo, d, h, mi, se], FormatSettings);
      AddAttribute(APropName, pDest, iLen, True);
    end;
  dtDateTimeStamp:
    begin
      pTS := PSQLTimeStamp(ABuff);
      iLen := WideFormatBuf(pDest^, iLen, Pointer(CDateTimeISO8601Format)^,
        Length(CDateTimeISO8601Format), [pTS^.Year, pTS^.Month, pTS^.Day, pTS^.Hour,
        pTS^.Minute, pTS^.Second], FormatSettings);
      AddAttribute(APropName, pDest, iLen, True);
    end;
  dtTimeIntervalFull,
  dtTimeIntervalYM,
  dtTimeIntervalDS:
    begin
      pInt := PFDSQLTimeInterval(ABuff);
      if pInt^.Sign < 0 then
        sSign := '-'
      else
        sSign := '';
      case pInt^.Kind of
      itYear:          sVal := Format('%sP%uY', [sSign, pInt^.Years]);
      itMonth:         sVal := Format('%sP%uM', [sSign, pInt^.Months]);
      itDay:           sVal := Format('%sP%uD', [sSign, pInt^.Days]);
      itHour:          sVal := Format('%sT%uH', [sSign, pInt^.Hours]);
      itMinute:        sVal := Format('%sT%uM', [sSign, pInt^.Minutes]);
      itSecond:        sVal := Format('%sT%uS%uF', [sSign, pInt^.Seconds, pInt^.Fractions]);
      itYear2Month:    sVal := Format('%sP%uY%uM', [sSign, pInt^.Years, pInt^.Months]);
      itDay2Hour:      sVal := Format('%sP%uDT%uH', [sSign, pInt^.Days, pInt^.Hours]);
      itDay2Minute:    sVal := Format('%sP%uDT%uH%uM', [sSign, pInt^.Days, pInt^.Hours, pInt^.Minutes]);
      itDay2Second:    sVal := Format('%sP%uDT%uH%uM%uS%uF', [sSign, pInt^.Days, pInt^.Hours, pInt^.Minutes, pInt^.Seconds, pInt^.Fractions]);
      itHour2Minute:   sVal := Format('%sT%uH%uM', [sSign, pInt^.Hours, pInt^.Minutes]);
      itHour2Second:   sVal := Format('%sT%uH%uM%uS%uF', [sSign, pInt^.Hours, pInt^.Minutes, pInt^.Seconds, pInt^.Fractions]);
      itMinute2Second: sVal := Format('%sT%uM%uS%uF', [sSign, pInt^.Minutes, pInt^.Seconds, pInt^.Fractions]);
      end;
      AddAttribute(APropName, sVal, True);
    end;
  dtTime:
    begin
      rTS := FDTime2SQLTimeStamp(PInteger(ABuff)^);
      iLen := WideFormatBuf(pDest^, iLen, Pointer(CTimeFormat)^,
        Length(CTimeFormat), [rTS.Hour, rTS.Minute, rTS.Second], FormatSettings);
      AddAttribute(APropName, pDest, iLen, True);
    end;
  dtDate:
    begin
      rTS := FDDate2SQLTimeStamp(PInteger(ABuff)^);
      iLen := WideFormatBuf(pDest^, iLen, Pointer(CDateFormat)^,
        Length(CDateFormat), [rTS.Year, rTS.Month, rTS.Day], FormatSettings);
      AddAttribute(APropName, pDest, iLen, True);
    end;
  dtGUID:
    AddAttribute(APropName, GUIDToString(PGUID(ABuff)^), True);
  end;
end;

{-------------------------------------------------------------------------------}
type
  TFDJSONStorageBmk = class(TObject)
  private
    FPos: Int64;
    FToken: TFDJSONToken;
    FTokenString: String;
  end;

function TFDJSONStorage.GetBookmark: TObject;
begin
  Result := TFDJSONStorageBmk.Create;
  if FMode = smRead then
    TFDJSONStorageBmk(Result).FPos := GetReadPos
  else
    TFDJSONStorageBmk(Result).FPos := FStream.Position;
  TFDJSONStorageBmk(Result).FToken := FToken;
  TFDJSONStorageBmk(Result).FTokenString := FTokenString;
end;

{-------------------------------------------------------------------------------}
procedure TFDJSONStorage.SetBookmark(const AValue: TObject);
begin
  if FMode = smRead then
    SetReadPos(TFDJSONStorageBmk(AValue).FPos)
  else
    FStream.Position := TFDJSONStorageBmk(AValue).FPos;
  FToken := TFDJSONStorageBmk(AValue).FToken;
  FTokenString := TFDJSONStorageBmk(AValue).FTokenString;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;
{$IFDEF MSWINDOWS}
  i: Integer;
{$ENDIF}

initialization
{$IFDEF MSWINDOWS}
  SetLength(C_EOL, Length(C_FD_EOL));
  for i := 1 to Length(C_FD_EOL) do
    C_EOL[i - 1] := Ord(C_FD_EOL[i]);
{$ELSE}
  SetLength(C_EOL, 1);
  C_EOL[0] := Ord(C_FD_EOL);
{$ENDIF}

  oFact := TFDMultyInstanceFactory.Create(TFDJSONStorage, IFDStanStorage,
    'JSON;.JSON');

finalization
  FDReleaseFactory(oFact);

end.
