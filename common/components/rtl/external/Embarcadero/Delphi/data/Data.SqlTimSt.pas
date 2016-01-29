{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.SqlTimSt;

// need to implement CastOLE, dispatch and stream (from Eddie?)

interface

uses
  System.Variants, System.SysUtils;

type

{ TSQLTimeStamp }
  PSQLTimeStamp = ^TSQLTimeStamp;
  TSQLTimeStamp = record
    Year: Word;
    Month: Word;
    Day: Word;
    Hour: Word;
    Minute: Word;
    Second: Word;
    Fractions: LongWord;
  end;

  PSQLTimeStampOffset = ^TSQLTimeStampOffset;
  TSQLTimeStampOffset = record
    Year: Word;
    Month: Word;
    Day: Word;
    Hour: Word;
    Minute: Word;
    Second: Word;
    Fractions: LongWord;
    TimeZoneHour: SmallInt;
    TimeZoneMinute: SmallInt;
  end;

{ TSQLTimeStamp variant creation utils }

procedure VarSQLTimeStampCreate(var aDest: Variant; const ASQLTimeStamp: TSQLTimeStamp); overload;
function VarSQLTimeStampCreate: Variant; overload;
function VarSQLTimeStampCreate(const AValue: string): Variant; overload;
function VarSQLTimeStampCreate(const AValue: string; const FormatSettings: TFormatSettings): Variant; overload;
function VarSQLTimeStampCreate(const AValue: TDateTime): Variant; overload;
function VarSQLTimeStampCreate(const ASQLTimeStamp: TSQLTimeStamp): Variant; overload;
function VarSQLTimeStamp: TVarType;
function VarIsSQLTimeStamp(const aValue: Variant): Boolean; overload;
//function VarAsSQLTimeStamp(const aValue: Variant): Variant;

{ TSQLTimeStampOffset variant creation utils }

procedure VarSQLTimeStampOffsetCreate(var aDest: Variant; const ASQLTimeStampOffset: TSQLTimeStampOffset); overload;
function VarSQLTimeStampOffsetCreate: Variant; overload;
function VarSQLTimeStampOffsetCreate(const AValue: string): Variant; overload;
function VarSQLTimeStampOffsetCreate(const AValue: string; const FormatSettings: TFormatSettings): Variant; overload;
function VarSQLTimeStampOffsetCreate(const AValue: TDateTime): Variant; overload;
function VarSQLTimeStampOffsetCreate(const ASQLTimeStampOffset: TSQLTimeStampOffset): Variant; overload;
function VarSQLTimeStampOffset: TVarType;
function VarIsSQLTimeStampOffset(const aValue: Variant): Boolean; overload;

function LocalToUTC(var Value: TSQLTimeStamp): TSQLTimeStamp;
function UTCToLocal(var Value: TSQLTimeStamp): TSQLTimeStamp;

{ TSQLTimeStamp conversion support }

// converts Variant SQLTimeStamp to record TSQLTimeStamp
function VarToSQLTimeStamp(const aValue: Variant): TSQLTimeStamp;
function SQLTimeStampToStr(const Format: string;
      DateTime: TSQLTimeStamp): string; overload;
function SQLTimeStampToStr(const Format: string;
      DateTime: TSQLTimeStamp; const FormatSettings: TFormatSettings): string; overload;
function SQLDayOfWeek(const DateTime: TSQLTimeStamp): Integer;
function DateTimeToSQLTimeStamp(const DateTime: TDateTime): TSQLTimeStamp;
function SQLTimeStampToDateTime(const DateTime: TSQLTimeStamp): TDateTime;
function TryStrToSQLTimeStamp(const S: string; var TimeStamp: TSQLTimeStamp) : Boolean; overload;
function TryStrToSQLTimeStamp(const S: string; var TimeStamp: TSQLTimeStamp; const FormatSettings: TFormatSettings) : Boolean; overload;
function StrToSQLTimeStamp(const S: string): TSQLTimeStamp; overload;
function StrToSQLTimeStamp(const S: string; const FormatSettings: TFormatSettings): TSQLTimeStamp; overload;

{ TSQLTimeStampOffset conversion support }

// converts Variant SQLTimeStampOffset to record TSQLTimeStampOffset
function VarToSQLTimeStampOffset(const aValue: Variant): TSQLTimeStampOffset;
function SQLTimeStampOffsetToStr(const Format: string;
      DateTime: TSQLTimeStampOffset): string; overload;
function SQLTimeStampOffsetToStr(const Format: string;
      DateTime: TSQLTimeStampOffset; const FormatSettings: TFormatSettings): string;  overload;
//function SQLDayOfWeek(const DateTime: TSQLTimeStamp): Integer;
function DateTimeToSQLTimeStampOffset(const DateTime: TDateTime): TSQLTimeStampOffset; overload;
function DateTimeToSQLTimeStampOffset(const DateTime: TDateTime; const TZOffsetHour: Integer; const TZOffsetMinute: Integer = 0 ): TSQLTimeStampOffset; overload;
function SQLTimeStampOffsetToDateTime(const DateTimeOffset: TSQLTimeStampOffset): TDateTime;
function TryStrToSQLTimeStampOffset(const S: string; var TimeStampOffset: TSQLTimeStampOffset) : Boolean; overload;
function TryStrToSQLTimeStampOffset(const S: string; var TimeStampOffset: TSQLTimeStampOffset; const FormatSettings: TFormatSettings) : Boolean; overload;
function StrToSQLTimeStampOffset(const S: string): TSQLTimeStampOffset; overload;
function StrToSQLTimeStampOffset(const S: string; const FormatSettings: TFormatSettings): TSQLTimeStampOffset; overload;


{ utility }

procedure CheckSqlTimeStamp(const ASQLTimeStamp: TSQLTimeStamp);
procedure CheckSqlTimeStampOffset(const ASQLTimeStampOffset: TSQLTimeStampOffset);

const

  NullSQLTimeStamp: TSQLTimeStamp = (Year: 0; Month: 0; Day: 0; Hour: 0; Minute: 0; Second: 0; Fractions: 0);
  NullSQLTimeStampOffset: TSQLTimeStampOffset = (Year: 0; Month: 0; Day: 0; Hour: 0; Minute: 0; Second: 0; Fractions: 0; TimeZoneHour: 0; TimeZoneMinute: 0);

implementation

uses
  System.VarUtils, System.DateUtils, System.SysConst, Data.DBConsts, System.TypInfo,
  System.Classes, System.StrUtils, System.TimeSpan
  {$IFDEF POSIX},System.Types{$ENDIF};

const

  IncrementAmount: array[Boolean] of Integer = (1, -1);

type

{ TSQLTimeStampVariantType }

  TSQLTimeStampVariantType = class(TPublishableVariantType)
  protected
    function RightPromotion(const V: TVarData; const Operator: TVarOp;
      out RequiredVarType: TVarType): Boolean; override;
    function GetInstance(const V: TVarData): TObject; override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean); override;
    procedure Cast(var Dest: TVarData; const Source: TVarData); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData; const AVarType: TVarType); override;
    procedure BinaryOp(var Left: TVarData; const Right: TVarData; const Operator: TVarOp); override;
    procedure Compare(const Left, Right: TVarData; var Relationship: TVarCompareResult); override;
  end;

{ TSQLTimeStampOffsetVariantType }

  TSQLTimeStampOffsetVariantType = class(TPublishableVariantType)
  protected
    function GetInstance(const V: TVarData): TObject; override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean); override;
    procedure Cast(var Dest: TVarData; const Source: TVarData); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData; const AVarType: TVarType); override;
    procedure BinaryOp(var Left: TVarData; const Right: TVarData; const Operator: TVarOp); override;
    procedure Compare(const Left, Right: TVarData; var Relationship: TVarCompareResult); override;
  end;

var

{ SQLTimeStamp that the complex variant points to }

  SQLTimeStampVariantType: TSQLTimeStampVariantType = nil;

{ SQLTimeStampOffset that the complex variant points to }

  SQLTimeStampOffsetVariantType: TSQLTimeStampOffsetVariantType = nil;

type

{ TSQLTimeStampData }

  TSQLTimeStampData = class(TPersistent)
  private
    FDateTime: TSQLTimeStamp;
    function GetAsDateTime: TDateTime;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure AdjustMonths(Reverse: Boolean);
    procedure AdjustDays(Reverse: Boolean);
    procedure AdjustHours(Reverse: Boolean);
    procedure AdjustMinutes(Reverse: Boolean);
    procedure AdjustSeconds(Reverse: Boolean);
    function DaysInMonth: Integer;
    function GetIsBlank: Boolean; inline;
    procedure SetDay(const Value: Word);
    procedure SetFractions(const Value: LongWord);
    procedure SetHour(const Value: Word);
    procedure SetMinute(const Value: Word);
    procedure SetMonth(const Value: Word);
    procedure SetSecond(const Value: Word);
    procedure SetYear(const Value: Word);
  protected
    procedure AdjustDate(Reverse: Boolean);
    property IsBlank: Boolean read GetIsBlank;
  public
    // the many ways to create
    constructor Create(const AValue: SmallInt); overload;
    constructor Create(const AValue: Integer); overload;
    constructor Create(const AValue: TDateTime); overload;
    constructor Create(const AText: string); overload;
    constructor Create(const AText: string; const FormatSettings: TFormatSettings); overload;
    constructor Create(const ASQLTimeStamp: TSQLTimeStamp); overload;
    constructor Create(const ASource: TSQLTimeStampData); overload;

    // access to the private bits
    property DateTime: TSQLTimeStamp read FDateTime write FDateTime;

    // non-destructive operations
    // check this one!
    function Compare(const Value: TSQLTimeStampData): TVarCompareResult;

    // destructive operations
    procedure DoAdd(const ADateTime: TSQLTimeStampData); overload;
    procedure DoSubtract(const ADateTime: TSQLTimeStampData); overload;
    // property access
  published
    // conversion
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsString: string read GetAsString write SetAsString;
    property Day: Word read FDateTime.Day write SetDay;
    property Fractions: LongWord read FDateTime.Fractions write SetFractions;
    property Hour: Word read FDateTime.Hour write SetHour;
    property Minute: Word read FDateTime.Minute write SetMinute;
    property Month: Word read FDateTime.Month write SetMonth;
    property Second: Word read FDateTime.Second write SetSecond;
    property Year: Word read FDateTime.Year write SetYear;
  end;

{ Helper record that helps crack open TSQLTimeStampObject }

  TSQLTimeStampVarData = record
  strict private
    function GetVTimeStamp: TSQLTimeStampData; inline;
    procedure SetVTimeStamp(const Value: TSQLTimeStampData); inline;
  public
    procedure Clear; inline;
  public
     VType: TVarType;
     Reserved1, Reserved2, Reserved3: Word;
    property VTimeStamp: TSQLTimeStampData read GetVTimeStamp write SetVTimeStamp;
  public
    case Integer of
    0: (_VTimeStamp: Pointer);
    1: (VLargest: TLargestVarData); // to match size as Variant/TVarData type
  end;

{ TSQLTimeStampOffsetData }

  TSQLTimeStampOffsetData = class(TPersistent)
  private
    FDateTimeOffset: TSQLTimeStampOffset;
    function ConvertToUTC(const Value: TSQLTimeStampOffset): TSQLTimeStamp;
  protected
    function GetAsDateTime: TDateTime;
    function GetAsString: string;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsString(const Value: string);
    function GetLocalDateTime: TDateTime;
    function GetLocalTimeStamp: TSQLTimeStamp;
    function GetUTCDateTime: TDateTime;
    function GetUTCTimeStamp: TSQLTimeStamp;
  public
    // the many ways to create
    constructor Create(const AValue: SmallInt); overload;
    constructor Create(const AValue: Integer); overload;
    constructor Create(const AValue: TDateTime); overload;
    constructor Create(const AText: string); overload;
    constructor Create(const AText: string; const FormatSettings: TFormatSettings); overload;
    constructor Create(const ASQLTimeStamp: TSQLTimeStamp); overload;
    constructor Create(const ASQLTimeStampOffset: TSQLTimeStampOffset); overload;
    constructor Create(const ASource: TSQLTimeStampOffsetData); overload;

    // access to the private bits
    property DateTimeOffset: TSQLTimeStampOffset read FDateTimeOffset write FDateTimeOffset;

    // non-destructive operations
    // check this one!
    function Compare(const Value: TSQLTimeStampOffsetData): TVarCompareResult;

  published
    // conversion
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsString: string read GetAsString write SetAsString;
    property LocalDateTime: TDateTime read GetLocalDateTime;
    property LocalTimeStamp: TSQLTimeStamp read GetLocalTimeStamp;
    property UTCDateTime: TDateTime read GetUTCDateTime;
    property UTCTimeStamp: TSQLTimeStamp read GetUTCTimeStamp;
  end;

{ Helper record that helps crack open TSQLTimeStampOffsetObject }

  TSQLTimeStampOffsetVarData = record
  strict private
    function GetVTimeStamp: TSQLTimeStampOffsetData; inline;
    procedure SetVTimeStamp(const Value: TSQLTimeStampOffsetData); inline;
  public
    procedure Clear; inline;
  public
    VType: TVarType;
    Reserved1, Reserved2, Reserved3: Word;
    property VDateTimeOffset: TSQLTimeStampOffsetData read GetVTimeStamp write SetVTimeStamp;
  public
    case Integer of
    0: (_VDateTimeOffset: Pointer);
    1: (VLargest: TLargestVarData); // to match size as Variant/TVarData type
  end;

{ TSQLTimeStampVarData }

procedure TSQLTimeStampVarData.Clear;
begin
  FreeAndNil(TSQLTimeStampData(Self._VTimeStamp));
end;

function TSQLTimeStampVarData.GetVTimeStamp: TSQLTimeStampData;
begin
  Result := TSQLTimeStampData(Self._VTimeStamp);
end;

procedure TSQLTimeStampVarData.SetVTimeStamp(const Value: TSQLTimeStampData);
begin
  TSQLTimeStampData(Self._VTimeStamp) := Value;
end;

{ TSQLTimeStampOffsetVarData }

procedure TSQLTimeStampOffsetVarData.Clear;
begin
  FreeAndNil(TSQLTimeStampOffsetData(Self._VDateTimeOffset));
end;

function TSQLTimeStampOffsetVarData.GetVTimeStamp: TSQLTimeStampOffsetData;
begin
  Result := TSQLTimeStampOffsetData(Self._VDateTimeOffset);
end;

procedure TSQLTimeStampOffsetVarData.SetVTimeStamp(const Value: TSQLTimeStampOffsetData);
begin
  TSQLTimeStampOffsetData(Self._VDateTimeOffset) := Value;
end;

function IsSQLTimeStampBlank(const TimeStamp: TSQLTimeStamp): Boolean;
begin
  Result := (TimeStamp.Year = 0) and
            (TimeStamp.Month = 0) and
            (TimeStamp.Day = 0) and
            (TimeStamp.Hour = 0) and
            (TimeStamp.Minute = 0) and
            (TimeStamp.Second = 0) and
            (TimeStamp.Fractions = 0);
end;

function IsSQLTimeStampOffsetBlank(const TimeStampOffset: TSQLTimeStampOffset): Boolean;
begin
  Result := (TimeStampOffset.Year = 0) and
            (TimeStampOffset.Month = 0) and
            (TimeStampOffset.Day = 0) and
            (TimeStampOffset.Hour = 0) and
            (TimeStampOffset.Minute = 0) and
            (TimeStampOffset.Second = 0) and
            (TimeStampOffset.Fractions = 0) and
            (TimeStampOffset.TimeZoneHour = 0) and
            (TimeStampOffset.TimeZoneMinute = 0);
end;

{ TSQLTimeStampOffsetVariantType }

procedure TSQLTimeStampOffsetVariantType.BinaryOp(var Left: TVarData;
  const Right: TVarData; const Operator: TVarOp);
begin
  // TSQLTimeStampOffset variant does not support any binary operation.
  RaiseInvalidOp;
end;

procedure TSQLTimeStampOffsetVariantType.Cast(var Dest: TVarData;
  const Source: TVarData);
var
  LSource, LTemp: TVarData;
begin
  VarDataInit(LSource);
  try
    VarDataCopyNoInd(LSource, Source);
    if VarDataIsStr(LSource) then
      TSQLTimeStampOffsetVarData(Dest).VDateTimeOffset := TSQLTimeStampOffsetData.Create(VarDataToStr(LSource))
    else
    begin
      VarDataInit(LTemp);
      try
        VarDataCastTo(LTemp, LSource, varDate);
        TSQLTimeStampOffsetVarData(Dest).VDateTimeOffset := TSQLTimeStampOffsetData.Create(LTemp.VDate);
      finally
        VarDataClear(LTemp);
      end;
    end;
    Dest.VType := VarType;
  finally
    VarDataClear(LSource);
  end;
end;

procedure TSQLTimeStampOffsetVariantType.CastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
var
  LTemp: TVarData;
begin
  if Source.VType = VarType then
    case AVarType of
{$IFNDEF NEXTGEN}
      varOleStr:
        VarDataFromOleStr(Dest, TSQLTimeStampOffsetVarData(Source).VDateTimeOffset.AsString);
      varString:
        VarDataFromLStr(Dest, AnsiString(TSQLTimeStampOffsetVarData(Source).VDateTimeOffset.AsString));
{$ELSE}
      varOleStr, varString,
{$ENDIF !NEXTGEN}
      varUString:
        VarDataFromStr(Dest, TSQLTimeStampOffsetData(TSQLTimeStampOffsetVarData(Source).VDateTimeOffset).AsString);
    else
      VarDataInit(LTemp);
      try
        LTemp.VType := varDate;
        LTemp.VDate := TSQLTimeStampOffsetData(TSQLTimeStampOffsetVarData(Source).VDateTimeOffset).AsDateTime;
        VarDataCastTo(Dest, LTemp, AVarType);
      finally
        VarDataClear(LTemp);
      end;
    end
  else
    inherited;
end;

procedure TSQLTimeStampOffsetVariantType.Clear(var V: TVarData);
begin
  V.VType := varEmpty;
  TSQLTimeStampOffsetVarData(V).Clear;
end;

procedure TSQLTimeStampOffsetVariantType.Compare(const Left, Right: TVarData;
  var Relationship: TVarCompareResult);
begin
  Relationship := TSQLTimeStampOffsetData(TSQLTimeStampOffsetVarData(Left).VDateTimeOffset).Compare(TSQLTimeStampOffsetVarData(Right).VDateTimeOffset);
end;

procedure TSQLTimeStampOffsetVariantType.Copy(var Dest: TVarData;
  const Source: TVarData; const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else
  begin
    TSQLTimeStampOffsetVarData(Dest).VType := VarType;
    TSQLTimeStampOffsetVarData(Dest).VDateTimeOffset := TSQLTimeStampOffsetData.Create(TSQLTimeStampOffsetVarData(Source).VDateTimeOffset);
  end;
end;

function TSQLTimeStampOffsetVariantType.GetInstance(const V: TVarData): TObject;
begin
  Result := TSQLTimeStampOffsetVarData(V).VDateTimeOffset;
end;

{ TSQLTimeStampData }

function TSQLTimeStampData.GetIsBlank: Boolean;
begin
  Result := IsSQLTimeStampBlank(FDateTime);
end;

// Adjust for Month > 12 or < 1
procedure TSQLTimeStampData.AdjustMonths(Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-12, 12);
begin
  while (FDateTime.Month < 1) or(FDateTime.Month > 12) do
  begin
    Inc(FDateTime.Year, IncrementAmount[Reverse]);
    Inc(FDateTime.Month, AdjustAmt[Reverse]);
  end;
end;

// Adjust for Days > 28/30/31 or < 1
procedure TSQLTimeStampData.AdjustDays(Reverse: Boolean);
var
  Days: Integer;
begin
  Days := DaysInMonth;
  while (FDateTime.Day < 1) or (FDateTime.Day > Days) do
  begin
    Inc(FDateTime.Month, IncrementAmount[Reverse]);
    if Reverse then
      Dec(FDateTime.Day, Days)
    else
      Inc(FDateTime.Day, Days);
    AdjustMonths(Reverse);
    Days := DaysInMonth;
  end;
end;

// Adjust for Hours over 23 or less than 0
procedure TSQLTimeStampData.AdjustHours(Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-24, 24);
begin
  while (FDateTime.Hour > 23) or (Integer(FDateTime.Hour) < 0) do
  begin
    Inc(FDateTime.Day, IncrementAmount[Reverse]);
    Inc(FDateTime.Hour, AdjustAmt[Reverse]);
    AdjustDays(Reverse);
  end;
end;

// Adjust Minutes for Hours over 59 or less than 0
procedure TSQLTimeStampData.AdjustMinutes(Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-60, 60);
begin
  while (FDateTime.Minute > 59) or (Integer(FDateTime.Minute) < 0) do
  begin
    Inc(FDateTime.Hour, IncrementAmount[Reverse]);
    Inc(FDateTime.Minute, AdjustAmt[Reverse]);
    AdjustHours(Reverse);
  end;
end;

// Adjust Seconds for Hours over 59 or less than 0
procedure TSQLTimeStampData.AdjustSeconds(Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-60, 60);
begin
  while (FDateTime.Second > 59) or (Integer(FDateTime.Second) < 0) do
  begin
    Inc(FDateTime.Minute, IncrementAmount[Reverse]);
    Inc(FDateTime.Second, AdjustAmt[Reverse]);
    AdjustMinutes(Reverse);
  end;
end;

procedure TSQLTimeStampData.AdjustDate(Reverse: Boolean);
begin
  if Reverse then
  begin
    AdjustSeconds(Reverse);
    AdjustMinutes(Reverse);
    AdjustHours(Reverse);
    AdjustDays(Reverse);
    AdjustMonths(Reverse);
  end else
  begin
    AdjustMonths(Reverse);
    AdjustDays(Reverse);
    AdjustHours(Reverse);
    AdjustMinutes(Reverse);
    AdjustSeconds(Reverse);
  end;
end;

function TSQLTimeStampData.DaysInMonth: Integer;
begin
  Result := DaysInAMonth(DateTime.Year, DateTime.Month);
end;

procedure TSQLTimeStampData.DoSubtract(const ADateTime: TSQLTimeStampData);
begin
  Dec(FDateTime.Year, ADateTime.Year);
  Dec(FDateTime.Month, ADateTime.Month);
  Dec(FDateTime.Day, ADateTime.Day);
  Dec(FDateTime.Hour, ADateTime.Hour);
  Dec(FDateTime.Minute, ADateTime.Minute);
  Dec(FDateTime.Second, ADateTime.Second);
  Dec(FDateTime.Fractions, ADateTime.Fractions);
  AdjustDate(True);
end;

procedure TSQLTimeStampData.DoAdd(const ADateTime: TSQLTimeStampData);
begin
  if not IsBlank then
  begin
    Inc(FDateTime.Year, ADateTime.Year);
    Inc(FDateTime.Month, ADateTime.Month);
    Inc(FDateTime.Day, ADateTime.Day);
    Inc(FDateTime.Hour, ADateTime.Hour);
    Inc(FDateTime.Minute, ADateTime.Minute);
    Inc(FDateTime.Second, ADateTime.Second);
    Inc(FDateTime.Fractions, ADateTime.Fractions);
    AdjustDate(False);;
  end;
end;

function TSQLTimeStampData.Compare(const Value: TSQLTimeStampData): TVarCompareResult;
var
  Status: Integer;
begin
  Status := FDateTime.Year - Value.Year;
  if Status = 0 then
    Status := FDateTime.Month - Value.Month;
  if Status = 0 then
    Status := FDateTime.Day - Value.Day;
  if Status = 0 then
    Status := FDateTime.Hour - Value.Hour;
  if Status = 0 then
    Status := FDateTime.Hour - Value.Hour;
  if Status = 0 then
    Status := FDateTime.Minute - Value.Minute;
  if Status = 0 then
    Status := FDateTime.Second - Value.Second;
  if Status = 0 then
    Status := FDateTime.Fractions - Value.Fractions;
  if Status = 0 then
    Result := crEqual
  else
  if Status > 0 then
    Result := crGreaterThan
  else
    Result := crLessThan;
end;

function TSQLTimeStampData.GetAsString: string;
begin
  Result := SQLTimeStampToStr('', FDateTime);
end;

function TSQLTimeStampData.GetAsDateTime: TDateTime;
begin
  Result := SQLTimeStampToDateTime(FDateTime);
end;

procedure TSQLTimeStampData.SetAsString(const Value: string);
begin
  FDateTime := StrToSQLTimeStamp(Value);
end;

procedure TSQLTimeStampData.SetAsDateTime(const Value: TDateTime);
begin
  FDateTime := DateTimeToSQLTimeStamp(Value);
end;

constructor TSQLTimeStampData.Create(const AValue: Integer);
begin
  inherited Create;
  FDateTime := NullSQLTimeStamp;
  FDateTime.Day := AValue;
end;

constructor TSQLTimeStampData.Create(const AValue: SmallInt);
begin
  inherited Create;
  FDateTime := NullSQLTimeStamp;
  FDateTime.Day := AValue;
end;

constructor TSQLTimeStampData.Create(const AValue: TDateTime);
begin
  inherited Create;
  FDateTime := DateTimeToSqlTimeStamp(AValue);
end;

constructor TSQLTimeStampData.Create(const AText: string);
var
  ts: TSQLTimeStamp;
begin
  ts := StrToSQLTimeStamp(AText);
  inherited Create;
  FDateTime := ts;
end;

constructor TSQLTimeStampData.Create(const AText: string; const FormatSettings: TFormatSettings);
var
  ts: TSQLTimeStamp;
begin
  ts := StrToSQLTimeStamp(AText, FormatSettings);
  inherited Create;
  FDateTime := ts;
end;

constructor TSQLTimeStampData.Create(const ASQLTimeStamp: TSQLTimeStamp);
begin
  CheckSqlTimeStamp( ASQLTimeStamp );
  inherited Create;
  move(ASQLTimeStamp, FDateTime, sizeof(TSQLTimeStamp));
end;

constructor TSQLTimeStampData.Create(const ASource: TSQLTimeStampData);
begin
  Create(aSource.DateTime);
end;

procedure TSQLTimeStampData.SetDay(const Value: Word);
begin
  Assert((Value >= 1) and (Value <= DaysInAMonth(Year, Month)));
  FDateTime.Day := Value;
end;

procedure TSQLTimeStampData.SetFractions(const Value: LongWord);
begin
  FDateTime.Fractions := Value;
end;

procedure TSQLTimeStampData.SetHour(const Value: Word);
begin
  Assert(Value <= 23);   // no need to check for > 0 on Word
  FDateTime.Hour := Value;
end;

procedure TSQLTimeStampData.SetMinute(const Value: Word);
begin
  Assert(Value <= 59);   // no need to check for > 0 on Word
  FDateTime.Minute := Value;
end;

procedure TSQLTimeStampData.SetMonth(const Value: Word);
begin
  Assert((Value >= 1) and (Value <= 12));
  FDateTime.Month := Value;
end;

procedure TSQLTimeStampData.SetSecond(const Value: Word);
begin
  Assert(Value <= 59);  // no need to check for > 0 on Word
  FDateTime.Second := Value;
end;

procedure TSQLTimeStampData.SetYear(const Value: Word);
begin
  FDateTime.Year := Value;
end;

{ TSQLTimeStampVariantType }

procedure TSQLTimeStampVariantType.Clear(var V: TVarData);
begin
  V.VType := varEmpty;
  TSQLTimeStampVarData(V).Clear;
end;

procedure TSQLTimeStampVariantType.Cast(var Dest: TVarData;
  const Source: TVarData);
var
  LSource, LTemp: TVarData;
begin
  VarDataInit(LSource);
  try
    VarDataCopyNoInd(LSource, Source);
    if VarDataIsStr(LSource) then
      TSQLTimeStampVarData(Dest).VTimeStamp := TSQLTimeStampData.Create(VarDataToStr(LSource))
    else
    begin
      VarDataInit(LTemp);
      try
        VarDataCastTo(LTemp, LSource, varDate);
        TSQLTimeStampVarData(Dest).VTimeStamp := TSQLTimeStampData.Create(LTemp.VDate);
      finally
        VarDataClear(LTemp);
      end;
    end;
    Dest.VType := VarType;
  finally
    VarDataClear(LSource);
  end;
end;

procedure TSQLTimeStampVariantType.CastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
var
  LTemp: TVarData;
begin
  if Source.VType = VarType then
    case AVarType of
{$IFNDEF NEXTGEN}
      varOleStr:
        VarDataFromOleStr(Dest, TSQLTimeStampVarData(Source).VTimeStamp.AsString);
      varString:
        VarDataFromLStr(Dest, AnsiString(TSQLTimeStampVarData(Source).VTimeStamp.AsString));
{$ELSE}
      varOleStr, varString,
{$ENDIF !NEXTGEN}
      varUString:
        VarDataFromStr(Dest, TSQLTimeStampData(TSQLTimeStampVarData(Source).VTimeStamp).AsString);
    else
      VarDataInit(LTemp);
      try
        LTemp.VType := varDate;
        LTemp.VDate := TSQLTimeStampData(TSQLTimeStampVarData(Source).VTimeStamp).AsDateTime;
        VarDataCastTo(Dest, LTemp, AVarType);
      finally
        VarDataClear(LTemp);
      end;
    end
  else
    inherited;
end;

procedure TSQLTimeStampVariantType.Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else
  begin
    TSQLTimeStampVarData(Dest).VType := VarType;
    TSQLTimeStampVarData(Dest).VTimeStamp := TSQLTimeStampData.Create(TSQLTimeStampVarData(Source).VTimeStamp);
  end;
end;

function TSQLTimeStampVariantType.RightPromotion(const V: TVarData; const Operator: TVarOp;
      out RequiredVarType: TVarType): Boolean;
begin
  if V.VType = VarSQLTimeStampOffset then
    Result := False
  else
    Result := inherited;
end;

function TSQLTimeStampVariantType.GetInstance(const V: TVarData): TObject;
begin
  Result := TSQLTimeStampVarData(V).VTimeStamp;
end;

procedure TSQLTimeStampVariantType.BinaryOp(var Left: TVarData; const Right: TVarData; const Operator: TVarOp);
begin
  case Operator of
    opAdd:
      TSQLTimeStampData(TSQLTimeStampVarData(Left).VTimeStamp).DoAdd(TSQLTimeStampVarData(Right).VTimeStamp);
    opSubtract:
      TSQLTimeStampData(TSQLTimeStampVarData(Left).VTimeStamp).DoSubtract(TSQLTimeStampVarData(Right).VTimeStamp);
  else
    RaiseInvalidOp;
  end;
end;

procedure TSQLTimeStampVariantType.Compare(const Left, Right: TVarData; var Relationship: TVarCompareResult);
begin
  Relationship := TSQLTimeStampData(TSQLTimeStampVarData(Left).VTimeStamp).Compare(TSQLTimeStampVarData(Right).VTimeStamp);
end;

{ SQLTimeStamp variant create utils }

function VarSQLTimeStampCreate(const AValue: string): Variant;
begin
  VarClear(Result);
  TSQLTimeStampVarData(Result).VType := SQLTimeStampVariantType.VarType;
  TSQLTimeStampVarData(Result).VTimeStamp := TSQLTimeStampData.Create(AValue);
end;

function VarSQLTimeStampCreate(const AValue: string; const FormatSettings: TFormatSettings): Variant;
begin
  VarClear(Result);
  TSQLTimeStampVarData(Result).VType := SQLTimeStampVariantType.VarType;
  TSQLTimeStampVarData(Result).VTimeStamp := TSQLTimeStampData.Create(AValue, FormatSettings);
end;

function VarSQLTimeStampCreate(const AValue: TDateTime): Variant;
begin
  VarClear(Result);
  TSQLTimeStampVarData(Result).VType := SQLTimeStampVariantType.VarType;
  TSQLTimeStampVarData(Result).VTimeStamp := TSQLTimeStampData.Create(AValue);
end;

procedure VarSQLTimeStampCreate(var aDest: Variant; const ASQLTimeStamp: TSQLTimeStamp);
begin
  VarClear(aDest);
  TSQLTimeStampVarData(aDest).VType := SQLTimeStampVariantType.VarType;
  TSQLTimeStampVarData(aDest).VTimeStamp := TSQLTimeStampData.Create(ASQLTimeStamp);
end;

function VarSQLTimeStampCreate: Variant;
begin
  VarSQLTimeStampCreate(Result, NullSQLTimeStamp);
end;

function VarSQLTimeStampCreate(const ASQLTimeStamp: TSQLTimeStamp): Variant;
begin
  VarSQLTimeStampCreate(Result, ASQLTimeStamp);
end;

function VarSQLTimeStamp: TVarType;
begin
  Result := SQLTimeStampVariantType.VarType;
end;

function VarIsSQLTimeStamp(const aValue: Variant): Boolean;
begin
  Result := TVarData(aValue).VType = SQLTimeStampVariantType.VarType;
end;

function GetSQLTimeStampFromStringVariant(const aValue: Variant): TSQLTimeStamp;
var
  Data: TSQLTimeStampData;
begin
  Data := TSQLTimeStampData.Create(string(aValue));
  try
    Result := Data.FDateTime;
  finally
    Data.Free;
  end;
end;

function VarToSQLTimeStamp(const aValue: Variant): TSQLTimeStamp;
begin
  if TVarData(aValue).VType in [varNULL, varEMPTY] then
    Result := NullSqlTimeStamp
  else if (TVarData(aValue).VType = varString) or (TVarData(aValue).VType = varUString) or
          (TVarData(aValue).VType = varOleStr) then
    Result := GetSQLTimeStampFromStringVariant(aValue)
  else if (TVarData(aValue).VType = varDouble) or (TVarData(aValue).VType = varDate) then
    Result := DateTimeToSqlTimeStamp(TDateTime(aValue))
  else if (TVarData(aValue).VType = SQLTimeStampVariantType.VarType) then
    Result := TSQLTimeStampData(TSQLTimeStampVarData(aValue).VTimeStamp).DateTime
  else
    raise EVariantError.Create(SInvalidVarCast);
end;

function GetSQLTimeStampOffsetFromStringVariant(const aValue: Variant): TSQLTimeStampOffset;
var
  Data: TSQLTimeStampOffsetData;
begin
  Data := TSQLTimeStampOffsetData.Create(string(aValue));
  try
    Result := Data.FDateTimeOffset;
  finally
    Data.Free;
  end;
end;

function VarToSQLTimeStampOffset(const aValue: Variant): TSQLTimeStampOffset;
begin
  if TVarData(aValue).VType in [varNULL, varEMPTY] then
    Result := NullSqlTimeStampOffset
  else if (TVarData(aValue).VType = varString) or (TVarData(aValue).VType = varUString) or
          (TVarData(aValue).VType = varOleStr) then
    Result := GetSQLTimeStampOffsetFromStringVariant(aValue)
  else if (TVarData(aValue).VType = varDouble) or (TVarData(aValue).VType = varDate) then
    Result := DateTimeToSqlTimeStampOffset(TDateTime(aValue))
  else if (TVarData(aValue).VType = SQLTimeStampOffsetVariantType.VarType) then
    Result := TSQLTimeStampOffsetData(TSQLTimeStampOffsetVarData(aValue).VDateTimeOffset).DateTimeOffset
  else
    raise EVariantError.Create(SInvalidVarCast);
end;

{ SQLTimeStampOffset variant create utils }

function VarSQLTimeStampOffsetCreate(const AValue: string): Variant;
begin
  VarClear(Result);
  TSQLTimeStampOffsetVarData(Result).VType := SQLTimeStampOffsetVariantType.VarType;
  TSQLTimeStampOffsetVarData(Result).VDateTimeOffset := TSQLTimeStampOffsetData.Create(AValue);
end;

function VarSQLTimeStampOffsetCreate(const AValue: string; const FormatSettings: TFormatSettings): Variant;
begin
  VarClear(Result);
  TSQLTimeStampOffsetVarData(Result).VType := SQLTimeStampOffsetVariantType.VarType;
  TSQLTimeStampOffsetVarData(Result).VDateTimeOffset := TSQLTimeStampOffsetData.Create(AValue, FormatSettings);
end;

function VarSQLTimeStampOffsetCreate(const AValue: TDateTime): Variant;
begin
  VarClear(Result);
  TSQLTimeStampOffsetVarData(Result).VType := SQLTimeStampOffsetVariantType.VarType;
  TSQLTimeStampOffsetVarData(Result).VDateTimeOffset := TSQLTimeStampOffsetData.Create(AValue);
end;

procedure VarSQLTimeStampOffsetCreate(var aDest: Variant; const ASQLTimeStampOffset: TSQLTimeStampOffset);
begin
  VarClear(aDest);
  TSQLTimeStampOffsetVarData(aDest).VType := SQLTimeStampOffsetVariantType.VarType;
  TSQLTimeStampOffsetVarData(aDest).VDateTimeOffset := TSQLTimeStampOffsetData.Create(ASQLTimeStampOffset);
end;

function VarSQLTimeStampOffsetCreate: Variant;
begin
  VarSQLTimeStampOffsetCreate(Result, NullSQLTimeStampOffset);
end;

function VarSQLTimeStampOffsetCreate(const ASQLTimeStampOffset: TSQLTimeStampOffset): Variant;
begin
  VarSQLTimeStampOffsetCreate(Result, ASQLTimeStampOffset);
end;

function VarSQLTimeStampOffset: TVarType;
begin
  Result := SQLTimeStampOffsetVariantType.VarType;
end;

function VarIsSQLTimeStampOffset(const aValue: Variant): Boolean;
begin
  Result := TVarData(aValue).VType = SQLTimeStampOffsetVariantType.VarType;
end;

{ SQLTimeStamp to string conversion }

function SQLTimeStampToStr(const Format: string;
  DateTime: TSQLTimeStamp): string;
var
  FTimeStamp: TDateTime;
begin
  FTimeStamp := SqlTimeStampToDateTime(DateTime);
  DateTimeToString(Result, Format, FTimeStamp);
end;

function SQLTimeStampToStr(const Format: string;
  DateTime: TSQLTimeStamp; const FormatSettings: TFormatSettings): string;
var
  FTimeStamp: TDateTime;
begin
  FTimeStamp := SqlTimeStampToDateTime(DateTime);
  DateTimeToString(Result, Format, FTimeStamp, FormatSettings);
end;

function IsSqlTimeStampValid(const ts: TSQLTimeStamp): Boolean;
begin
  if (ts.Month > 12) or (ts.Day > DaysInAMonth(ts.Year, ts.Month)) or
       (ts.Hour > 23) or (ts.Minute > 59) or (ts.Second > 59) then
    Result := False
  else
    Result := True;
end;

function ExtractMSecFromString(const S: string; const FormatSettings: TFormatSettings): Word;
var
  DT: TDateTime;
  Hour, Min, Sec: Word;
  CurPos: Integer;
  Pattern, TimeStr: string;
  NextChar: Char;
begin
  Result := 0;
  if TryStrToDateTime(S, DT, FormatSettings) then
  begin
    DecodeTime(DT, Hour, Min, Sec, Result);
    if Result <> 0 then
      Exit;

    Pattern := IntToStr(Hour)+FormatSettings.TimeSeparator;
    CurPos := S.IndexOf(Pattern) + 1;
    if (CurPos = 0) and (Hour > 12) then
    begin
      Dec(Hour, 12);
      Pattern := IntToStr(Hour)+FormatSettings.TimeSeparator;
      CurPos := S.IndexOf(Pattern) + 1;
    end;
    if CurPos = 0 then
      Exit(0);
    TimeStr := AnsiMidStr(S, CurPos+Pattern.Length-1, MaxInt);
    Pattern := IntToStr(Min)+FormatSettings.TimeSeparator;
    CurPos := TimeStr.IndexOf(Pattern) + 1;
    if CurPos = 0 then
      Exit(0);
    TimeStr := AnsiMidStr(TimeStr, CurPos+Pattern.Length-1, MaxInt);
    Pattern := FormatSettings.TimeSeparator+IntToStr(Sec);
    CurPos := TimeStr.IndexOf(Pattern) + 1;
    if (CurPos = 0) and (Pattern.Length = 2) then
    begin
      Pattern := FormatSettings.TimeSeparator+'0'+IntToStr(Sec);
      CurPos := TimeStr.IndexOf(Pattern) + 1;
    end;
    if CurPos = 0 then
      Exit(0);
    TimeStr := AnsiMidStr(TimeStr, CurPos+Pattern.Length+1, MaxInt);

    Pattern := '';
    for NextChar in TimeStr do
    begin
      if (NextChar < '0') or (NextChar > '9') then
        break;
      Pattern := Pattern + NextChar;
    end;

    if Pattern <> '' then
      Result := StrToInt(Pattern);
  end;
end;

function TryStrToSQLTimeStamp(const S: string; var TimeStamp: TSQLTimeStamp): Boolean;
var
  DT: TDateTime;
begin
  Result := TryStrToDateTime(S, DT);
  if Result then
  begin
    TimeStamp := DateTimeToSQLTimeStamp(DT);
    if TimeStamp.Fractions = 0 then
      TimeStamp.Fractions := ExtractMSecFromString(S, FormatSettings);

    Result := IsSqlTimeStampValid(TimeStamp);
  end;
  if not Result then
    TimeStamp := NullSQLTimeStamp;
end;

function TryStrToSQLTimeStamp(const S: string; var TimeStamp: TSQLTimeStamp; const FormatSettings: TFormatSettings): Boolean;
var
  DT: TDateTime;
begin
  Result := TryStrToDateTime(S, DT, FormatSettings);
  if Result then
  begin
    TimeStamp := DateTimeToSQLTimeStamp(DT);
    if TimeStamp.Fractions = 0 then
      TimeStamp.Fractions := ExtractMSecFromString(S, FormatSettings);

    Result := IsSqlTimeStampValid(TimeStamp);
  end;
  if not Result then
    TimeStamp := NullSQLTimeStamp;
end;

function StrToSQLTimeStamp(const S: string): TSQLTimeStamp;
begin
  if not TryStrToSqlTimeStamp(S, Result) then
    raise EConvertError.Create(SCouldNotParseTimeStamp);
end;

function StrToSQLTimeStamp(const S: string; const FormatSettings: TFormatSettings): TSQLTimeStamp;
begin
  if not TryStrToSqlTimeStamp(S, Result, FormatSettings) then
    raise EConvertError.Create(SCouldNotParseTimeStamp);
end;

function DateTimeToSQLTimeStamp(const DateTime: TDateTime): TSQLTimeStamp;
var
  F: Word;
begin
  DecodeDate(DateTime, Result.Year, Result.Month, Result.Day);
  DecodeTime(DateTime, Result.Hour, Result.Minute, Result.Second, F);
  Result.Fractions := F;
end;

function SQLTimeStampToDateTime(const DateTime: TSQLTimeStamp): TDateTime;
begin
  if IsSQLTimeStampBlank(DateTime) then
    Result := 0
  else
  begin
    Result := EncodeDate(DateTime.Year, DateTime.Month, DateTime.Day);
    if Result >= 0 then
      Result := Result + EncodeTime(DateTime.Hour, DateTime.Minute, DateTime.Second, DateTime.Fractions)
    else
      Result := Result - EncodeTime(DateTime.Hour, DateTime.Minute, DateTime.Second, DateTime.Fractions);
  end;
end;

function SQLDayOfWeek(const DateTime: TSQLTimeStamp): Integer;
var
  dt: TDateTime;
begin
  dt := SQLTimeStampToDateTime(DateTime);
  Result := DayOfWeek(dt);
end;

function DateTimeToSQLTimeStampOffset(const DateTime: TDateTime): TSQLTimeStampOffset;
begin
  Result := DateTimeToSQLTimeStampOffset(DateTime, TTimeZone.Local.UtcOffset.Hours, TTimeZone.Local.UtcOffset.Minutes);
end;

function DateTimeToSQLTimeStampOffset(const DateTime: TDateTime; const TZOffsetHour: Integer; const TZOffsetMinute: Integer ): TSQLTimeStampOffset;
var
  TLocal: TSQLTimeStamp;
begin
  TLocal := DateTimeToSQLTimeStamp(DateTime);

  Result.Year := TLocal.Year;
  Result.Month := TLocal.Month;
  Result.Day := TLocal.Day;
  Result.Hour := TLocal.Hour;
  Result.Minute := TLocal.Minute;
  Result.Second := TLocal.Second;
  Result.Fractions := TLocal.Fractions;
  Result.TimeZoneHour := TZOffsetHour;
  Result.TimeZoneMinute := TZOffsetMinute;
end;

                                            
function SQLTimeStampOffsetToDateTime(const DateTimeOffset: TSQLTimeStampOffset): TDateTime;
begin
  if IsSQLTimeStampOffsetBlank(DateTimeOffset) then
    Result := 0
  else
  begin
    Result := EncodeDate(DateTimeOffset.Year, DateTimeOffset.Month, DateTimeOffset.Day);
    if Result >= 0 then
      Result := Result + EncodeTime(DateTimeOffset.Hour, DateTimeOffset.Minute, DateTimeOffset.Second, DateTimeOffset.Fractions)
    else
      Result := Result - EncodeTime(DateTimeOffset.Hour, DateTimeOffset.Minute, DateTimeOffset.Second, DateTimeOffset.Fractions);
  end;
end;

function SQLTimeStampOffsetToStr(const Format: string;
      DateTime: TSQLTimeStampOffset): string;
var
  FTimeStamp: TDateTime;
  FOffset: TDateTime;
  OffsetStr: string;
begin
  FTimeStamp := SqlTimeStampOffsetToDateTime(DateTime);
  DateTimeToString(Result, Format, FTimeStamp);
  //something to append the timezone time
  FOffset := EncodeTime(Abs(DateTime.TimeZoneHour), DateTime.TimeZoneMinute, 0, 0);
  DateTimeToString(OffsetStr, 'hh:nn', FOffset);
  if DateTime.TimeZoneHour < 0 then
    Result := Result + ' -' + OffsetStr
  else
    Result := Result + ' +' + OffsetStr;
end;

function SQLTimeStampOffsetToStr(const Format: string;
      DateTime: TSQLTimeStampOffset; const FormatSettings: TFormatSettings): string;
var
  FTimeStamp: TDateTime;
  FOffset: TDateTime;
  OffsetStr: string;
begin
  FTimeStamp := SqlTimeStampOffsetToDateTime(DateTime);
  DateTimeToString(Result, Format, FTimeStamp, FormatSettings);
  //something to append the timezone time
  FOffset := EncodeTime(Abs(DateTime.TimeZoneHour), DateTime.TimeZoneMinute, 0, 0);
  DateTimeToString(OffsetStr, 'hh:nn', FOffset);
  if DateTime.TimeZoneHour < 0 then
    Result := Result + ' -' + OffsetStr
  else
    Result := Result + ' +' + OffsetStr;
end;

function IsSqlTimeStampOffsetValid(const ts: TSQLTimeStampOffset): Boolean;
begin
  if (ts.Month > 12) or (ts.Day > DaysInAMonth(ts.Year, ts.Month)) or
       (ts.Hour > 23) or (ts.Minute > 59) or (ts.Second > 59) or
       (ts.TimeZoneHour > 14) or (ts.TimeZoneHour < -12) or (ts.TimeZoneMinute > 59) or
       ((ts.TimeZoneHour = 14) and (ts.TimeZoneMinute > 0)) then
    Result := False
  else
    Result := True;
end;

function TryStrToSQLTimeStampOffset(const S: string; var TimeStampOffset: TSQLTimeStampOffset) : Boolean;
var
  DT: TDateTime;
  OffsetStr: string;
  Offset: TDateTime;
  Hour, Minute, Second, Milli: Word;
begin
  if S = '' then
    Result := False
  else
    Result := TryStrToDateTime(S, DT);
  if Result then
  begin
    OffsetStr := S.Substring(S.Length-5);
    Offset := StrToDateTime(OffsetStr);
    TimeStampOffset := DateTimeToSQLTimeStampOffset(DT, 0);
    if TimeStampOffset.Fractions = 0 then
      TimeStampOffset.Fractions := ExtractMSecFromString(S, FormatSettings);

    DecodeTime(Offset, Hour, Minute, Second, Milli);
    if S.Chars[S.Length-6] = '-' then
      TimeStampOffset.TimeZoneHour := Hour * -1
    else
      TimeStampOffset.TimeZoneHour := Hour;
    TimeStampOffset.TimeZoneMinute := Minute;
    Result := IsSqlTimeStampOffsetValid(TimeStampOffset);
  end;
  if not Result then
    TimeStampOffset := NullSQLTimeStampOffset;
end;

function TryStrToSQLTimeStampOffset(const S: string; var TimeStampOffset: TSQLTimeStampOffset; const FormatSettings: TFormatSettings) : Boolean;
var
  DT: TDateTime;
  OffsetStr: string;
  Offset: TDateTime;
  Hour, Minute, Second, Milli: Word;
begin
  if S = '' then
    Result := False
  else
    Result := TryStrToDateTime(S, DT, FormatSettings);
  if Result then
  begin
    TimeStampOffset := DateTimeToSQLTimeStampOffset(DT, 0);
    if TimeStampOffset.Fractions = 0 then
      TimeStampOffset.Fractions := ExtractMSecFromString(S, FormatSettings);

    OffsetStr := S.Substring(S.Length-5);
    Offset := StrToDateTime(OffsetStr);
    DecodeTime(Offset, Hour, Minute, Second, Milli);
    if S.Chars[S.Length-6] = '-' then
      TimeStampOffset.TimeZoneHour := Hour * -1
    else
      TimeStampOffset.TimeZoneHour := Hour;
    TimeStampOffset.TimeZoneMinute := Minute;
    Result := IsSqlTimeStampOffsetValid(TimeStampOffset);
  end;
  if not Result then
    TimeStampOffset := NullSQLTimeStampOffset;
end;

function StrToSQLTimeStampOffset(const S: string): TSQLTimeStampOffset;
begin
  if not TryStrToSqlTimeStampOffset(S, Result) then
    raise EConvertError.Create(SCouldNotParseTimeStamp);
end;

function StrToSQLTimeStampOffset(const S: string; const FormatSettings: TFormatSettings): TSQLTimeStampOffset;
begin
  if not TryStrToSqlTimeStampOffset(S, Result, FormatSettings) then
    raise EConvertError.Create(SCouldNotParseTimeStamp);
end;

procedure CheckSqlTimeStamp(const ASQLTimeStamp: TSQLTimeStamp);
begin  // only check if not an empty timestamp
  if ASQLTimeStamp.Year + ASQLTimeStamp.Month + ASQLTimeStamp.day +
     ASQLTimeStamp.Hour + ASQLTimeStamp.Minute + ASQLTimeStamp.Second > 0 then
  begin
    if ASQLTimeStamp.Year + ASQLTimeStamp.Month + ASQLTimeStamp.Day > 0 then
      if (ASQLTimeStamp.Year = 0) or (ASQLTimeStamp.Month = 0) or
       (ASQLTimeStamp.Day =0) or (ASQLTimeStamp.Month > 12) or (ASQLTimeStamp.Day >
       DaysInAMonth(ASQLTimeStamp.Year,ASQLTimeStamp.Month)) then
         raise EConvertError.Create(SInvalidSQLTimeStamp);
    if ASQLTimeStamp.Hour + ASQLTimeStamp.Minute + ASQLTimeStamp.Second > 0 then
       if (ASQLTimeStamp.Hour > 23) or (ASQLTimeStamp.Second > 59) or
       (ASQLTimeStamp.Minute > 59) then
         raise EConvertError.Create(SInvalidSQLTimeStamp);
  end;
end;

procedure CheckSqlTimeStampOffset(const ASQLTimeStampOffset: TSQLTimeStampOffset);
begin  // only check if not an empty timestamp
  if ASQLTimeStampOffset.Year + ASQLTimeStampOffset.Month + ASQLTimeStampOffset.day +
     ASQLTimeStampOffset.Hour + ASQLTimeStampOffset.Minute + ASQLTimeStampOffset.Second +
     Abs(ASQLTimeStampOffset.TimeZoneHour) + ASQLTimeStampOffset.TimeZoneMinute > 0 then
  begin
    if ASQLTimeStampOffset.Year + ASQLTimeStampOffset.Month + ASQLTimeStampOffset.Day > 0 then
      if (ASQLTimeStampOffset.Year = 0) or (ASQLTimeStampOffset.Month = 0) or
       (ASQLTimeStampOffset.Day =0) or (ASQLTimeStampOffset.Month > 12) or (ASQLTimeStampOffset.Day >
       DaysInAMonth(ASQLTimeStampOffset.Year,ASQLTimeStampOffset.Month)) then
         raise EConvertError.Create(SInvalidSQLTimeStamp);
    if ASQLTimeStampOffset.Hour + ASQLTimeStampOffset.Minute + ASQLTimeStampOffset.Second +
       Abs(ASQLTimeStampOffset.TimeZoneHour) + ASQLTimeStampOffset.TimeZoneMinute > 0 then
       if (ASQLTimeStampOffset.Hour > 23) or (ASQLTimeStampOffset.Second > 59) or
       (ASQLTimeStampOffset.Minute > 59) or (abs(ASQLTimeStampOffset.TimeZoneHour) > 14) or
       ((abs(ASQLTimeStampOffset.TimeZoneHour) = 14) and (ASQLTimeStampOffset.TimeZoneMinute > 0)) or
       (ASQLTimeStampOffset.TimeZoneMinute > 59) then
         raise EConvertError.Create(SInvalidSQLTimeStamp);
  end;
end;

function LocalToUTC(var Value: TSQLTimeStamp): TSQLTimeStamp;
var
  InDateTime, OutDateTime: TDateTime;
begin
  InDateTime := SQLTimeStampToDateTime(Value);
  OutDateTime := TTimeZone.Local.ToUniversalTime(InDateTime);
  Result := DateTimeToSQLTimeStamp(OutDateTime);
end;

function UTCToLocal(var Value: TSQLTimeStamp): TSQLTimeStamp;
var
  InDateTime, OutDateTime: TDateTime;
begin
  InDateTime := SQLTimeStampToDateTime(Value);
  OutDateTime := TTimeZone.Local.ToLocalTime(InDateTime);
  Result := DateTimeToSQLTimeStamp(OutDateTime);
end;

{ TSQLTimeStampOffsetData }

constructor TSQLTimeStampOffsetData.Create(const AValue: SmallInt);
begin
  FDateTimeOffset := NullSQLTimeStampOffset;
  FDateTimeOffset.Day := AValue;
end;

constructor TSQLTimeStampOffsetData.Create(const AValue: Integer);
begin
  FDateTimeOffset := NullSQLTimeStampOffset;
  FDateTimeOffset.Day := AValue;
end;

constructor TSQLTimeStampOffsetData.Create(const AValue: TDateTime);
begin
  FDateTimeOffset := DateTimeToSQLTimeStampOffset(AValue);
end;


constructor TSQLTimeStampOffsetData.Create(const AText: string);
begin
  inherited Create();
  FDateTimeOffset := StrToSQLTimeStampOffset(AText);
end;

constructor TSQLTimeStampOffsetData.Create(const AText: string; const FormatSettings: TFormatSettings);
begin
  inherited Create;
  FDateTimeOffset := StrToSQLTimeStampOffset(AText, FormatSettings);
end;

constructor TSQLTimeStampOffsetData.Create(const ASQLTimeStamp: TSQLTimeStamp);
var
  LocalTime, UTCTime : TSQLTimeStamp;
begin
  LocalTime := ASQLTimeStamp;
  UTCTime := LocalToUTC(LocalTime);

  FDateTimeOffset.Year := UTCTime.Year;
  FDateTimeOffset.Month := UTCTime.Month;
  FDateTimeOffset.Day := UTCTime.Day;
  FDateTimeOffset.Hour := UTCTime.Hour;
  FDateTimeOffset.Minute := UTCTime.Minute;
  FDateTimeOffset.Second := UTCTime.Second;
  FDateTimeOffset.Fractions := UTCTime.Fractions;
  FDateTimeOffset.TimeZoneHour := 0;
  FDateTimeOffset.TimeZoneMinute := 0;
end;

constructor TSQLTimeStampOffsetData.Create(
  const ASQLTimeStampOffset: TSQLTimeStampOffset);
begin
  CheckSqlTimeStampOffset( ASQLTimeStampOffset );
  inherited Create;
  move(ASQLTimeStampOffset, FDateTimeOffset, sizeof(TSQLTimeStampOffset));
end;

constructor TSQLTimeStampOffsetData.Create(
  const ASource: TSQLTimeStampOffsetData);
begin
  Create(ASource.DateTimeOffset);
end;

function TSQLTimeStampOffsetData.ConvertToUTC(const Value: TSQLTimeStampOffset): TSQLTimeStamp;
var
  Date: TDate;
  M: Integer;
begin
  Result.Year := Value.Year;
  Result.Month := Value.Month;
  Result.Day := Value.Day;
  Result.Hour := Value.Hour;
  Result.Minute := Value.Minute;
  Result.Second := Value.Second;
  Result.Fractions := Value.Fractions;
  if (Value.TimeZoneHour <> 0) or (Value.TimeZoneMinute <> 0) then
  begin
    Date := EncodeDate(Result.Year, Result.Month, Result.Day);

    M := Value.Hour * MinsPerHour + Value.Minute;
    if Value.TimeZoneHour > 0 then
      M := M - Value.TimeZoneHour * MinsPerHour - Value.TimeZoneMinute
    else
      M := M - Value.TimeZoneHour * MinsPerHour + Value.TimeZoneMinute;

    if M < 0 then
    begin
      Date := IncDay(Date, -1);
      M := M + MinsPerDay;
    end
    else if M >= MinsPerDay then
    begin
      Date := IncDay(Date);
      M := M - MinsPerDay;
    end;

    DecodeDate(Date, Result.Year, Result.Month, Result.Day);
    Result.Hour := M div MinsPerHour;
    Result.Minute := M mod MinsPerHour;
  end;
end;

function TSQLTimeStampOffsetData.GetAsDateTime: TDateTime;
begin
  Result := LocalDateTime;
end;

procedure TSQLTimeStampOffsetData.SetAsDateTime(const Value: TDateTime);
begin
  FDateTimeOffset := DateTimeToSQLTimeStampOffset(Value);
end;

function TSQLTimeStampOffsetData.GetAsString: string;
begin
  Result := SQLTimeStampOffsetToStr('', FDateTimeOffset);
end;

procedure TSQLTimeStampOffsetData.SetAsString(const Value: string);
begin
  FDateTimeOffset := StrToSQLTimeStampOffset(Value);
end;

function TSQLTimeStampOffsetData.GetLocalDateTime: TDateTime;
begin
  Result := SQLTimeStampToDateTime(GetLocalTimeStamp);
end;

function TSQLTimeStampOffsetData.GetLocalTimeStamp: TSQLTimeStamp;
var
  UTC: TSQLTimeStamp;
begin
  UTC := GetUTCTimeStamp;
  Result := UTCToLocal(UTC);
end;

function TSQLTimeStampOffsetData.GetUTCDateTime: TDateTime;
begin
  Result := SQLTimeStampToDateTime(GetUTCTimeStamp);
end;

function TSQLTimeStampOffsetData.GetUTCTimeStamp: TSQLTimeStamp;
begin
  Result := ConvertToUTC(FDateTimeOffset);
end;

function TSQLTimeStampOffsetData.Compare(const Value: TSQLTimeStampOffsetData): TVarCompareResult;
var
  L, R : TSQLTimeStamp;
  Status: Integer;
begin
  L := ConvertToUTC(FDateTimeOffset);
  R := ConvertToUTC(Value.FDateTimeOffset);

  Status := L.Year - R.Year;
  if Status = 0 then
    Status := L.Month - R.Month;
  if Status = 0 then
    Status := L.Day - R.Day;
  if Status = 0 then
    Status := L.Hour - R.Hour;
  if Status = 0 then
    Status := L.Hour - R.Hour;
  if Status = 0 then
    Status := L.Minute - R.Minute;
  if Status = 0 then
    Status := L.Second - R.Second;
  if Status = 0 then
    Status := L.Fractions - R.Fractions;
  if Status = 0 then
    Result := crEqual
  else
  if Status > 0 then
    Result := crGreaterThan
  else
    Result := crLessThan;
end;

initialization
  SQLTimeStampVariantType := TSQLTimeStampVariantType.Create;
  SQLTimeStampOffsetVariantType := TSQLTimeStampOffsetVariantType.Create;
finalization
  FreeAndNil(SQLTimeStampVariantType);
  FreeAndNil(SQLTimeStampOffsetVariantType);
end.
