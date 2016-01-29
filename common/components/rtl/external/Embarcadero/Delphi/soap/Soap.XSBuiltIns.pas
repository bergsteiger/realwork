{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.XSBuiltIns;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

interface

uses
  System.SysUtils, System.Types, Data.FMTBcd, Soap.InvokeRegistry, Xml.XMLIntf;

const
  SHexMarker               = '$';      { do not localize }
  SoapTimePrefix: InvString= 'T';      { do not localize }
  XMLDateSeparator         = '-';      { do not localize }
  XMLHourOffsetMinusMarker = '-';      { do not localize }
  XMLHourOffsetPlusMarker  = '+';      { do not localize }
  XMLTimeSeparator         = ':';      { do not localize }
  XMLMonthPos              = 6;
  XMLDayPos                = 9;
  XMLYearPos               = 1;
  XMLMilSecPos             = 10;
  XMLDefaultYearDigits     = 4;
  XMLDurationStart         = 'P';      { do not localize }
  XMLDurationYear          = 'Y';      { do not localize }
  XMLDurationMonth         = 'M';      { do not localize }
  XMLDurationDay           = 'D';      { do not localize }
  XMLDurationHour          = 'H';      { do not localize }
  XMLDurationMinute        = 'M';      { do not localize }
  XMLDurationSecond        = 'S';      { do not localize }
{$IFDEF HIGHLANDER_UP}
  SNAN: InvString          = 'NAN';    { do not localize }
{$ELSE}
  SNAN                     = 'NAN';    { do not localize }
{$ENDIF}
  SSciNotationMarker: Char = 'E';      { do not localize }
  SDecimal: Char           = '.';      { do not localize }
  SNegative: Char          = '-';      { do not localize }
  SPlus: Char              = '+';      { do not localize }
  SLocalTimeMarker         = 'Z';      { do not localize }
  MaxMonth                 = 12;
  MinMonth                 = 1;
  MaxDay                   = 31;
  MinDay                   = 1;
  SoapDecimalSeparator     = '.';

  IncrementAmount: array[Boolean] of Integer = (1, -1);

type

{ forward declarations }

TXSDuration = class;
TXSTime = class;
TXSDate = class;
TXSDateTime = class;

{ TXSTime }

TXSTime = class(TRemotableXS)
  private
    FTimeValue: InvString;
    FUseZeroMilliseconds: Boolean;
  protected
    function GetAsTime: TDateTime;
    function GetFractionalSeconds: Double;
    function GetFractionalSecondString: string;
    function GetHourOffset: SmallInt;
    function GetHour: Word;
    function GetMillisecond: Word;
    function GetMinute: Word;
    function GetMinuteOffset: SmallInt;
    function GetSecond: Word;
    procedure SetAsTime(const Value: TDateTime);
    procedure SetFractionalSeconds(const Value: Double);
    procedure SetHour(const Value: Word);
    procedure SetHourOffset(const Value: SmallInt);
    procedure SetMillisecond(const Value: Word);
    procedure SetMinute(const Value: Word);
    procedure SetMinuteOffset(const Value: SmallInt);
    procedure SetSecond(const Value: Word);
    property FractionalSecondString: string read GetFractionalSecondString;
  public
    property AsTime: TDateTime read GetAsTime write SetAsTime;
    property FractionalSeconds: Double read GetFractionalSeconds write
             SetFractionalSeconds;
    property Hour: Word read GetHour write SetHour default 0;
    property HourOffset: SmallInt read GetHourOffset write SetHourOffset default 0;
    property Millisecond: Word read GetMillisecond write SetMillisecond default 0;
    property Minute: Word read GetMinute write SetMinute default 0;
    property MinuteOffset: SmallInt read GetMinuteOffset write SetMinuteOffset;
    property Second: Word read GetSecond write SetSecond default 0;
    property UseZeroMilliseconds: Boolean read FUseZeroMilliseconds write
             FUseZeroMilliseconds;
    function Clone: TXSTime;
    procedure XSToNative(const Value: InvString); override;
    function NativeToXS: InvString; override;
end;

{ TXSDate }

TXSDate = class(TRemotableXS)
  private
    FDateValue: InvString;
  protected
    function GetAsDate: TDateTime;
    function GetDay: Word;
    function GetMonth: Word;
    function GetYear: Integer;
    procedure SetAsDate(const Value: TDateTime);
    procedure SetMonth(const Value: Word);
    procedure SetDay(const Value: Word);
    procedure SetYear(const Value: Integer);
  public
    constructor Create; override;
    property Month: Word read GetMonth write SetMonth default 0;
    property Day: Word read GetDay write SetDay default 0;
    property Year: Integer read GetYear write SetYear default 0;
    function Clone: TXSDate;
    procedure XSToNative(const Value: InvString); override;
    function NativeToXS: InvString; override;
    property AsDate: TDateTime read GetAsDate write SetAsDate;
end;

{ TXSCustomDateTime }

TXSCustomDateTime = class(TRemotableXS)
  protected
    FDateTime: InvString;
    function GetAsDateTime: TDateTime;
    function GetAsUTCDateTime: TDateTime;
    function GetDay: Word;
    function GetFractionalSeconds: Double;
    function GetHour: Word;
    function GetHourOffset: SmallInt;
    function GetMonth: Word;
    function GetMillisecond: Word;
    function GetMinute: Word;
    function GetMinuteOffset: SmallInt;
    function GetSecond: Word;
    function GetUseZeroMilliseconds: Boolean;
    function GetYear: Integer;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsUTCDateTime(const Value: TDateTime);
    procedure SetFractionalSeconds(const Value: Double);
    procedure SetDay(const Value: Word); virtual;
    procedure SetHour(const Value: Word); virtual;
    procedure SetHourOffset(const Value: SmallInt); virtual;
    procedure SetMillisecond(const Value: Word); virtual;
    procedure SetMinute(const Value: Word); virtual;
    procedure SetMinuteOffset(const Value: SmallInt); virtual;
    procedure SetMonth(const Value: Word); virtual;
    procedure SetSecond(const Value: Word); virtual;
    procedure SetUseZeroMilliseconds(const Value: Boolean);
    procedure SetYear(const Value: Integer); virtual;
    property Millisecond: Word read GetMillisecond write SetMillisecond default 0;
  public
    constructor Create;  override;
    destructor Destroy; override;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsUTCDateTime: TDateTime read GetAsUTCDateTime write SetAsUTCDateTime;
    property FractionalSeconds: Double read GetFractionalSeconds write
             SetFractionalSeconds;
    property Hour: Word read GetHour write SetHour default 0;
    property HourOffset: SmallInt read GetHourOffset write SetHourOffset default 0;
    property Minute: Word read GetMinute write SetMinute default 0;
    property MinuteOffset: SmallInt read GetMinuteOffset write SetMinuteOffset default 0;
    property Second: Word read GetSecond write SetSecond default 0;
    property Month: Word read GetMonth write SetMonth default 0;
    property Day: Word read GetDay write SetDay default 0;
    property Year: Integer read GetYear write SetYear default 0;
    property UseZeroMilliseconds: Boolean read GetUseZeroMilliseconds write
             SetUseZeroMilliseconds;
end;

{ TXSDateTime }

TXSDateTime = class(TXSCustomDateTime)
  public
    function Clone: TXSDateTime;
    function NativeToXS: InvString; override;
    procedure XSToNative(const Value: InvString); override;

    class function CompareDateTimeParam(const Value1, Value2: TXSDateTime): TXSDuration; static;
    property Millisecond: Word read GetMillisecond write SetMillisecond default 0;
end;

{ TXSDuration }

TXSDuration = class(TRemotableXS)

  protected type
    { Record that holds Duration Data }
    TDurationData = record
      Year: Integer;
      Month: Integer;
      Day: Integer;
      Hour: Integer;
      Minute: Integer;
      Second: Double;
      Negative: Boolean;
    end;

  protected
    FData: TDurationData;
    function GetSecond: Integer;
    procedure SetSecond(const Value: Integer);

  public
    constructor Create; override;
    procedure XSToNative(const Value: InvString); override;
    function NativeToXS: InvString; override;
    
    class function EncodeDuration(const Data: TDurationData): InvString; static;
    class procedure DecodeDuration(const ADuration: string;
                                   out Data: TDurationData); static;
                                   
    property Year: Integer read FData.Year write FData.Year;
    property Month: Integer read FData.Month write FData.Month;
    property Day: Integer read FData.Day write FData.Day;
    property Hour: Integer read FData.Hour write FData.Hour;
    property Minute: Integer read FData.Minute write FData.Minute;
    property Second: Integer read GetSecond write SetSecond;
    property DecimalSecond: Double read Fdata.Second write FData.Second;
end;

{ NOTE: These classes should derive from ERemotableException so we can
        send better SOAP faults across the wire?? }
EXSDateTimeException  = class(Exception);
EXSDecimalException   = class(Exception);
EXSHexBinaryException = class(Exception);

{ TXSHexBinary }
TXSHexBinary = class(TRemotableXS)
  private
    FHexBinaryString: string;
    procedure  SetAsByteArray(const Value: TByteDynArray);
    function   GetAsByteArray: TByteDynArray;
  public
    procedure XSToNative(const Value: InvString); override;
    function  NativeToXS: InvString; override;
    property  HexBinaryString: string read FHexBinaryString write FHexBinaryString;
    property  AsByteArray: TByteDynArray read GetAsByteArray write SetAsByteArray;
end;

{ TXSDecimal }
{ Rudimentary support (strictly to handle xsd:decimal) for now }
TXSDecimal = class(TRemotableXS)
  private
    FDecimalString: string;
    function GetAsBcd: TBcd;
    procedure SetAsBcd(const Value: TBcd);
  public
    procedure XSToNative(const Value: InvString); override;
    function  NativeToXS: InvString; override;
    property  DecimalString: string read FDecimalString write FDecimalString;
    property  AsBcd: TBcd read GetAsBcd write SetAsBcd;
end;

{ TXSString - for xsd:string and any other XML Data Types where nillable support
              is required }
TXSString = class(TRemotableXS)
  private
    FString: InvString;
  public
    procedure XSToNative(const Value: InvString); override;
    function  NativeToXS: InvString; override;
  end;

TXSTimeInstant = TXSDateTime;

{ TXSBoolean - for xsd:boolean that require nillable support }
TXSBoolean = class(TRemotableXS)
  private
    FBoolean: Boolean;
  public
    function  NativeToXS: InvString; override;
    procedure XSToNative(const Value: InvString); override;
    property AsBoolean: Boolean read FBoolean write FBoolean;
end;

{ TXSInteger - for xsd:int that require nillable support }
TXSInteger = class(TRemotableXS)
  private
    FInteger: Integer;
  public
    function  NativeToXS: InvString; override;
    procedure XSToNative(const Value: InvString); override;
    property AsInteger: Integer read FInteger write FInteger;
end;

{ TXSLong - for xsd:long that require nillable support }
TXSLong = class(TRemotableXS)
  private
    FLong: Int64;
  public
    function  NativeToXS: InvString; override;
    procedure XSToNative(const Value: InvString); override;
    property AsLong: Int64 read FLong write FLong;
end;

{ For cases where one needs access to the raw XMLNode data in a SOAP envelope }
TXMLData = class(TRemotable)
  private
    FXMLDocument: IXMLDocument;
    FXMLNode: IXMLNode;
  public
    constructor Create; override;
    destructor  Destroy; override;
    function   ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; override;
    procedure  SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); override;
    procedure  LoadFromXML(const XML: string); overload;
{$IFNDEF NEXTGEN}
    procedure  LoadFromXML(const XML: WideString); overload;
{$ENDIF !NEXTGEN}

    property XMLNode: IXMLNode read FXMLNode;
end;

{ Utility function }

{ XML DateTime <-> Delphi TDateTime conversion routines }
function DateTimeToXMLTime(Value: TDateTime; ApplyLocalBias: Boolean = True): InvString;
function XMLTimeToDateTime(const XMLDateTime: InvString; AsUTCTime: Boolean = False): TDateTime;

{ Utility function for TDateTime -> TXSDateTime conversion }
function DateTimeToXSDateTime(const Value: TDateTime; ApplyLocalBias: Boolean = False): TXSDateTime;

function GetDataFromFile(AFileName: string): string;
function SoapFloatToStr(Value: double): string;
function SoapStrToFloat(Value: string): double;

procedure InitXSTypes;

implementation

uses
  {$IFDEF MSWINDOWS}Winapi.Windows,{$ENDIF}
  System.Character, System.Classes, System.DateUtils, System.TimeSpan,
  Soap.SOAPConst, Xml.XMLDoc;

type

{ TXSBaseTime }

TXSBaseTime = class
  private
    FFractionalSecondString: string;
    FHour: Word;
    FHourOffset: Word;
    FMinute: Word;
    FMinuteOffset: Word;
    FNegativeOffset: Boolean;
    FSecond: Word;
    FUseZeroMilliseconds: Boolean;
    function BuildHourOffset: InvString;
    function IntToFractionalSeconds(Value: Word): string;
  protected
    function GetAsTime: TDateTime;
    function GetFractionalSeconds: Double;
    function GetFractionalSecondString: string;
    function GetHourOffset: SmallInt;
    function GetMillisecond: Word;
    function GetMinuteOffset: SmallInt;
    procedure SetAsTime(const Value: TDateTime);
    procedure SetFractionalSeconds(const Value: Double);
    procedure SetHour(const Value: Word);
    procedure SetHourOffset(const Value: SmallInt);
    procedure SetMillisecond(const Value: Word);
    procedure SetMinute(const Value: Word);
    procedure SetMinuteOffset(const Value: SmallInt);
    procedure SetSecond(const Value: Word);
    property FractionalSecondString: string read GetFractionalSecondString;
  public
    property AsTime: TDateTime read GetAsTime write SetAsTime;
    property FractionalSeconds: Double read GetFractionalSeconds write
             SetFractionalSeconds;
    property Hour: Word read FHour write SetHour default 0;
    property HourOffset: SmallInt read GetHourOffset write SetHourOffset default 0;
    property Millisecond: Word read GetMillisecond write SetMillisecond default 0;
    property Minute: Word read FMinute write SetMinute default 0;
    property MinuteOffset: SmallInt read GetMinuteOffset write SetMinuteOffset;
    property Second: Word read FSecond write SetSecond default 0;
    property UseZeroMilliseconds: Boolean read FUseZeroMilliseconds write
             FUseZeroMilliseconds;
    procedure XSToNative(const Value: InvString);
    function NativeToXS: InvString;
end;

{ TXSBaseDate }

TXSBaseDate = class
  private
{$IFDEF _NOT_DEFINED}
    { place holder for future work supporting years with greater than 4 digits }
    FAdditionalYearDigits: Word;
{$ENDIF}
    FMonth: Word;
    FDay: Word;
    FYear: Integer;
    FNegativeDate: Boolean;
  protected
    function GetAsDate: TDateTime;
    function GetYear: Integer;
    procedure SetAsDate(const Value: TDateTime);
    procedure SetMonth(const Value: Word);
    procedure SetDay(const Value: Word);
    procedure SetYear(const Value: Integer);
  public
    constructor Create;
    property Month: Word read FMonth write SetMonth default 0;
    property Day: Word read FDay write SetDay default 0;
    property Year: Integer read GetYear write SetYear default 0;
    procedure XSToNative(const Value: InvString);
    function NativeToXS: InvString;
    property AsDate: TDateTime read GetAsDate write SetAsDate;
end;

{ TXSBaseCustomDateTime }

TXSBaseCustomDateTime = class
  private
    FDateParam: TXSBaseDate;
    FTimeParam: TXSBaseTime;
    procedure SetUseZeroMilliseconds(const Value: Boolean);
    function GetUseZeroMilliseconds: Boolean;
  protected
    procedure AdjustDate(Reverse: Boolean); virtual;
    function GetAsDateTime: TDateTime;
    function GetAsUTCDateTime: TDateTime;
    function GetDay: Word;
    function GetFractionalSeconds: Double;
    function GetHour: Word;
    function GetHourOffset: SmallInt;
    function GetMonth: Word;
    function GetMillisecond: Word;
    function GetMinute: Word;
    function GetMinuteOffset: SmallInt;
    function GetSecond: Word;
    function GetYear: Integer;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsUTCDateTime(const Value: TDateTime);
    procedure SetFractionalSeconds(const Value: Double);
    procedure SetDay(const Value: Word); virtual;
    procedure SetHour(const Value: Word); virtual;
    procedure SetHourOffset(const Value: SmallInt); virtual;
    procedure SetMillisecond(const Value: Word); virtual;
    procedure SetMinute(const Value: Word); virtual;
    procedure SetMinuteOffset(const Value: SmallInt); virtual;
    procedure SetMonth(const Value: Word); virtual;
    procedure SetSecond(const Value: Word); virtual;
    procedure SetYear(const Value: Integer); virtual;
    property Millisecond: Word read GetMillisecond write SetMillisecond default 0;
  public
    constructor Create;
    destructor Destroy; override;
    procedure XSToNative(const Value: InvString);
    function NativeToXS: InvString;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsUTCDateTime: TDateTime read GetAsUTCDateTime write SetAsUTCDateTime;
    property FractionalSeconds: Double read GetFractionalSeconds write
             SetFractionalSeconds;
    property Hour: Word read GetHour write SetHour default 0;
    property HourOffset: SmallInt read GetHourOffset write SetHourOffset default 0;
    property Minute: Word read GetMinute write SetMinute default 0;
    property MinuteOffset: SmallInt read GetMinuteOffset write SetMinuteOffset default 0;
    property Second: Word read GetSecond write SetSecond default 0;
    property Month: Word read GetMonth write SetMonth default 0;
    property Day: Word read GetDay write SetDay default 0;
    property Year: Integer read GetYear write SetYear default 0;
    property UseZeroMilliseconds: Boolean read GetUseZeroMilliseconds write
             SetUseZeroMilliseconds;
end;

{ TXSBaseDateTime }

TXSBaseDateTime = class(TXSBaseCustomDateTime)
  public
    property Millisecond: Word read GetMillisecond write SetMillisecond default 0;
end;

function IsDurationType(const DateTimeStr: InvString): Boolean;
begin
  Result := (Length(DateTimeStr) > 2) and
             (DateTimeStr[Low(string)] = XMLDurationStart) or
             (DateTimeSTr[Low(string)] = '-');
end;

{ Exception routines }

procedure SoapDateTimeError(const Message: string); local;
begin
  raise EXSDateTimeException.Create(Message);
end;

procedure SoapDateTimeErrorFmt(const Message: string; const Args: array of const); local;
begin
  SoapDateTimeError(Format(Message,Args));
end;

procedure SoapDecimalError(const Message: string); local;
begin
  raise EXSDecimalException.Create(Message);
end;

procedure SoapDecimalErrorFmt(const Message: string; const Args: array of const); local;
begin
  SoapDecimalError(Format(Message,Args));
end;

procedure SoapHexBinaryError(const Message: string); local;
begin
  raise EXSHexBinaryException.Create(Message);
end;

procedure SoapHexBinaryErrorFmt(const Message: string; const Args: array of const); local;
begin
  SoapHexBinaryError(Format(Message,Args));
end;

{ utility functions }

type
  PFormatSettings = ^TFormatSettings;

var
  FormatSettings : TFormatSettings;

function GetFormatSettings: PFormatSettings;
begin
  if FormatSettings.DecimalSeparator <> SoapDecimalSeparator then
  begin
    FormatSettings := TFormatSettings.Create('');
    FormatSettings.DecimalSeparator := SoapDecimalSeparator;
  end;
  Result := @FormatSettings;
end;

function SoapFloatToStr(Value: double): string;
begin
  Result := FloatToStr(Value, GetFormatSettings^);
end;

function SoapStrToFloat(Value: string): double;
begin
  Result := StrToFloat(Value, GetFormatSettings^);
end;

function GetNumberBefore(const AParam: string; const AType: string;
                         const Decimals: Boolean = False): InvString;
var
  I, J: Integer;
begin
  I := AParam.IndexOf(AType);
  J := I;
//  while (I > 1) and (CharInSet(AParam[I-1], ['0'..'9']) or
  while (I > 0) and (AParam.Chars[I-1].IsDigit or
        (Decimals and (AParam.Chars[I-1] = '.'))) do
    Dec(I);
  // NOTE: In the case of 'Decimals' == true, the spec specifies:
  // " .. Following [ISO 8601], at least one digit must follow the decimal point if it appears. "
  // So we could check that '.' was *NOT* the last valid character found
  // MORE: "...the value of the Seconds component must conform to the pattern [0-9]+(\.[0-9]+)?."
  if J > I then
    Result := AParam.Substring(I, J-I)
  else
    Result := '0';
end;

function GetBaseTime(const Value: InvString): TXSBaseTime;
begin
  Result := TXSBaseTime.Create;
  try
    { exception will be raised for invalid values }
    if Value <> '' then
      Result.XSToNative(Value);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function GetBaseDate(const Value: InvString): TXSBaseDate;
begin
  Result := TXSBaseDate.Create;
  try
    { exception will be raised for invalid values }
    if Value <> '' then
      Result.XSToNative(Value);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function GetBaseCustomDateTime(const Value: InvString): TXSBaseCustomDateTime;
begin
  Result := TXSBaseCustomDateTime.Create;
  try
    { exception will be raised for invalid values }
    if Value <> '' then
      Result.XSToNative(Value);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function GetBaseDateTime(const Value: InvString): TXSBaseDateTime;
begin
  Result := TXSBaseDateTime.Create;
  try
    { Exception will be raised for invalid values }
    if Value <> '' then
      Result.XSToNative(Value);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

{ Adjust for Month > 12 or < 1 }
procedure AdjustMonths(var Year: Integer; var Month: Word; Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-12, 12);
begin
  if (Month < 1) or (Month > 12) then
  begin
    Inc(Year, IncrementAmount[Reverse]);
    Inc(Month, AdjustAmt[Reverse]);
  end;
end;

function ValidValue(Value, Subtract, Min, Max: Integer; var Remainder: Integer): Integer;
begin
  Result := Value - Subtract;
  Remainder := 0;
  if Result < Min then
  begin
    Remainder := 1;
    Inc(Result, Max);
  end;
end;

{ Adjust for Days > 28/30/31 or < 1 }
procedure AdjustDays(var Month, Day: Word; const Year: Word; Reverse: Boolean);
var
  Days: Integer;
begin
  Days := DaysInAMonth(Year, Month);
  if (Day < 1) or (Day > Days) then
  begin
    Inc(Month, IncrementAmount[Reverse]);
    if Reverse then
      Dec(Day, Days)
    else
      Inc(Day, Days);
  end;
end;

{ Adjust for Hours over 23 or less than 0 }
procedure AdjustHours(var Day, Hour: Word; Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-24, 24);
begin
  if (Hour > 23) or (Integer(Hour) < 0) then
  begin
    Inc(Day, IncrementAmount[Reverse]);
    Inc(Hour, AdjustAmt[Reverse]);
  end;
end;

{ Adjust Minutes for Hours over 59 or less than 0 }
procedure AdjustMinutes(var Hour, Minute: Word; Reverse: Boolean);
const
  AdjustAmt: array[Boolean] of Integer = (-60, 60);
begin
  if (Minute > 59) or (Integer(Minute) < 0) then
  begin
    Inc(Hour, IncrementAmount[Reverse]);
    Inc(Minute, AdjustAmt[Reverse]);
  end;
end;

{ Utility functions }
procedure AddUTCBias(DateTime: TXSBaseCustomDateTime);
var
  TimeZone: TTimeZone;
begin
  TimeZone := TTimeZone.Local;
  DateTime.HourOffset := Trunc(TimeZone.UtcOffset.TotalHours);
  DateTime.MinuteOffset := Trunc(TimeZone.UtcOffset.TotalMinutes);
  DateTime.FTimeParam.FNegativeOffset := TimeZone.UtcOffset.TotalMinutes < 0;
  if DateTime.FTimeParam.FNegativeOffset then
  begin
    DateTime.FTimeParam.FHour := DateTime.Hour - DateTime.HourOffset;
    DateTime.FTimeParam.FMinute := DateTime.Minute - DateTime.MinuteOffset;
    DateTime.AdjustDate(True);
  end
  else
  begin
    DateTime.FTimeParam.FHour := DateTime.Hour + DateTime.HourOffset;
    DateTime.FTimeParam.FMinute := DateTime.Minute + DateTime.MinuteOffset;
    DateTime.AdjustDate(False);
  end;
end;

function GetTimeZoneBias: Integer;
var
  TimeZone: TTimeZone;
begin
  TimeZone := TTimeZone.Local;
  Result := Trunc(TimeZone.UtcOffset.Negate.TotalMinutes);
end;

function DateTimeToXMLTime(Value: TDateTime; ApplyLocalBias: Boolean = True): InvString;
const
  Neg: array[Boolean] of string=  ('+', '-');
var
  Bias: Integer;
begin
  Result := FormatDateTime('yyyy''-''mm''-''dd''T''hh'':''nn'':''ss''.''zzz', Value); { Do not localize }
  Bias := GetTimeZoneBias;
  if (Bias <> 0) and ApplyLocalBias then
  begin
    Result := Format('%s%s%.2d:%.2d', [Result, Neg[Bias > 0],                         { Do not localize }
                                       Abs(Bias) div MinsPerHour,
                                       Abs(Bias) mod MinsPerHour]);
  end else
    Result := Result + 'Z'; { Do not localize }
end;

function XMLTimeToDateTime(const XMLDateTime: InvString; AsUTCTime: Boolean = False): TDateTime;
var
  XSDateTime: TXSDateTime;
begin
  XSDateTime := TXSDateTime.Create;
  try
    if XMLDateTime <> '' then
      XSDateTime.XSToNative(XMLDateTime);
    if AsUTCTime then
      Result := XSDateTime.AsUTCDateTime
    else
      Result := XSDateTime.AsDateTime;
  finally
    XSDateTime.Free;
  end;
end;

function DateTimeToXSDateTime(const Value: TDateTime; ApplyLocalBias: Boolean = False): TXSDateTime;
begin
  Result := TXSDateTime.Create;
  Result.XSToNative(DateTimeToXMLTime(Value, ApplyLocalBias));
end;

type
  DTErrorCode = (dteInvDate, dteInvTime, dteInvOffset);

procedure DTFmtError(AErrorCode: DTErrorCode; const AValue: string);
const
  Errors: array[DTErrorCode] of string = (SInvalidDateString,
                                          SInvalidTimeString,
                                          SInvalidTimeOffset);
begin
  raise EXSDateTimeException.CreateFmt(Errors[AErrorCode], [AValue]);
end;

function GetNextDTComp(var P: PChar; const PEnd: PChar;  ErrorCode: DTErrorCode;
                       const AValue: string): string; overload;
begin
  Result := '';
//  while ((P <= PEnd) and CharInSet(P^, ['0'..'9'])) do
  while ((P <= PEnd) and P^.IsDigit) do
  begin
    Result := Result + P^;
    Inc(P);
  end;
  if Result = '' then
    DTFmtError(ErrorCode, AValue);
end;

function GetNextDTComp(var P: PChar; const PEnd: PChar; const DefValue: string;
                       Prefix: Char; IsOptional: Boolean;
                       ErrorCode: DTErrorCode; const AValue: string): string; overload;
begin
  if (P >= PEnd) then
  begin
    Result := DefValue;
    Exit;
  end;

  if P^ <> Prefix then
  begin
    if IsOptional then
    begin
      Result := DefValue;
      Exit;
    end;
    DTFmtError(ErrorCode, AValue);
  end;
  Inc(P);

  Result := '';
//  while ((P <= PEnd) and CharInSet(P^, ['0'..'9'])) do
  while ((P <= PEnd) and P^.IsDigit) do
  begin
    Result := Result + P^;
    Inc(P);
  end;
  if Result = '' then
    DTFmtError(ErrorCode, AValue);
end;

function DateTimeToXSBaseDateTime(Value: TDateTime; ApplyLocalBias: Boolean = False): TXSBaseDateTime;
begin
  Result := TXSBaseDateTime.Create;
  Result.XSToNative(DateTimeToXMLTime(Value, ApplyLocalBias));
end;

function XMLDateToStr(const ADate: InvString; AddDigits: Word = 0): InvString;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create('');
  Result := Copy(ADate, XMLMonthPos + AddDigits, 2) + FormatSettings.DateSeparator +
            Copy(ADate, XMLDayPos + AddDigits, 2 ) +
            FormatSettings.DateSeparator + Copy(ADate, XMLYearPos, XMLDefaultYearDigits + AddDigits);
end;

procedure TXSBaseCustomDateTime.AdjustDate(Reverse: Boolean);
begin
  if (FTimeParam.FMinute >= 60) or (Integer(FTimeParam.FMinute) < 0) then
    AdjustMinutes(FTimeParam.FHour, FTimeParam.FMinute, Reverse);
  if (FTimeParam.FHour >= 24) or (Integer(FTimeParam.FHour) < 0) then
  begin
    AdjustHours(FDateParam.FDay, FTimeParam.FHour, Reverse);
    AdjustDays(FDateParam.FMonth, FDateParam.FDay, FDateParam.FYear, Reverse);
    AdjustMonths(FDateParam.FYear, FDateParam.FMonth, Reverse);
  end;
end;

function GetDataFromFile(AFileName: string): string;
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead);
  try
    SetLength(Result, Stream.Size);
    Stream.Read(PChar(Result)^, Stream.Size);
  finally
    FreeAndNil(Stream);
  end;
end;

{ TXSBaseTime }

function TXSBaseTime.IntToFractionalSeconds(Value: Word): string;
begin
  if Value < 1000 then
  begin
    Result := Format('.%.3d', [Value]);
  end else
    SoapDateTimeErrorFmt(SInvalidMillisecond, [Value]);
end;

function TXSBaseTime.GetFractionalSeconds: Double;
begin
  if FFractionalSecondString = '' then
    Result := 0
  else
    Result := SoapStrToFloat(FFractionalSecondString);
end;

procedure TXSBaseTime.SetFractionalSeconds(const Value: Double);
begin
  if Value > 1 then
    SoapDateTimeErrorFmt(SInvalidFractionalSecond, [Value]);
  if Value > 0 then
  begin
    FFractionalSecondString := SoapFloatToStr(Value);
    while FFractionalSecondString[Low(string)] = '0' do
      Delete(FFractionalSecondString, 1, 1);
  end
  else
    FFractionalSecondString := '';
end;

function TXSBaseTime.GetFractionalSecondString: string;
begin
  if (FFractionalSecondString = '') and UseZeroMilliseconds then
      Result := '.000'
  else
    Result := FFractionalSecondString;
end;

function TXSBaseTime.GetMilliSecond: Word;
begin
  Result := Round(FractionalSeconds*1000);
end;

procedure TXSBaseTime.SetHour(const Value: Word);
begin
  FHour := Value
end;

procedure TXSBaseTime.SetMinute(const Value: Word);
begin
  FMinute := Value
end;

procedure TXSBaseTime.SetSecond(const Value: Word);
begin
  FSecond := Value
end;

procedure TXSBaseTime.SetMillisecond(const Value: Word);
begin
  FFractionalSecondString := IntToFractionalSeconds(Value);
end;

procedure TXSBaseTime.SetHourOffset(const Value: SmallInt);
const
 {  http://www.w3.org/TR/xmlschema-2/#dateTime:
    ... currently there are no legally prescribed
   timezones which are durations whose magnitude is greater than 14 hours }
  sMaxOffset = 14;
begin
  if Abs(Value) <= sMaxOffset then
  begin
    FHourOffset := Abs(Value);
    if Value < 0 then
      FNegativeOffset := True;
  end else
    SoapDateTimeErrorFmt(SInvalidHourOffset, [Value]);
end;

procedure TXSBaseTime.SetMinuteOffset(const Value: SmallInt);
begin
  if Abs(Value) < 60 then
    FMinuteOffset := Abs(Value)
  else
    SoapDateTimeErrorFmt(SInvalidMinute, [Value]);
end;

function TXSBaseTime.GetHourOffset: SmallInt;
begin
  if FNegativeOffset then
    Result := -FHourOffset
  else
    Result := FHourOffset;
end;

function TXSBaseTime.GetMinuteOffset: SmallInt;
begin
  if FNegativeOffset then
    Result := -FMinuteOffset
  else
    Result := FMinuteOffset;
end;

procedure TXSBaseTime.XSToNative(const Value: InvString);
const
  XMLMilSecSeparator : char = '.';
var
  P, PE: PChar;
begin
  P := PChar(Value);
  PE := P + (Length(Value)-1);
  FHour   := StrToInt(GetNextDTComp(P, PE, dteInvTime, Value));
  FMinute := StrToInt(GetNextDTComp(P, PE, '00', XMLTimeSeparator, False, dteInvTime, Value));
  FSecond := StrToInt(GetNextDTComp(P, PE, '00', XMLTimeSeparator, True, dteInvTime, Value));
  FFractionalSecondString := GetNextDTComp(P, PE, '', XMLMilSecSeparator, True, dteInvTime, Value);
  if FFractionalSecondString <> '' then
  begin
    FFractionalSecondString := XMLMilSecSeparator + FFractionalSecondString;
    FUseZeroMilliseconds := True;
  end;
//  if CharInSet(P^, ['-', '+']) then
  if P^.IsInArray(['-', '+']) then
  begin
    FNegativeOffset := (P^ = '-');
    Inc(P);
//    if not CharInSet(P^, ['0'..'9']) then
    if not P^.IsDigit then
      DTFmtError(dteInvTime, Value);
    FHourOffset  := StrToInt(GetNextDTComp(P, PE, dteInvOffset, Value));
    FMinuteOffset:= StrToInt(GetNextDTComp(P, PE, '00', XMLTimeSeparator, True, dteInvOffset, Value));
  end else
  begin
    HourOffset := 0;
    MinuteOffset := 0;
  end;
end;

function TXSBaseTime.BuildHourOffset: InvString;
var
  Marker: String;
begin
  if Abs(FHourOffset) + Abs(FMinuteOffset) > 0 then
  begin
    if FNegativeOffset then
      Marker := XMLHourOffsetMinusMarker
    else
      Marker := XMLHourOffsetPlusMarker;
    Result := IntToStr(Abs(HourOffset));
    if Abs(HourOffset) < 10 then
      Result := '0' + Result;
    if Abs(MinuteOffSet) > 9 then
      Result := Result + XMLTimeSeparator + IntToStr(Abs(MinuteOffset))
    else if Abs(MinuteOffSet) > 0 then
      Result := Result + XMLTimeSeparator + '0' + IntToStr(Abs(MinuteOffset))
    else
      Result := Result + XMLTimeSeparator + '00';
    Result := Marker + Result;
  end else
    Result := SLocalTimeMarker;
end;

function TXSBaseTime.NativeToXS: InvString;
begin
  Result := Format('%.2d%s%.2d%s%.2d', [Hour, XMLTimeSeparator,
            Minute, XMLTimeSeparator, Second]) +
            FFractionalSecondString + BuildHourOffset;
end;

procedure TXSBaseTime.SetAsTime(const Value: TDateTime);
var
  AMilSeconds: Word;
begin
  DecodeTime(Value, FHour, FMinute, FSecond, AMilSeconds);
  FFractionalSecondString := IntToFractionalSeconds(AMilSeconds);
end;

function TXSBaseTime.GetAsTime: TDateTime;
begin
  Result := EncodeTime(Hour, Minute, Second, 0);
end;

{ TXSBaseDate }

constructor TXSBaseDate.Create;
begin
  inherited Create;
end;

procedure TXSBaseDate.SetMonth(const Value: Word);
begin
  FMonth := Value
end;

procedure TXSBaseDate.SetDay(const Value: Word);
begin
  FDay := Value
end;

procedure TXSBaseDate.SetYear(const Value: Integer);
begin
  FYear := Abs(Value);
  FNegativeDate := Value < 0;
end;


procedure TXSBaseDate.XSToNative(const Value: InvString);

  procedure ConvertDate(const Value: string);
  var
    P, PE: PChar;
  begin
    P := PChar(Value);
    PE := P + (Length(Value)-1);
    FYear  := StrToInt(GetNextDTComp(P, PE, dteInvTime, Value));
    FMonth := StrToInt(GetNextDTComp(P, PE, '00', XMLDateSeparator, True, dteInvDate, Value));
    FDay   := StrToInt(GetNextDTComp(P, PE, '00', XMLDateSeparator, True, dteInvDate, Value));
  end;

var
  TempValue: string;
begin
  FNegativeDate := (Value[Low(string)] = '-');
  if FNegativeDate then
    TempValue := Copy(Value, 2, Length(Value))
  else
    TempValue := Value;
{$IFDEF _NOT_DEFINED}
  FAdditionalYearDigits := GetAdditionalYears(TempValue);
{$ENDIF}
  if Length(TempValue) < 4 then
    raise EXSDateTimeException.CreateFmt(SInvalidDateString, [TempValue]);
  ConvertDate(TempValue);
end;

function TXSBaseDate.NativeToXS: InvString;
const
  sFormatString = '%s%.4d-%.2d-%.2d';
  sNegative: array[boolean] of string = ('', '-');
begin
  Result := Format(sFormatString, [sNegative[FNegativeDate], FYear, FMonth, FDay]);
end;

function TXSBaseDate.GetYear: Integer;
begin
  Result := FYear;
  if FNegativeDate then
    Result := -Result;
end;

function TXSBaseDate.GetAsDate: TDateTime;
begin
  Result := EncodeDate(Year, Month, Day);
end;

procedure TXSBaseDate.SetAsDate(const Value: TDateTime);
var
  AYear: Word;
begin
  { Earliest TDateTime is 30 Dec 1899 }
  FNegativeDate := False;
  DecodeDate(Value, AYear, FMonth, FDay);
  FYear := Integer(AYear);
end;

{ TXSBaseCustomDateTime }

constructor TXSBaseCustomDateTime.Create;
begin
  Inherited Create;
  FDateParam := TXSBaseDate.Create;
  FTimeParam := TXSBaseTime.Create;
end;

destructor TXSBaseCustomDateTime.Destroy;
begin
  FreeAndNil(FDateParam);
  FreeAndNil(FTimeParam);
  inherited Destroy;
end;

function TXSBaseCustomDateTime.GetFractionalSeconds: Double;
begin
  Result := FTimeParam.GetFractionalSeconds;
end;

procedure TXSBaseCustomDateTime.SetFractionalSeconds(const Value: Double);
begin
  FTimeParam.SetFractionalSeconds(Value);
end;

procedure TXSBaseCustomDateTime.SetUseZeroMilliseconds(const Value: Boolean);
begin
  FTimeParam.FUseZeroMilliseconds := Value;
end;

function TXSBaseCustomDateTime.GetUseZeroMilliseconds: Boolean;
begin
  Result := FTimeParam.FUseZeroMilliseconds;
end;

function TXSBaseCustomDateTime.GetHour: Word;
begin
  Result := FTimeParam.Hour;
end;

function TXSBaseCustomDateTime.GetMinute: Word;
begin
  Result := FTimeParam.Minute;
end;

function TXSBaseCustomDateTime.GetSecond: Word;
begin
  Result := FTimeParam.Second;
end;

function TXSBaseCustomDateTime.GetMilliSecond: Word;
begin
  Result := FTimeParam.MilliSecond;
end;

function TXSBaseCustomDateTime.GetHourOffset: SmallInt;
begin
  Result := FTimeParam.HourOffset
end;

function TXSBaseCustomDateTime.GetMinuteOffset: SmallInt;
begin
  Result := FTimeParam.MinuteOffset
end;

function TXSBaseCustomDateTime.GetMonth: Word;
begin
  Result := FDateParam.Month;
end;

function TXSBaseCustomDateTime.GetDay: Word;
begin
  Result := FDateParam.Day;
end;

function TXSBaseCustomDateTime.GetYear: Integer;
begin
  Result := FDateParam.Year;
end;

procedure TXSBaseCustomDateTime.SetHour(const Value: Word);
begin
  FTimeParam.SetHour(Value);
end;

procedure TXSBaseCustomDateTime.SetMinute(const Value: Word);
begin
  FTimeParam.SetMinute(Value);
end;

procedure TXSBaseCustomDateTime.SetSecond(const Value: Word);
begin
  FTimeParam.SetSecond(Value);
end;

procedure TXSBaseCustomDateTime.SetMillisecond(const Value: Word);
begin
  FTimeParam.SetMillisecond(Value);
end;

procedure TXSBaseCustomDateTime.SetHourOffset(const Value: SmallInt);
begin
  FTimeParam.SetHourOffset(Value);
end;

procedure TXSBaseCustomDateTime.SetMinuteOffset(const Value: SmallInt);
begin
  FTimeParam.SetMinuteOffset(Value);
end;

procedure TXSBaseCustomDateTime.SetMonth(const Value: Word);
begin
  FDateParam.SetMonth(Value);
end;

procedure TXSBaseCustomDateTime.SetDay(const Value: Word);
begin
  FDateParam.SetDay(Value);
end;

procedure TXSBaseCustomDateTime.SetYear(const Value: Integer);
begin
  FDateParam.SetYear(Value);
end;

procedure TXSBaseCustomDateTime.SetAsDateTime(const Value: TDateTime);
begin
  FDateParam.AsDate := Value;
  FTimeParam.AsTime := Value;
end;

procedure TXSBaseCustomDateTime.SetAsUTCDateTime(const Value: TDateTime);
begin
  FDateParam.AsDate := Value;
  FTimeParam.AsTime := Value;
  AddUTCBias(Self);
end;

function TXSBaseCustomDateTime.GetAsDateTime: TDateTime;
var
  BiasDT: TDateTime;
  BiasTime, BiasLocal: Integer;
  BiasHour, BiasMins: Word;
begin
  { NOTE: In XML Years can exceed 9999 - that's not the case for TDateTime.
          So here, there would be a problem with the conversion }
  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, 0);
  { Now adjust TDateTime based on any offsets we have and the local bias }
  { There are two possibilities:
      a. The time we have has the same offset as the local bias - nothing to do!!
      b. The time we have and the local bias are different - requiring adjustments }
  BiasLocal := GetTimeZoneBias;
  BiasTime  := (HourOffset * MinsPerHour) + MinuteOffset;
  if (BiasLocal + BiasTime) = 0 then
    Exit;

  { Here we adjust the Local Bias to make it relative to the Time's own offset
    instead of being relative to GMT }
  BiasLocal := BiasLocal + BiasTime;
  BiasHour := Abs(BiasLocal) div MinsPerHour;
  BiasMins := Abs(BiasLocal) mod MinsPerHour;
  BiasDT := EncodeTime(BiasHour, BiasMins, 0, 0);
  if (BiasLocal > 0) then
    Result := Result - BiasDT
  else
    Result := Result + BiasDT;
end;

function TXSBaseCustomDateTime.GetAsUTCDateTime: TDateTime;
var
  AdjustDT: TDateTime;
begin
  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, 0);
  { If we have an offset, adjust time to go back to UTC }
  if (HourOffset <> 0) or (MinuteOffset <> 0) then
  begin
    AdjustDT := EncodeTime(Abs(HourOffset), Abs(MinuteOffset), 0, 0);
    if ((HourOffset * MinsPerHour) + MinuteOffset) > 0 then
      Result := Result - AdjustDT
    else
      Result := Result + AdjustDT;
  end;
end;

procedure TXSBaseCustomDateTime.XSToNative(const Value: InvString);
var
  TimeString, DateString: InvString;
  TimePosition: Integer;
begin
  TimePosition := Pos(SoapTimePrefix, Value);
  if TimePosition > 0 then
  begin
    DateString := Copy(Value, 1, TimePosition -1);
    TimeString := Copy(Value, TimePosition + 1, Length(Value) - TimePosition);
    FDateParam.XSToNative(DateString);
    FTimeParam.XSToNative(TimeString);
  end else
  begin
    FTimeParam.Hour := 0;
    FTimeParam.Minute := 0;
    FTimeParam.Second := 0;
    FTimeParam.Millisecond := 0;
    FTimeParam.HourOffset := 0;
    FDateParam.XSToNative(Value);
  end;
end;

function TXSBaseCustomDateTime.NativeToXS: InvString;
var
  TimeString: InvString;
begin
  TimeString := FTimeParam.NativeToXS;
  if TimeString <> '' then
    Result := FDateParam.NativeToXS + SoapTimePrefix + TimeString
  else
    Result := FDateParam.NativeToXS;
end;

{ TXSTime }

function TXSTime.GetAsTime: TDateTime;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.AsTime;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetFractionalSeconds: Double;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.FractionalSeconds;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetFractionalSecondString: string;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.FractionalSecondString;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetHourOffset: SmallInt;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.HourOffset;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetHour: Word;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.Hour;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetMillisecond: Word;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.Millisecond;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetMinute: Word;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.Minute;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetMinuteOffset: SmallInt;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.MinuteOffset;
  finally
    Time.Free;
  end;
end;

function TXSTime.GetSecond: Word;
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Result := Time.Second;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetAsTime(const Value: TDateTime);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.AsTime := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetFractionalSeconds(const Value: Double);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.FractionalSeconds := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetHour(const Value: Word);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.Hour := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetHourOffset(const Value: SmallInt);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.HourOffset := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetMillisecond(const Value: Word);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.Millisecond := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetMinute(const Value: Word);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.Minute := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetMinuteOffset(const Value: SmallInt);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.MinuteOffset := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

procedure TXSTime.SetSecond(const Value: Word);
var
  Time: TXSBaseTime;
begin
  Time := GetBaseTime(FTimeValue);
  try
    Time.Second := Value;
    FTimeValue := Time.NativeToXS;
  finally
    Time.Free;
  end;
end;

function TXSTime.Clone: TXSTime;
begin
  Result := TXSTime.Create;
  try
    if FTimeValue <> '' then
      Result.XSToNative(FTimeValue);
  except
    FreeAndNil(Result)
  end;
end;

procedure TXSTime.XSToNative(const Value: InvString);
begin
  FTimeValue := Value;
end;

function TXSTime.NativeToXS: InvString;
const
  sDefaultValue: InvString = '00:00:00';
begin
  if FTimeValue <> '' then
    Result := FTimeValue
  else
    Result := sDefaultValue;
end;

{ TXSDate }

function TXSDate.GetAsDate: TDateTime;
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    Result := ADate.AsDate;
  finally
    ADate.Free;
  end;
end;

function TXSDate.GetDay: Word;
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    Result := ADate.Day;
  finally
    ADate.Free;
  end;
end;

function TXSDate.GetMonth: Word;
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    Result := ADate.Month;
  finally
    ADate.Free;
  end;
end;

function TXSDate.GetYear: Integer;
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    Result := ADate.Year;
  finally
    ADate.Free;
  end;
end;

procedure TXSDate.SetAsDate(const Value: TDateTime);
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    ADate.AsDate := Value;
    FDateValue := ADate.NativeToXS;
  finally
    ADate.Free;
  end;
end;

procedure TXSDate.SetMonth(const Value: Word);
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    ADate.Month := Value;
    FDateValue := ADate.NativeToXS;
  finally
    ADate.Free;
  end;
end;

procedure TXSDate.SetDay(const Value: Word);
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    ADate.Day := Value;
    FDateValue := ADate.NativeToXS;
  finally
    ADate.Free;
  end;
end;

procedure TXSDate.SetYear(const Value: Integer);
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(FDateValue);
  try
    ADate.Year := Value;
    FDateValue := ADate.NativeToXS;
  finally
    ADate.Free;
  end;
end;

constructor TXSDate.Create; 
begin
  inherited Create;
end;

function TXSDate.Clone: TXSDate;
begin
  Result := TXSDate.Create;
  try
    if FDateValue <> '' then
      Result.XSToNative(FDateValue);
  except
    FreeAndNil(Result);
  end;
end;

procedure TXSDate.XSToNative(const Value: InvString);
var
  ADate: TXSBaseDate;
begin
  ADate := GetBaseDate(Value);
  try
    FDateValue := Value;
  finally
    ADate.Free;
  end;
end;

function TXSDate.NativeToXS: InvString;
const
  sDefaultValue: InvString = '0001-01-01';
begin
  if FDateValue <> '' then
    Result := FDateValue
  else
    Result := sDefaultValue;
end;

{ TXSCustomDateTime }

function TXSCustomDateTime.GetAsDateTime: TDateTime;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.AsDateTime;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetAsUTCDateTime: TDateTime;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.AsUTCDateTime;
  finally
    DateTime.Free;
  end;
end;


function TXSCustomDateTime.GetDay: Word;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Day;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetFractionalSeconds: Double;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.FractionalSeconds;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetHour: Word;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Hour;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetHourOffset: SmallInt;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.HourOffset;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetMonth: Word;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Month;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetMillisecond: Word;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Millisecond;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetMinute: Word;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Minute;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetMinuteOffset: SmallInt;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.MinuteOffset;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetSecond: Word;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Second;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetUseZeroMilliseconds: Boolean;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.UseZeroMilliseconds;
  finally
    DateTime.Free;
  end;
end;

function TXSCustomDateTime.GetYear: Integer;
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    Result := DateTime.Year;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetAsDateTime(const Value: TDateTime);
begin
  { Here the user gives us a TDateTime that's in the current TimeZone }
  { So we store the value with the offset of the local bias }
  FDateTime := DateTimeToXMLTime(Value, True);
end;

procedure TXSCustomDateTime.SetAsUTCDateTime(const Value: TDateTime);
begin
  { Here we are given a TDateTime that's already UTC. Therefore
    we don't need to save the Local Bias as Offset }
  FDateTime := DateTimeToXMLTime(Value, False);
end;

procedure TXSCustomDateTime.SetFractionalSeconds(const Value: Double);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.FractionalSeconds := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetDay(const Value: Word);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Day := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetHour(const Value: Word);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Hour := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetHourOffset(const Value: SmallInt);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.HourOffset := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetMillisecond(const Value: Word);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Millisecond := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetMinute(const Value: Word);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Minute := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetMinuteOffset(const Value: SmallInt);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.MinuteOffset := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetMonth(const Value: Word);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Month := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetSecond(const Value: Word);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Second := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetUseZeroMilliseconds(const Value: Boolean);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.UseZeroMilliseconds := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

procedure TXSCustomDateTime.SetYear(const Value: Integer);
var
  DateTime: TXSBaseCustomDateTime;
begin
  DateTime := GetBaseCustomDateTime(FDateTime);
  try
    DateTime.Year := Value;
    FDateTime := DateTime.NativeToXS;
  finally
    DateTime.Free;
  end;
end;

constructor TXSCustomDateTime.Create;
const
  sDefaultValue: InvString = '0001-01-01T00:00:00';
begin
  FDateTime := sDefaultValue;
  inherited Create;
end;

destructor TXSCustomDateTime.Destroy;
begin
  inherited Destroy;
end;

{ TXSDateTime }

class function TXSDateTime.CompareDateTimeParam(const Value1, Value2: TXSDateTime): TXSDuration;
var
  TS: TTimeSpan;
begin
  TS := TTimeSpan.Subtract(Value1.AsDateTime, Value2.AsDateTime);
  Result := TXSDuration.Create;
  Result.Day := TS.Days;
  Result.Hour:= TS.Hours;
  Result.Minute := TS.Minutes;
  Result.Second := TS.Seconds;
end;

function TXSDateTime.Clone: TXSDateTime;
begin
  Result := TXSDateTime.Create;
  try
    if FDateTime <> '' then
      Result.XSToNative(FDateTime);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TXSDateTime.XSToNative(const Value: InvString);
var
  BaseDate: TXSBaseDateTime;
begin
  BaseDate := GetBaseDateTime(Value);
  try
    FDateTime := Value;
  finally
    BaseDate.Free;
  end;
end;

function TXSDateTime.NativeToXS: InvString;
begin
  Result := FDateTime;
end;


{ TXSDuration }

constructor TXSDuration.Create;
begin
  inherited Create;
end;

function TXSDuration.GetSecond: Integer;
begin
  Result := Trunc(FData.Second);
end;

procedure TXSDuration.SetSecond(const Value: Integer);
begin
  FData.Second := Value;
end;

class function TXSDuration.EncodeDuration(const Data: TDurationData): InvString;
const
  sNegPrefix: array[Boolean] of string = ('', '-');
var
  SecStr: string;
begin
  Result := sNegPrefix[Data.Negative] + XMLDurationStart;
  if Data.Year <> 0 then
    Result := Result + IntToStr(Data.Year) + XMLDurationYear;
  if Data.Month <> 0 then
    Result := Result + IntToStr(Data.Month) + XMLDurationMonth;
  if Data.Day <> 0 then
    Result := Result + IntToStr(Data.Day) + XMLDurationDay;

  SecStr := SoapFloatToStr(Data.Second);
  if (Data.Hour <> 0) or (Data.Minute <> 0) or (SecStr <> '0') or
     (AnsiLastChar(Result)^ = XMLDurationStart) then
  begin
    Result := Result + SoapTimePrefix;
    if Data.Hour <> 0 then
      Result := Result + IntToStr(Data.Hour) + XMLDurationHour;
    if Data.Minute <> 0 then
      Result := Result + IntToSTr(Data.Minute) + XMLDurationMinute;
    if (SecStr <> '0') or (AnsiLastChar(Result)^ = SoapTimePrefix) then
      Result := Result + SecStr + XMLDurationSecond;
  end;
end;

class procedure TXSDuration.DecodeDuration(const ADuration: string;
                                           out Data: TDurationData);
var
  TimeStr, DateStr: string;
  TimePosition: Integer;
begin
  { "The designator 'P' must be present"
    "...at least one number and its designator ·must· be present."
    http://www.w3.org/TR/2001/REC-xmlschema-2-20010502/#duration }
  if (Length(ADuration) < 3) then
    SoapDateTimeErrorFmt(SInvalidDuration, [ADuration]);

  { "The designator 'P' must always be present."
    "An optional preceding minus sign ('-') is allowed, to indicate
     a negative duration."
    http://www.w3.org/TR/2001/REC-xmlschema-2-20010502/#duration }
  if not ((ADuration[Low(string)] = XMLDurationStart) or
          ((ADuration[Low(string)] = '-') and (ADuration[Low(string)+1] = XMLDurationStart)))  then
    SoapDateTimeErrorFmt(SInvalidDuration, [ADuration]);

  TimePosition := Pos(SoapTimePrefix, ADuration);
  if TimePosition > 0 then
  begin
    TimeStr := Copy(ADuration, TimePosition + 1, Length(ADuration) - TimePosition);
    DateStr := Copy(ADuration, 1, TimePosition - 1);
  end
  else
    DateStr := ADuration;

  Data.Negative := ADuration[Low(string)] = '-';
  data.Year  := StrToInt(GetNumberBefore(DateStr, XMLDurationYear));
  data.Month := StrToInt(GetNumberBefore(DateStr, XMLDurationMonth));
  data.Day   := StrToInt(GetNumberBefore(DateStr, XMLDurationDay));
  if (TimePosition > 0) then
  begin
    data.Hour  := StrToInt(GetNumberBefore(TimeStr, XMLDurationHour));
    data.Minute:= StrToInt(GetNumberBefore(TimeStr, XMLDurationMinute));
    data.Second:= SoapStrToFloat(GetNumberBefore(TimeStr, XMLDurationSecond, True));
  end
  else
  begin
    data.Hour  := 0;
    data.Minute:= 0;
    data.Second:= 0;
  end;
end;

procedure TXSDuration.XSToNative(const Value: InvString);
begin
  DecodeDuration(Value, FData);
end;

function TXSDuration.NativeToXS: InvString;
begin
  Result := EncodeDuration(FData);
end;

{ TXSHexBinary }

function TXSHexBinary.NativeToXS: InvString;
begin
  Result := FHexBinaryString;
end;

procedure TXSHexBinary.XSToNative(const Value: InvString);
{$IFDEF NEXTGEN}
var
  SourceBytes, DestBytes: TBytes;
  V: string;
  L : Integer;
begin
                                                                       
  V := Value;
  if V.IndexOf(SHexMarker) = -1 then
    V := SHexMarker + V;
  SourceBytes := TEncoding.UTF8.GetBytes(V);
  L := Length(SourceBytes);
  SetLEngth(DestBytes, (L+1) div 2);
  if HexToBin(SourceBytes, 0, DestBytes, 0, L) > 0 then
    SoapHexBinaryErrorFmt(SInvalidHexValue, [Value]);
  FHexBinaryString := Value;
end;
{$ELSE !NEXTGEN}
var
  PText: PChar;
  V: string;
  L : Integer;
begin
  V := Value;
  L := Length(V);
  PText := AllocMem((L * 2 + 1) * sizeof(Char));
  try
    if Pos(SHexMarker, V) = 0 then
      V := SHexMarker + V;
    if HexToBin(PChar(V), PText, L) > 0 then
      SoapHexBinaryErrorFmt(SInvalidHexValue, [Value]);
    FHexBinaryString := Value;
  finally
    FreeMem(PText);
  end;
end;
{$ENDIF NEXTGEN}

function TXSHexBinary.GetAsByteArray: TByteDynArray;
{$IFDEF NEXTGEN}
var
  SourceBytes, DestBytes: TBytes;
  count: integer;
begin
  if FHexBinaryString = '' then
    SetLength(Result, 0)
  else
  begin
    SourceBytes := TEncoding.UTF8.GetBytes(FHexBinaryString);
    SetLength(DestBytes, Length(SourceBytes));
    count := HexToBin(SourceBytes, 0, DestBytes, 0, Length(SourceBytes));
    SetLength(Result, count);
    Move(DestBytes[0], Result[0], Count);
  end;
end;
{$ELSE !NEXTGEN}
var
  P: PChar;
begin
  if FHexBinaryString = '' then
    SetLength(Result, 0)
  else
  begin
    SetLength(Result, Length(FHexBinaryString));
    P := @Result[0];
    HexToBin(PChar(FHexBinaryString), P, Length(FHexBinaryString));
  end;
end;
{$ENDIF NEXTGEN}

procedure TXSHexBinary.SetAsByteArray(const Value: TByteDynArray);
{$IFDEF NEXTGEN}
var
  SourceBytes, DestBytes: TBytes;
  Count: integer;
begin
  Count := Length(Value);
  SetLength(SourceBytes, Count);
  Move(Value[0], SourceBytes[0], Count);
  SetLength(DestBytes, Count*2);
  BinToHex(SourceBytes, 0, DestBytes, 0, Count);
  FHexBinaryString := TEncoding.UTF8.GetString(DestBytes);
end;
{$ELSE !NEXTGEN}
var
  P, PText: PChar;
  L : Integer;
begin
  P := @Value[0];
  L := Length(Value);
  PText := AllocMem(((L+1) * 2) * sizeof(Char));
  try
    BinToHex(P, PText, L);
    SetString(FHexBinaryString, PText, StrLen(PText));
  finally
    FreeMem(PText);
  end;
end;
{$ENDIF NEXTGEN}

{ TXSDecimal }

function TXSDecimal.NativeToXS: InvString;
begin
  Result := FDecimalString
end;

procedure TXSDecimal.XSToNative(const Value: InvString);
begin
  FDecimalString := Value;
end;

function TXSDecimal.GetAsBcd: TBcd;

  procedure CheckDecimalString(const Value: InvString);
  begin
    if Pos(SSciNotationMarker, Value) > 0 then
      SoapDecimalError(SNoSciNotation)
    else if Pos(SNAN, Value) > 0 then
      SoapDecimalError(SNoNAN)
    else if Length(Value) > 2 + (MaxFMTBcdDigits * 2) then
      SoapDecimalErrorFMT(SBcdStringTooBig, [Value]);
  end;

const
  sDefaultValue: InvString = '00';
var
  Value: InvString;
begin
  Value := NativeToXS;
  if Value = '' then
    Value := sDefaultValue;
  CheckDecimalString(Value);
  if not TryStrToBcd(Value, Result, GetFormatSettings^) then
    SoapDecimalErrorFmt(SInvalidDecimalString, [Value]);
end;

procedure TXSDecimal.SetAsBcd(const Value: TBcd);
begin
  if (Value.Precision > MaxFMTBcdDigits * 2) or
     (Value.Precision < 1) or
     (BcdScale(Value) > MaxFMTBcdDigits * 2) then
    SoapDecimalErrorFmt(SInvalidBcd, [Value.Precision, BcdScale(Value)]);
  FDecimalString := BcdToStr(Value, GetFormatSettings^);
end;

{ TXSString }

procedure TXSString.XSToNative(const Value: InvString);
begin
  FString := Value;
end;

function  TXSString.NativeToXS: InvString;
begin
  Result := FString;
end;

function TXSBoolean.NativeToXS: InvString;
const
  sValues: array[Boolean] of InvString = ('0', '1'); { Do not localize }
begin
  Result := sValues[FBoolean]
end;

procedure TXSBoolean.XSToNative(const Value: InvString);
begin
  FBoolean := (Value = '1') or (Value = 'true'); { Do not localize }
end;

{ TXSInteger }

function TXSInteger.NativeToXS: InvString;
begin
  Result := IntToStr(FInteger);
end;

procedure TXSInteger.XSToNative(const Value: InvString);
begin
  FInteger := StrToInt(Value);
end;

{ TXSLong }

function TXSLong.NativeToXS: InvString;
begin
  Result := IntToStr(FLong);
end;

procedure TXSLong.XSToNative(const Value: InvString);
begin
  FLong := StrToInt64(Value);
end;

{ TXMLData }

constructor TXMLData.Create;
begin
  inherited;
  FXMLDocument := NewXMLDocument;
end;

destructor TXMLData.Destroy;
begin
  FXMLNode := nil;
  FXMLDocument := nil;
  inherited;
end;

procedure TXMLData.LoadFromXML(const XML: string);
begin
  FXMLDocument.LoadFromXML(XML);
  if FXMLDocument.Node.ChildNodes.Count > 0 then
    FXMLNode := FXMLDocument.Node.ChildNodes[0];
end;

{$IFNDEF NEXTGEN}
procedure TXMLData.LoadFromXML(const XML: WideString);
begin
  FXMLDocument.LoadFromXML(XML);
  if FXMLDocument.Node.ChildNodes.Count > 0 then
    FXMLNode := FXMLDocument.Node.ChildNodes[0];
end;
{$ENDIF !NEXTGEN}

{ Utility routine lifted from XMLDoc.pas }
function CloneNodeToDoc(const SourceNode: IXMLNode; const TargetDoc: IXMLDocument;
  Deep: Boolean = True): IXMLNode;
var
  I: Integer;
begin
  with SourceNode do
    case nodeType of
      ntElement:
        begin
          Result := TargetDoc.CreateElement(NodeName, NamespaceURI);
          for I := 0 to AttributeNodes.Count - 1 do
            Result.AttributeNodes.Add(CloneNodeToDoc(AttributeNodes[I], TargetDoc, False));
          if Deep then
            for I := 0 to ChildNodes.Count - 1 do
              Result.ChildNodes.Add(CloneNodeToDoc(ChildNodes[I], TargetDoc, Deep));
        end;
      ntAttribute:
        begin
          Result := TargetDoc.CreateNode(NodeName, ntAttribute, NamespaceURI);
          Result.NodeValue := NodeValue;
        end;
      ntText, ntCData, ntComment:
          Result := TargetDoc.CreateNode(NodeValue, NodeType);
      ntEntityRef:
          Result := TargetDoc.createNode(nodeName, NodeType);
      ntProcessingInstr:
          Result := TargetDoc.CreateNode(NodeName, ntProcessingInstr, NodeValue);
      ntDocFragment:
        begin
          Result := TargetDoc.CreateNode('', ntDocFragment);
          if Deep then
            for I := 0 to ChildNodes.Count - 1 do
              Result.ChildNodes.Add(CloneNodeToDoc(ChildNodes[I], TargetDoc, Deep));
        end;
      else
       {ntReserved, ntEntity, ntDocument, ntDocType:}
       { XMLDocError(SInvalidNodeType); }
    end;
end;

function TXMLData.ObjectToSOAP(RootNode, ParentNode: IXMLNode;
  const ObjConverter: IObjConverter; const NodeName, NodeNamespace, ChildNamespace: InvString;
  ObjConvOpts: TObjectConvertOptions; out RefID: InvString): IXMLNode;
var
  RawNode: IXMLNode;
begin
  Result := inherited ObjectToSOAP(RootNode, ParentNode, ObjConverter, NodeName, NodeNamespace, ChildNamespace,
                                   ObjConvOpts+[ocoDontSerializeProps], RefId);
  if (Result <> nil) and (FXMLNode <> nil) then
  begin
    RawNode := CloneNodeToDoc(FXMLNode, ParentNode.OwnerDocument, True);
    if RawNode <> nil then
      Result.ChildNodes.Add(RawNode);
  end;
end;

procedure TXMLData.SOAPToObject(const RootNode, Node: IXMLNode;
  const ObjConverter: IObjConverter);
begin
  if Node.ChildNodes.Count = 1 then
    FXMLNode := CloneNodeToDoc(Node.ChildNodes[0], FXMLDocument, True)
end;

procedure InitXSTypes;
begin
  RemClassRegistry.RegisterXSClass(TXSDateTime, XMLSchemaNameSpace, 'dateTime', '',True);
  RemClassRegistry.RegisterXSClass(TXSTimeInstant, XMLSchemaNameSpace, 'timeInstant', '', True);
  RemClassRegistry.RegisterXSClass(TXSTime, XMLSchemaNameSpace, 'time', '', True);
  RemClassRegistry.RegisterXSClass(TXSDate, XMLSchemaNameSpace, 'date', '', True);
  RemClassRegistry.RegisterXSClass(TXSDuration, XMLSchemaNameSpace, 'duration', '', True);
  RemClassRegistry.RegisterXSClass(TXSDuration, XMLSchemaNameSpace, 'timeDuration', '', True);
  RemClassRegistry.RegisterXSClass(TXSHexBinary, XMLSchemaNamespace, 'hexBinary', '', True);
  RemClassRegistry.RegisterXSClass(TXSDecimal, XMLSchemaNamespace, 'decimal', '', True);
  {
  RemClassRegistry.RegisterXSClass(TXSDecimal, XMLSchemaNamespace, 'integer', '', True);
  }
  RemClassRegistry.RegisterXSClass(TXSString, XMLSchemaNamespace, 'string', '', True);
  RemClassRegistry.RegisterXSClass(TXSBoolean, XMLSchemaNamespace, 'boolean', '', True);
  RemClassRegistry.RegisterXSClass(TXSInteger, XMLSchemaNamespace, 'int', '', True);
  RemClassRegistry.RegisterXSClass(TXSLong, XMLSchemaNamespace, 'long', '', True);

  RemClassRegistry.RegisterXSClass(TXSDecimal, XMLSchemaNamespace, 'negativeInteger', '', True);
  RemClassRegistry.RegisterXSClass(TXSDecimal, XMLSchemaNamespace, 'nonNegativeInteger', '', True);
  RemClassRegistry.RegisterXSClass(TXSDecimal, XMLSchemaNamespace, 'nonPositiveInteger', '', True);
  RemClassRegistry.RegisterXSClass(TXSDecimal, XMLSchemaNamespace, 'positiveInteger', '', True);
end;

end.
