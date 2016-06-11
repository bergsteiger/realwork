{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.DateTimeCtrls.Types;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, System.Classes;

type

  TDTPart = (Year, Month, Day, Hour24, Hour12, Minute, Sec, MSec, AMPM, Unknown);
  TDTPartHelper = record helper for TDTPart
  const
    tpYear = TDTPart.Year deprecated 'Use TDTPart.Year';
    tpMonth = TDTPart.Month deprecated 'Use TDTPart.Month';
    tpDay = TDTPart.Day deprecated 'Use TDTPart.Day';
    tpHour24 = TDTPart.Hour24 deprecated 'Use TDTPart.Hour24';
    tpHour12 = TDTPart.Hour12 deprecated 'Use TDTPart.Hour12';
    tpMin = TDTPart.Minute deprecated 'Use TDTPart.Minute';
    tpSec = TDTPart.Sec deprecated 'Use TDTPart.Sec';
    tpMSec = TDTPart.MSec deprecated 'Use TDTPart.MSec';
    tpAMPM = TDTPart.AMPM deprecated 'Use TDTPart.AMPM';
    tpUnknow = TDTPart.Unknown deprecated 'Use TDTPart.Unknown';
  end;
  TDateTimePart = TDTPart deprecated 'Use TDTPart instead';

  TRange<T> = record
    Min: T;
    Max: T;
  end;

  // This type incapsulates information about format part of DateTime (Hour, min and other)
  // like as current value, boundary values, display format for FormatDateTime
  // and other
  TDTFormatPart = record
  public
    Part: TDTPart;
    Value: Integer;
    DisplayFormat: string;
    Range: TRange<Integer>;
  public
    constructor Create(const APart: TDTPart; const AMin, AMax: Integer); overload;
    constructor Create(const APart: TDTPart); overload;
    { Time section }
    function IsAM: Boolean;
    function ToAMPMString: string;
    function IsShortYearFormat: Boolean;
  end;
  TDateTimeFormatPart = TDTFormatPart deprecated 'Use TDTFormatPart instead';

  // Class for separating Date Time format on parts. Each parts has local format of displaying, value of current
  // path of DateTime (year, month and etc). Also this clas allow to separately change parts of date.
  // For Example, if Formatter has 31 January, and you change a month on February, Formatter will change day on 28 or 29
  // depended from leap year.
  TDateTimeFormatter = class
  private
    FFormat: string;
    FDateTime: TDateTime;
    FMaskPlaceholder: Char;
    FOnChange: TNotifyEvent;
    procedure SetFormat(const Value: string);
    procedure SetDateTime(const Value: TDateTime);
    function GetPart(Index: Integer): TDTFormatPart;
    function GetCount: Integer;
    procedure SetValue(AIndex: Integer; const Value: Integer);
    function GetValue(Index: Integer): Integer;
    function GetDisplayValue(Index: Integer): string;
  protected
    FParts: TList<TDTFormatPart>;
    procedure ParseFormat(const AFormat: string); virtual;
    procedure RefreshDayParts(const AYear: Word; const AMonth: Word; out NewDay: Word); virtual;
    procedure UpdatePartsValues; virtual;
    procedure DoChange; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property Format: string read FFormat write SetFormat;
    property MaskPlaceholder: Char read FMaskPlaceholder write FMaskPlaceholder;
    property Parts[Index: Integer]: TDTFormatPart read GetPart; default;
    property Values[Index: Integer]: Integer read GetValue write SetValue;
    property DisplayValues[Index: Integer]: string read GetDisplayValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses
{$IFDEF MACOS} Macapi.CoreFoundation, {$ENDIF}
  System.Math, System.SysUtils, System.DateUtils, System.RTLConsts, System.TypInfo, System.Character;

{ TDateTimePartInfo }

constructor TDTFormatPart.Create(const APart: TDTPart; const AMin, AMax: Integer);
begin
  Self.Part := APart;
  Self.Range.Min := AMin;
  Self.Range.Max := AMax;
  Self.Value := 0;
end;

constructor TDTFormatPart.Create(const APart: TDTPart);
begin
  Self.Part := APart;
end;

function TDTFormatPart.ToAMPMString: string;
begin
  if IsAM then
    Result := FormatSettings.TimeAMString
  else
    Result := FormatSettings.TimePMString;
end;

function TDTFormatPart.IsAM: Boolean;
begin
  Result := (Part in [TDTPart.Hour24, TDTPart.Hour12]) and (Value <= 12) or
            (Part = TDTPart.AMPM) and (Value = 0);
end;

function TDTFormatPart.IsShortYearFormat: Boolean;
begin
 Result := (Self.Part = TDTPart.Year) and (Self.DisplayFormat = 'yy') or (Self.DisplayFormat = 'y');
end;

{ TDateTimeFormatter }

constructor TDateTimeFormatter.Create;
begin
  FParts := TList<TDTFormatPart>.Create;
  FMaskPlaceholder := '_';
end;

destructor TDateTimeFormatter.Destroy;
begin
  FParts.Free;
  inherited Destroy;
end;

procedure TDateTimeFormatter.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TDateTimeFormatter.GetCount: Integer;
begin
  Result := FParts.Count;
end;

function TDateTimeFormatter.GetDisplayValue(Index: Integer): string;

  function Hour12ToFormattedStr(const ADTPart: TDTFormatPart): string;
  begin
    if ADTPart.Part = TDTPart.Hour12 then
    begin
      if ADTPart.Value > 12 then
      begin
        if (ADTPart.DisplayFormat.ToLower = 'hh') and (ADTPart.Value - 12 < 10) then
          Result := '0' + (ADTPart.Value - 12).ToString
        else
          Result := (ADTPart.Value - 12).ToString;
      end
      else
        if ADTPart.Value = 0 then
          Result := '12'
        else
          Result := FormatDateTime(ADTPart.DisplayFormat, DateTime);
    end
    else
      Result := '';
  end;

var
  DTPart: TDTFormatPart;
  DisplayValue: string;
begin
  DTPart := GetPart(Index);
  DisplayValue := '';

  if DTPart.Part = TDTPart.Unknown then
    DisplayValue := DTPart.DisplayFormat.Substring(0, DTPart.DisplayFormat.Length)
  else if DTPart.Part = TDTPart.AMPM then
    DisplayValue := DTPart.ToAMPMString
  else if DTPart.Part = TDTPart.Hour12 then
    DisplayValue := Hour12ToFormattedStr(DTPart)
  else
    DisplayValue := FormatDateTime(DTPart.DisplayFormat, DateTime);

  Result := DisplayValue;
end;

function TDateTimeFormatter.GetPart(Index: Integer): TDTFormatPart;
begin
  if (Index < 0) or (Index >= Count) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  Result := FParts[Index];
end;

function TDateTimeFormatter.GetValue(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= Count) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  Result := FParts[Index].Value;
end;

procedure TDateTimeFormatter.ParseFormat(const AFormat: string);
const
  DATETIME_FORMAT_SYMBOLS: array of Char = ['y', 'm', 'd', 'h', 'n', 's', 'z', 'a'];
  MAX_YEAR = 9999;
type
  TStateParser = (None, Comment, Format, NoneFormat);

  procedure ParseDateTime(const ASource: string; const AHourFormatType: TDTPart; var AIndex: Integer);
  var
    FormatSection: TDTFormatPart;
  begin
    case ASource.Chars[AIndex] of
      { Years }
      'y':
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Year, 1, MAX_YEAR);
          if ASource.IndexOf('yyyy', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'yyyy';
            Inc(AIndex, 3);
          end
          else if ASource.IndexOf('yyy', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'yyy';
            Inc(AIndex, 3);
          end
          else if ASource.IndexOf('yy', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'yy';
            Inc(AIndex);
          end
          else
            FormatSection.DisplayFormat := 'y';
        end;
      'm':
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Month, 1, 12);
          if ASource.IndexOf('mmmm', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'mmmm';
            Inc(AIndex, 3);
          end
          else if ASource.IndexOf('mmm', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'mmm';
            Inc(AIndex, 2);
          end
          else if ASource.IndexOf('mm', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'mm';
            Inc(AIndex);
          end
          else
            FormatSection.DisplayFormat := 'm';
        end;
      'd':
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Day, 1, DaysInMonth(DateTime));
          if ASource.IndexOf('dddd', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'dddd';
            Inc(AIndex, 3);
          end
          else if ASource.IndexOf('ddd', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'ddd';
            Inc(AIndex, 2);
          end
          else if ASource.IndexOf('dd', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'dd';
            Inc(AIndex);
          end
          else
            FormatSection.DisplayFormat := 'd';
        end;
      { Hours }
      'h':
        begin
          FormatSection := TDTFormatPart.Create(AHourFormatType, 0, 23);
          if ASource.IndexOf('hh', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'hh';
            Inc(AIndex);
          end
          else
            FormatSection.DisplayFormat := 'h'
        end;
      { Minutes }
      'n':
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Minute, 0, 59);
          if ASource.IndexOf('nn', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'nn';
            Inc(AIndex);
          end
          else
            FormatSection.DisplayFormat := 'n';
        end;
      { Seconds }
      's':
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Sec, 0, 59);
          if ASource.IndexOf('ss', AIndex) = AIndex then
          begin
            FormatSection.DisplayFormat := 'ss';
            Inc(AIndex);
          end
          else
            FormatSection.DisplayFormat := 's';
        end;
      { MSecs }
      'z':
      begin
        FormatSection := TDTFormatPart.Create(TDTPart.MSec, 0, 999);
        if ASource.IndexOf('zzz', AIndex) = AIndex then
        begin
          FormatSection.DisplayFormat := 'zzz';
          Inc(AIndex, 2);
        end
        else
          FormatSection.DisplayFormat := 'z';
      end;
      { A.M. or P.M. }
      'a':
      begin
        FormatSection := TDTFormatPart.Create(TDTPart.AMPM, 0, 1);
        if ASource.IndexOf('ampm', AIndex) = AIndex then
        begin
          FormatSection.DisplayFormat := 'ampm';
          Inc(AIndex, 3);
        end;
        if ASource.IndexOf('am/pm', AIndex) = AIndex then
        begin
          FormatSection.DisplayFormat := 'am/pm';
          Inc(AIndex, 4);
        end;
        if ASource.IndexOf('a/p', AIndex) = AIndex then
        begin
          FormatSection.DisplayFormat := 'a/p';
          Inc(AIndex, 2);
        end;
      end;
    end;
    FParts.Add(FormatSection);
    Inc(AIndex);
  end;

var
  FormatTmp: string;
  FormatSection: TDTFormatPart;
  I: Integer;
  Ch: Char;
  HourFormatType: TDTPart;
  StateParser: TStateParser;
  StrBuffer: string;
begin
  FormatTmp := AFormat.ToLower;
  FParts.Clear;

  // Define format Hour 24 or 12
  if FormatTmp.Contains('am/pm') or FormatTmp.Contains('a/p') or FormatTmp.Contains('ampm') then
    HourFormatType := TDTPart.Hour12
  else
    HourFormatType := TDTPart.Hour24;

  I := 0;
  StateParser := TStateParser.None;
  StrBuffer := '';
  while I <= FormatTmp.Length - 1 do
  begin
    Ch := FormatTmp.Chars[I];
    case StateParser of
      TStateParser.None:
      begin
        // Is open quote for comment?
        if Ch = '''' then
        begin
          StateParser := TStateParser.Comment;
          StrBuffer := '';
          Inc(I);
        end
        else if not Ch.IsInArray(DATETIME_FORMAT_SYMBOLS) then
        begin
          StateParser := TStateParser.NoneFormat;
          StrBuffer := '';
        end
        else
          StateParser := TStateParser.Format;
      end;
      // Comments is a part of string concluded in ''
      TStateParser.Comment:
      begin
        // Is close quote for comment?
        if Ch = '''' then
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Unknown);
          FormatSection.DisplayFormat := StrBuffer;
          FParts.Add(FormatSection);
          StateParser := TStateParser.None;
        end
        else
          StrBuffer := StrBuffer + AFormat.Chars[I];
        Inc(I);
      end;
      // NoneFormat is a part of string which doesn't include date time format symbols
      TStateParser.NoneFormat:
      begin
        if Ch.IsInArray(DATETIME_FORMAT_SYMBOLS) or (Ch = '''') then
        begin
          FormatSection := TDTFormatPart.Create(TDTPart.Unknown);
          if StrBuffer.Contains('/') then
            StrBuffer := StrBuffer.Replace('/', FormatSettings.DateSeparator);
          FormatSection.DisplayFormat := StrBuffer;
          FParts.Add(FormatSection);
          StateParser := TStateParser.None;
        end
        else
        begin
          StrBuffer := StrBuffer + AFormat.Chars[I];
          Inc(I);
        end;
      end;
      TStateParser.Format:
      begin
        ParseDateTime(FormatTmp, HourFormatType, I);
        StateParser := TStateParser.None;
      end;
    end;
  end;
  UpdatePartsValues;
end;

procedure TDateTimeFormatter.RefreshDayParts(const AYear: Word; const AMonth: Word; out NewDay: Word);
var
  I: Integer;
  FormatPart: TDTFormatPart;
  NewRange: TRange<Integer>;
  DayPartFound: Boolean;
  DaysInMonth: Word;
begin
  DayPartFound := False;
  for I := 0 to Count - 1 do
  begin
    FormatPart := Parts[I];
    if FormatPart.Part = TDTPart.Day then
    begin
      if not DayPartFound then
      begin
        DaysInMonth := DaysInAMonth(AYear, AMonth);
        NewDay := Min(FormatPart.Value, DaysInMonth);
        NewRange.Min := FormatPart.Range.Min;
        NewRange.Max := DaysInMonth;
      end;
      FormatPart.Value := NewDay;
      FormatPart.Range := NewRange;
      FParts[I] := FormatPart;
      DayPartFound := True;
    end;
  end;
  if not DayPartFound then
    NewDay := DayOf(DateTime);
end;

procedure TDateTimeFormatter.SetDateTime(const Value: TDateTime);
var
  Days: Word;
begin
  if not SameDateTime(DateTime, Value) then
  begin
    FDateTime := Value;
    UpdatePartsValues;
    RefreshDayParts(YearOf(DateTime), MonthOf(DateTime), Days);
    DoChange;
  end;
end;

procedure TDateTimeFormatter.SetFormat(const Value: string);
begin
  if FFormat <> Value then
  begin
    FFormat := Value;
    ParseFormat(FFormat);
  end;
end;

procedure TDateTimeFormatter.SetValue(AIndex: Integer; const Value: Integer);
var
  Part: TDTFormatPart;
  Year: Word;
  Month: Word;
  Day: Word;
  Hour: Word;
  Min: Word;
  Sec: Word;
  MSec: Word;
begin
  if (AIndex < 0) or (AIndex >= Count) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  Part := FParts[AIndex];
  Part.Value := Value;
  FParts[AIndex] := Part;

  DecodeDateTime(DateTime, Year, Month, Day, Hour, Min, Sec, MSec);

  if Part.Part in [TDTPart.Month] then
    RefreshDayParts(Year, Value, Day);
  if Part.Part in [TDTPart.Year] then
    RefreshDayParts(Value, Month, Day);

  case Part.Part of
    TDTPart.Year:
      Year := Part.Value;
    TDTPart.Month:
      Month := Part.Value;
    TDTPart.Day:
      Day := Part.Value;
    TDTPart.Hour24,
    TDTPart.Hour12:
      Hour := Part.Value;
    TDTPart.Minute:
      Min := Part.Value;
    TDTPart.Sec:
      Sec := Part.Value;
    TDTPart.MSec:
      MSec := Part.Value;
    TDTPart.AMPM:
      begin
        if (Hour >= 12) and Part.IsAM then
          Hour := Hour - 12;
        if (Hour < 12) and not Part.IsAM then
          Hour := Hour + 12;
      end;
    TDTPart.Unknown: ;
  end;
  DateTime := EncodeDateTime(Year, Month, Day, Hour, Min, Sec, MSec);
end;

procedure TDateTimeFormatter.UpdatePartsValues;
var
  TimeSection: TDTFormatPart;
  Hour: Word;
  Min: Word;
  Sec: Word;
  MSec: Word;
  I: Integer;
  Year: Word;
  Month: Word;
  Day: Word;
begin
  DecodeDateTime(FDateTime, Year, Month, Day, Hour, Min, Sec, MSec);
  for I := 0 to Count - 1 do
  begin
    TimeSection := FParts[I];
    case TimeSection.Part of
      TDTPart.Year:
        TimeSection.Value := Year;
      TDTPart.Month:
        TimeSection.Value := Month;
      TDTPart.Day:
        TimeSection.Value := Day;
      TDTPart.Hour24,
      TDTPart.Hour12:
        TimeSection.Value := Hour;
      TDTPart.Minute:
        TimeSection.Value := Min;
      TDTPart.Sec:
        TimeSection.Value := Sec;
      TDTPart.MSec:
        TimeSection.Value := MSec;
      TDTPart.AMPM:
        TimeSection.Value := Hour div 12;
      TDTPart.Unknown: ;
    end;
    FParts[I] := TimeSection;
  end;
end;

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TDTPart), ['tpYear', 'tpMonth', 'tpDay', 'tpHour24', 'tpHour12', 'tpMin', 'tpSec', 'tpMSec', 'tpAMPM', 'tpUnknow']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TDTPart));
end;

initialization
  RegisterAliases;

finalization
  UnregisterAliases;
end.
