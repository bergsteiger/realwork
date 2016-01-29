{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnMisc
|
| Description: Miscelaneous types and routines.
|
| History: Nov 29, 1998. Michel Brazeau, first version
|          Jun 24, 1998. Michel Brazeau, add Ceiling, Floor
|          Aug 30, 1999. Michel Brazeau, GetTempFileName
|
|---------------------------------------------------------------------------}
unit EnMisc;

{$I Envision.Inc}

interface

uses
    SysUtils, { for Exception, ShortDateFormat, LongTimeFormat }
    Windows;  { for THandle }

const

CCentimetersPerInch = 2.54;

CMetersPerInch      = 0.0254;
CInchesPerMeter     = 100 / 2.54;

type

{$ifdef __Delphi3}
      
DWORD = LongInt;

{$endif}

EEnvisionError = class(Exception);


TImageFormat = ( ifBlackWhite, ifGray16, ifGray256,
                 ifColor16, ifColor256, ifTrueColor );

TAcquireEvent = procedure( const DibHandle    : THandle;
                           const XDpi         : Word;
                           const YDpi         : Word;
                           const CallBackData : LongInt ) of object;

TIntegerArray = array[0..(MaxLongInt div 4)-1] of Integer;
TpIntegerArray = ^TIntegerArray;

TEnvisionProgressEvent = procedure( const Sender          : TObject;
                                    const PercentProgress : Byte ) of object;

{ utility procedure to call a progress event given progress values not based
  on a percentage scale.

  MB Jun 24, 1999. Add LastPercent parameter. If the new percent calculated is
  the same as the last one, the progress event is not triggered. Set
  LastPercent to -1, to always trigger the event.
  Return percentage of progress. }
function DoProgress( const Sender        : TObject;
                     const ProgressEvent : TEnvisionProgressEvent;
                     const Current       : LongInt;
                     const Min           : LongInt;
                     const Max           : LongInt;
                     const LastPercent   : ShortInt ) : Byte;


{ converts a date to a date string. The format of the date is defined
  by Mask, ie, 'yyyy/mm/dd'. }
function DateToDateStr( const Date  : TDateTime;
                        const Mask  : String ) : String;

{ converts a time to a time string. The format of the time is defined
  by Mask, ie, 'hh:nn:ss'. }
function TimeToTimeStr( const Time : TDateTime;
                        const Mask : String ) : String;

function MinInteger( const Value1 : LongInt;
                     const Value2 : LongInt ) : LongInt;

function MaxInteger( const Value1 : LongInt;
                     const Value2 : LongInt ) : LongInt;

function MinFloat( const Value1 : Extended;
                   const Value2 : Extended ) : Extended;

function MaxFloat( const Value1 : Extended;
                   const Value2 : Extended ) : Extended;

{ rounds a floating point number to a specified number of decimal places.
  Places >= 0 }
function RoundFloat( const Value  : Extended;
                     const Places : Word ) : Extended;

{ compute Base^Exponent, with Base > 0 }
function Power( const Base     : Extended;
                const Exponent : Extended): Extended;

{ ensure Value is bounded by MinValue and MaxValue }
function BoundFloat( const Value    : Extended;
                     const MinValue : Extended;
                     const MaxValue : Extended ) : Extended;

function BoundInteger( const Value    : LongInt;
                       const MinValue : LongInt;
                       const MaxValue : LongInt ) : LongInt;

function IncWrap( const Value : LongInt; const Min, Max : LongInt) : LongInt;
function DecWrap( const Value : LongInt; const Min, Max : LongInt) : LongInt;

{ returns True if all the bit fields in Flags are set in Value. }
function AreFlagsSet(const Value, Flags : LongInt) : Boolean;

function InchesToCm( const Inches : Double ) : Double;
function CmToInches( const Centimeters : Double ) : Double;

function InchesToPixels( const Inches : Double;
                         const Dpi    : Word ) : LongInt;
function PixelsToInches( const Pixels : LongInt;
                         const Dpi    : Word ) : Double;


{ display/terminate the hourglass cursor. Successive calls to
  BeginHourglass are allowed as long as corresponding call to
  EndHourglass are done. }
procedure BeginHourglass;
procedure EndHourglass;


function AddBackSlashToPath(const Path: String): String;

{ Returns the Ceiling of a floating point value. ie, 3.4 returns 4 }
function Ceiling( const Value : Extended) : Integer;

{ Returns the Floor of a floating point value. ie, 3.4 returns 3 }
function Floor( const Value : Extended): Integer;


{ Create a temporary file. The name will start with PreName and have the
  specified Extension. The file will be created in the directory
  returned by GetTempPath API call }
function GetTempFileName( const PreName   : String;
                                Extension : String ) : String;

procedure RaiseLZWCompressionNotSupported;

implementation

uses
    Controls, { for crHourglass }
    Dialogs,
    Forms,    { for Screen }
    EnMsg;    { for msgXXXX }


{--------------------------------------------------------------------------}

function DateToDateStr( const Date  : TDateTime;
                        const Mask  : String ) : String;
var
    SavedStr : String;
begin
    SavedStr := ShortDateFormat;
    try
        ShortDateFormat := Mask;
        Result := DateToStr(Date);
    finally
        ShortDateFormat := SavedStr;
    end;
end;

{--------------------------------------------------------------------------}

function TimeToTimeStr( const Time : TDateTime;
                        const Mask : String ) : String;
var
    SavedStr : String;
begin
    { use LongTimeFormat to include seconds. }
    SavedStr := LongTimeFormat;
    try
        LongTimeFormat := Mask;
        Result := TimeToStr(Time);
    finally
        LongTimeFormat := SavedStr;
    end;
end;

{--------------------------------------------------------------------------}

function MinInteger( const Value1 : LongInt;
                     const Value2 : LongInt ) : LongInt;
begin
    if Value1 < Value2 then
        Result := Value1
    else
        Result := Value2;
end;

{--------------------------------------------------------------------------}

function MaxInteger( const Value1 : LongInt;
                     const Value2 : LongInt ) : LongInt;
begin
    if Value1 > Value2 then
        Result := Value1
    else
        Result := Value2;
end;

{--------------------------------------------------------------------------}

function MinFloat( const Value1 : Extended;
                   const Value2 : Extended ) : Extended;
begin
    if Value1 < Value2 then
        Result := Value1
    else
        Result := Value2;
end;

{--------------------------------------------------------------------------}

function MaxFloat( const Value1 : Extended;
                   const Value2 : Extended ) : Extended;
begin
    if Value1 > Value2 then
        Result := Value1
    else
        Result := Value2;
end;

{--------------------------------------------------------------------------}

function RoundFloat( const Value  : Extended;
                     const Places : Word ) : Extended;
var
    ValStr     : String;
    TempResult : Integer;
begin
    Str(Value:40:Places, ValStr);

    Val(ValStr, Result, TempResult);
end;

{--------------------------------------------------------------------------}

function Power( const Base     : Extended;
                const Exponent : Extended): Extended;
begin
    Result := Exp(Exponent * ln(Base));
end;

{--------------------------------------------------------------------------}

function BoundFloat( const Value    : Extended;
                     const MinValue : Extended;
                     const MaxValue : Extended ) : Extended;
begin
    Result := Value;

    if Result < MinValue then
        Result := MinValue;

    if Result > MaxValue then
        Result := MaxValue;
end;

{--------------------------------------------------------------------------}

function BoundInteger( const Value    : LongInt;
                       const MinValue : LongInt;
                       const MaxValue : LongInt ) : LongInt;
begin
    Result := Value;

    if Result < MinValue then
        Result := MinValue;

    if Result > MaxValue then
        Result := MaxValue;
end;

{--------------------------------------------------------------------------}

function IncWrap( const Value : LongInt; const Min, Max : LongInt) : LongInt;
begin
    if Value >= Max then
        Result := Min
    else
        Result := Value + 1;
end;

{--------------------------------------------------------------------------}

function DecWrap( const Value : LongInt; const Min, Max : LongInt) : LongInt;
begin
    if Value <= Min then
        Result := Max
    else
        Result := Value - 1;
end;

{--------------------------------------------------------------------------}

function AreFlagsSet(const Value, Flags : LongInt) : Boolean;
begin
    Result := (Flags = Flags and Value);
end;

{--------------------------------------------------------------------------}

function InchesToCm( const Inches : Double ) : Double;
begin
    Result := Inches * CCentimetersPerInch;
end;

{--------------------------------------------------------------------------}

function CmToInches( const Centimeters : Double ) : Double;
begin
    Result := Centimeters / CCentimetersPerInch;
end;

{--------------------------------------------------------------------------}

function InchesToPixels( const Inches : Double;
                         const Dpi    : Word ) : LongInt;
begin
    Result := Round( Inches * Dpi );
end;

{--------------------------------------------------------------------------}

function PixelsToInches( const Pixels : LongInt;
                         const Dpi    : Word ) : Double;
begin
    Result := Round( Pixels / Dpi );
end;

{--------------------------------------------------------------------------}

function DoProgress( const Sender        : TObject;
                     const ProgressEvent : TEnvisionProgressEvent;
                     const Current       : LongInt;
                     const Min           : LongInt;
                     const Max           : LongInt;
                     const LastPercent   : ShortInt ) : Byte;
var
    Percent : Byte;
begin
    if not Assigned(ProgressEvent) then
    begin
        Result := 0;
        Exit;
    end;

    Percent := BoundInteger( ((Current - Min) * 100) div (Max - Min),
                             0, 100 );

    if SmallInt(Percent) <> SmallInt(LastPercent) then
        ProgressEvent(Sender, Percent);

    Result := Percent;
end;

{--------------------------------------------------------------------------}

var
    HourglassCount : LongInt;

procedure BeginHourglass;
begin
    if HourglassCount = 0 then
         Screen.Cursor := crHourglass;

    Inc(HourglassCount);
end;

{--------------------------------------------------------------------------}

procedure EndHourglass;
begin
    Dec(HourglassCount);

    if HourglassCount = 0 then
        Screen.Cursor := crDefault;
end;

{--------------------------------------------------------------------------}

function AddBackSlashToPath(const Path: String): String;
begin
    if Path = '' then
    begin
        Result := '\';
        Exit;
    end;

    Result := Path;

    { verify Path does not end with :, before adding the back slash. ie, to
      prevent c: becoming c:\, which is not the same directory. }
    if (Path[Length(Path)] <> '\') and
       (Path[Length(Path)] <> ':') then
        Result := Path + '\';
end;

{--------------------------------------------------------------------------}

procedure RaiseLZWCompressionNotSupported;
begin
    raise EEnvisionError.Create(
            msgLZWCompressionNotSupported );

end;

{--------------------------------------------------------------------------}

function Ceiling( const Value : Extended) : Integer;
begin
    Result := Integer(Trunc(Value));
    if Frac(Value) > 0 then
        Inc(Result);
end;

{--------------------------------------------------------------------------}

function Floor( const Value : Extended): Integer;
begin
    Result := Integer(Trunc(Value));
    if Frac(Value) < 0 then
        Dec(Result);
end;

{--------------------------------------------------------------------------}

function GetTempFileName( const PreName   : String;
                                Extension : String ) : String;
var
    Path       : AnsiString;
    PathLength : Integer;
    Count      : Integer;
begin
    SetLength(Path, 256);

    PathLength := GetTempPath(256, PChar(Path));

    if PathLength = 0 then
        raise Exception.Create('EnMisc.CreateTempFile.GetTempPath failed');

    SetString(Path, PChar(Path), PathLength);

    Path := AddBackslashToPath(Path);

    if (Length(Extension) > 0) and
       (Extension[1] <> '.') then
        Extension := '.' + Extension;

    Count := 0;

    repeat
        Result := Path + PreName + IntToStr(Count) + Extension;
        Inc(Count);
    until not FileExists(Result);
end;

{--------------------------------------------------------------------------}

initialization
    HourglassCount := 0;
end.
