{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC SQL Time Interval data type          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

                                                
                                                                 

unit FireDAC.Stan.SQLTimeInt;

interface

uses
  System.Variants;

type
  TFDSQLTimeIntervalKind = (itUnknown, itYear, itMonth, itDay, itHour, itMinute,
    itSecond, itYear2Month, itDay2Hour, itDay2Minute, itDay2Second, itHour2Minute,
    itHour2Second, itMinute2Second);

  TFDSQLTimeInterval = packed record
    Sign: Shortint;
    case Kind: TFDSQLTimeIntervalKind of
    itYear, itMonth, itYear2Month: (
      Years: Cardinal;
      Months: Cardinal
    );
    itDay, itHour, itMinute, itSecond, itDay2Hour, itDay2Minute,
    itDay2Second, itHour2Minute, itHour2Second, itMinute2Second: (
      Days: Cardinal;
      Hours: Cardinal;
      Minutes: Cardinal;
      Seconds: Cardinal;
      Fractions: Cardinal
    );
  end;
  PFDSQLTimeInterval = ^TFDSQLTimeInterval;

function FDVarSQLTimeIntervalCreate: Variant; overload;
function FDVarSQLTimeIntervalCreate(const AValue: string): Variant; overload;
function FDVarSQLTimeIntervalCreate(const AValue: TFDSQLTimeInterval): Variant; overload;
function FDVarSQLTimeInterval: TVarType;
function FDVarIsSQLTimeInterval(const AValue: Variant): Boolean; overload;
function FDVar2SQLTimeInterval(const AValue: Variant): TFDSQLTimeInterval;

function FDStr2SQLTimeInterval(const AValue: String): TFDSQLTimeInterval;
function FDSQLTimeInterval2Str(const AValue: TFDSQLTimeInterval): String;
function FDSQLTimeIntervalCompare(const AValue1, AValue2: TFDSQLTimeInterval): Integer;
function FDSQLTimeIntervalCast(const AValue: TFDSQLTimeInterval;
  AKind: TFDSQLTimeIntervalKind): TFDSQLTimeInterval;

const
  C_NullSQLTimeInterval: TFDSQLTimeInterval = (Sign: 0; Kind: itUnknown; Days: 0;
    Hours: 0; Minutes: 0; Seconds: 0; Fractions: 0);

implementation

uses
  System.SysUtils, System.Classes, System.TypInfo, System.SysConst, Data.SQLTimSt,
  FireDAC.Stan.Intf, FireDAC.Stan.Util;

{ ----------------------------------------------------------------------------- }
{ TFDSQLTimeIntervalVariantType                                                 }
{ ----------------------------------------------------------------------------- }
type
  TFDSQLTimeIntervalData = class(TPersistent)
  private
    FInterval: TFDSQLTimeInterval;
    procedure CheckIntervalsCompatibility(const AInt1, AInt2: TFDSQLTimeInterval);
    procedure NotInitError;
    function GetIsBlankBase(const AInterval: TFDSQLTimeInterval): Boolean;
    function GetIsBlank: Boolean;
    function GetIsNegative: Boolean;
    procedure DoIncrementBase(const AInterval: TFDSQLTimeInterval; ASign: Integer); overload;
    procedure DoIncrementBase(const AValue: Integer; ASign: Integer); overload;
    procedure DoAddToBase(var ADateTime: TSQLTimeStamp; ASign: Integer);
    function GetAsString: string;
    procedure SetAsString(const AValue: string);

  public
    // the many ways to create
    constructor Create(const AText: string); overload;
    constructor Create(const ASQLTimeInterval: TFDSQLTimeInterval); overload;
    constructor Create(const ASource: TFDSQLTimeIntervalData); overload;

    // access to the private bits
    property Interval: TFDSQLTimeInterval read FInterval write FInterval;
    property IsBlank: Boolean read GetIsBlank;
    property IsNegative: Boolean read GetIsNegative;

    // non-destructive operations
    function Compare(const AValue: TFDSQLTimeInterval): TVarCompareResult;
    procedure DoAddTo(var ADateTime: TSQLTimeStamp);
    procedure DoSubFrom(var ADateTime: TSQLTimeStamp);

    // destructive operations
    procedure DoSubstract(const ADateTime1, ADateTime2: TSQLTimeStamp); overload;
    procedure DoInc(const AInterval: TFDSQLTimeInterval); overload;
    procedure DoInc(const AValue: Integer); overload;
    procedure DoDec(const AInterval: TFDSQLTimeInterval); overload;
    procedure DoDec(const AValue: Integer); overload;
    procedure CastToKind(AKind: TFDSQLTimeIntervalKind);
    procedure DoMultiply(AValue: Integer);
    procedure DoDivide(AValue: Integer);
    procedure DoNegate;

  published
    // conversion
    property AsString: string read GetAsString write SetAsString;
    property Sign: Shortint read FInterval.Sign write FInterval.Sign;
    property Kind: TFDSQLTimeIntervalKind read FInterval.Kind write FInterval.Kind;
    property Years: Cardinal read FInterval.Years write FInterval.Years;
    property Month: Cardinal read FInterval.Months write FInterval.Months;
    property Days: Cardinal read FInterval.Days write FInterval.Days;
    property Hour: Cardinal read FInterval.Hours write FInterval.Hours;
    property Minute: Cardinal read FInterval.Minutes write FInterval.Minutes;
    property Second: Cardinal read FInterval.Seconds write FInterval.Seconds;
    property Fractions: Cardinal read FInterval.Fractions write FInterval.Fractions;
  end;

  TFDSQLTimeIntervalVariantType = class(TPublishableVariantType)
  protected
    function GetInstance(const V: TVarData): TObject; override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean); override;
    procedure Cast(var Dest: TVarData; const Source: TVarData); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData; const AVarType: TVarType); override;
    function RightPromotion(const V: TVarData; const Operator: TVarOp; out RequiredVarType: TVarType): Boolean; override;
    procedure BinaryOp(var Left: TVarData; const Right: TVarData; const Operator: TVarOp); override;
    procedure UnaryOp(var Right: TVarData; const Operator: TVarOp); override;
    procedure Compare(const Left, Right: TVarData; var Relationship: TVarCompareResult); override;
  end;

  PFDSQLTimeIntervalVarData = ^TFDSQLTimeIntervalVarData;
  TFDSQLTimeIntervalVarData = packed record
    VType: TVarType;
    Reserved1, Reserved2, Reserved3: Word;
    VInterval: TFDSQLTimeIntervalData;
    Reserved4: Cardinal;
  end;

var
  GSQLTimeIntervalVariantType: TFDSQLTimeIntervalVariantType = nil;

{-------------------------------------------------------------------------------}
{ TFDSQLTimeIntervalData                                                        }
{-------------------------------------------------------------------------------}
constructor TFDSQLTimeIntervalData.Create(const AText: string);
begin
  inherited Create;
  SetAsString(AText);
end;

{-------------------------------------------------------------------------------}
constructor TFDSQLTimeIntervalData.Create(const ASQLTimeInterval: TFDSQLTimeInterval);
begin
  inherited Create;
  FInterval := ASQLTimeInterval;
end;

{-------------------------------------------------------------------------------}
constructor TFDSQLTimeIntervalData.Create(const ASource: TFDSQLTimeIntervalData);
begin
  Create(ASource.FInterval);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.CheckIntervalsCompatibility(
  const AInt1, AInt2: TFDSQLTimeInterval);
begin
  if not (
     (AInt1.Kind in [itYear, itMonth, itYear2Month]) and
     (AInt2.Kind in [itYear, itMonth, itYear2Month]) or
     (AInt1.Kind in [itDay, itHour, itMinute, itSecond, itDay2Hour, itDay2Minute,
                     itDay2Second, itHour2Minute, itHour2Second, itMinute2Second]) and
     (AInt2.Kind in [itDay, itHour, itMinute, itSecond, itDay2Hour, itDay2Minute,
                     itDay2Second, itHour2Minute, itHour2Second, itMinute2Second])) then
    raise EVariantError.Create('Cannot substruct intervals of incompatible kinds');
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.NotInitError;
begin
  raise EVariantError.Create('Cannot perform operation on non initialized interval value');
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalData.GetIsBlankBase(const AInterval: TFDSQLTimeInterval): Boolean;
begin
  Result := (AInterval.Sign = 0) and (AInterval.Kind = itUnknown) or
    (AInterval.Days = 0) and (AInterval.Hours = 0) and (AInterval.Minutes = 0) and
    (AInterval.Seconds = 0) and (AInterval.Fractions = 0);
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalData.GetIsBlank: Boolean;
begin
  Result := GetIsBlankBase(FInterval);
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalData.GetIsNegative: Boolean;
begin
  Result := FInterval.Sign < 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoSubstract(const ADateTime1, ADateTime2: TSQLTimeStamp);
var
  dVal: Double;
  lNeg: Boolean;
  wHour, wMin, wSec, wMSec: Word;
begin
  dVal := SQLTimeStampToDateTime(ADateTime1) - SQLTimeStampToDateTime(ADateTime2);
  if dVal < 0 then begin
    lNeg := True;
    dVal := Abs(dVal);
  end
  else
    lNeg := False;

  if lNeg then
    FInterval.Sign := -1
  else
    FInterval.Sign := 1;
  FInterval.Kind := itDay2Second;
  FInterval.Days := Trunc(dVal);

  DecodeTime(Frac(dVal), wHour, wMin, wSec, wMSec);
  FInterval.Hours := wHour;
  FInterval.Minutes := wMin;
  FInterval.Seconds := wSec;
  FInterval.Fractions := wMSec;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoAddToBase(var ADateTime: TSQLTimeStamp;
  ASign: Integer);
var
  iSign, iVal: Integer;
  d: TDateTime;
begin
  if IsBlank then
    Exit;

  if (ASign < 0) xor (FInterval.Sign < 0) then
    iSign := -1
  else
    iSign := 1;
  case Kind of
  itYear,
  itMonth,
  itYear2Month:
    begin
      ADateTime.Year := ADateTime.Year + iSign * Integer(FInterval.Years);
      iVal := Integer(ADateTime.Month) + iSign * Integer(FInterval.Months);
      ADateTime.Year := ADateTime.Year + iVal div 12;
      iVal := iVal mod 12;
      if iVal < 0 then begin
        Dec(ADateTime.Year);
        ADateTime.Month := Word(12 + iVal);
      end
      else
        ADateTime.Month := Word(iVal);
    end;
  itDay,
  itHour,
  itMinute,
  itSecond,
  itDay2Hour,
  itDay2Minute,
  itDay2Second,
  itHour2Minute,
  itHour2Second,
  itMinute2Second:
    begin
      d := SQLTimeStampToDateTime(ADateTime);
      d := d + iSign * Integer(FInterval.Days);
      d := d + iSign * MSecsPerDay / (((FInterval.Hours * 60 + FInterval.Minutes) * 60 + FInterval.Seconds) * 1000 + FInterval.Fractions);
      ADateTime := DateTimeToSQLTimeStamp(d);
    end;
  else
    NotInitError;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoAddTo(var ADateTime: TSQLTimeStamp);
begin
  DoAddToBase(ADateTime, 1);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoSubFrom(var ADateTime: TSQLTimeStamp);
begin
  DoAddToBase(ADateTime, -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoIncrementBase(const AInterval: TFDSQLTimeInterval;
  ASign: Integer);
var
  iMonths: Int64;
  iFractions: Int64;
  iSignMy, iSignArg: Integer;
begin
  if GetIsBlankBase(AInterval) then
    Exit;

  if (ASign < 0) xor (AInterval.Sign < 0) then
    iSignArg := -1
  else
    iSignArg := 1;
  if IsBlank then begin
    FInterval := AInterval;
    FInterval.Sign := iSignArg;
    Exit;
  end;

  CheckIntervalsCompatibility(FInterval, AInterval);
  iMonths := 0;
  iFractions := 0;
  if FInterval.Sign < 0 then
    iSignMy := -1
  else
    iSignMy := 1;
  case Kind of
  itYear,
  itMonth,
  itYear2Month:
    begin
      iMonths :=
        iSignMy * (Int64(FInterval.Years) * 12 + Int64(FInterval.Months)) +
        iSignArg * (Int64(AInterval.Years) * 12 + Int64(AInterval.Months));
      if iMonths < 0 then begin
        iMonths := Abs(iMonths);
        iSignMy := -1;
      end
      else
        iSignMy := 1;
    end;
  itDay,
  itHour,
  itMinute,
  itSecond,
  itDay2Hour,
  itDay2Minute,
  itDay2Second,
  itHour2Minute,
  itHour2Second,
  itMinute2Second:
    begin
      iFractions :=
        iSignMy * ((((Int64(FInterval.Days) * 24 + Int64(FInterval.Hours)) * 60 + Int64(FInterval.Minutes)) * 60 +
          Int64(FInterval.Seconds)) * 1000 + Int64(FInterval.Fractions)) +
        iSignArg * ((((Int64(AInterval.Days) * 24 + Int64(AInterval.Hours)) * 60 + Int64(AInterval.Minutes)) * 60 +
          Int64(AInterval.Seconds)) * 1000 + Int64(AInterval.Fractions));
      if iFractions < 0 then begin
        iFractions := Abs(iFractions);
        iSignMy := -1;
      end
      else
        iSignMy := 1;
    end;
  else
    NotInitError;
  end;

  FInterval.Sign := iSignMy;
  FInterval.Days := 0;
  FInterval.Hours := 0;
  FInterval.Minutes := 0;
  FInterval.Seconds := 0;
  FInterval.Fractions := 0;

  case FInterval.Kind of
  itYear:
    FInterval.Years := iMonths div 12;
  itMonth:
    FInterval.Months := iMonths;
  itYear2Month:
    begin
      FInterval.Years := iMonths div 12;
      FInterval.Months := iMonths mod 12;
    end;
  itDay:
    FInterval.Days := iFractions div (1000 * SecsPerDay);
  itHour:
    FInterval.Hours := iFractions div (1000 * SecsPerHour);
  itMinute:
    FInterval.Hours := iFractions div (1000 * SecsPerMin);
  itSecond:
    FInterval.Hours := iFractions div 1000;
  itDay2Hour:
    begin
      FInterval.Days := iFractions div (1000 * SecsPerDay);
      iFractions := iFractions - Int64(FInterval.Days) * 1000 * SecsPerDay;
      FInterval.Hours := iFractions div (1000 * SecsPerHour);
    end;
  itDay2Minute:
    begin
      FInterval.Days := iFractions div (1000 * SecsPerDay);
      iFractions := iFractions - Int64(FInterval.Days) * 1000 * SecsPerDay;
      FInterval.Hours := iFractions div (1000 * SecsPerHour);
      iFractions := iFractions - Int64(FInterval.Hours) * 1000 * SecsPerHour;
      FInterval.Minutes := iFractions div (1000 * SecsPerMin);
    end;
  itDay2Second:
    begin
      FInterval.Days := iFractions div (1000 * SecsPerDay);
      iFractions := iFractions - Int64(FInterval.Days) * 1000 * SecsPerDay;
      FInterval.Hours := iFractions div (1000 * SecsPerHour);
      iFractions := iFractions - Int64(FInterval.Hours) * 1000 * SecsPerHour;
      FInterval.Minutes := iFractions div (1000 * SecsPerMin);
      iFractions := iFractions - Int64(FInterval.Minutes) * 1000 * SecsPerMin;
      FInterval.Seconds := iFractions div 1000;
      FInterval.Fractions := iFractions - Int64(FInterval.Seconds) * 1000;
    end;
  itHour2Minute:
    begin
      FInterval.Hours := iFractions div (1000 * SecsPerHour);
      iFractions := iFractions - Int64(FInterval.Hours) * 1000 * SecsPerHour;
      FInterval.Minutes := iFractions div (1000 * SecsPerMin);
    end;
  itHour2Second:
    begin
      FInterval.Hours := iFractions div (1000 * SecsPerHour);
      iFractions := iFractions - Int64(FInterval.Hours) * 1000 * SecsPerHour;
      FInterval.Minutes := iFractions div (1000 * SecsPerMin);
      iFractions := iFractions - Int64(FInterval.Minutes) * 1000 * SecsPerMin;
      FInterval.Seconds := iFractions div 1000;
      FInterval.Fractions := iFractions - Int64(FInterval.Seconds) * 1000;
    end;
  itMinute2Second:
    begin
      FInterval.Minutes := iFractions div (1000 * SecsPerMin);
      iFractions := iFractions - Int64(FInterval.Minutes) * 1000 * SecsPerMin;
      FInterval.Seconds := iFractions div 1000;
      FInterval.Fractions := iFractions - Int64(FInterval.Seconds) * 1000;
    end;
  else
    NotInitError;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoInc(const AInterval: TFDSQLTimeInterval);
begin
  DoIncrementBase(AInterval, 1);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoDec(const AInterval: TFDSQLTimeInterval);
begin
  DoIncrementBase(AInterval, -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoIncrementBase(const AValue: Integer; ASign: Integer);
var
  rInt: TFDSQLTimeInterval;
begin
  FillChar(rInt, SizeOf(rInt), 0);
  rInt.Sign := 1;
  rInt.Kind := FInterval.Kind;
  case FInterval.Kind of
  itYear:
    rInt.Years := AValue;
  itMonth,
  itYear2Month:
    rInt.Months := AValue;
  itDay:
    rInt.Days := AValue;
  itHour,
  itDay2Hour:
    rInt.Hours := AValue;
  itMinute,
  itDay2Minute,
  itHour2Minute:
    rInt.Minutes := AValue;
  itSecond,
  itDay2Second,
  itHour2Second,
  itMinute2Second:
    rInt.Seconds := AValue;
  else
    NotInitError;
  end;
  DoIncrementBase(rInt, ASign);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoInc(const AValue: Integer);
begin
  DoIncrementBase(AValue, 1);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoDec(const AValue: Integer);
begin
  DoIncrementBase(AValue, -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoDivide(AValue: Integer);
begin
  if AValue < 0 then begin
    AValue := Abs(AValue);
    DoNegate;
  end;
  case FInterval.Kind of
  itYear,
  itMonth,
  itYear2Month:
    begin
      FInterval.Years := FInterval.Years div Cardinal(AValue);
      FInterval.Months := FInterval.Months div Cardinal(AValue);
    end;
  itDay,
  itHour,
  itMinute,
  itSecond,
  itDay2Hour,
  itDay2Minute,
  itDay2Second,
  itHour2Minute,
  itHour2Second,
  itMinute2Second:
    begin
      FInterval.Days := FInterval.Days div Cardinal(AValue);
      FInterval.Hours := FInterval.Hours div Cardinal(AValue);
      FInterval.Minutes := FInterval.Minutes div Cardinal(AValue);
      FInterval.Seconds := FInterval.Seconds div Cardinal(AValue);
      FInterval.Fractions := FInterval.Fractions div Cardinal(AValue);
    end;
  else
    NotInitError;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoMultiply(AValue: Integer);
begin
  if AValue < 0 then begin
    AValue := Abs(AValue);
    DoNegate;
  end;
  case FInterval.Kind of
  itYear,
  itMonth,
  itYear2Month:
    begin
      FInterval.Years := FInterval.Years * Cardinal(AValue);
      FInterval.Months := FInterval.Months * Cardinal(AValue);
    end;
  itDay,
  itHour,
  itMinute,
  itSecond,
  itDay2Hour,
  itDay2Minute,
  itDay2Second,
  itHour2Minute,
  itHour2Second,
  itMinute2Second:
    begin
      FInterval.Days := FInterval.Days * Cardinal(AValue);
      FInterval.Hours := FInterval.Hours * Cardinal(AValue);
      FInterval.Minutes := FInterval.Minutes * Cardinal(AValue);
      FInterval.Seconds := FInterval.Seconds * Cardinal(AValue);
      FInterval.Fractions := FInterval.Fractions * Cardinal(AValue);
    end;
  else
    NotInitError;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.DoNegate;
begin
  if FInterval.Sign < 0 then
    FInterval.Sign := 1
  else
    FInterval.Sign := -1;
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalData.Compare(const AValue: TFDSQLTimeInterval): TVarCompareResult;
var
  oData: TFDSQLTimeIntervalData;
begin
  oData := TFDSQLTimeIntervalData.Create(FInterval);
  try
    oData.DoDec(AValue);
    if oData.IsBlank then
      Result := crEqual
    else if oData.IsNegative then
      Result := crLessThan
    else
      Result := crGreaterThan;
  finally
    FDFree(oData);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalData.GetAsString: string;
begin
  if IsBlank then
    Result := ''
  else begin
    case FInterval.Kind of
    itYear,
    itMonth,
    itYear2Month:
      Result := Format('%u-%.2u', [FInterval.Years, FInterval.Months]);
    itDay:
      Result := Format('%u', [FInterval.Days]);
    itDay2Hour,
    itDay2Minute,
    itDay2Second:
      begin
        Result := Format('%u %.2u:%.2u:%.2u', [FInterval.Days, FInterval.Hours,
          FInterval.Minutes, FInterval.Seconds]);
        if FInterval.Fractions <> 0 then
          Result := Result + Format('.%.3u', [FInterval.Fractions]);
      end;
    itHour,
    itMinute,
    itSecond,
    itHour2Minute,
    itHour2Second,
    itMinute2Second:
      begin
        Result := Format('%u:%.2u:%.2u', [FInterval.Hours, FInterval.Minutes,
          FInterval.Seconds]);
        if FInterval.Fractions <> 0 then
          Result := Result + Format('.%.3u', [FInterval.Fractions]);
      end;
    else
      NotInitError;
    end;
    if FInterval.Sign < 0 then
      Result := '-' + Result;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.SetAsString(const AValue: string);
var
  pCh, pSep: PChar;
  iSign: Integer;

  procedure NextGroup;
  begin
    while pCh^ = ' ' do
      Inc(pCh);
    if pCh^ = '-' then begin
      iSign := -1;
      Inc(pCh);
    end
    else if pCh^ = '+' then
      Inc(pCh);
  end;

  function NextItem(out APart: Cardinal; ADelim: Char; ARequired: Boolean): Boolean;
  begin
    if pCh^ = #0 then begin
      Result := False;
      Exit;
    end;
    pSep := StrScan(pCh, ADelim);
    Result := pSep <> nil;
    if not Result then
      if ARequired then
        Exit
      else
        pSep := PChar(AValue) + Length(AValue);
    FDStr2Int(pCh, pSep - pCh, @APart, SizeOf(APart), True);
    if pSep^ = #0 then
      pCh := pSep
    else
      pCh := pSep + 1;
  end;

  procedure Error;
  begin
    raise EVariantError.CreateFmt('[%s] is not a valid interval', [AValue]);
  end;

begin
  FillChar(FInterval, SizeOf(FInterval), 0);
  if AValue = '' then
    Exit;

  pCh := PChar(AValue);
  iSign := 1;
  NextGroup;
  if NextItem(FInterval.Years, '-', True) then begin
    NextItem(FInterval.Months, ' ', False);
    FInterval.Kind := itYear2Month;
  end
  else begin
    NextGroup;
    if NextItem(FInterval.Days, ' ', True) then
      FInterval.Kind := itDay;

    NextGroup;
    if NextItem(FInterval.Hours, ':', True) then begin
      NextItem(FInterval.Minutes, ':', False);
      NextItem(FInterval.Seconds, '.', False);
      NextItem(FInterval.Fractions, #0, False);
      if FInterval.Kind = itDay then
        FInterval.Kind := itDay2Second
      else
        FInterval.Kind := itHour2Second;
    end;
  end;
  if (pCh^ <> #0) or (FInterval.Kind = itUnknown) then
    Error;
  FInterval.Sign := iSign;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalData.CastToKind(AKind: TFDSQLTimeIntervalKind);
var
  oData: TFDSQLTimeIntervalData;
begin
  oData := TFDSQLTimeIntervalData.Create(C_NullSQLTimeInterval);
  try
    oData.Kind := AKind;
    oData.DoInc(Interval);
    Interval := oData.Interval;
  finally
    FDFree(oData);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDSQLTimeIntervalVariantType                                                 }
{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalVariantType.GetInstance(const V: TVarData): TObject;
begin
  Result := PFDSQLTimeIntervalVarData(@V)^.VInterval;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.Clear(var V: TVarData);
begin
  V.VType := varEmpty;
  FDFreeAndNil(PFDSQLTimeIntervalVarData(@V)^.VInterval);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.Cast(var Dest: TVarData; const Source: TVarData);
var
  LSource: TVarData;
begin
  VarDataInit(LSource);
  try
    VarDataCopyNoInd(LSource, Source);
    if VarDataIsStr(LSource) then
      PFDSQLTimeIntervalVarData(@Dest)^.VInterval := TFDSQLTimeIntervalData.Create(VarDataToStr(LSource))
    else
      RaiseCastError;
    Dest.VType := VarType;
  finally
    VarDataClear(LSource);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.CastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
begin
  if Source.VType = VarType then
    case AVarType of
{$IFNDEF NEXTGEN}
      varOleStr:
        VarDataFromOleStr(Dest, PFDSQLTimeIntervalVarData(@Source)^.VInterval.AsString);
{$ELSE}
      varOleStr,
{$ENDIF}
      varUString,
      varString:
        VarDataFromStr(Dest, PFDSQLTimeIntervalVarData(@Source)^.VInterval.AsString);
      else
        RaiseCastError;
    end
  else
    inherited;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.Copy(var Dest: TVarData;
  const Source: TVarData; const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else begin
    PFDSQLTimeIntervalVarData(@Dest)^.VType := VarType;
    PFDSQLTimeIntervalVarData(@Dest)^.VInterval :=
      TFDSQLTimeIntervalData.Create(PFDSQLTimeIntervalVarData(@Source)^.VInterval);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalVariantType.RightPromotion(const V: TVarData;
  const Operator: TVarOp; out RequiredVarType: TVarType): Boolean;
begin
  RequiredVarType := VarType;
  Result := True;
  case Operator of
    opAdd:
      if VarIsSQLTimeStamp(Variant(V)) then
        RequiredVarType := VarSQLTimeStamp;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.BinaryOp(var Left: TVarData;
  const Right: TVarData; const Operator: TVarOp);
var
  rTS: TSQLTimeStamp;
begin
  case Operator of
    opAdd:
      if VarIsSQLTimeStamp(Variant(Right)) then begin
        rTS := VarToSQLTimeStamp(Variant(Right));
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoAddTo(rTS);
        Variant(Left) := VarSQLTimeStampCreate(rTS);
      end
      else
      if FDVarIsSQLTimeInterval(Variant(Right)) then
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoInc(
          PFDSQLTimeIntervalVarData(@Right)^.VInterval.Interval)
      else if VarDataIsNumeric(Right) then
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoInc(Integer(Variant(Right)))
      else
        RaiseInvalidOp;
    opSubtract:
      if VarIsSQLTimeStamp(Variant(Right)) then begin
        rTS := VarToSQLTimeStamp(Variant(Right));
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoSubFrom(rTS);
        Variant(Left) := VarSQLTimeStampCreate(rTS);
      end
      else
      if FDVarIsSQLTimeInterval(Variant(Right)) then
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoDec(
          PFDSQLTimeIntervalVarData(@Right)^.VInterval.Interval)
      else if VarDataIsNumeric(Right) then
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoDec(Integer(Variant(Right)))
      else
        RaiseInvalidOp;
    opMultiply:
      if VarDataIsNumeric(Right) then
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoMultiply(Integer(Variant(Right)))
      else
        RaiseInvalidOp;
    opDivide:
      if VarDataIsNumeric(Right) then
        PFDSQLTimeIntervalVarData(@Left)^.VInterval.DoDivide(Integer(Variant(Right)))
      else
        RaiseInvalidOp;
  else
    RaiseInvalidOp;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.UnaryOp(var Right: TVarData;
  const Operator: TVarOp);
begin
  case Operator of
  opNegate:
    if FDVarIsSQLTimeInterval(Variant(Right)) then
      PFDSQLTimeIntervalVarData(@Right)^.VInterval.DoNegate
    else
      RaiseInvalidOp;
  else
    RaiseInvalidOp;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalVariantType.Compare(const Left, Right: TVarData;
  var Relationship: TVarCompareResult);
begin
  Relationship := PFDSQLTimeIntervalVarData(@Left)^.VInterval.Compare(
    PFDSQLTimeIntervalVarData(@Right)^.VInterval.Interval);
end;

{-------------------------------------------------------------------------------}
{ Utilities                                                                     }
{-------------------------------------------------------------------------------}
function FDVarSQLTimeIntervalCreate: Variant;
begin
  Result := FDVarSQLTimeIntervalCreate('');
end;

{-------------------------------------------------------------------------------}
function FDVarSQLTimeIntervalCreate(const AValue: string): Variant;
begin
  VarClear(Result);
  TVarData(Result).VType := GSQLTimeIntervalVariantType.VarType;
  TFDSQLTimeIntervalData(TVarData(Result).VPointer) := TFDSQLTimeIntervalData.Create(AValue);
end;

{-------------------------------------------------------------------------------}
function FDVarSQLTimeIntervalCreate(const AValue: TFDSQLTimeInterval): Variant;
begin
  VarClear(Result);
  TVarData(Result).VType := GSQLTimeIntervalVariantType.VarType;
  TFDSQLTimeIntervalData(TVarData(Result).VPointer) := TFDSQLTimeIntervalData.Create(AValue);
end;

{-------------------------------------------------------------------------------}
function FDVarSQLTimeInterval: TVarType;
begin
  Result := GSQLTimeIntervalVariantType.VarType;
end;

{-------------------------------------------------------------------------------}
function FDVarIsSQLTimeInterval(const AValue: Variant): Boolean; overload;
begin
  Result := TVarData(AValue).VType = GSQLTimeIntervalVariantType.VarType;
end;

{-------------------------------------------------------------------------------}
function FDVar2SQLTimeInterval(const AValue: Variant): TFDSQLTimeInterval;
var
  oData: TFDSQLTimeIntervalData;
begin
  case TVarData(AValue).VType of
  varNull,
  varEmpty:
    Result := C_NullSQLTimeInterval;
  varUString,
  varString,
  varOleStr:
    begin
      oData := TFDSQLTimeIntervalData.Create(String(AValue));
      try
        Result := oData.Interval;
      finally
        FDFree(oData);
      end;
    end;
  else
    if TVarData(AValue).VType = GSQLTimeIntervalVariantType.VarType then
      Result := TFDSQLTimeIntervalData(TVarData(AValue).VPointer).Interval
    else
      raise EVariantError.Create(SInvalidVarCast);
  end;
end;

{-------------------------------------------------------------------------------}
function FDStr2SQLTimeInterval(const AValue: String): TFDSQLTimeInterval;
var
  oData: TFDSQLTimeIntervalData;
begin
  oData := TFDSQLTimeIntervalData.Create(AValue);
  try
    Result := oData.Interval;
  finally
    FDFree(oData);
  end;
end;

{-------------------------------------------------------------------------------}
function FDSQLTimeInterval2Str(const AValue: TFDSQLTimeInterval): String;
var
  oData: TFDSQLTimeIntervalData;
begin
  oData := TFDSQLTimeIntervalData.Create(AValue);
  try
    Result := oData.AsString;
  finally
    FDFree(oData);
  end;
end;

{-------------------------------------------------------------------------------}
function FDSQLTimeIntervalCompare(const AValue1, AValue2: TFDSQLTimeInterval): Integer;
var
  oData: TFDSQLTimeIntervalData;
begin
  oData := TFDSQLTimeIntervalData.Create(AValue1);
  try
    case oData.Compare(AValue2) of
    crLessThan:    Result := -1;
    crGreaterThan: Result := 1;
    else           Result := 0;
    end;
  finally
    FDFree(oData);
  end;
end;

{-------------------------------------------------------------------------------}
function FDSQLTimeIntervalCast(const AValue: TFDSQLTimeInterval;
  AKind: TFDSQLTimeIntervalKind): TFDSQLTimeInterval;
var
  oData: TFDSQLTimeIntervalData;
begin
  oData := TFDSQLTimeIntervalData.Create(AValue);
  try
    oData.CastToKind(AKind);
    Result := oData.Interval;
  finally
    FDFree(oData);
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  GSQLTimeIntervalVariantType := TFDSQLTimeIntervalVariantType.Create;

finalization
  FDFreeAndNil(GSQLTimeIntervalVariantType);

end.
