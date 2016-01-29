{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.TypeTrans;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

interface

uses
  System.TypInfo, System.SysUtils, Soap.InvokeRegistry;

type

  TTypeTranslator = class
  public
    constructor Create;
    destructor Destroy; override;

    function   CastSoapToNative(Info: PTypeInfo; const SoapData: InvString;
                                NatData: Pointer; IsNull: Boolean): Boolean;
    procedure  CastNativeToSoap(Info: PTypeInfo; var SoapData: InvString;
                                NatData: Pointer; var IsNull: Boolean);
    procedure  CastSoapToVariant(SoapInfo: PTypeInfo; const SoapData: InvString; NatData: Pointer); overload;
    function   CastSoapToVariant(SoapInfo: PTypeInfo; const SoapData: InvString): Variant; overload;
    procedure  Base64ToVar(NatData: Pointer; const SoapData: InvString); overload;
    procedure  Base64ToVar(var V: Variant; const SoapData: InvString); overload;
  end;

  ETypeTransException = class(Exception);

function  FloatToStrEx(Value: Extended): string;
function  StrToFloatEx(const S: string): Extended;
function  GetEnumValueEx(TypInfo: PTypeInfo; const Name: string): Integer; deprecated;
procedure SetEnumPropEx(Instance: TObject; PropInfo: PPropInfo;
                        const Value: string); deprecated;

function  GetEnumValueExW(TypInfo: PTypeInfo; const Name: InvString): Integer;
procedure SetEnumPropExW(Instance: TObject; PropInfo: PPropInfo;
                         const Value: InvString);
var
  TypeTranslator: TTypeTranslator;

implementation

uses
  System.Math, System.Types, System.Variants,
  Soap.EncdDecd, Soap.IntfInfo, Soap.SOAPConst, Soap.XSBuiltIns;


constructor TTypeTranslator.Create;
begin
  inherited Create;
end;

destructor TTypeTranslator.Destroy;
begin
  inherited;
end;

type
  PWideChar = ^WideChar;

function IsBooleanTypeInfo(TypInfo: PTypeInfo): Boolean;
begin
  Assert(TypInfo^.Kind = tkEnumeration);
  Result := GetTypeData(TypInfo)^.MinValue < 0;
  if not Result then
    Result := GetTypeData(TypInfo)^.BaseType^ = TypeInfo(System.Boolean);
end;

function TTypeTranslator.CastSoapToVariant(SoapInfo: PTypeInfo; const SoapData: InvString): Variant;
var
  I64: Int64;
begin
  case SoapInfo.Kind of
    tkString,
    tkLString,
    tkChar:
     Result  := SoapData;
    tkInt64:
      Result := StrToInt64(Trim(SoapData));
    tkInteger:
      begin
        if GetTypeData(SoapInfo).OrdType = otULong then
        begin
          I64 := StrToInt64(Trim(SoapData));
          Result := Cardinal(I64);
        end else
          Result := StrToInt(Trim(SoapData));
      end;
    tkFloat:
      Result:= StrToFloatEx(Trim(SoapData));
    tkWChar,
    tkWString:
{$IFDEF NEXTGEN}
      Result := string(Trim(SoapData));
{$ELSE !NEXTGEN}
      Result := WideString(Trim(SoapData));
{$ENDIF NEXTGEN}
{$IFDEF TIBURON_UP}
    tkUString:
      Result := UnicodeString(Trim(SoapData));
{$ENDIF}
    tkClass:
      ;
    tkSet,
    tkMethod,

    tkArray,
    tkRecord,
    tkInterface,
    tkEnumeration:
      if IsBooleanTypeInfo(SoapInfo) then
        Result := SameText(SoapData, '1') or SameText(SoapData, 'true') { Do not localize }
      else
        raise ETypeTransException.Create(SVariantCastNotSupported);

    tkDynArray:
    begin
      if SameTypeInfo(TypeInfo(System.Types.TByteDynArray), SoapInfo) then
        Base64ToVar(Result, SoapData)
      else
       raise ETypeTransException.Create(SVariantCastNotSupported);
    end;
  end;
end;


procedure TTypeTranslator.CastSoapToVariant(SoapInfo: PTypeInfo; const SoapData: InvString; NatData: Pointer);
begin
  case SoapInfo.Kind of
    tkString,
    tkLString,
    tkChar:
      Variant(PVarData(NatData)^) := SoapData;
    tkInt64:
      Variant(PVarData(NatData)^) := StrToInt64(Trim(SoapData));
    tkInteger:
      Variant(PVarData(NatData)^) := StrToInt(Trim(SoapData));
    tkFloat:
      Variant(PVarData(NatData)^) := StrToFloatEx(Trim(SoapData));
    tkWChar,
    tkWString:
{$IFDEF NEXTGEN}
      Variant(PVarData(NatData)^) := string(SoapData);
{$ELSE !NEXTGEN}
      Variant(PVarData(NatData)^) := WideString(SoapData);
{$ENDIF NEXTGEN}
{$IFDEF TIBURON_UP}
    tkUString:
      Variant(PVarData(NatData)^) := UnicodeString(SoapData);
{$ENDIF}
    tkDynArray:
      begin
        if SameTypeInfo(TypeInfo(System.Types.TByteDynArray), SoapInfo) then
          Base64ToVar(NatData, SoapData)
        else
         raise ETypeTransException.Create(SVariantCastNotSupported);
       end;
    tkClass:
      ;
    tkSet,
    tkMethod,

    tkArray,
    tkRecord,
    tkInterface,
    tkEnumeration:
      if IsBooleanTypeInfo(SoapInfo) then
        Variant(PVarData(NatData)^) := SameText(SoapData, '1') or SameText(SoapData, 'true')
      else
        raise ETypeTransException.Create(SVariantCastNotSupported);
  else
    raise ETypeTransException.Create(SVariantCastNotSupported);
  end;
end;

{ Convert string to Enum value }
function GetEnumValueEx(TypInfo: PTypeInfo; const Name: string): Integer;
var
  PName: string;
begin
  PName := Name;
  if IsBooleanTypeInfo(TypInfo) then
  begin
    if SameText(Name, 'true') or SameText(Name, '1') then         { Do not localize }
      PName := 'True'                                             { Do not localize }
    else if SameText(Name, 'false') or SameText(Name, '0') then   { Do not localize }
      PName := 'False';                                           { Do not localize }
    Result := GetEnumValue(TypeInfo(System.Boolean), PName);
  end else
  begin
    { Here check whether this enumeration has been renamed }
    PName := RemTypeRegistry.GetInternalPropName(TypInfo, PName);
    Result := GetEnumValue(TypInfo, PName);
  end;
end;

procedure SetEnumPropEx(Instance: TObject; PropInfo: PPropInfo; const Value: string);
var
  Val: string;
  TypInfo: PTypeInfo;
begin
  TypInfo := PropInfo.PropType^;
  if IsBooleanTypeInfo(TypInfo) then
  begin
    if SameText(Value, 'true') or SameText(Value, '1') then
      Val := 'True'
    else if SameText(Value, 'false') or SameText(Value, '0') then
      Val := 'False';
    SetEnumProp(Instance, PropInfo, Val);
  end else
  begin
    Val := RemClassRegistry.GetInternalPropName(TypInfo, Value);
    SetEnumProp(Instance, PropInfo, Val);
  end;
end;

function GetEnumValueExW(TypInfo: PTypeInfo; const Name: InvString): Integer;
var
  PName: string;
begin
  if IsBooleanTypeInfo(TypInfo) then
  begin
    if SameText(Name, 'true') or SameText(Name, '1') then         { Do not localize }
      PName := 'True'                                             { Do not localize }
    else if SameText(Name, 'false') or SameText(Name, '0') then   { Do not localize }
      PName := 'False';                                           { Do not localize }
    Result := GetEnumValue(TypeInfo(System.Boolean), PName);
  end else
  begin
    { Here check whether this enumeration has been renamed }
    PName := RemTypeRegistry.GetInternalPropName(TypInfo, Name);
    Result := GetEnumValue(TypInfo, PName);
  end;
end;

procedure SetEnumPropExW(Instance: TObject; PropInfo: PPropInfo;
                         const Value: InvString);
var
  Val: string;
  TypInfo: PTypeInfo;
begin
  TypInfo := PropInfo.PropType^;
  if IsBooleanTypeInfo(TypInfo) then
  begin
    if SameText(Value, 'true') or SameText(Value, '1') then
      Val := 'True'
    // The logic handles ( Value = '' ) for when a nillable xsd:boolean is
    // mapped to System.Boolean/bool. TXSBoolean would be better then but ...
    else if SameText(Value, 'false') or SameText(Value, '0') or (Value = '') then
      Val := 'False';
    SetEnumProp(Instance, PropInfo, Val);
  end else
  begin
    if Value <> '' then
    begin
      Val := RemClassRegistry.GetInternalPropName(TypInfo, Value);
      SetEnumProp(Instance, PropInfo, Val);
    end else
      SetOrdProp(Instance, PropInfo, 0);
  end;
end;

{ Convert String to Float }
function StrToFloatEx(const S: string): Extended;
begin
  if SameText(S, 'NaN') then
    Result := Nan
  else if SameText(S, 'INF') then
    Result := Infinity
  else if SameText(S, '-INF') then
    Result := NegInfinity
  else
    Result := SoapStrToFloat(S);
end;

function IsNeg(const AValue: Double): Boolean;
begin
  Result := ((PInt64(@AValue)^ and $8000000000000000) = $8000000000000000);
end;

{ Convert float to String }
function FloatToStrEx(Value: Extended): string;
begin
  if IsNan(Value) then
    Result := 'NaN'
  else if IsInfinite(Value) then
  begin
    { +|- ve }
    if isNeg(Value) then
      Result := '-INF'
    else
      Result := 'INF';
  end
  else
    Result := SoapFloatToStr(Value);
end;

function  TTypeTranslator.CastSoapToNative(Info: PTypeInfo; const SoapData: InvString; NatData: Pointer; IsNull: Boolean): Boolean;

const
{$IFDEF NEXTGEN}
  sDefaultValues: array[TTypeKind] of string = (
{$ELSE !NEXTGEN}
  sDefaultValues: array[TTypeKind] of WideString = (
{$ENDIF NEXTGEN}
    {tkUnknown}'', {tkInteger}'0', {tkChar}#0,    {tkEnumeration}'',
    {tkFloat}'0',  {tkString}'',   {tkSet}'',     {tkClass}'',
    {tkMethod}'',  {tkWChar}#0,    {tkLString}'', {tkWString}'',
    {tkVariant}'', {tkArray}'',    {tkRecord}'',  {tkInterface}'',
    {tkInt64}'0',  {tkDynArray}''
{$IFDEF TIBURON_UP}
    ,{tkUString}''
{$ENDIF}
    ,{tkClassRef}''
    ,{tkPointer}''
    ,{tkProcedure}''
  );

  function Check(const SoapData: InvString): InvString;
  begin
    if not IsNull then
      Result := Trim(SoapData)
    else
      Result := sDefaultValues[Info^.Kind];
  end;

var
  ParamTypeData: PTypeData;
begin
  Result := True;
  if IsNull and (Info.Kind = tkVariant) then
  begin
    Variant(PVarData(NatData)^) := NULL;
    Exit;
  end;
  ParamTypeData := GetTypeData(Info);
  case Info^.Kind of
    tkInteger:
      case ParamTypeData^.OrdType of
        otSByte,
        otUByte:
          PByte(NatData)^ := StrToInt(Check(SoapData));
        otSWord,
        otUWord:
          PSmallInt(NatData)^ := StrToInt(Check(SoapData));
        otSLong,
        otULong:
          PInteger(NatData)^ := StrToInt(Check(SoapData));
      end;
    tkFloat:
      case ParamTypeData^.FloatType of
        ftSingle:
          PSingle(NatData)^ := StrToFloatEx(Check(SoapData));
        ftDouble:
        begin
          if Info = TypeInfo(TDateTime) then
            PDateTime(NatData)^ := XMLTimeToDateTime(Check(SoapData))
          else
            PDouble(NatData)^ := StrToFloatEx(Check(SoapData));
        end;

        ftComp:
          PComp(NatData)^ := StrToFloatEx(Check(SoapData));
        ftCurr:
          PCurrency(NatData)^ := StrToFloatEx(Check(SoapData));
        ftExtended:
          PExtended(NatData)^ := StrToFloatEx(Check(SoapData));
      end;
{$IFNDEF NEXTGEN}
    tkWString:
      PWideString(NatData)^ := SoapData;
    tkString:
      PShortString(NatData)^ := ShortString(SoapData);
    tkLString:
      PAnsiString(NatData)^ := AnsiString(SoapData);
{$ENDIF !NEXTGEN}
{$IFDEF TIBURON_UP}
    tkUString:
      PUnicodeString(NatData)^ := SoapData;
{$ENDIF}
    tkChar:
      if SoapData <> '' then
        PChar(NatData)^ := Char(SoapData[Low(string)]);
    tkWChar:
      if SoapData <> '' then
        PWideChar(NatData)^ := WideChar(SoapData[Low(string)]);
    tkInt64:
      PInt64(NatData)^ := StrToInt64(Check(SoapData));

    tkEnumeration:
      { NOTE: Here we assume enums to be byte-size; make sure (specially for C++)
              that enums are generated with the proper size }
      if SoapData <> '' then
        PByte(NatData)^ := GetEnumValueExW(Info, Check(SoapData))
      else
        PByte(NatData)^ := 0;
    tkClass:
      ;
    tkSet,
    tkMethod,

    tkArray,
    tkRecord,
    tkInterface,

    tkDynArray:
      raise ETypeTransException.CreateFmt(SUnexpectedDataType, [KindNameArray[Info.Kind]] );
    tkVariant:
      { NOTE: Null case handled above }
      CastSoapToVariant(Info, SoapData, NatData);
  end;
end;

procedure TTypeTranslator.CastNativeToSoap(Info: PTypeInfo;
     var SoapData: InvString; NatData: Pointer; var IsNull: Boolean);
var
  TypeData: PTypeData;
begin
  IsNull := False;
  TypeData := GetTypeData(Info);
  case Info.Kind of
    tkInteger:
      case TypeData.OrdType of
        otSByte,
        otUByte:
          SoapData := IntToStr(byte(NatData^) );
        otSWord:
          SoapData := IntToStr(SmallInt(NatData^));
        otUWord:
           SoapData := IntToStr(SmallInt(NatData^));
        otSLong,
        otULong:
          SoapData := IntToStr(Integer(NatData^));
      end;
    tkFloat:
      case TypeData.FloatType of
        ftSingle:
          SoapData := FloatToStrEx(Single(NatData^));
        ftDouble:
        begin
          if Info = TypeInfo(TDateTime) then
            SoapData := DateTimeToXMLTime(TDateTime(NatData^), True)
          else
            SoapData := FloatToStrEx(Double(NatData^));
        end;
        ftComp:
          SoapData := FloatToStrEx(Comp(NatData^));
        ftCurr:
          SoapData := FloatToStrEx(Currency(NatData^));
        ftExtended:
         SoapData := FloatToStrEx(Extended(NatData^));
      end;
    tkInt64:
      SoapData := IntToStr(Int64(NatData^));
    tkChar:
      SoapData := Char(NatData^);
    tkWChar:
      SoapData := WideChar(NatData^);
{$IFNDEF NEXTGEN}
    tkWString:
      SoapData  := PWideString(NatData)^;
    tkString:
      SoapData := InvString(PShortString(NatData)^);
    tkLString:
      SoapData := InvString(PAnsiString(NatData)^);
{$ENDIF !NEXTGEN}
{$IFDEF TIBURON_UP}
    tkUString:
      SoapData := PUnicodeString(NatData)^;
{$ENDIF}
  end;
end;

procedure TTypeTranslator.Base64ToVar(var V: Variant; const SoapData: InvString);
var
{$IFNDEF UNICODE}
  Base64Dec: string;
{$ELSE}
  Base64Dec: TBytes;
{$ENDIF}
  P: Pointer;
begin
{$IFNDEF UNICODE}
  Base64Dec := DecodeString(SoapData);
{$ELSE}
{$IFDEF NEXTGEN}
  Base64Dec := DecodeBase64(SoapData);
{$ELSE !NEXTGEN}
  Base64Dec := DecodeBase64(AnsiString(SoapData));
{$ENDIF NEXTGEN}
{$ENDIF}
  V :=  VarArrayCreate([0, Length(Base64Dec) - 1], varByte);
  P := VarArrayLock(V);
  try
{$IFNDEF UNICODE}
    Move(Base64Dec[1], P^, Length(Base64Dec));
{$ELSE}
    Move(Base64Dec[0], P^, Length(Base64Dec));
{$ENDIF}
  finally
    VarArrayUnLock(V);
  end;
end;

procedure TTypeTranslator.Base64ToVar(NatData: Pointer; const SoapData: InvString);
begin
  Base64ToVar(PVariant(PVarData(NatData))^, SoapData);
end;


initialization
  TypeTranslator := TTypeTranslator.Create;

finalization
  TypeTranslator.Free;

end.
