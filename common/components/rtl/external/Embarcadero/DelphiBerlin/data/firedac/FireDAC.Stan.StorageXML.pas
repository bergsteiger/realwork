{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC XML streaming implementation         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.StorageXML;

interface

uses
  System.Classes;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDStanStorageXMLLink = class(TComponent)
  end;

implementation

uses
  System.SysUtils, System.TypInfo, System.DateUtils,
  Xml.XMLDoc, Xml.XMLDOM, Xml.XMLIntf,
{$IFDEF MSWINDOWS}
  Xml.Win.msxmldom,
{$ENDIF}
{$IFDEF POSIX}
  Xml.omnixmldom,
{$ENDIF}
  Data.FMTBcd, Data.SQLTimSt, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Storage, FireDAC.Stan.SQLTimeInt,
    FireDAC.Stan.Factory, FireDAC.Stan.Error, FireDAC.Stan.Consts;

type
  TFDXMLStorage = class(TFDStorage, IFDStanStorage)
  private
    FCurrentChildElement: IDOMElement;
    FCurrentElement: IDOMElement;
    FParser: IXMLDocument;
    FLevel: Integer;
    procedure AddAttribute(const AAttrName, AValue: DOMString);
    procedure AddCData(AStream: TMemoryStream);
    procedure AddFormat;
    function SkipText(const AElem: IDOMElement): IDOMElement; overload;
    function SkipText(const AElem: IDOMNode): IDOMElement; overload;
    function AddElement(const AElemName: DOMString): IDOMElement;
    function CurrentElement: IDOMElement;
    procedure ReadCData(AStream: TMemoryStream);
    function ReadProperty(const APropName: DOMString): DOMString;
    function GetXMLObject: IDOMElement;
    function EncodeName(const AName: DOMString): DOMString;
    function DecodeName(const AName: DOMString): DOMString;
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

{-------------------------------------------------------------------------------}
{ TFDXMLStorage                                                                 }
{-------------------------------------------------------------------------------}
{ http://msdn.microsoft.com/en-us/library/xfaz0c52(VS.71).aspx }
{ http://www.w3.org/TR/2000/REC-xml-20001006.html#NT-Name }
function TFDXMLStorage.EncodeName(const AName: DOMString): DOMString;
var
  i, iCur: Integer;

  procedure PutCh(ACh: WideChar);
  begin
    Inc(iCur);
    if iCur > Length(Result) then
      SetLength(Result, Length(Result) * 2);
    Result[iCur] := ACh;
  end;

  procedure PutOrd(ACh: WideChar);
  var
    s: String;
    i: Integer;
  begin
    s := Format('_0x%.4x_', [Integer(ACh)]);
    for i := 1 to Length(s) do
      PutCh(WideChar(s[i]));
  end;

begin
  SetLength(Result, Length(AName));
  if Length(AName) = 0 then
    Exit;
  iCur := 0;
  if not FDInSet(Char(AName[1]), ['a' .. 'z', 'A' .. 'Z', '_', ':']) then
    PutOrd(AName[1])
  else
    PutCh(AName[1]);
  for i := 2 to Length(AName) do
    if not FDInSet(Char(AName[i]), ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '.', '-', '_', ':']) then
      PutOrd(AName[i])
    else
      PutCh(AName[i]);
  SetLength(Result, iCur);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.DecodeName(const AName: DOMString): DOMString;
var
  i, iCur: Integer;

  procedure PutCh(ACh: WideChar);
  begin
    Inc(iCur);
    if iCur > Length(Result) then
      SetLength(Result, Length(Result) * 2);
    Result[iCur] := ACh;
  end;

begin
  SetLength(Result, Length(AName));
  if Length(AName) = 0 then
    Exit;
  iCur := 0;
  i := 1;
  while i <= Length(AName) do
    if (i <= Length(AName) - 6) and
       (AName[i] = '_') and
       (AName[i + 1] = '0') and
       ((AName[i + 2] = 'x') or (AName[i] = 'X')) and
       FDInSet(Char(AName[i + 3]), ['0' .. '9', 'a' .. 'f', 'A' .. 'F']) and
       FDInSet(Char(AName[i + 4]), ['0' .. '9', 'a' .. 'f', 'A' .. 'F']) and
       FDInSet(Char(AName[i + 5]), ['0' .. '9', 'a' .. 'f', 'A' .. 'F']) and
       FDInSet(Char(AName[i + 6]), ['0' .. '9', 'a' .. 'f', 'A' .. 'F']) and
       (AName[i + 7] = '_') then begin
      PutCh(WideChar(StrToInt(Copy(AName, i + 1, 6))));
      Inc(i, 8);
    end
    else begin
      PutCh(AName[i]);
      Inc(i);
    end;
  SetLength(Result, iCur);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.AddAttribute(const AAttrName, AValue: DOMString);
begin
  CurrentElement.SetAttribute(EncodeName(AAttrName), AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.AddCData(AStream: TMemoryStream);
var
  s: String;
begin
  s := FDBin2Hex(AStream.Memory, AStream.Size);
  CurrentElement.appendChild(FParser.DOMDocument.createCDATASection(s));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.AddFormat;
var
  i: Integer;
  s: DOMString;
  pCh: PWideChar;
  oFmt: IDOMText;
begin
  if not FFormat then
    Exit;
  SetLength(s, (FLevel - 1) * 2 + 1);
  pCh := PWideChar(s);
  pCh^ := #10;
  for i := 1 to Length(s) - 1 do
    (pCh + i)^ := ' ';
  oFmt := FParser.DOMDocument.createTextNode(s);
  if CurrentElement = nil then
    FParser.DOMDocument.appendChild(oFmt)
  else
    CurrentElement.appendChild(oFmt);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.SkipText(const AElem: IDOMElement): IDOMElement;
begin
  Result := AElem;
  while (Result <> nil) and (Result.nodeType = TEXT_NODE) do
    Result := IDOMElement(Result.nextSibling);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.SkipText(const AElem: IDOMNode): IDOMElement;
begin
  Result := SkipText(IDOMElement(AElem));
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.AddElement(const AElemName: DOMString): IDOMElement;
begin
  Result := FParser.DOMDocument.createElement(EncodeName(AElemName));
  if CurrentElement = nil then
    FParser.DOMDocument.appendChild(Result)
  else
    CurrentElement.appendChild(Result);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.CurrentElement: IDOMElement;
begin
  if FCurrentElement <> nil then
    Result := FCurrentElement
  else
    Result := FParser.DOMDocument.documentElement;
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.ReadCData(AStream: TMemoryStream);
var
  oNode: IDOMNode;
  i: Integer;
begin
  oNode := nil;
  for i := 0 to CurrentElement.childNodes.length - 1 do
    if CurrentElement.childNodes.item[i].nodeType = CDATA_SECTION_NODE then
      oNode := CurrentElement.childNodes.item[i];
  if oNode = nil then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadCDATA, [CurrentElement.nodeName]);
  Hex2BinStream((oNode as IDOMCDATASection).data, AStream);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadProperty(const APropName: DOMString): DOMString;
begin
  if not TestProperty(APropName) then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadProp, [APropName]);
  Result := CurrentElement.attributes.getNamedItem(EncodeName(APropName)).nodeValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.Close;
begin
  if IsOpen then
    try
      if FMode = smWrite then begin
        WriteObjectEnd('FDBS', osObject);
        FParser.SaveToStream(FStream);
      end
      else if TestObject('FDBS') then
        ReadObjectEnd('FDBS', osObject);
    finally
      FCurrentChildElement := nil;
      FCurrentElement := nil;
      FParser := nil;
      inherited Close;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.IsObjectEnd(const AObjectName: String): Boolean;
begin
  if (FCurrentElement = nil) or
     (CompareText(DecodeName(FCurrentElement.nodeName), AObjectName) <> 0) then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, [AObjectName]);
  Result := (FCurrentChildElement = nil) and (SkipText(FCurrentElement.firstChild) = nil) or
            (FCurrentChildElement <> nil) and (SkipText(FCurrentChildElement.nextSibling) = nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.Open(AResOpts: TObject; AEncoder: TObject;
  const AFileName: String; AStream: TStream; AMode: TFDStorageMode);
begin
  inherited Open(AResOpts, AEncoder, AFileName, AStream, AMode);
  FLevel := 0;
  FParser := TXMLDocument.Create(nil);
  FParser.Active := True;
  if AMode = smWrite then begin
    FParser.Version := '1.0';
    FParser.Encoding := 'utf-8';
    WriteObjectBegin('FDBS', osObject);
    WriteInteger('Version', GetStreamVersion, -1);
  end
  else begin
    FParser.LoadFromStream(FStream);
    if TestObject('FDBS') then begin
      ReadObjectBegin('FDBS', osObject);
      FStreamVersion := ReadInteger('Version', C_FD_StorageVer);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadBoolean(const APropName: String; ADefValue: Boolean): Boolean;
begin
  if TestAndReadProperty(APropName) then
    Result := (CompareText(ReadProperty(APropName), S_FD_True) = 0)
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadDate(const APropName: String; ADefValue: TDateTime): TDateTime;
var
  s: String;
  i: Integer;
begin
  if TestAndReadProperty(APropName) then begin
    s := ReadProperty(APropName);
    if s <> '' then begin
      if FStreamVersion >= 9 then
        i := 1
      else
        i := 0;
      Result := EncodeDateTime(
        StrToInt(Copy(s, 1, 4)), StrToInt(Copy(s, 5, 2)), StrToInt(Copy(s, 7, 2)),
        StrToInt(Copy(s, 9 + i, 2)), StrToInt(Copy(s, 11 + i, 2)), StrToInt(Copy(s, 13 + i, 2)), 0);
    end
    else
      Result := ADefValue;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadFloat(const APropName: String; ADefValue: Double): Double;
var
  s: String;
begin
  if TestAndReadProperty(APropName) then begin
    s := ReadProperty(APropName);
    if s <> '' then
      Result := FDStr2Float(s, '.')
    else
      Result := ADefValue;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadInteger(const APropName: String; ADefValue: Integer): Integer;
var
  s: String;
begin
  if TestAndReadProperty(APropName) then begin
    s := ReadProperty(APropName);
    if s <> '' then
      Result := StrToInt(s)
    else
      Result := ADefValue;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadLongWord(const APropName: String;
  ADefValue: Cardinal): Cardinal;
var
  s: String;
begin
  if TestAndReadProperty(APropName) then begin
    s := ReadProperty(APropName);
    if s <> '' then
      Result := StrToInt(s)
    else
      Result := ADefValue;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadInt64(const APropName: String; ADefValue: Int64): Int64;
var
  s: String;
begin
  if TestAndReadProperty(APropName) then begin
    s := ReadProperty(APropName);
    if s <> '' then
      Result := StrToInt64(s)
    else
      Result := ADefValue;
  end
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): String;
var
  oCurrElement: IDOMElement;
begin
  if AObjectName = '' then begin
    oCurrElement := GetXMLObject;
    if oCurrElement = nil then
      FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, ['<unknown>']);
    Result := DecodeName(oCurrElement.nodeName);
  end
  else begin
    Result := AObjectName;
    if not TestObject(AObjectName) then
      FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, [AObjectName]);
  end;
  if FCurrentElement = nil then
    FCurrentElement := FParser.DOMDocument.documentElement
  else begin
    if FCurrentChildElement = nil then
      FCurrentElement := IDOMElement(CurrentElement.firstChild)
    else begin
      FCurrentElement := IDOMElement(FCurrentChildElement.nextSibling);
      FCurrentChildElement := nil;
    end;
  end;
  FCurrentElement := SkipText(FCurrentElement);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.ReadObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
begin
  if CompareText(DecodeName(FCurrentElement.nodeName), AObjectName) <> 0 then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgCantReadObj, [AObjectName]);
  FCurrentChildElement := FCurrentElement;
  FCurrentElement := IDOMElement(FCurrentElement.parentNode);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadAnsiString(const APropName: String;
  const ADefValue: TFDAnsiString): TFDAnsiString;
begin
  if TestAndReadProperty(APropName) then
    Result := TFDAnsiString(ReadProperty(APropName))
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadString(const APropName: String;
  const ADefValue: UnicodeString): UnicodeString;
begin
  if TestAndReadProperty(APropName) then
    Result := ReadProperty(APropName)
  else
    Result := ADefValue;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.GetXMLObject: IDOMElement;
begin
  if FCurrentElement = nil then
    if FParser.DOMDocument = nil then
      Result := nil
    else
      Result := FParser.DOMDocument.documentElement
  else if FCurrentChildElement = nil then
    Result := IDOMElement(CurrentElement.firstChild)
  else
    Result := IDOMElement(FCurrentChildElement.nextSibling);
  Result := SkipText(Result);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.TestObject(const AObjectName: String): Boolean;
var
  oCurrElement: IDOMElement;
begin
  oCurrElement := GetXMLObject;
  Result := (oCurrElement <> nil) and
    (CompareText(DecodeName(oCurrElement.nodeName), AObjectName) = 0);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.TestAndReadObjectBegin(const AObjectName: String;
  AStyle: TFDStorageObjectStyle): Boolean;
begin
  Result := TestObject(AObjectName);
  if Result then
    ReadObjectBegin(AObjectName, AStyle);
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.TestProperty(const APropName: String): Boolean;
begin
  Result := CurrentElement.attributes.getNamedItem(EncodeName(APropName)) <> nil;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.TestAndReadProperty(const APropName: String): Boolean;
begin
  Result := TestProperty(APropName);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteBoolean(const APropName: String; const AValue, ADefValue: Boolean);
begin
  if AValue <> ADefValue then
    if AValue then
      AddAttribute(APropName, S_FD_True)
    else
      AddAttribute(APropName, S_FD_False);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteDate(const APropName: String; const AValue, ADefValue: TDateTime);
const
  CShortDateTimeFormat = 'yyyymmddhhnnss';
  CShortDateTimeISO8601Format = 'yyyymmddThhnnss';
begin
  if AValue <> ADefValue then
    if FStreamVersion >= 9 then
      AddAttribute(APropName, FormatDateTime(CShortDateTimeISO8601Format, AValue))
    else
      AddAttribute(APropName, FormatDateTime(CShortDateTimeFormat, AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteFloat(const APropName: String; const AValue, ADefValue: Double);
begin
  if Abs(AValue - ADefValue) >= 1e-14 then
    AddAttribute(APropName, FDFloat2Str(AValue, '.'));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteInteger(const APropName: String; const AValue, ADefValue: Integer);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, IntToStr(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteLongWord(const APropName: String; const AValue,
  ADefValue: Cardinal);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, IntToStr(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteInt64(const APropName: String; const AValue,
  ADefValue: Int64);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, IntToStr(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle);
begin
  Inc(FLevel);
  if FLevel > 1 then
    AddFormat;
  FCurrentElement := AddElement(AObjectName);
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle);
begin
  if (FLevel >= 1) and (CurrentElement <> nil) and CurrentElement.hasChildNodes then
    AddFormat;
  Dec(FLevel);
  if (FCurrentElement <> nil) and (FCurrentElement.parentNode.nodeType = ELEMENT_NODE) then
    FCurrentElement := IDOMElement(FCurrentElement.parentNode)
  else
    FCurrentElement := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteAnsiString(const APropName: String; const AValue,
  ADefValue: TFDAnsiString);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, DOMString(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteString(const APropName: String;
  const AValue, ADefValue: UnicodeString);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, DOMString(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteValue(const APropName: String; APropIndex: Word;
  ADataType: TFDDataType; ABuff: Pointer; ALen: Cardinal);
const
  CDateTimeFormat = '%.4d%.2d%.2d%.2d%.2d%.2d';
  CDateTimeISO8601Format = '%.4d%.2d%.2dT%.2d%.2d%.2d';
var
  sVal: DOMString;
  s: String;
  sSign: String;
  iLen: Integer;
  oMS: TFDReadSharedMemoryStream;
  oMS2: TMemoryStream;
  y, mo, d, h, mi, se, ms: Word;
  dt: TDateTime;
  pTS: PSQLTimeStamp;
  pInt: PFDSQLTimeInterval;
  rTS: TSQLTimeStamp;
begin
  if ABuff = nil then
    Exit;
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
  dtHBFile:
    begin
      oMS := TFDReadSharedMemoryStream.Create;
      try
        WriteObjectBegin(APropName, osObject);
        if ADataType in [dtWideMemo, dtXML, dtWideHMemo] then
          ALen := ALen * SizeOf(WideChar);
        oMS.SetData(ABuff, ALen);
        Inc(FLevel);
        AddFormat;
        AddCData(oMS);
        Dec(FLevel);
        WriteObjectEnd(APropName, osObject);
      finally
        FDFree(oMS);
      end;
    end;
  dtBoolean:
    AddAttribute(APropName, S_FD_Bools[PWord(ABuff)^ <> 0]);
  dtSByte:
    AddAttribute(APropName, IntToStr(PShortInt(ABuff)^));
  dtInt16:
    AddAttribute(APropName, IntToStr(PSmallInt(ABuff)^));
  dtInt32:
    AddAttribute(APropName, IntToStr(PInteger(ABuff)^));
  dtInt64:
    AddAttribute(APropName, IntToStr(PInt64(ABuff)^));
  dtByte:
    AddAttribute(APropName, IntToStr(PByte(ABuff)^));
  dtUInt16:
    AddAttribute(APropName, IntToStr(PWord(ABuff)^));
  dtUInt32,
  dtParentRowRef:
    AddAttribute(APropName, IntToStr(PCardinal(ABuff)^));
  dtUInt64:
    AddAttribute(APropName, IntToStr(PUInt64(ABuff)^));
  dtSingle:
    AddAttribute(APropName, FDFloat2Str(PSingle(ABuff)^, '.'));
  dtDouble:
    AddAttribute(APropName, FDFloat2Str(PDouble(ABuff)^, '.'));
  dtExtended:
    AddAttribute(APropName, FDFloat2Str(PExtended(ABuff)^, '.'));
  dtCurrency:
    AddAttribute(APropName, FDCurr2Str(PCurrency(ABuff)^, '.'));
  dtBCD,
  dtFmtBCD:
    begin
      oMS2 := CheckBuffer(C_FD_MaxFixedSize);
      FDBCD2Str(PChar(oMS2.Memory), iLen, PBcd(ABuff)^, '.');
      SetString(sVal, PChar(oMS2.Memory), iLen);
      AddAttribute(APropName, sVal);
    end;
  dtDateTime:
    begin
      dt := TimeStampToDateTime(MSecsToTimeStamp(PDateTimeRec(ABuff)^.DateTime));
      DecodeDate(dt, y, mo, d);
      DecodeTime(dt, h, mi, se, ms);
      if FStreamVersion >= 9 then
        sVal := Format(CDateTimeISO8601Format, [y, mo, d, h, mi, se])
      else
        sVal := Format(CDateTimeFormat, [y, mo, d, h, mi, se]);
      AddAttribute(APropName, sVal);
    end;
  dtDateTimeStamp:
    begin
      pTS := PSQLTimeStamp(ABuff);
      if FStreamVersion >= 9 then
        AddAttribute(APropName, Format(CDateTimeISO8601Format, [pTS^.Year,
          pTS^.Month, pTS^.Day, pTS^.Hour, pTS^.Minute, pTS^.Second]))
      else
        AddAttribute(APropName, Format(CDateTimeFormat, [pTS^.Year,
          pTS^.Month, pTS^.Day, pTS^.Hour, pTS^.Minute, pTS^.Second]));
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
      AddAttribute(APropName, sVal);
    end;
  dtTime:
    begin
      rTS := FDTime2SQLTimeStamp(PInteger(ABuff)^);
      AddAttribute(APropName, Format('%.2d%.2d%.2d', [rTS.Hour, rTS.Minute, rTS.Second]));
    end;
  dtDate:
    begin
      rTS := FDDate2SQLTimeStamp(PInteger(ABuff)^);
      AddAttribute(APropName, Format('%.4d%.2d%.2d', [rTS.Year, rTS.Month, rTS.Day]));
    end;
  dtAnsiString:
    begin
      s := FEncoder.Decode(ABuff, ALen, ecANSI);
      AddAttribute(APropName, DOMString(s));
    end;
  dtWideString:
    begin
      SetString(sVal, PWideChar(ABuff), ALen);
      AddAttribute(APropName, sVal);
    end;
  dtGUID:
    AddAttribute(APropName, GUIDToString(PGUID(ABuff)^));
  end;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadValue(const APropName: String; APropIndex: Word;
  ADataType: TFDDataType; out ABuff: Pointer; out ALen: Cardinal): Boolean;
var
  oItem: IDOMNode;
  sName: DOMString;
  sVal: String;
  sb: TFDByteString;
  sw: UnicodeString;
  oMS: TMemoryStream;
  rTS: TSQLTimeStamp;
  pCh: PChar;
  i, iSign: Integer;
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
    FDException(Self, [S_FD_LStan], er_FD_StanStrgUnknownFmt, [sVal]);
  end;

begin
  ABuff := nil;
  ALen := 0;
  Result := False;
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
  dtHBFile:
    if TestObject(APropName) then begin
      ReadObjectBegin(APropName, osObject);
      oMS := CheckBuffer(0);
      ReadCData(oMS);
      ABuff := oMS.Memory;
      ALen := oMS.Size;
      if ADataType in [dtWideMemo, dtXML, dtWideHMemo] then
        ALen := ALen div SizeOf(WideChar);
      Result := True;
      ReadObjectEnd(APropName, osObject);
    end;
  else
    sName := EncodeName(APropName);
    oItem := CurrentElement.attributes.getNamedItem(sName);
    if oItem = nil then
      Exit;
    sVal := String(oItem.nodeValue);
    ABuff := CheckBuffer(C_FD_MaxFixedSize).Memory;
    Result := True;
    case ADataType of
    dtBoolean:
      PWordBool(ABuff)^ := CompareText(S_FD_True, sVal) = 0;
    dtSByte:
      PShortInt(ABuff)^ := StrToInt(sVal);
    dtInt16:
      PSmallInt(ABuff)^ := StrToInt(sVal);
    dtInt32:
      PInteger(ABuff)^ := StrToInt(sVal);
    dtInt64:
      PInt64(ABuff)^ := StrToInt64(sVal);
    dtByte:
      PByte(ABuff)^ := StrToInt(sVal);
    dtUInt16:
      PWord(ABuff)^ := StrToInt(sVal);
    dtUInt32,
    dtParentRowRef:
      PCardinal(ABuff)^ := Cardinal(StrToInt64(sVal));
    dtUInt64:
      PUInt64(ABuff)^ := StrToInt64(sVal);
    dtSingle:
      PSingle(ABuff)^ := FDStr2Float(sVal, '.');
    dtDouble:
      PDouble(ABuff)^ := FDStr2Float(sVal, '.');
    dtExtended:
      PExtended(ABuff)^ := FDStr2Float(sVal, '.');
    dtCurrency:
      PCurrency(ABuff)^ := FDStr2Curr(sVal, '.');
    dtBCD,
    dtFmtBCD:
      FDStr2BCD(PChar(sVal), Length(sVal), PBcd(ABuff)^, Char('.'));
    dtDateTime:
      begin
        if FStreamVersion >= 9 then
          i := 1
        else
          i := 0;
        FDStr2Int(PChar(sVal) + 0, 4, @rTS.Year, SizeOf(rTS.Year), True);
        FDStr2Int(PChar(sVal) + 4, 2, @rTS.Month, SizeOf(rTS.Month), True);
        FDStr2Int(PChar(sVal) + 6, 2, @rTS.Day, SizeOf(rTS.Day), True);
        if (i = 0) or ((PChar(sVal) + 8)^ = 'T') then begin
          FDStr2Int(PChar(sVal) + 8 + i, 2, @rTS.Hour, SizeOf(rTS.Hour), True);
          FDStr2Int(PChar(sVal) + 10 + i, 2, @rTS.Minute, SizeOf(rTS.Minute), True);
          FDStr2Int(PChar(sVal) + 12 + i, 2, @rTS.Second, SizeOf(rTS.Second), True);
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
        if FStreamVersion >= 9 then
          i := 1
        else
          i := 0;
        pTS := PSQLTimeStamp(ABuff);
        FDStr2Int(PChar(sVal) + 0, 4, @pTS^.Year, SizeOf(pTS^.Year), True);
        FDStr2Int(PChar(sVal) + 4, 2, @pTS^.Month, SizeOf(pTS^.Month), True);
        FDStr2Int(PChar(sVal) + 6, 2, @pTS^.Day, SizeOf(pTS^.Day), True);
        if (i = 0) or ((PChar(sVal) + 8)^ = 'T') then begin
          FDStr2Int(PChar(sVal) + 8 + i, 2, @pTS^.Hour, SizeOf(pTS^.Hour), True);
          FDStr2Int(PChar(sVal) + 10 + i, 2, @pTS^.Minute, SizeOf(pTS^.Minute), True);
          FDStr2Int(PChar(sVal) + 12 + i, 2, @pTS^.Second, SizeOf(pTS^.Second), True);
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
        pCh := PChar(sVal);
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
        FDStr2Int(PChar(sVal) + 0, 2, @rTS.Hour, SizeOf(rTS.Hour), True);
        FDStr2Int(PChar(sVal) + 2, 2, @rTS.Minute, SizeOf(rTS.Minute), True);
        FDStr2Int(PChar(sVal) + 4, 2, @rTS.Second, SizeOf(rTS.Second), True);
        rTS.Fractions := 0;
        PInteger(ABuff)^ := FDSQLTimeStamp2Time(rTS);
      end;
    dtDate:
      begin
        FDStr2Int(PChar(sVal) + 0, 4, @rTS.Year, SizeOf(rTS.Year), True);
        FDStr2Int(PChar(sVal) + 4, 2, @rTS.Month, SizeOf(rTS.Month), True);
        FDStr2Int(PChar(sVal) + 6, 2, @rTS.Day, SizeOf(rTS.Day), True);
        rTS.Hour := 0;
        rTS.Minute := 0;
        rTS.Second := 0;
        rTS.Fractions := 0;
        PInteger(ABuff)^ := FDSQLTimeStamp2Date(rTS);
      end;
    dtAnsiString:
      begin
        sb := FEncoder.Encode(sVal, ecANSI);
        ALen := FEncoder.EncodedLength(sb, ecANSI);
        ABuff := CheckBuffer(ALen * SizeOf(Byte)).Memory;
        Move(PByte(sb)^, PByte(ABuff)^, ALen * SizeOf(Byte));
      end;
    dtWideString:
      begin
        sw := oItem.nodeValue;
        ALen := Length(sw);
        ABuff := CheckBuffer(ALen * SizeOf(WideChar)).Memory;
        Move(PWideChar(sw)^, PWideChar(ABuff)^, ALen * SizeOf(WideChar));
      end;
    dtGUID:
      PGUID(ABuff)^ := StringToGUID(sVal);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDXMLStorage.ReadEnum(const APropName: String; ATypeInfo: PTypeInfo;
  ADefValue: Integer): Integer;
begin
  Result := GetEnumValue(ATypeInfo, Copy(GetCachedEnumName(ATypeInfo, Integer(ADefValue)), 1, 2) +
    ReadString(APropName, Copy(GetCachedEnumName(ATypeInfo, Integer(ADefValue)), 3, MAXINT)));
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.WriteEnum(const APropName: String; ATypeInfo: PTypeInfo;
  const AValue, ADefValue: Integer);
begin
  if AValue <> ADefValue then
    AddAttribute(APropName, DOMString(Copy(GetCachedEnumName(ATypeInfo, AValue), 3, MAXINT)));
end;

{-------------------------------------------------------------------------------}
type
  TFDXMLStorageBmk = class(TObject)
    FCurrentChildElement: IDOMElement;
    FCurrentElement: IDOMElement;
  end;

function TFDXMLStorage.GetBookmark: TObject;
begin
  Result := TFDXMLStorageBmk.Create;
  TFDXMLStorageBmk(Result).FCurrentElement := FCurrentElement;
  TFDXMLStorageBmk(Result).FCurrentChildElement := FCurrentChildElement;
end;

{-------------------------------------------------------------------------------}
procedure TFDXMLStorage.SetBookmark(const AValue: TObject);
begin
  FCurrentElement := TFDXMLStorageBmk(AValue).FCurrentElement;
  FCurrentChildElement := TFDXMLStorageBmk(AValue).FCurrentChildElement;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDXMLStorage, IFDStanStorage,
    'XML;.XML');

finalization
  FDReleaseFactory(oFact);

end.
