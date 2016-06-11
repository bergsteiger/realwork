{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{                                                       }
{            Platform-independent utilities             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Utils;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.UITypes, System.Types, System.Math.Vectors, System.Classes;

type
  PAlphaColorArray = ^TAlphaColorArray;
  TAlphaColorArray = array [0 .. MaxInt div 4 - 1] of TAlphaColor;

  PAlphaColorRecArray = ^TAlphaColorRecArray;
  TAlphaColorRecArray = array [0 .. MaxInt div 4 - 1] of TAlphaColorRec;

  /// <summary>
  ///  A helper class that contains utilities to facilitate writing non-reentrant sections of code. It does not
  ///  provide thread-safety. A non-reentrable task is passed as a procedure or a function and can return a value.
  ///  Guard flag variable Guard is passed by reference and should be False in order for the procedure to execute.
  ///
  ///  For the cases when a non-reentrant section cannot be contained in one procedure, EnterSection/LeaveSection
  ///  can be used.
  /// </summary>
  TNonReentrantHelper = class
  public
    /// <summary>Execute non-reentrable procedure Proc using guard variable Guard. Return True if procedure was
    /// executed</summary>
    class function Execute(var Guard: Boolean; const Proc: TProc): Boolean; overload;
    /// <summary>Execute non-reentrable procedure Proc&lt;A&gt; with an argument of type A. Return True if procedure
    /// was executed </summary>
    class function Execute<A>(var Guard: Boolean; const Proc: TProc<A>; const Arg: A): Boolean; overload;
    /// <summary>Execute non-reentrable function Func:R. Return function result of type R or provided Default
    /// value of type R if the code was not executed</summary>
    class function Execute<R>(var Guard: Boolean; const Func: TFunc<R>; const Default: R): R; overload;
    /// <summary>Execute non-reentrable function Func with an argument of type A and return type R. Return function
    /// result or provided default value of type R if the code was not executed</summary>
    class function Execute<A; R>(var Guard: Boolean; const Func: TFunc<A, R>; const Arg: A; const Default: R): R; overload;
    /// <summary>Enter non-reentrable section of code. If the value of Guard was False, it will be changed to True
    /// and the result will be True. Otherwise the value is not going to be changed and the result will be False.
    /// </summary>
    class function EnterSection(var Guard: Boolean): Boolean; inline;
    /// <summary>Leave non-reentrable section of code. This should only be called once after EnterSection with same
    /// Guard variable returned True</summary>
    class procedure LeaveSection(var Guard: Boolean); inline;
  end;

/// <summary>
/// Calculate relative luminance of given TAlphaColor.
/// See: http://en.wikipedia.org/wiki/Luminance_(relative)
/// Return value in range [0..1]
/// 1 - Light
/// 0 - Dark
/// </summary>
function Luminance(const AColor: TAlphaColor): Single;
/// <summary>
///  Fill array of TAlphaColor Dest of size Count with TAlphaColor value Value.
/// </summary>
procedure FillAlphaColor(const Dest: PAlphaColorArray; const Count: Integer; const Value: TAlphaColor);
/// <summary>
/// Fill a TAlphaColor rectangle in bit plane Dest of Width x Height with TAlphaColor value Value.
/// Rectangle is specified by (X1,Y1)-(X2,Y2), right-bottom bounds not included.
/// </summary>
procedure FillAlphaColorRect(const Dest: PAlphaColorArray; Width, Height, X1, Y1, X2, Y2: Integer;
  const Value: TAlphaColor);
/// <summary>
/// Fill Alpha in pixel array Dest of size Count. Other color components are intact.
/// </summary>
procedure FillAlpha(const Dest: PAlphaColorRecArray; const Count: Integer; const Alpha: Byte);
/// <summary>
/// Reverse order of bytes in place in array Dest of size Count.
/// </summary>
procedure ReverseBytes(const Dest: Pointer; const Count: Integer); deprecated;
/// <summary>
/// Return a string representation of R: TRectF.
/// </summary>
function RectToString(const R: TRectF): string;
/// <summary>
/// Return TRectF represented by string S.
/// </summary>
function StringToRect(S: string): TRectF;
/// <summary>
/// Return a string representation of P: TPointF.
/// </summary>
function PointToString(const P: TPointF): string;
/// <summary>
/// Return TPointF represented by string S.
/// </summary>
function StringToPoint(S: string): TPointF;
/// <summary>
/// Return a Single value between Start and Stop at time moment T. When T = 0, Result = Start. When T = 1, Result = Stop.
/// </summary>
function InterpolateSingle(const Start, Stop, T: Single): Single;
/// <summary>
/// Used for rotation angles. Same as InterpolateSingle.
/// </summary>
function InterpolateRotation(const Start, Stop, T: Single): Single;
/// <summary>
/// Interpolate color value between colors Start and Stop at time moment T.
/// When T = 0, Result = Start. When T = 1, Result = Stop.
/// </summary>
function InterpolateColor(const Start, Stop: TAlphaColor; T: Single): TAlphaColor;
/// <summary>
/// Get a token from string S. Tokens are separated by one of the characters in Separators. Separators may be different
/// every time GetToken is called.
/// S is modified for subsequent calls to GetToken.
/// </summary>
function GetToken(var S: string; const Separators: string; const Stop: string = string.Empty): string; overload;
/// <summary>
/// Get a token from immutable string S, starting at position Pos. Pos is updated for subsequent calls to GetToken.
/// Tokens are separated by one of the characters in Separators. Separators may be different every time GetToken is
/// called.
/// </summary>
function GetToken(var Pos: Integer; const S: string; const Separators: string;
  const Stop: string = string.Empty): string; overload;
/// <summary>
/// Return a string representation of P: TPoint3D.
/// </summary>
function Point3DToString(const P: TPoint3D): string;
/// <summary>
///  Return TPoint3D represented by string S.
/// </summary>
function StringToPoint3D(S: string): TPoint3D;
/// <summary>
/// Returns the short version of the hint specified in the Hint string
/// </summary>
function GetShortHint(const Hint: string): string;
/// <summary>
/// Returns the long version of the hint specified in the Hint string
/// </summary>
function GetLongHint(const Hint: string): string;
/// <summary>
/// Make a normalized TVector3D equivalent to given TAlphaColor.
/// </summary>
function ColorToVector3D(const AColor: TAlphaColor): TVector3D; deprecated 'Use TAlphaColorF instead.';
/// <summary>
///  Make a TAlphaColor from TVector3D. The vector should be normalized.
/// </summary>
function Vector3DToColor(const AColor: TVector3D): TAlphaColor; deprecated 'Use TAlphaColorF instead.';
///<summary> verifies that AValue is an instance of AClass or its heir.
///<para> If this is not true, then it raise the exception.</para>
///<para> If AValue=nil and CanBeNil=true nothing happens, otherwise it raises the exception</para> </summary>
///<exception>EArgumentException is raised if AValue does not satisfy the conditions</exception>
///<exception>EArgumentNilException is raised if AValue or AClass is nil</exception>
procedure ValidateInheritance(const AValue: TPersistent; const AClass: TClass; const CanBeNil: Boolean = True);

///<summary> This function returns true if the given point (APoint) is inside or is on the contour of a
///circle centered at ACenter with radius ARadius.</summary>
function IsPointInCircle(const APoint, ACenter: TPointF; const ARadius: Integer): Boolean;

///<summary> Takes into account margin of error returning a percentage of match.
/// 100% match will be margin of error of deviation from the source point.
/// 0% will be at deviation away and beyond.</summary>
function CheckPoint(const APoint, ASource: TPointF; const ADeviation, ErrorMargin: Integer): Double;

// 2D shapes
type
  ///<summary> This structure represents a 2D circle centered in Center with a Radius.</summary>
  TCircle2D = record
    ///<summary> Center of the circle.</summary>
    Center: TPointF;
    ///<summary> Radius of the circle.</summary>
    Radius: Single;
    ///<summary> Default constructor.</summary>
    constructor Create(const ACenter: TPointF; const ARadius: Single);
  end;

  ///<summary> This structure represents a 2D line passing through one Origin and with a Direction.</summary>
  TLine2D = record
    ///<summary> Origin of the line.</summary>
    Origin: TPointF;
    ///<summary> Direction of the line.</summary>
    Direction: TPointF;
    ///<summary> Default constructor.</summary>
    constructor Create(const AnOrigin, ADestination: TPointF);
    ///<summary> Returns true if the line intersects with the circle, False otherwise.</summary>
    function Intersects(const ACircle: TCircle2D): Boolean;
  end;

var
  ///<summary>
  /// used for correct string to float convertion
  ///</summary>
  USFormatSettings: TFormatSettings;

implementation

uses
  System.UIConsts, System.RTLConsts, FMX.Consts;

{ TLine2D }

constructor TLine2D.Create(const AnOrigin, ADestination: TPointF);
begin
  Origin := AnOrigin;
  Direction := ADestination - AnOrigin;
end;

function TLine2D.Intersects(const ACircle: TCircle2D): Boolean;
var
  A, B, C: Single;
begin
  A := Sqr(Direction.X) + Sqr(Direction.Y);
  B := 2 * ((Direction.X) * (Origin.X - ACircle.Center.X) + (Direction.Y) * (Origin.Y - ACircle.Center.Y));
  C := Sqr(ACircle.Center.X) + Sqr(ACircle.Center.Y) + Sqr(Origin.X) + Sqr(Origin.Y) - 2 *
    (ACircle.Center.X * Origin.X + ACircle.Center.Y * Origin.Y) - Sqr(ACircle.Radius);

  Result := (B * B - 4 * A * C) > 0;
end;

{ TCircle2D }

constructor TCircle2D.Create(const ACenter: TPointF; const ARadius: Single);
begin
  Center := ACenter;
  Radius := ARadius;
end;

{ TNonReentrantHelper }

class function TNonReentrantHelper.Execute(var Guard: Boolean; const Proc: TProc): Boolean;
begin
  Result := False;
  if EnterSection(Guard) then
    try
      Proc;
      Result := True;
    finally
      LeaveSection(Guard);
    end;
end;

class function TNonReentrantHelper.Execute<A>(var Guard: Boolean; const Proc: TProc<A>; const Arg: A): Boolean;
begin
  Result := False;
  if EnterSection(Guard) then
    try
      Proc(Arg);
      Result := True;
    finally
      LeaveSection(Guard);
    end;
end;

class function TNonReentrantHelper.Execute<R>(var Guard: Boolean; const Func: TFunc<R>; const Default: R): R;
begin
  Result := Default;
  if EnterSection(Guard) then
    try
      Result := Func;
    finally
      LeaveSection(Guard);
    end;
end;

class function TNonReentrantHelper.Execute<A, R>(var Guard: Boolean; const Func: TFunc<A, R>; const Arg: A;
  const Default: R): R;
begin
  Result := Default;
  if EnterSection(Guard) then
    try
      Result := Func(Arg);
    finally
      LeaveSection(Guard)
    end;
end;

class function TNonReentrantHelper.EnterSection(var Guard: Boolean): Boolean;
begin
  Result := not Guard;
  if Result then
    Guard := True;
end;

class procedure TNonReentrantHelper.LeaveSection(var Guard: Boolean);
begin
  Guard := False;
end;

function Luminance(const AColor: TAlphaColor): Single;
var
  Red: Single;
  Green: Single;
  Blue: Single;
begin
  Red := TAlphaColorRec(AColor).R / 255;
  Green := TAlphaColorRec(AColor).G / 255;
  Blue := TAlphaColorRec(AColor).B / 255;
  Result := 0.2126 * Red + 0.7152 * Green + 0.0722 * Blue;
end;

procedure FillAlphaColor(const Dest: PAlphaColorArray; const Count: Integer; const Value: TAlphaColor);
var
  I: Integer;
begin
  if Value = 0 then
    FillChar(Dest^, Count * SizeOf(TAlphaColor), 0)
  else if Value = $FFFFFFFF then
    FillChar(Dest^, Count * SizeOf(TAlphaColor), $FF)
  else
    for I := 0 to Count - 1 do
      Dest[I] := Value;
end;

procedure FillAlphaColorRect(const Dest: PAlphaColorArray; Width, Height, X1, Y1, X2, Y2: Integer;
  const Value: TAlphaColor);
var
  J: Integer;
begin
  if X2 > Width then
    X2 := Width;
  if Y2 > Height then
    Y2 := Height;
  if X1 > X2 then
    X1 := X2;
  if Y1 > Y2 then
    Y1 := Y2;
  for J := Y1 to Y2 - 1 do
  begin
    if Value = 0 then
      FillChar(Dest[X1 + (J * Width)], (X2 - X1) * SizeOf(TAlphaColor), 0)
    else if Value = $FFFFFFFF then
      FillChar(Dest[X1 + (J * Width)], (X2 - X1) * SizeOf(TAlphaColor), $FF)
    else
      FillAlphaColor(@Dest[X1 + (J * Width)], X2 - X1, Value);
  end;
end;

procedure FillAlpha(const Dest: PAlphaColorRecArray; const Count: Integer; const Alpha: Byte);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Dest[I].A := Alpha;
end;

procedure ReverseBytes(const Dest: Pointer; const Count: Integer);
var
  P1: PByte;
  P2: PByte;
  C: Byte;
begin
  P1 := PByte(Dest);
  P2 := PByte(Dest) + Count - 1;
  while P1 < P2 do
  begin
    C := P1^;
    P1^ := P2^;
    P2^ := C;
    Inc(P1);
    Dec(P2);
  end;
end;

{$EXCESSPRECISION OFF}

function RectToString(const R: TRectF): string;
begin
  Result := '(' + FloatToStr(R.Left, USFormatSettings) + ',' + FloatToStr(R.Top, USFormatSettings) + ',' +
    FloatToStr(R.Right, USFormatSettings) + ',' + FloatToStr(R.Bottom, USFormatSettings) + ')';
end;

function StringToRect(S: string): TRectF;
begin
  try
    GetToken(S, ',()');
    Result.Left := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Top := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Right := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Bottom := StrToFloat(GetToken(S, ',()'), USFormatSettings);
  except
    Result := TRectF.Empty;
  end;
end;

function PointToString(const P: TPointF): string;
begin
  Result := '(' + FloatToStr(P.X, USFormatSettings) + ',' + FloatToStr(P.Y, USFormatSettings) + ')';
end;

function StringToPoint(S: string): TPointF;
begin
  try
    GetToken(S, ',()');
    Result.X := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Y := StrToFloat(GetToken(S, ',()'), USFormatSettings);
  except
    Result := TPointF.Zero;
  end;
end;

function InterpolateSingle(const Start, Stop, T: Single): Single;
begin
  Result := Start + (Stop - Start) * T;
end;

function InterpolateRotation(const Start, Stop, T: Single): Single;
begin
  Result := InterpolateSingle(Start, Stop, T);
end;

function InterpolateColor(const Start, Stop: TAlphaColor; T: Single): TAlphaColor;
begin
  TAlphaColorRec(Result).A := TAlphaColorRec(Start).A + Trunc((TAlphaColorRec(Stop).A - TAlphaColorRec(Start).A) * T);
  TAlphaColorRec(Result).R := TAlphaColorRec(Start).R + Trunc((TAlphaColorRec(Stop).R - TAlphaColorRec(Start).R) * T);
  TAlphaColorRec(Result).G := TAlphaColorRec(Start).G + Trunc((TAlphaColorRec(Stop).G - TAlphaColorRec(Start).G) * T);
  TAlphaColorRec(Result).B := TAlphaColorRec(Start).B + Trunc((TAlphaColorRec(Stop).B - TAlphaColorRec(Start).B) * T);
end;

{$EXCESSPRECISION ON}

function GetToken(var S: string; const Separators: string; const Stop: string = string.Empty): string;
var
  I: Integer;
  Breaks: string;
begin
  Breaks := Separators + Stop;
  for I := 0 to S.Length - 1 do
    if Breaks.Contains(S.Chars[I]) then
      Break;

  Result := S.Substring(0, I);
  S := S.Substring(I + 1);
end;


function GetToken(var Pos: Integer; const S: string; const Separators: string; const Stop: string = string.Empty): string;
var
  Len: Integer;
begin
  Result := string.Empty;
  Len := S.Length;
  { skip first separators }
  while Pos <= Len do
  begin
    if not Separators.Contains(S.Chars[Pos]) then
      Break;
    Inc(Pos);
  end;
  { get }
  while Pos <= Len do
  begin
    if Stop.Contains(S.Chars[Pos]) then
      Break;
    if Separators.Contains(S.Chars[Pos]) then
      Break;
    Result := Result + S.Chars[Pos];
    Inc(Pos);
  end;
  { skip separators }
  while Pos <= Len do
  begin
    if not Separators.Contains(S.Chars[Pos]) then
      Break;
    Inc(Pos);
  end;
end;

function Point3DToString(const P: TPoint3D): string;
begin
  Result := '(' + FloatToStr(P.X, USFormatSettings) + ',' + FloatToStr(P.Y, USFormatSettings) + ',' +
    FloatToStr(P.Z, USFormatSettings) + ')';
end;

function StringToPoint3D(S: string): TPoint3D;
begin
  try
    GetToken(S, ',()');
    Result.X := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Y := StrToFloat(GetToken(S, ',()'), USFormatSettings);
    Result.Z := StrToFloat(GetToken(S, ',()'), USFormatSettings);
  except
    Result := TPoint3D.Zero;
  end;
end;

function ColorToVector3D(const AColor: TAlphaColor): TVector3D;
begin
  Result.X := TAlphaColorRec(AColor).R / $FF;
  Result.Y := TAlphaColorRec(AColor).G / $FF;
  Result.Z := TAlphaColorRec(AColor).B / $FF;
  Result.W := TAlphaColorRec(AColor).A / $FF;
end;

function Vector3DToColor(const AColor: TVector3D): TAlphaColor;
begin
  Result := MakeColor(Trunc(AColor.X * $FF), Trunc(AColor.Y * $FF), Trunc(AColor.Z * $FF), Trunc(AColor.W * $FF));
end;

function IsPointInCircle(const APoint, ACenter: TPointF; const ARadius: Integer): Boolean;
begin
  if ARadius > 0 then
    Result := Sqr((APoint.X - ACenter.X) / ARadius) + Sqr((APoint.Y - ACenter.Y) / ARadius) <= 1
  else
    Result := False;
end;

function CheckPoint(const APoint, ASource: TPointF; const ADeviation, ErrorMargin: Integer): Double;
var
  LDistance: Double;
  LErrorMarginDistance: Double;
  LRelativeError, LMinErrorMargin: Double;
  LDeviation: Integer;
begin
  LDeviation := ADeviation;
  LDistance := APoint.Distance(ASource);
  LErrorMarginDistance := LDeviation * ErrorMargin / 100;

  if LDistance <= LErrorMarginDistance then
    Result := 100
  else if LDistance > LDeviation then
    Result := 0
  else
  begin
    LRelativeError := (100 - ErrorMargin) / (LErrorMarginDistance - LDeviation);
    LMinErrorMargin := ErrorMargin - (LRelativeError * LDeviation);
    Result := LRelativeError * LDistance + LMinErrorMargin;
  end;
end;

procedure ValidateInheritance(const AValue: TPersistent; const AClass: TClass; const CanBeNil: Boolean = True);
begin
  if (AClass <> nil) and (CanBeNil or (AValue <> nil)) then
  begin
    if (AValue <> nil) and not AValue.InheritsFrom(AClass) then
      raise EArgumentException.CreateFMT(SEUseHeirs, [AClass.ClassName])at ReturnAddress;
  end
  else
    raise EArgumentNilException.Create(SArgumentNil)at ReturnAddress;
end;

function GetShortHint(const Hint: string): string;
var
  I: Integer;
begin
  I := AnsiPos('|', Hint);
  if I = 0 then
    Result := Hint
  else
    Result := Copy(Hint, 1, I - 1);
end;

function GetLongHint(const Hint: string): string;
var
  I: Integer;
begin
  I := AnsiPos('|', Hint);
  if I = 0 then
    Result := Hint
  else
    Result := Copy(Hint, I + 1, Maxint);
end;

initialization
  USFormatSettings := TFormatSettings.Invariant;

end.
