{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{ Copyright and license exceptions noted in source      }
{                                                       }
{*******************************************************}

unit System.Math;

{ This unit contains high-performance arithmetic, trigonometric, logarithmic,
  statistical, financial calculation and FPU routines which supplement the math
  routines that are part of the Delphi language or System unit.

  References:
  1) P.J. Plauger, "The Standard C Library", Prentice-Hall, 1992, Ch. 7.
  2) W.J. Cody, Jr., and W. Waite, "Software Manual For the Elementary
     Functions", Prentice-Hall, 1980.
  3) Namir Shammas, "C/C++ Mathematical Algorithms for Scientists and Engineers",
     McGraw-Hill, 1995, Ch 8.
  4) H.T. Lau, "A Numerical Library in C for Scientists and Engineers",
     CRC Press, 1994, Ch. 6.
  5) "Pentium(tm) Processor User's Manual, Volume 3: Architecture
     and Programming Manual", Intel, 1994

  Some of the functions, concepts or constants in this unit were provided by
  Earl F. Glynn (www.efg2.com) and Ray Lischner (www.tempest-sw.com)

  All angle parameters and results of trig functions are in radians.

  Most of the following trig and log routines map directly to Intel 80387 FPU
  floating point machine instructions.  Input domains, output ranges, and
  error handling are determined largely by the FPU hardware.

  Routines coded in x86 basm favor the Pentium FPU pipeline architecture.
}

{$N+,S-}

{$IF Defined(CPUX86) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
  {$DEFINE X86ASM}
{$ELSE}
  {$IF Defined(CPUX64) and Defined(ASSEMBLER) and not Defined(PUREPASCAL)}
    {$DEFINE X64ASM}
  {$ENDIF}
  {$DEFINE PUREPASCAL}
{$ENDIF}

{$IF SizeOf(Extended) >= 10} // 10,12,16
  {$DEFINE EXTENDEDHAS10BYTES}
{$ENDIF}
{$IF SizeOf(Extended) = 16}
  {$DEFINE EXTENDEDIS16BYTES}
{$ELSEIF SizeOf(Extended) = 12}
  {$DEFINE EXTENDEDIS12BYTES}
{$ELSEIF SizeOf(Extended) = 10}
  {$DEFINE EXTENDEDIS10BYTES}
{$ELSEIF SizeOf(Extended) = 8}
  {$DEFINE EXTENDEDIS8BYTES}
{$ELSE}
  {$MESSAGE ERROR 'Unknown condition'}
{$ENDIF}

{$IFDEF IOS}
  {$DEFINE IOS_FIXME}
{$ENDIF IOS}

{$EXCESSPRECISION OFF}

interface
{$HPPEMIT LEGACYHPP}

uses System.SysUtils, System.Types;

{ To handle 'Conversion may lose significant digits' on default parameters }
(*$HPPEMIT '#pragma option -w-8071'*)


const   { Ranges of the IEEE floating point types, including denormals }

(*$HPPEMIT OPENNAMESPACE*)

  MinSingle   =  1.4012984643248170709e-45;
  (*$EXTERNALSYM MinSingle*)
  MaxSingle   =  340282346638528859811704183484516925440.0;
  (*$EXTERNALSYM MaxSingle*)
  MinDouble   =  4.9406564584124654418e-324;
  (*$EXTERNALSYM MinDouble*)
  MaxDouble   =  1.7976931348623157081e+308;
  (*$EXTERNALSYM MaxDouble*)
{$IFDEF EXTENDEDHAS10BYTES}
  MinExtended =  3.64519953188247460253e-4951;
  (*$EXTERNALSYM MinExtended*)
  MaxExtended =  1.18973149535723176505e+4932;
  (*$EXTERNALSYM MaxExtended*)
{$ELSE !EXTENDEDHAS10BYTES}
  MinExtended =  MinDouble;
  (*$EXTERNALSYM MinExtended*)
  MaxExtended =  MaxDouble;
  (*$EXTERNALSYM MaxExtended*)
{$ENDIF !EXTENDEDHAS10BYTES}
  MinComp     = -9223372036854775807;
  (*$EXTERNALSYM MinComp*)
  (*$HPPEMIT 'extern const System::Extended MinComp /*= -9223372036854775807*/;'*)
  MaxComp     =  9223372036854775807;
  (*$EXTERNALSYM MaxComp*)
  (*$HPPEMIT 'extern const System::Extended MaxComp /*= 9223372036854775807*/;'*)

  { The following constants should not be used for comparison, only
    assignments. For comparison please use the IsNan and IsInfinity functions
    provided below. }
  NaN         =  0.0 / 0.0;
  (*$EXTERNALSYM NaN*)
  (*$HPPEMIT 'extern const System::Extended NaN /*= 0.0 / 0.0*/;'*)
  Infinity    =  1.0 / 0.0;
  (*$EXTERNALSYM Infinity*)
  (*$HPPEMIT 'extern const System::Extended Infinity /*= 1.0 / 0.0*/;'*)
  NegInfinity = -1.0 / 0.0;
  (*$EXTERNALSYM NegInfinity*)
  (*$HPPEMIT 'extern const System::Extended NegInfinity /*= -1.0 / 0.0*/;'*)

(*$HPPEMIT CLOSENAMESPACE*)

{ Trigonometric functions }
{ IN: |X| <= 1  OUT: [0..PI] radians }
function ArcCos(const X : Extended) : Extended; overload;
function ArcCos(const X : Double) : Double; overload;
function ArcCos(const X : Single) : Single; overload;
{ IN: |X| <= 1  OUT: [-PI/2..PI/2] radians }
function ArcSin(const X : Extended) : Extended; overload;
function ArcSin(const X : Double) : Double; overload;
function ArcSin(const X : Single) : Single; overload;

{ ArcTan2 calculates ArcTan(Y/X), and returns an angle in the correct quadrant.
  IN: |Y| < 2^64, |X| < 2^64, X <> 0   OUT: [-PI..PI] radians }
function ArcTan2(const Y, X: Extended): Extended; overload;
function ArcTan2(const Y, X: Double): Double; overload;
function ArcTan2(const Y, X: Single): Single; overload;

{ SinCos is 2x faster than calling Sin and Cos separately for the same angle }
procedure SinCos(const Theta: Single; var Sin, Cos: Single); overload;
procedure SinCos(const Theta: Double; var Sin, Cos: Double); overload;
procedure SinCos(const Theta: Extended; var Sin, Cos: Extended); overload;
function Tan(const X: Single): Single; overload;
function Tan(const X: Double): Double; overload;
function Tan(const X: Extended): Extended; overload;
function Cotan(const X: Single): Single; overload;        { 1 / tan(X), X <> 0 }
function Cotan(const X: Double): Double; overload;
function Cotan(const X: Extended): Extended; overload;
function Secant(const X: Single): Single; overload;       { 1 / cos(X) }
function Secant(const X: Double): Double; overload;
function Secant(const X: Extended): Extended; overload;
function Cosecant(const X: Single): Single; overload;     { 1 / sin(X) }
function Cosecant(const X: Double): Double; overload;
function Cosecant(const X: Extended): Extended; overload;
function Hypot(const X, Y: Single): Single; overload;
function Hypot(const X, Y: Double): Double; overload;
function Hypot(const X, Y: Extended): Extended; overload; { Sqrt(X**2 + Y**2) }

{ Angle unit conversion routines }
function RadToDeg(const Radians: Single): Single; inline; overload;       { Degrees := Radians * 180 / PI }
function RadToDeg(const Radians: Double): Double; inline; overload;
function RadToDeg(const Radians: Extended): Extended; inline; overload;
function RadToGrad(const Radians: Single): Single; inline; overload;      { Grads := Radians * 200 / PI }
function RadToGrad(const Radians: Double): Double; inline; overload;
function RadToGrad(const Radians: Extended): Extended; inline; overload;
function RadToCycle(const Radians: Single): Single; inline; overload;     { Cycles := Radians / 2PI }
function RadToCycle(const Radians: Double): Double; inline; overload;
function RadToCycle(const Radians: Extended): Extended; inline; overload;

function DegToRad(const Degrees: Single): Single; inline; overload;       { Radians := Degrees * PI / 180}
function DegToRad(const Degrees: Double): Double; inline; overload;
function DegToRad(const Degrees: Extended): Extended; inline; overload;
function DegToGrad(const Degrees: Single): Single; overload;
function DegToGrad(const Degrees: Double): Double; overload;
function DegToGrad(const Degrees: Extended): Extended; overload;
function DegToCycle(const Degrees: Single): Single; overload;
function DegToCycle(const Degrees: Double): Double; overload;
function DegToCycle(const Degrees: Extended): Extended; overload;

{ When angle not between -180 and 180 remove left }
function DegNormalize(const Degrees: Single): Single; inline; overload;
function DegNormalize(const Degrees: Double): Double; inline; overload;
function DegNormalize(const Degrees: Extended): Extended; inline; overload;

function GradToRad(const Grads: Single): Single; inline; overload;        { Radians := Grads * PI / 200 }
function GradToRad(const Grads: Double): Double; inline; overload;
function GradToRad(const Grads: Extended): Extended; inline; overload;
function GradToDeg(const Grads: Single): Single; overload;
function GradToDeg(const Grads: Double): Double; overload;
function GradToDeg(const Grads: Extended): Extended; overload;
function GradToCycle(const Grads: Single): Single; overload;
function GradToCycle(const Grads: Double): Double; overload;
function GradToCycle(const Grads: Extended): Extended; overload;

function CycleToRad(const Cycles: Single): Single; inline; overload;      { Radians := Cycles * 2PI }
function CycleToRad(const Cycles: Double): Double; inline; overload;
function CycleToRad(const Cycles: Extended): Extended; inline; overload;
function CycleToDeg(const Cycles: Single): Single; overload;
function CycleToDeg(const Cycles: Double): Double; overload;
function CycleToDeg(const Cycles: Extended): Extended; overload;
function CycleToGrad(const Cycles: Single): Single; overload;
function CycleToGrad(const Cycles: Double): Double; overload;
function CycleToGrad(const Cycles: Extended): Extended; overload;

{ Hyperbolic functions and inverses }
function Cot(const X: Single): Single; inline; overload;     { alias for Cotan }
function Cot(const X: Double): Double; inline; overload;
function Cot(const X: Extended): Extended; inline; overload;
function Sec(const X: Single): Single; inline; overload;     { alias for Secant }
function Sec(const X: Double): Double; inline; overload;
function Sec(const X: Extended): Extended; inline; overload;
function Csc(const X: Single): Single; inline; overload;     { alias for Cosecant }
function Csc(const X: Double): Double; inline; overload;
function Csc(const X: Extended): Extended; inline; overload;
function Cosh(const X: Single): Single; overload;
function Cosh(const X: Double): Double; overload;
function Cosh(const X: Extended): Extended; overload;
function Sinh(const X: Single): Single; overload;
function Sinh(const X: Double): Double; overload;
function Sinh(const X: Extended): Extended; overload;
function Tanh(const X: Single): Single; overload;
function Tanh(const X: Double): Double; overload;
function Tanh(const X: Extended): Extended; overload;
function CotH(const X: Single): Single; inline; overload;
function CotH(const X: Double): Double; inline; overload;
function CotH(const X: Extended): Extended; inline; overload;
function SecH(const X: Single): Single; inline; overload;
function SecH(const X: Double): Double; inline; overload;
function SecH(const X: Extended): Extended; inline; overload;
function CscH(const X: Single): Single; inline; overload;
function CscH(const X: Double): Double; inline; overload;
function CscH(const X: Extended): Extended; inline; overload;
function ArcCot(const X: Single): Single; overload;          { IN: X <> 0 }
function ArcCot(const X: Double): Double; overload;
function ArcCot(const X: Extended): Extended; overload;
function ArcSec(const X: Single): Single; overload;          { IN: X <> 0 }
function ArcSec(const X: Double): Double; overload;
function ArcSec(const X: Extended): Extended; overload;
function ArcCsc(const X: Single): Single; overload;          { IN: X <> 0 }
function ArcCsc(const X: Double): Double; overload;
function ArcCsc(const X: Extended): Extended; overload;
function ArcCosh(const X: Single): Single; overload;         { IN: X >= 1 }
function ArcCosh(const X: Double): Double; overload;
function ArcCosh(const X: Extended): Extended; overload;
function ArcSinh(const X: Single): Single; overload;
function ArcSinh(const X: Double): Double; overload;
function ArcSinh(const X: Extended): Extended; overload;
function ArcTanh(const X: Single): Single; overload;         { IN: |X| <= 1 }
function ArcTanh(const X: Double): Double; overload;
function ArcTanh(const X: Extended): Extended; overload;
function ArcCotH(const X: Single): Single; overload;         { IN: X <> 0 }
function ArcCotH(const X: Double): Double; overload;
function ArcCotH(const X: Extended): Extended; overload;
function ArcSecH(const X: Single): Single; overload;         { IN: X <> 0 }
function ArcSecH(const X: Double): Double; overload;
function ArcSecH(const X: Extended): Extended; overload;
function ArcCscH(const X: Single): Single; overload;         { IN: X <> 0 }
function ArcCscH(const X: Double): Double; overload;
function ArcCscH(const X: Extended): Extended; overload;

{ Logarithmic functions }
function LnXP1(const X: Single): Single; overload; { Ln(X + 1), accurate for X near zero }
function LnXP1(const X: Double): Double; overload;
function LnXP1(const X: Extended): Extended; overload;
function Log10(const X: Single): Single; overload;               { Log base 10 of X }
function Log10(const X: Double): Double; overload;
function Log10(const X: Extended): Extended; overload;
function Log2(const X: Single): Single; overload;                { Log base 2 of X }
function Log2(const X: Double): Double; overload;
function Log2(const X: Extended): Extended; overload;
function LogN(const Base, X: Single): Single; overload;          { Log base N of X }
function LogN(const Base, X: Double): Double; overload;
function LogN(const Base, X: Extended): Extended; overload;

{ Exponential functions }

{ IntPower: Raise base to an integral power.  Fast. }
function IntPower(const Base: Single; const Exponent: Integer): Single; overload;
function IntPower(const Base: Double; const Exponent: Integer): Double; overload;
function IntPower(const Base: Extended; const Exponent: Integer): Extended; overload;

{ Power: Raise base to any power.
  For fractional exponents, or |exponents| > MaxInt, base must be > 0. }
function Power(const Base, Exponent: Extended): Extended; overload;
function Power(const Base, Exponent: Double): Double; overload;
function Power(const Base, Exponent: Single): Single; overload;

{ Miscellaneous Routines }

{ Frexp:  Separates the mantissa and exponent of X. }
procedure Frexp(const X: Single; var Mantissa: Single; var Exponent: Integer); overload;
procedure Frexp(const X: Double; var Mantissa: Double; var Exponent: Integer); overload;
procedure Frexp(const X: Extended; var Mantissa: Extended; var Exponent: Integer); overload;

{ Ldexp: returns X*2**P }
function Ldexp(const X: Single; const P: Integer): Single; overload;
function Ldexp(const X: Double; const P: Integer): Double; overload;
function Ldexp(const X: Extended; const P: Integer): Extended; overload;

{ Ceil: Smallest integer >= X, |X| < MaxInt }
function Ceil(const X: Single): Integer; overload;
function Ceil(const X: Double): Integer; overload;
function Ceil(const X: Extended): Integer; overload;

{ Floor: Largest integer <= X,  |X| < MaxInt }
function Floor(const X: Single): Integer; overload;
function Floor(const X: Double): Integer; overload;
function Floor(const X: Extended): Integer; overload;

{ Poly: Evaluates a uniform polynomial of one variable at value X.
    The coefficients are ordered in increasing powers of X:
    Coefficients[0] + Coefficients[1]*X + ... + Coefficients[N]*(X**N) }
function Poly(const X: Single; const Coefficients: array of Single): Single; overload;
function Poly(const X: Double; const Coefficients: array of Double): Double; overload;
function Poly(const X: Extended; const Coefficients: array of Extended): Extended; overload;

{-----------------------------------------------------------------------
Statistical functions.

Common commercial spreadsheet macro names for these statistical and
financial functions are given in the comments preceding each function.
-----------------------------------------------------------------------}

{ Mean:  Arithmetic average of values.  (AVG):  SUM / N }
function Mean(const Data: array of Single): Single; overload;
function Mean(const Data: array of Double): Double; overload;
function Mean(const Data: array of Extended): Extended; overload;

{ Sum: Sum of values.  (SUM) }
function Sum(const Data: array of Single): Single; overload;
function Sum(const Data: array of Double): Double; overload;
function Sum(const Data: array of Extended): Extended; overload;
function SumInt(const Data: array of Integer): Integer;
function SumOfSquares(const Data: array of Single): Single; overload;
function SumOfSquares(const Data: array of Double): Double; overload;
function SumOfSquares(const Data: array of Extended): Extended; overload;
procedure SumsAndSquares(const Data: array of Single;
  var Sum, SumOfSquares: Extended); overload;
procedure SumsAndSquares(const Data: array of Double;
  var Sum, SumOfSquares: Extended); overload;
procedure SumsAndSquares(const Data: array of Extended;
  var Sum, SumOfSquares: Extended); overload;

{ MinValue: Returns the smallest signed value in the data array (MIN) }
function MinValue(const Data: array of Single): Single; overload;
function MinValue(const Data: array of Double): Double; overload;
function MinValue(const Data: array of Extended): Extended; overload;
function MinIntValue(const Data: array of Integer): Integer;

function Min(const A, B: Integer): Integer; overload; inline;
function Min(const A, B: Int64): Int64; overload; inline;
function Min(const A, B: UInt64): UInt64; overload; inline;
function Min(const A, B: Single): Single; overload; inline;
function Min(const A, B: Double): Double; overload; inline;
function Min(const A, B: Extended): Extended; overload; inline;

{ MaxValue: Returns the largest signed value in the data array (MAX) }
function MaxValue(const Data: array of Single): Single; overload;
function MaxValue(const Data: array of Double): Double; overload;
function MaxValue(const Data: array of Extended): Extended; overload;
function MaxIntValue(const Data: array of Integer): Integer;

function Max(const A, B: Integer): Integer; overload; inline;
function Max(const A, B: Int64): Int64; overload; inline;
function Max(const A, B: UInt64): UInt64; overload; inline;
function Max(const A, B: Single): Single; overload; inline;
function Max(const A, B: Double): Double; overload; inline;
function Max(const A, B: Extended): Extended; overload; inline;

{ Standard Deviation (STD): Sqrt(Variance). aka Sample Standard Deviation }
function StdDev(const Data: array of Single): Single; overload;
function StdDev(const Data: array of Double): Double; overload;
function StdDev(const Data: array of Extended): Extended; overload;

{ MeanAndStdDev calculates Mean and StdDev in one call. }
procedure MeanAndStdDev(const Data: array of Single; var Mean, StdDev: Single); overload;
procedure MeanAndStdDev(const Data: array of Double; var Mean, StdDev: Double); overload;
procedure MeanAndStdDev(const Data: array of Extended; var Mean, StdDev: Extended); overload;

{ Population Standard Deviation (STDP): Sqrt(PopnVariance).
  Used in some business and financial calculations. }
function PopnStdDev(const Data: array of Single): Single; overload;
function PopnStdDev(const Data: array of Double): Double; overload;
function PopnStdDev(const Data: array of Extended): Extended; overload;

{ Variance (VARS): TotalVariance / (N-1). aka Sample Variance }
function Variance(const Data: array of Single): Single; overload;
function Variance(const Data: array of Double): Double; overload;
function Variance(const Data: array of Extended): Extended; overload;

{ Population Variance (VAR or VARP): TotalVariance/ N }
function PopnVariance(const Data: array of Single): Single; overload;
function PopnVariance(const Data: array of Double): Double; overload;
function PopnVariance(const Data: array of Extended): Extended; overload;

{ Total Variance: SUM(i=1,N)[(X(i) - Mean)**2] }
function TotalVariance(const Data: array of Single): Single; overload;
function TotalVariance(const Data: array of Double): Double; overload;
function TotalVariance(const Data: array of Extended): Extended; overload;

{ Norm:  The Euclidean L2-norm.  Sqrt(SumOfSquares) }
function Norm(const Data: array of Single): Single; overload;
function Norm(const Data: array of Double): Double; overload;
function Norm(const Data: array of Extended): Extended; overload;

{ MomentSkewKurtosis: Calculates the core factors of statistical analysis:
  the first four moments plus the coefficients of skewness and kurtosis.
  M1 is the Mean.  M2 is the Variance.
  Skew reflects symmetry of distribution: M3 / (M2**(3/2))
  Kurtosis reflects flatness of distribution: M4 / Sqr(M2) }
procedure MomentSkewKurtosis(const Data: array of Double;
  var M1, M2, M3, M4, Skew, Kurtosis: Extended);

{ RandG produces random numbers with Gaussian distribution about the mean.
  Useful for simulating data with sampling errors. }
function RandG(Mean, StdDev: Single): Single; overload;
function RandG(Mean, StdDev: Double): Double; overload;
function RandG(Mean, StdDev: Extended): Extended; overload;

{-----------------------------------------------------------------------
General/Misc use functions
-----------------------------------------------------------------------}

{ Extreme testing }

// Like an infinity, a NaN double value has an exponent of 7FF, but the NaN
// values have a fraction field that is not 0.
function IsNan(const AValue: Single): Boolean; overload;
function IsNan(const AValue: Double): Boolean; overload;
function IsNan(const AValue: Extended): Boolean; overload;

// Like a NaN, an infinity double value has an exponent of 7FF, but the
// infinity values have a fraction field of 0. Infinity values can be positive
// or negative, which is specified in the high-order, sign bit.
function IsInfinite(const AValue: Single): Boolean; overload;
function IsInfinite(const AValue: Double): Boolean; overload;
function IsInfinite(const AValue: Extended): Boolean; overload;

{ Simple sign testing }

type
  TValueSign = -1..1;

const
  NegativeValue = Low(TValueSign);
  ZeroValue = 0;
  PositiveValue = High(TValueSign);

function Sign(const AValue: Integer): TValueSign; overload;
function Sign(const AValue: Int64): TValueSign; overload;
function Sign(const AValue: Single): TValueSign; overload;
function Sign(const AValue: Double): TValueSign; overload;
function Sign(const AValue: Extended): TValueSign; overload;

{ CompareFloat & SameFloat: If epsilon is not given (or is zero) we will
  attempt to compute a reasonable one based on the precision of the floating
  point type used. }

function CompareValue(const A, B: Extended; Epsilon: Extended = 0): TValueRelationship; overload;
function CompareValue(const A, B: Double; Epsilon: Double = 0): TValueRelationship; overload;
function CompareValue(const A, B: Single; Epsilon: Single = 0): TValueRelationship; overload;
function CompareValue(const A, B: Integer): TValueRelationship; overload;
function CompareValue(const A, B: Int64): TValueRelationship; overload;
function CompareValue(const A, B: UInt64): TValueRelationship; overload;

function SameValue(const A, B: Extended; Epsilon: Extended = 0): Boolean; overload;
function SameValue(const A, B: Double; Epsilon: Double = 0): Boolean; overload;
function SameValue(const A, B: Single; Epsilon: Single = 0): Boolean; overload;

{ IsZero: These will return true if the given value is zero (or very very very
  close to it). }

function IsZero(const A: Extended; Epsilon: Extended = 0): Boolean; overload;
function IsZero(const A: Double; Epsilon: Double = 0): Boolean; overload;
function IsZero(const A: Single; Epsilon: Single = 0): Boolean; overload;

{ Easy to use conditional functions }

function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer = 0): Integer; overload; inline;
function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64 = 0): Int64; overload; inline;
function IfThen(AValue: Boolean; const ATrue: UInt64; const AFalse: UInt64 = 0): UInt64; overload; inline;
function IfThen(AValue: Boolean; const ATrue: Single; const AFalse: Single = 0.0): Single; overload; inline;
function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double = 0.0): Double; overload; inline;
function IfThen(AValue: Boolean; const ATrue: Extended; const AFalse: Extended = 0.0): Extended; overload; inline;

/// <summary>FMod returns the remainder of ANumerator / ADenominator (like mod in integers) with the same sign as ANumerator.</summary>
function FMod(const ANumerator, ADenominator: Single): Single; overload;
function FMod(const ANumerator, ADenominator: Double): Double; overload;
function FMod(const ANumerator, ADenominator: Extended): Extended; overload;

{ Various random functions }

function RandomRange(const AFrom, ATo: Integer): Integer;
function RandomFrom(const AValues: array of Integer): Integer; overload;
function RandomFrom(const AValues: array of Int64): Int64; overload;
function RandomFrom(const AValues: array of UInt64): UInt64; overload;
function RandomFrom(const AValues: array of Single): Single; overload;
function RandomFrom(const AValues: array of Double): Double; overload;
function RandomFrom(const AValues: array of Extended): Extended; overload;

{ Range testing functions }

function InRange(const AValue, AMin, AMax: Integer): Boolean; overload; inline;
function InRange(const AValue, AMin, AMax: Int64): Boolean; overload; inline;
function InRange(const AValue, AMin, AMax: UInt64): Boolean; overload; inline;
function InRange(const AValue, AMin, AMax: Single): Boolean; overload; inline;
function InRange(const AValue, AMin, AMax: Double): Boolean; overload; inline;
function InRange(const AValue, AMin, AMax: Extended): Boolean; overload; inline;

{ Range truncation functions }

function EnsureRange(const AValue, AMin, AMax: Integer): Integer; overload;
function EnsureRange(const AValue, AMin, AMax: Int64): Int64; overload;
function EnsureRange(const AValue, AMin, AMax: UInt64): UInt64; overload;
function EnsureRange(const AValue, AMin, AMax: Single): Single; overload;
function EnsureRange(const AValue, AMin, AMax: Double): Double; overload;
function EnsureRange(const AValue, AMin, AMax: Extended): Extended; overload;

{ 16 bit unsigned integer division and remainder in one operation }

procedure DivMod(Dividend: Cardinal; Divisor: Word;
  var Result, Remainder: Word); overload;

{ 64 bit unsigned integer division and remainder in one operation }

procedure DivMod(Dividend: UInt64; Divisor: UInt64;
  var Result, Remainder: UInt64); overload;


{ Round to a specific digit or power of ten }
{ ADigit has a valid range of 37 to -37.  Here are some valid examples
  of ADigit values...
   3 = 10^3  = 1000   = thousand's place
   2 = 10^2  =  100   = hundred's place
   1 = 10^1  =   10   = ten's place
  -1 = 10^-1 = 1/10   = tenth's place
  -2 = 10^-2 = 1/100  = hundredth's place
  -3 = 10^-3 = 1/1000 = thousandth's place }

type
  TRoundToRange = -37..37;

type
 TRoundToEXRangeExtended = -20..20;

function RoundTo(const AValue: Extended;
                 const ADigit: TRoundToEXRangeExtended): Extended;

{ This variation of the RoundTo function follows the symmetric arithmetic
  rounding algorithm (if Frac(X) < .5 then return X else return X + 1 if X > 0 and
  X - 1 if X < 0). This function defaults to rounding to the hundredth's place (cents).
  Note: FPU rounding modes affect the behavior of this function. }

function SimpleRoundTo(const AValue: Single; const ADigit: TRoundToRange = -2): Single; overload;
function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double; overload;
function SimpleRoundTo(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended; overload;

{-----------------------------------------------------------------------
Financial functions.  Standard set from Quattro Pro.

Parameter conventions:

From the point of view of A, amounts received by A are positive and
amounts disbursed by A are negative (e.g. a borrower's loan repayments
are regarded by the borrower as negative).

Interest rates are per payment period.  11% annual percentage rate on a
loan with 12 payments per year would be (11 / 100) / 12 = 0.00916667

-----------------------------------------------------------------------}

type
  TPaymentTime = (ptEndOfPeriod, ptStartOfPeriod);

{ Double Declining Balance (DDB) }
function DoubleDecliningBalance(const Cost, Salvage: Extended;
  Life, Period: Integer): Extended;

{ Future Value (FVAL) }
function FutureValue(const Rate: Extended; NPeriods: Integer; const Payment,
  PresentValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Interest Payment (IPAYMT)  }
function InterestPayment(const Rate: Extended; Period, NPeriods: Integer;
  const PresentValue, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Interest Rate (IRATE) }
function InterestRate(NPeriods: Integer; const Payment, PresentValue,
  FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Internal Rate of Return. (IRR) Needs array of cash flows. }
function InternalRateOfReturn(const Guess: Extended;
  const CashFlows: array of Double): Extended;

{ Number of Periods (NPER) }
function NumberOfPeriods(const Rate: Extended; Payment: Extended;
  const PresentValue, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Net Present Value. (NPV) Needs array of cash flows. }
function NetPresentValue(const Rate: Extended; const CashFlows: array of Double;
  PaymentTime: TPaymentTime): Extended;

{ Payment (PAYMT) }
function Payment(Rate: Extended; NPeriods: Integer; const PresentValue,
  FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Period Payment (PPAYMT) }
function PeriodPayment(const Rate: Extended; Period, NPeriods: Integer;
  const PresentValue, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Present Value (PVAL) }
function PresentValue(const Rate: Extended; NPeriods: Integer;
  const Payment, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ Straight Line depreciation (SLN) }
function SLNDepreciation(const Cost, Salvage: Extended; Life: Integer): Extended;

{ Sum-of-Years-Digits depreciation (SYD) }
function SYDDepreciation(const Cost, Salvage: Extended; Life, Period: Integer): Extended;

type
  EInvalidArgument = class(EMathError) end;

{-----------------------------------------------------------------------
FPU/SSE exception/precision/rounding management

The following functions allow you to control the behavior of the FPU/SSE.
With them you can control what constutes an FPU/SSE exception, what the default
precision is used and finally how rounding is handled by the FPU/SSE.

-----------------------------------------------------------------------}

type
  TRoundingMode = (rmNearest, rmDown, rmUp, rmTruncate);
{$IFNDEF NEXTGEN}
  TFPURoundingMode = type TRoundingMode;
  TSSERoundingMode = type TRoundingMode;
{$ENDIF !NEXTGEN}

{ Return the current rounding mode }
{$IFNDEF NEXTGEN}
function GetFPURoundMode: TFPURoundingMode; platform;
function GetSSERoundMode: TSSERoundingMode; platform;
{$ENDIF !NEXTGEN}
function GetRoundMode: TRoundingMode;

{ Set the rounding mode and return the old mode }
{$IFNDEF NEXTGEN}
function SetFPURoundMode(const RoundMode: TFPURoundingMode): TFPURoundingMode; platform;
function SetSSERoundMode(const RoundMode: TSSERoundingMode): TSSERoundingMode; platform;
{$ENDIF !NEXTGEN}
function SetRoundMode(const RoundMode: TRoundingMode): TRoundingMode;

{$IFNDEF NEXTGEN}
type
  TFPUPrecisionMode = (pmSingle, pmReserved, pmDouble, pmExtended) platform;

{ Return the current precision control mode }
function GetPrecisionMode: TFPUPrecisionMode; platform;

{ Set the precision control mode and return the old one }
function SetPrecisionMode(const Precision: TFPUPrecisionMode): TFPUPrecisionMode; platform;
{$ENDIF !NEXTGEN}

type
  TArithmeticException = (exInvalidOp, exDenormalized, exZeroDivide,
                   exOverflow, exUnderflow, exPrecision);
{$IFNDEF NEXTGEN}
  TFPUException = type TArithmeticException;
  TSSEException = type TArithmeticException;
{$ENDIF !NEXTGEN}

const
   exAllArithmeticExceptions = [
     TArithmeticException.exInvalidOp,
{$IFNDEF LINUX}
     TArithmeticException.exDenormalized,
{$ENDIF LINUX}
     TArithmeticException.exZeroDivide,
     TArithmeticException.exOverflow,
     TArithmeticException.exUnderflow,
     TArithmeticException.exPrecision];

  DefaultExceptionFlags = [
      TArithmeticException.exInvalidOp,
      TArithmeticException.exZeroDivide,
      TArithmeticException.exOverflow];

type
  TArithmeticExceptions = set of TArithmeticException;
  TArithmeticExceptionMask = set of TArithmeticException;
{$IFNDEF NEXTGEN}
  TFPUExceptionMask = set of TFPUException;
  TSSEExceptionMask = set of TSSEException;
{$ENDIF !NEXTGEN}

{ Return the exception mask from the control word.
  Any element set in the mask prevents the FPU from raising that kind of
  exception.  Instead, it returns its best attempt at a value, often NaN or an
  infinity. The value depends on the operation and the current rounding mode. }
{$IFNDEF NEXTGEN}
function GetFPUExceptionMask: TFPUExceptionMask; platform;
function GetSSEExceptionMask: TSSEExceptionMask; platform;
{$ENDIF !NEXTGEN}
function GetExceptionMask: TArithmeticExceptionMask;

{ Set a new exception mask and return the old one }
{$IFNDEF NEXTGEN}
function SetFPUExceptionMask(const Mask: TFPUExceptionMask): TFPUExceptionMask; platform;
function SetSSEExceptionMask(const Mask: TSSEExceptionMask): TSSEExceptionMask; platform;
{$ENDIF !NEXTGEN}
function SetExceptionMask(const Mask: TArithmeticExceptionMask): TArithmeticExceptionMask;

{ Clear any pending exception bits in the status word }
{$IFNDEF NEXTGEN}
procedure ClearFPUExceptions(RaisePending: Boolean = True); platform;
procedure ClearSSEExceptions(RaisePending: Boolean = True); platform;
{$ENDIF !NEXTGEN}
procedure ClearExceptions(RaisePending: Boolean = True; ExceptionFlags: TArithmeticExceptions = DefaultExceptionFlags);

{ Get cumulative floating-point exception flags }
function GetExceptions: TArithmeticExceptions;

{ Set cumulative floating-point exception flags and return the old one }
function SetExceptions(const Exceptions: TArithmeticExceptions): TArithmeticExceptions;

{ Raise cumulative floating-point exceptions }
procedure RaiseExceptions(const ExceptionFlags: TArithmeticExceptions = DefaultExceptionFlags);

{$IFNDEF NEXTGEN}
{ SSE Type for System.TestSSE variable. }
const
  seSSE    = $0001;
  seSSE2   = $0002;
  seSSE3   = $0004;
  seSSSE3  = $0008;
  seSSE41  = $0010;
  seSSE42  = $0020;
  sePOPCNT = $0040;
  seAESNI  = $0080;
  sePCLMULQDQ = $0100;
{$ENDIF !NEXTGEN}

implementation

uses System.SysConst;

{$IF defined(PIC) and not defined(PUREPASCAL)}
function GetGOT: Pointer; export;
begin
  asm
        MOV     Result,EBX
  end;
end;
{$ENDIF PIC && !PUREPASCAL}

procedure RaiseOverflowError;
begin
  raise EIntOverflow.Create(SIntOverflow);
end;

procedure RaiseDivByZeroError;
begin
  raise EDivByZero.Create(SIntOverflow);
end;


procedure DivMod(Dividend: Cardinal; Divisor: Word;
  var Result, Remainder: Word);
{$IF Defined(CPUX64) and Defined(MSWINDOWS)}
asm
        MOV     R10,RBX
        MOV     EBX,EDX
        MOV     EAX,ECX
        MOV     EDX,ECX
        SHR     EDX,16
        DIV     BX
        MOV     WORD PTR[R8],AX
        MOV     WORD PTR[R9],DX
        MOV     RBX,R10
end;
{$ELSEIF Defined(CPUX86) and Defined(MSWINDOWS)}
asm // StackAlignSafe
        PUSH    EBX
        MOV     EBX,EDX
        MOV     EDX,EAX
        SHR     EDX,16
        DIV     BX
        MOV     EBX,Remainder
        MOV     [ECX],AX
        MOV     [EBX],DX
        POP     EBX
end;
{$ELSEIF Defined(PUREPASCAL) or (not Defined(MSWINDOWS))}
{$IFOPT R+}
  {$DEFINE __RANGECHECKS}
  {$RANGECHECKS OFF}
{$ENDIF}
var
  D: Cardinal;
begin
  if Divisor = 0 then
    System.Error(reDivByZero);
  D := Dividend div Divisor;
  if D > Word.Maxvalue then
    System.Error(reIntOverflow)
  else
    Result := D;
  Remainder := Dividend mod Divisor;
end;
{$IFDEF __RANGECHECKS}
  {$RANGECHECKS ON}
{$ENDIF}
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

procedure DivMod(Dividend: UInt64; Divisor: UInt64;
  var Result, Remainder: UInt64); overload;
{$IF Defined(PUREPASCAL)}
begin
  Result := Dividend div Divisor;
  Remainder := Dividend mod Divisor;
end;
{$ELSEIF Defined(CPUX64)}
asm
        MOV     R10,RDX
        MOV     RAX,RCX
        XOR     EDX,EDX
        DIV     R10
        MOV     [R8],RAX
        MOV     [R9],RDX
end;
{$ELSEIF Defined(X86ASM)}
// Merged from system __lludiv and __llumod
asm
        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        PUSH    EAX
        PUSH    EDX
//
//       Now the stack looks something like this:
//
//               40[esp]: Dividend(high dword)
//               36[esp]: Dividend(low dword)
//               32[esp]: divisor (high dword)
//               28[esp]: divisor (low dword)
//               24[esp]: return EIP
//               20[esp]: previous EBP
//               16[esp]: previous EBX
//               12[esp]: previous ESI
//                8[esp]: previous EDI
//                4[esp]: previous EAX  Result ptr
//                 [esp]: previous EDX  Remainder ptr
//
        MOV     EBX,28[ESP]             // get the divisor low word
        MOV     ECX,32[ESP]             // get the divisor high word
        MOV     EAX,36[ESP]             // get the dividend low word
        MOV     EDX,40[ESP]             // get the dividend high word

        OR      ECX,ECX
        JNZ     @DivMod64@slow_ldiv     // both high words are zero

        OR      EDX,EDX
        JZ      @DivMod64@quick_ldiv

        OR      EBX,EBX
        JZ      @DivMod64@quick_ldiv    // if ecx:ebx == 0 force a zero divide
          // we don't expect this to actually
          // work
@DivMod64@slow_ldiv:
        MOV     EBP,ECX
        MOV     ECX,64                  // shift counter
        XOR     EDI,EDI                 // fake a 64 bit dividend
        XOR     ESI,ESI                 //

@DivMod64@xloop:
        SHL     EAX,1                   // shift dividend left one bit
        RCL     EDX,1
        RCL     ESI,1
        RCL     EDI,1
        CMP     EDI,EBP                 // dividend larger?
        JB      @DivMod64@nosub
        JA      @DivMod64@subtract
        CMP     ESI,EBX                 // maybe
        JB      @DivMod64@nosub

@DivMod64@subtract:
        SUB     ESI,EBX
        SBB     EDI,EBP                 // subtract the divisor
        INC     EAX                     // build quotient

@DivMod64@nosub:
        LOOP    @DivMod64@xloop
//
//       When done with the loop the four registers values' look like:
//
//       |     edi    |    esi     |    edx     |    eax     |
//       |        remainder        |         quotient        |
//
        JMP     @DivMod64@finish

@DivMod64@quick_ldiv:
        DIV     EBX                     // unsigned divide
        MOV     ESI,EDX
        XOR     EDX,EDX
        XOR     EDI,EDI

@DivMod64@finish:
        POP     EBX
        POP     ECX
        MOV     [EBX],ESI
        MOV     [EBX+4],EDI
        MOV     [ECX],EAX
        MOV     [ECX+4],EDX

        POP     EDI
        POP     ESI
        POP     EBX
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

procedure RoundExError;
begin
  raise EArgumentException.Create(SVarInvalid);
end;

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function RoundTo is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow
 *
 * ***** END LICENSE BLOCK ***** *)
function RoundTo(const AValue: Extended;
                 const ADigit: TRoundToEXRangeExtended): Extended;
type
  TFactors = array[1..2] of Extended;
const
  LFactorArray : array[-20..20] of TFactors = (
    (1E-20, 1E20), (1E-19, 1E19), (1E-18, 1E18), (1E-17, 1E17), (1E-16, 1E16),
    (1E-15, 1E15), (1E-14, 1E14), (1E-13, 1E13), (1E-12, 1E12), (1E-11, 1E11),
    (1E-10, 1E10), (1E-09, 1E09), (1E-08, 1E08), (1E-07, 1E07), (1E-06, 1E06),
    (1E-05, 1E05), (1E-04, 1E04), (1E-03, 1E03), (1E-02, 1E02), (1E-01, 1E01),
    (1, 1),
    (1E01, 1E-01), (1E02, 1E-02), (1E03, 1E-03), (1E04, 1E-04), (1E05, 1E-05),
    (1E06, 1E-06), (1E07, 1E-07), (1E08, 1E-08), (1E09, 1E-09), (1E10, 1E-10),
    (1E11, 1E-11), (1E12, 1E-12), (1E13, 1E-13), (1E14, 1E-14), (1E15, 1E-15),
    (1E16, 1E-16), (1E17, 1E-17), (1E18, 1E-18), (1E19, 1E-19), (1E20, 1E-20));
{$IFNDEF X86ASM}
const
{$IFDEF EXTENDEDHAS10BYTES}
  ROUNDMAX : extended = 18446744073709551616.0; // $403F8000000000000000
{$ELSE !EXTENDEDHAS10BYTES}
  ROUNDMAX = 4503599627370496; // $4330000000000000
{$ENDIF !EXTENDEDHAS10BYTES}
var
  T: Extended;
  originalRoundMode: TRoundingMode;
begin
  if (ADigit >= Low(LFactorArray)) and (ADigit <= High(LFactorArray)) then
  begin
    originalRoundMode := SetRoundMode(TRoundingMode.rmNearest);
    try
      T := AValue * LFactorArray[ADigit][2];
      if Abs(T) < ROUNDMAX then T := Round(T);
      Result := T * LFactorArray[ADigit][1];
    finally
      SetRoundMode(originalRoundMode);
    end;
  end
  else
  begin
    RoundExError;
    Result := 0; // avoid warning W1035 Return value of function '%s' might be undefined
  end;
end;
{$ELSE X86ASM}
asm
  push    esi {Store esi. Will be used for GOT}
{$IFDEF PIC}
  push    eax
  push    ebx
  call    GetGOT
  pop     ebx

  mov     esi, eax
  pop     eax
{$ELSE !PIC}
  xor     esi, esi
{$ENDIF !PIC}

  sub     esp, 4
  movsx   eax,al
  cmp     eax, 20
  jle     @@LessThan20
  call    RoundExError
@@LessThan20:
  cmp     eax, -20
  jge     @@ValidRange
  call    RoundExError
@@ValidRange:
  fnstcw  word ptr [esp]   { save }
  fnstcw  word ptr [esp+2] { scratch }
  and     word ptr [esp+2], $f0ff { clean RC/PC bits. }
  or      word ptr [esp+2], $0300 { round to nearest even / full precision }
  fldcw   word ptr [esp+2]
  {$IF defined(EXTENDEDIS16BYTES)}
  lea     eax, [eax*8]
  lea     eax, [esi + eax*4 + LFactorArray + Type(Extended)*2*20] {Use GOT}
  {$ELSEIF defined(EXTENDEDIS12BYTES)}
  lea     eax, [eax+eax*2]
  lea     eax, [esi + eax*8 + LFactorArray + Type(Extended)*2*20] {Use GOT}
  {$ELSEIF defined(EXTENDEDIS10BYTES)}
  lea     eax, [eax+eax*4]
  lea     eax, [esi + eax*4 + LFactorArray + Type(Extended)*2*20] {Use GOT}
  {$ELSE}
  imul    eax, Type Extended
  lea     eax, [esi + eax + LFactorArray + Type(Extended)*2*20] {Use GOT}
  {$ENDIF}
  fld     tbyte ptr [eax]
  fld     tbyte ptr [eax+Type(Extended)]
  fld     tbyte ptr AValue
  fmulp
  frndint
  fmulp
  fldcw   word ptr [esp]
  wait
  pop     eax {Restore Stack}
  pop     esi {Restore esi}
end;
{$ENDIF X86ASM}

function SimpleRoundTo(const AValue: Single; const ADigit: TRoundToRange = -2): Single;
var
  LFactor: Extended;
begin
  LFactor := IntPower(10.0, ADigit);
  if AValue < 0 then
    Result := Int((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Int((AValue / LFactor) + 0.5) * LFactor;
end;

function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;
var
  LFactor: Extended;
begin
  LFactor := IntPower(10.0, ADigit);
  if AValue < 0 then
    Result := Int((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Int((AValue / LFactor) + 0.5) * LFactor;
end;

function SimpleRoundTo(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
var
  LFactor: Extended;
begin
  LFactor := IntPower(10.0, ADigit);
  if AValue < 0 then
    Result := Int((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Int((AValue / LFactor) + 0.5) * LFactor;
end;

function Annuity2(const R: Extended; N: Integer; PaymentTime: TPaymentTime;
  var CompoundRN: Extended): Extended; Forward;
function Compound(const R: Extended; N: Integer): Extended; Forward;
function RelSmall(const X, Y: Extended): Boolean; Forward;

type
  TPoly = record
    Neg, Pos, DNeg, DPos: Extended
  end;

const
  MaxIterations = 15;

procedure ArgError(const Msg: string);
begin
  raise EInvalidArgument.Create(Msg);
end;

function DegToRad(const Degrees: Single): Single;  { Radians := Degrees * PI / 180 }
begin
  Result := Degrees * (PI / 180);
end;

function DegToRad(const Degrees: Double): Double;  { Radians := Degrees * PI / 180 }
begin
  Result := Degrees * (PI / 180);
end;

function DegToRad(const Degrees: Extended): Extended;  { Radians := Degrees * PI / 180 }
begin
  Result := Degrees * (PI / 180);
end;

function RadToDeg(const Radians: Single): Single;  { Degrees := Radians * 180 / PI }
begin
  Result := Radians * (180 / PI);
end;

function RadToDeg(const Radians: Double): Double;  { Degrees := Radians * 180 / PI }
begin
  Result := Radians * (180 / PI);
end;

function RadToDeg(const Radians: Extended): Extended;  { Degrees := Radians * 180 / PI }
begin
  Result := Radians * (180 / PI);
end;

function GradToRad(const Grads: Single): Single;   { Radians := Grads * PI / 200 }
begin
  Result := Grads * (PI / 200);
end;

function GradToRad(const Grads: Double): Double;   { Radians := Grads * PI / 200 }
begin
  Result := Grads * (PI / 200);
end;

function GradToRad(const Grads: Extended): Extended;   { Radians := Grads * PI / 200 }
begin
  Result := Grads * (PI / 200);
end;

function RadToGrad(const Radians: Single): Single; { Grads := Radians * 200 / PI}
begin
  Result := Radians * (200 / PI);
end;

function RadToGrad(const Radians: Double): Double; { Grads := Radians * 200 / PI}
begin
  Result := Radians * (200 / PI);
end;

function RadToGrad(const Radians: Extended): Extended; { Grads := Radians * 200 / PI}
begin
  Result := Radians * (200 / PI);
end;

function CycleToRad(const Cycles: Single): Single; { Radians := Cycles * 2PI }
begin
  Result := Cycles * (2 * PI);
end;

function CycleToRad(const Cycles: Double): Double; { Radians := Cycles * 2PI }
begin
  Result := Cycles * (2 * PI);
end;

function CycleToRad(const Cycles: Extended): Extended; { Radians := Cycles * 2PI }
begin
  Result := Cycles * (2 * PI);
end;

function RadToCycle(const Radians: Single): Single;{ Cycles := Radians / 2PI }
begin
  Result := Radians / (2 * PI);
end;

function RadToCycle(const Radians: Double): Double;{ Cycles := Radians / 2PI }
begin
  Result := Radians / (2 * PI);
end;

function RadToCycle(const Radians: Extended): Extended;{ Cycles := Radians / 2PI }
begin
  Result := Radians / (2 * PI);
end;

function DegToGrad(const Degrees: Single): Single;
begin
  Result := RadToGrad(DegToRad(Degrees));
end;

function DegToGrad(const Degrees: Double): Double;
begin
  Result := RadToGrad(DegToRad(Degrees));
end;

function DegToGrad(const Degrees: Extended): Extended;
begin
  Result := RadToGrad(DegToRad(Degrees));
end;

function DegToCycle(const Degrees: Single): Single;
begin
  Result := RadToCycle(DegToRad(Degrees));
end;

function DegToCycle(const Degrees: Double): Double;
begin
  Result := RadToCycle(DegToRad(Degrees));
end;

function DegToCycle(const Degrees: Extended): Extended;
begin
  Result := RadToCycle(DegToRad(Degrees));
end;

function DegNormalize(const Degrees: Single): Single; inline; overload;
begin
  Result := Degrees - Int(Degrees * cInv360) * c360;
  if Result < 0 then
    Result := Result + c360;
end;

function DegNormalize(const Degrees: Double): Double; inline; overload;
begin
  Result := Degrees - Int(Degrees * cInv360) * c360;
  if Result < 0 then
    Result := Result + c360;
end;

function DegNormalize(const Degrees: Extended): Extended; inline; overload;
begin
  Result := Degrees - Int(Degrees * cInv360) * c360;
  if Result < 0 then
    Result := Result + c360;
end;

function GradToDeg(const Grads: Single): Single;
begin
  Result := RadToDeg(GradToRad(Grads));
end;

function GradToDeg(const Grads: Double): Double;
begin
  Result := RadToDeg(GradToRad(Grads));
end;

function GradToDeg(const Grads: Extended): Extended;
begin
  Result := RadToDeg(GradToRad(Grads));
end;

function GradToCycle(const Grads: Single): Single;
begin
  Result := RadToCycle(GradToRad(Grads));
end;

function GradToCycle(const Grads: Double): Double;
begin
  Result := RadToCycle(GradToRad(Grads));
end;

function GradToCycle(const Grads: Extended): Extended;
begin
  Result := RadToCycle(GradToRad(Grads));
end;

function CycleToDeg(const Cycles: Single): Single;
begin
  Result := RadToDeg(CycleToRad(Cycles));
end;

function CycleToDeg(const Cycles: Double): Double;
begin
  Result := RadToDeg(CycleToRad(Cycles));
end;

function CycleToDeg(const Cycles: Extended): Extended;
begin
  Result := RadToDeg(CycleToRad(Cycles));
end;

function CycleToGrad(const Cycles: Single): Single;
begin
  Result := RadToGrad(CycleToRad(Cycles));
end;

function CycleToGrad(const Cycles: Double): Double;
begin
  Result := RadToGrad(CycleToRad(Cycles));
end;

function CycleToGrad(const Cycles: Extended): Extended;
begin
  Result := RadToGrad(CycleToRad(Cycles));
end;

function LnXP1(const X: Single): Single;
{ Return ln(1 + X).  Accurate for X near 0. }
{$IFNDEF X86ASM}
{$IFDEF EXTENDEDIS10BYTES}
begin
  Result := Ln(1 + X);
end;
{$ELSE  EXTENDEDIS10BYTES}
begin
  Result := System.LnXPlus1(X);
end;
{$ENDIF EXTENDEDIS10BYTES}
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm
        FLDLN2
        MOV     AX,WORD PTR X+8               { exponent }
        FLD     X
        CMP     AX,$3FFD                      { .4225 }
        JB      @@1
        FLD1
        FADD
        FYL2X
        JMP     @@2
@@1:
        FYL2XP1
@@2:
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLDLN2
        MOV     AX,WORD PTR X+8               { exponent }
        FLD     X
        CMP     AX,$3FFD                      { .4225 }
        JB      @@1
        FLD1
        FADD
        FYL2X
        JMP     @@2
@@1:
        FYL2XP1
@@2:
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function LnXP1(const X: Double): Double;
{ Return ln(1 + X).  Accurate for X near 0. }
{$IFNDEF X86ASM}
{$IFDEF EXTENDEDIS10BYTES}
begin
  Result := Ln(1 + X);
end;
{$ELSE  EXTENDEDIS10BYTES}
begin
  Result := System.LnXPlus1(X);
end;
{$ENDIF EXTENDEDIS10BYTES}
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLDLN2
        MOV     AX,WORD PTR X+8               { exponent }
        FLD     X
        CMP     AX,$3FFD                      { .4225 }
        JB      @@1
        FLD1
        FADD
        FYL2X
        JMP     @@2
@@1:
        FYL2XP1
@@2:
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLDLN2
        MOV     AX,WORD PTR X+8               { exponent }
        FLD     X
        CMP     AX,$3FFD                      { .4225 }
        JB      @@1
        FLD1
        FADD
        FYL2X
        JMP     @@2
@@1:
        FYL2XP1
@@2:
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function LnXP1(const X: Extended): Extended;
{ Return ln(1 + X).  Accurate for X near 0. }
{$IFNDEF X86ASM}
{$IFDEF EXTENDEDIS10BYTES}
begin
  Result := Ln(1 + X);
end;
{$ELSE  EXTENDEDIS10BYTES}
begin
  Result := System.LnXPlus1(X);
end;
{$ENDIF EXTENDEDIS10BYTES}
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLDLN2
        MOV     AX,WORD PTR X+8               { exponent }
        FLD     tbyte ptr X
        CMP     AX,$3FFD                      { .4225 }
        JB      @@1
        FLD1
        FADD
        FYL2X
        JMP     @@2
@@1:
        FYL2XP1
@@2:
        FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLDLN2
        MOV     AX,WORD PTR X+8               { exponent }
        FLD     tbyte ptr X
        CMP     AX,$3FFD                      { .4225 }
        JB      @@1
        FLD1
        FADD
        FYL2X
        JMP     @@2
@@1:
        FYL2XP1
@@2:
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function IntPower(const Base: Single; const Exponent: Integer): Single;
{$IFNDEF X86ASM}
var
  Y: Integer;
  LBase: Extended;
begin
  FClearExcept;
  Y := Abs(Exponent);
  LBase := Base;
  Result := 1.0;
  while Y > 0 do
  begin
    while not Odd(Y) do
    begin
      Y := Y shr 1;
      LBase := LBase * LBase
    end;
    Dec(Y);
    Result := Result * LBase
  end;
  if Exponent < 0 then
    Result := 1.0 / Result;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        mov     eax, Exponent
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fstp   Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;
{$ENDIF}
{$ENDIF X86ASM}

function IntPower(const Base: Double; const Exponent: Integer): Double;
{$IFNDEF X86ASM}
var
  Y: Integer;
  LBase: Extended;
begin
  FClearExcept;
  Y := Abs(Exponent);
  LBase := Base;
  Result := 1.0;
  while Y > 0 do
  begin
    while not Odd(Y) do
    begin
      Y := Y shr 1;
      LBase := LBase * LBase
    end;
    Dec(Y);
    Result := Result * LBase
  end;
  if Exponent < 0 then
    Result := 1.0 / Result;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        mov     eax, Exponent
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fstp    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;
{$ENDIF}
{$ENDIF X86ASM}

function IntPower(const Base: Extended; const Exponent: Integer): Extended;
{$IFNDEF X86ASM}
var
  Y: Integer;
  LBase: Extended;
begin
  FClearExcept;
  Y := Abs(Exponent);
  LBase := Base;
  Result := 1.0;
  while Y > 0 do
  begin
    while not Odd(Y) do
    begin
      Y := Y shr 1;
      LBase := LBase * LBase
    end;
    Dec(Y);
    Result := Result * LBase
  end;
  if Exponent < 0 then
    Result := 1.0 / Result;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        mov     eax, Exponent
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     tbyte ptr Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fstp    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     tbyte ptr Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;
{$ENDIF}
{$ENDIF X86ASM}

function Compound(const R: Extended; N: Integer): Extended;
{ Return (1 + R)**N. }
begin
  Result := IntPower(Extended(1.0 + R), N)
end;

function Annuity2(const R: Extended; N: Integer; PaymentTime: TPaymentTime;
  var CompoundRN: Extended): Extended;
{ Set CompoundRN to Compound(R, N),
  return (1+Rate*PaymentTime)*(Compound(R,N)-1)/R;
}
begin
  if R = 0.0 then
  begin
    CompoundRN := 1.0;
    Result := N;
  end
  else
  begin
    { 6.1E-5 approx= 2**-14 }
    if Abs(R) < 6.1E-5 then
    begin
      CompoundRN := Exp(N * LnXP1(R));
      Result := N*(1+(N-1)*R/2);
    end
    else
    begin
      CompoundRN := Compound(R, N);
      Result := (CompoundRN-1) / R
    end;
    if PaymentTime = TPaymentTime.ptStartOfPeriod then
      Result := Result * (1 + R);
  end;
end; {Annuity2}


procedure PolyX(const A: array of Double; X: Extended; var Poly: TPoly);
{ Compute A[0] + A[1]*X + ... + A[N]*X**N and X * its derivative.
  Accumulate positive and negative terms separately. }
var
  I: Integer;
  Neg, Pos, DNeg, DPos: Extended;
begin
  Neg := 0.0;
  Pos := 0.0;
  DNeg := 0.0;
  DPos := 0.0;
  for I := High(A) downto Low(A) do
  begin
    DNeg := X * DNeg + Neg;
    Neg := Neg * X;
    DPos := X * DPos + Pos;
    Pos := Pos * X;
    if A[I] >= 0.0 then
      Pos := Pos + A[I]
    else
      Neg := Neg + A[I]
  end;
  Poly.Neg := Neg;
  Poly.Pos := Pos;
  Poly.DNeg := DNeg * X;
  Poly.DPos := DPos * X;
end; {PolyX}


function RelSmall(const X, Y: Extended): Boolean;
{ Returns True if X is small relative to Y }
const
  C1: Double = 1E-15;
  C2: Double = 1E-12;
begin
  Result := Abs(X) < (C1 + C2 * Abs(Y))
end;

{ Math functions. }

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function ArcCos is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow and Norbert Juffa
 *
 * ***** END LICENSE BLOCK ***** *)
function ArcCos(const X : Extended) : Extended; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := ArcTan2(Sqrt((1 + X) * (1 - X)), X);
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
    //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
    FLD   tbyte ptr X
    FLD1
    FADD  ST(0), ST(1)
    FLD1
    FSUB  ST(0), ST(2)
    FMULP ST(1), ST(0)
    FSQRT
    FXCH
    FPATAN
    FSTP  tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
  //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
  FLD   tbyte ptr X
  FLD1
  FADD  ST(0), ST(1)
  FLD1
  FSUB  ST(0), ST(2)
  FMULP ST(1), ST(0)
  FSQRT
  FXCH
  FPATAN
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcCos(const X : Double) : Double; overload;
{$IFNDEF X86ASM}
begin
  Result := ArcTan2(Sqrt((1 + X) * (1 - X)), X);
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm  // StackAlignSafe
    //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
    FLD   X
    FLD1
    FADD  ST(0), ST(1)
    FLD1
    FSUB  ST(0), ST(2)
    FMULP ST(1), ST(0)
    FSQRT
    FXCH
    FPATAN
    FSTP Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm  // StackAlignSafe
  //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
  FLD   X
  FLD1
  FADD  ST(0), ST(1)
  FLD1
  FSUB  ST(0), ST(2)
  FMULP ST(1), ST(0)
  FSQRT
  FXCH
  FPATAN
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcCos(const X : Single) : Single; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := ArcTan2(Sqrt((1 + X) * (1 - X)), X);
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
    //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
    fld1
    fld    X
    fst    st(2)
    fmul   st(0), st(0)
    fsubp
    fsqrt
    fxch
    fpatan
    FSTP Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
  //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fxch
  fpatan
end;
{$ENDIF}
{$ENDIF X86ASM}

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function ArcSin is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow and Norbert Juffa
 *
 * ***** END LICENSE BLOCK ***** *)
function ArcSin(const X : Extended) : Extended; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := ArcTan2(X, Extended(Sqrt((1 + X) * (1 - X))));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
    //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
    fld1
    fld    tbyte ptr X
    fst    st(2)
    fmul   st(0), st(0)
    fsubp
    fsqrt
    fpatan
    fstp   tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
  //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
  fld1
  fld    tbyte ptr X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcSin(const X : Double) : Double; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := ArcTan2(X, Sqrt((1 + X) * (1 - X)));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
    //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
    FLD   X
    FLD1
    FADD  ST(0), ST(1)
    FLD1
    FSUB  ST(0), ST(2)
    FMULP ST(1), ST(0)
    FSQRT
    FPATAN
    FSTP Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
  //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
  FLD   X
  FLD1
  FADD  ST(0), ST(1)
  FLD1
  FSUB  ST(0), ST(2)
  FMULP ST(1), ST(0)
  FSQRT
  FPATAN
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcSin(const X : Single) : Single; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := ArcTan2(X, Sqrt((1 + X) * (1 - X)));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
    //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
    fld1
    fld    X
    fst    st(2)
    fmul   st(0), st(0)
    fsubp
    fsqrt
    fpatan
    fstp Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
  //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcTan2(const Y, X: Extended): Extended;
{$IFNDEF X86ASM}
const
  ArcTanMap : array[TFloatSpecial, TFloatSpecial] of Extended = (
  //X:fsZero,fsNZero,fsDen,fsNDen,fsPosi,fsNega,fsInf,fsNInf, fsNaN
    (+0.0,   +Pi,    +0.0, +Pi,   +0.0,  +Pi,   +0.0,  +Pi,    NaN), // Y:fsZero
    (-0.0,   -Pi,    -0.0, -Pi,   -0.0,  -Pi,   -0.0,  -Pi,    NaN), // Y:fsNZero
    (+Pi/2,  +Pi/2,   0,    Pi,    0,     Pi,   +0.0,  +Pi,    NaN), // Y:fsDenormal
    (-Pi/2,  -Pi/2,   0,   -Pi,    0,    -Pi,   -0.0,  -Pi,    NaN), // Y:fsNDenormal
    (+Pi/2,  +Pi/2,   0,    Pi,    0,     Pi,   +0.0,  +Pi,    NaN), // Y:fsPosi
    (-Pi/2,  -Pi/2,   0,   -Pi,    0,    -Pi,   -0.0,  -Pi,    NaN), // Y:fsNega
    (+Pi/2,  +Pi/2,  +Pi/2,+Pi/2, +Pi/2, +Pi/2, +Pi/4,+3*Pi/4, NaN), // Y:fsInf
    (-Pi/2,  -Pi/2,  -Pi/2,-Pi/2, -Pi/2, -Pi/2, -Pi/4,-3*Pi/4, NaN), // Y:fsNInf
    ( NaN,    NaN,    NaN,  NaN,   NaN,   NaN,   NaN,  NaN,    NaN)  // Y:fsNaN
  );
var
  TypeY, TypeX: TFloatSpecial;
begin
  FClearExcept;
  TypeY := Y.SpecialType;
  TypeX := X.SpecialType;
  Result := ArcTanMap[TypeY, TypeX];
  if (TypeY in [fsDenormal..fsNegative]) and (TypeX in [fsDenormal..fsNegative]) then
  begin
{$IFDEF EXTENDEDHAS10BYTES}
    if Y.Exponent - X.Exponent > 65 then
{$ELSE !EXTENDEDHAS10BYTES}
    if Y.Exponent - X.Exponent > 55 then
{$ENDIF !EXTENDEDHAS10BYTES}
    begin
      if Y.Sign = X.Sign then
        Result := Result + Pi/2
      else
        Result := Result - Pi/2;
    end
    else
    begin
      if Result = 0 then
        Result := ArcTan(Y/X)
      else
        Result := Result + ArcTan(Y/X);
    end;
  end;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD     tbyte ptr Y
        FLD     tbyte ptr X
        FPATAN
        FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD     tbyte ptr Y
        FLD     tbyte ptr X
        FPATAN
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcTan2(const Y, X: Double): Double;
{$IFNDEF X86ASM}
const
  ArcTanMap : array[TFloatSpecial, TFloatSpecial] of Double = (
  //X:fsZero,fsNZero,fsDen,fsNDen,fsPosi,fsNega,fsInf,fsNInf, fsNaN
    (+0.0,   +Pi,    +0.0, +Pi,   +0.0,  +Pi,   +0.0,  +Pi,    NaN), // Y:fsZero
    (-0.0,   -Pi,    -0.0, -Pi,   -0.0,  -Pi,   -0.0,  -Pi,    NaN), // Y:fsNZero
    (+Pi/2,  +Pi/2,   0,    Pi,    0,     Pi,   +0.0,  +Pi,    NaN), // Y:fsDenormal
    (-Pi/2,  -Pi/2,   0,   -Pi,    0,    -Pi,   -0.0,  -Pi,    NaN), // Y:fsNDenormal
    (+Pi/2,  +Pi/2,   0,    Pi,    0,     Pi,   +0.0,  +Pi,    NaN), // Y:fsPosi
    (-Pi/2,  -Pi/2,   0,   -Pi,    0,    -Pi,   -0.0,  -Pi,    NaN), // Y:fsNega
    (+Pi/2,  +Pi/2,  +Pi/2,+Pi/2, +Pi/2, +Pi/2, +Pi/4,+3*Pi/4, NaN), // Y:fsInf
    (-Pi/2,  -Pi/2,  -Pi/2,-Pi/2, -Pi/2, -Pi/2, -Pi/4,-3*Pi/4, NaN), // Y:fsNInf
    ( NaN,    NaN,    NaN,  NaN,   NaN,   NaN,   NaN,  NaN,    NaN)  // Y:fsNaN
  );
var
  TypeY, TypeX: TFloatSpecial;
begin
  FClearExcept;
  TypeY := Y.SpecialType;
  TypeX := X.SpecialType;
  Result := ArcTanMap[TypeY, TypeX];
  if (TypeY in [fsDenormal..fsNegative]) and (TypeX in [fsDenormal..fsNegative]) then
  begin
    if Y.Exponent - X.Exponent > 55 then
    begin
      if Y.Sign = X.Sign then
        Result := Result + Pi/2
      else
        Result := Result - Pi/2;
    end
    else
    begin
      if Result = 0 then
        Result := ArcTan(Y/X)
      else
        Result := Result + ArcTan(Y/X);
    end;
  end;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD     Y
        FLD     X
        FPATAN
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD     Y
        FLD     X
        FPATAN
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function ArcTan2(const Y, X: Single): Single;
{$IFNDEF X86ASM}
const
  ArcTanMap : array[TFloatSpecial, TFloatSpecial] of Single = (
  //X:fsZero,fsNZero,fsDen,fsNDen,fsPosi,fsNega,fsInf,fsNInf, fsNaN
    (+0.0,   +Pi,    +0.0, +Pi,   +0.0,  +Pi,   +0.0,  +Pi,    NaN), // Y:fsZero
    (-0.0,   -Pi,    -0.0, -Pi,   -0.0,  -Pi,   -0.0,  -Pi,    NaN), // Y:fsNZero
    (+Pi/2,  +Pi/2,   0,    Pi,    0,     Pi,   +0.0,  +Pi,    NaN), // Y:fsDenormal
    (-Pi/2,  -Pi/2,   0,   -Pi,    0,    -Pi,   -0.0,  -Pi,    NaN), // Y:fsNDenormal
    (+Pi/2,  +Pi/2,   0,    Pi,    0,     Pi,   +0.0,  +Pi,    NaN), // Y:fsPosi
    (-Pi/2,  -Pi/2,   0,   -Pi,    0,    -Pi,   -0.0,  -Pi,    NaN), // Y:fsNega
    (+Pi/2,  +Pi/2,  +Pi/2,+Pi/2, +Pi/2, +Pi/2, +Pi/4,+3*Pi/4, NaN), // Y:fsInf
    (-Pi/2,  -Pi/2,  -Pi/2,-Pi/2, -Pi/2, -Pi/2, -Pi/4,-3*Pi/4, NaN), // Y:fsNInf
    ( NaN,    NaN,    NaN,  NaN,   NaN,   NaN,   NaN,  NaN,    NaN)  // Y:fsNaN
  );
var
  TypeY, TypeX: TFloatSpecial;
begin
  FClearExcept;
  TypeY := Y.SpecialType;
  TypeX := X.SpecialType;
  Result := ArcTanMap[TypeY, TypeX];
  if (TypeY in [fsDenormal..fsNegative]) and (TypeX in [fsDenormal..fsNegative]) then
  begin
    if Y.Exponent - X.Exponent > 25 then
    begin
      if Y.Sign = X.Sign then
        Result := Result + Pi/2
      else
        Result := Result - Pi/2;
    end
    else
    begin
      if Result = 0 then
        Result := ArcTan(Y/X)
      else
        Result := Result + ArcTan(Y/X);
    end;
  end;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD     Y
        FLD     X
        FPATAN
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD     Y
        FLD     X
        FPATAN
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Tan(const X: Single): Single;
{  Tan := Sin(X) / Cos(X) }
begin
  Result := System.Tangent(X);
end;

function Tan(const X: Double): Double;
{  Tan := Sin(X) / Cos(X) }
begin
  Result := System.Tangent(X);
end;

function Tan(const X: Extended): Extended;
{  Tan := Sin(X) / Cos(X) }
begin
  Result := System.Tangent(X);
end;

function CoTan(const X: Single): Single;
{ CoTan := Cos(X) / Sin(X) = 1 / Tan(X) }
begin
  FClearExcept;
  Result := 1 / System.Tangent(X);
  FCheckExcept;
end;

function CoTan(const X: Double): Double;
{ CoTan := Cos(X) / Sin(X) = 1 / Tan(X) }
begin
  FClearExcept;
  Result := 1 / System.Tangent(X);
  FCheckExcept;
end;

function CoTan(const X: Extended): Extended;
{ CoTan := Cos(X) / Sin(X) = 1 / Tan(X) }
begin
  FClearExcept;
  Result := 1 / System.Tangent(X);
  FCheckExcept;
end;

function Secant(const X: Single): Single;
{ Secant := 1 / Cos(X) }
begin
  FClearExcept;
  Result := 1 / Cos(X);
  FCheckExcept;
end;

function Secant(const X: Double): Double;
{ Secant := 1 / Cos(X) }
begin
  FClearExcept;
  Result := 1 / Cos(X);
  FCheckExcept;
end;

function Secant(const X: Extended): Extended;
{ Secant := 1 / Cos(X) }
begin
  FClearExcept;
  Result := 1 / Cos(X);
  FCheckExcept;
end;

function Cosecant(const X: Single): Single;
{ Cosecant := 1 / Sin(X) }
begin
  FClearExcept;
  Result := 1 / Sin(X);
  FCheckExcept;
end;

function Cosecant(const X: Double): Double;
{ Cosecant := 1 / Sin(X) }
begin
  FClearExcept;
  Result := 1 / Sin(X);
  FCheckExcept;
end;

function Cosecant(const X: Extended): Extended;
{ Cosecant := 1 / Sin(X) }
begin
  FClearExcept;
  Result := 1 / Sin(X);
  FCheckExcept;
end;

function Hypot(const X, Y: Single): Single;
{ formula: Sqrt(X*X + Y*Y)
  implemented as:  |Y|*Sqrt(1+Sqr(X/Y)), |X| < |Y| for greater precision }
{$IFNDEF X86ASM}
var
  Temp, TempX, TempY: Extended;
begin
  FClearExcept;
  TempX := Abs(X);
  TempY := Abs(Y);
  if TempX > TempY then
  begin
    Temp := TempX;
    TempX := TempY;
    TempY := Temp;
  end;
  if TempX = 0 then
    Result := TempY
  else         // TempY > TempX, TempX <> 0, so TempY > 0
    Result := TempY * Sqrt(1 + Sqr(TempX/TempY));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD     Y
        FABS
        FLD     X
        FABS
        FCOM
        FNSTSW  AX
        TEST    AH,$45
        JNZ      @@1        // if ST > ST(1) then swap
        FXCH    ST(1)      // put larger number in ST(1)
@@1:    FLDZ
        FCOMP
        FNSTSW  AX
        TEST    AH,$40     // if ST = 0, return ST(1)
        JZ      @@2
        FSTP    ST         // eat ST(0)
        JMP     @@3
@@2:    FDIV    ST,ST(1)   // ST := ST / ST(1)
        FMUL    ST,ST      // ST := ST * ST
        FLD1
        FADD               // ST := ST + 1
        FSQRT              // ST := Sqrt(ST)
        FMUL               // ST(1) := ST * ST(1); Pop ST
@@3:    FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD     Y
        FABS
        FLD     X
        FABS
        FCOM
        FNSTSW  AX
        TEST    AH,$45
        JNZ      @@1        // if ST > ST(1) then swap
        FXCH    ST(1)      // put larger number in ST(1)
@@1:    FLDZ
        FCOMP
        FNSTSW  AX
        TEST    AH,$40     // if ST = 0, return ST(1)
        JZ      @@2
        FSTP    ST         // eat ST(0)
        JMP     @@3
@@2:    FDIV    ST,ST(1)   // ST := ST / ST(1)
        FMUL    ST,ST      // ST := ST * ST
        FLD1
        FADD               // ST := ST + 1
        FSQRT              // ST := Sqrt(ST)
        FMUL               // ST(1) := ST * ST(1); Pop ST
@@3:    FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Hypot(const X, Y: Double): Double;
{ formula: Sqrt(X*X + Y*Y)
  implemented as:  |Y|*Sqrt(1+Sqr(X/Y)), |X| < |Y| for greater precision }
{$IFNDEF X86ASM}
var
  Temp, TempX, TempY: Extended;
begin
  FClearExcept;
  TempX := Abs(X);
  TempY := Abs(Y);
  if TempX > TempY then
  begin
    Temp := TempX;
    TempX := TempY;
    TempY := Temp;
  end;
  if TempX = 0 then
    Result := TempY
  else         // TempY > TempX, TempX <> 0, so TempY > 0
    Result := TempY * Sqrt(1 + Sqr(TempX/TempY));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD     Y
        FABS
        FLD     X
        FABS
        FCOM
        FNSTSW  AX
        TEST    AH,$45
        JNZ      @@1        // if ST > ST(1) then swap
        FXCH    ST(1)      // put larger number in ST(1)
@@1:    FLDZ
        FCOMP
        FNSTSW  AX
        TEST    AH,$40     // if ST = 0, return ST(1)
        JZ      @@2
        FSTP    ST         // eat ST(0)
        JMP     @@3
@@2:    FDIV    ST,ST(1)   // ST := ST / ST(1)
        FMUL    ST,ST      // ST := ST * ST
        FLD1
        FADD               // ST := ST + 1
        FSQRT              // ST := Sqrt(ST)
        FMUL               // ST(1) := ST * ST(1); Pop ST
@@3:    FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD     Y
        FABS
        FLD     X
        FABS
        FCOM
        FNSTSW  AX
        TEST    AH,$45
        JNZ      @@1        // if ST > ST(1) then swap
        FXCH    ST(1)      // put larger number in ST(1)
@@1:    FLDZ
        FCOMP
        FNSTSW  AX
        TEST    AH,$40     // if ST = 0, return ST(1)
        JZ      @@2
        FSTP    ST         // eat ST(0)
        JMP     @@3
@@2:    FDIV    ST,ST(1)   // ST := ST / ST(1)
        FMUL    ST,ST      // ST := ST * ST
        FLD1
        FADD               // ST := ST + 1
        FSQRT              // ST := Sqrt(ST)
        FMUL               // ST(1) := ST * ST(1); Pop ST
@@3:    FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Hypot(const X, Y: Extended): Extended;
{ formula: Sqrt(X*X + Y*Y)
  implemented as:  |Y|*Sqrt(1+Sqr(X/Y)), |X| < |Y| for greater precision }
{$IFNDEF X86ASM}
var
  Temp, TempX, TempY: Extended;
begin
  FClearExcept;
  TempX := Abs(X);
  TempY := Abs(Y);
  if TempX > TempY then
  begin
    Temp := TempX;
    TempX := TempY;
    TempY := Temp;
  end;
  if TempX = 0 then
    Result := TempY
  else         // TempY > TempX, TempX <> 0, so TempY > 0
    Result := TempY * Sqrt(1 + Sqr(TempX/TempY));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD     tbyte ptr Y
        FABS
        FLD     tbyte ptr X
        FABS
        FCOM
        FNSTSW  AX
        TEST    AH,$45
        JNZ      @@1        // if ST > ST(1) then swap
        FXCH    ST(1)      // put larger number in ST(1)
@@1:    FLDZ
        FCOMP
        FNSTSW  AX
        TEST    AH,$40     // if ST = 0, return ST(1)
        JZ      @@2
        FSTP    ST         // eat ST(0)
        JMP     @@3
@@2:    FDIV    ST,ST(1)   // ST := ST / ST(1)
        FMUL    ST,ST      // ST := ST * ST
        FLD1
        FADD               // ST := ST + 1
        FSQRT              // ST := Sqrt(ST)
        FMUL               // ST(1) := ST * ST(1); Pop ST
@@3:    FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD     tbyte ptr Y
        FABS
        FLD     tbyte ptr X
        FABS
        FCOM
        FNSTSW  AX
        TEST    AH,$45
        JNZ      @@1        // if ST > ST(1) then swap
        FXCH    ST(1)      // put larger number in ST(1)
@@1:    FLDZ
        FCOMP
        FNSTSW  AX
        TEST    AH,$40     // if ST = 0, return ST(1)
        JZ      @@2
        FSTP    ST         // eat ST(0)
        JMP     @@3
@@2:    FDIV    ST,ST(1)   // ST := ST / ST(1)
        FMUL    ST,ST      // ST := ST * ST
        FLD1
        FADD               // ST := ST + 1
        FSQRT              // ST := Sqrt(ST)
        FMUL               // ST(1) := ST * ST(1); Pop ST
@@3:    FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

procedure SinCos(const Theta: Single; var Sin, Cos: Single);
var
{$IFDEF EXTENDEDHAS10BYTES}
  S, C: Extended;
{$ELSE !EXTENDEDHAS10BYTES}
  S, C: Double;
{$ENDIF !EXTENDEDHAS10BYTES}
begin
  System.SineCosine(Theta, S, C);
  Sin := S;
  Cos := C;
end;

procedure SinCos(const Theta: Double; var Sin, Cos: Double);
{$IFDEF EXTENDEDHAS10BYTES}
var
  S, C: Extended;
begin
  System.SineCosine(Theta, S, C);
  Sin := S;
  Cos := C;
end;
{$ELSE !EXTENDEDHAS10BYTES}
begin
  System.SineCosine(Theta, Sin, Cos);
end;
{$ENDIF !EXTENDEDHAS10BYTES}

procedure SinCos(const Theta: Extended; var Sin, Cos: Extended);
{$IFDEF EXTENDEDHAS10BYTES}
begin
  System.SineCosine(Theta, Sin, Cos);
end;
{$ELSE !EXTENDEDHAS10BYTES}
var
  S, C: Double;
begin
  System.SineCosine(Theta, S, C);
  Sin := S;
  Cos := C;
end;
{$ENDIF !EXTENDEDHAS10BYTES}

{ Extract exponent and mantissa from X }

procedure Frexp(const X: Single; var Mantissa: Single; var Exponent: Integer); overload;
{$IFNDEF X86ASM}
var
  M : UInt64;
begin
  Mantissa := X;
  Exponent := 0;
  case X.SpecialType of
    fsZero,
    fsNZero:
      ;
    fsInf,
    fsNInf:
      begin
        FRaiseExcept(feeINVALID);
        Exponent := -$7FFFFFFF;
      end;
    fsNaN:
      FRaiseExcept(feeINVALID);
    fsDenormal,
    fsNDenormal:
      begin
        Exponent := X.Exponent + 1; // exponent biased to match
        M := X.Mantissa;
        if (M and $FFFF00) = 0 then
        begin
          M := M shl 16;
          Exponent := Exponent - 16;
        end;
        if (M and $FF0000) = 0 then
        begin
          M := M shl 8;
          Exponent := Exponent - 8;
        end;
        if (M and $F00000) = 0 then
        begin
          M := M shl 4;
          Exponent := Exponent - 4;
        end;
        if (M and $C00000) = 0 then
        begin
          M := M shl 2;
          Exponent := Exponent - 2;
        end;
        if (M and $800000) = 0 then
        begin
          M := M shl 1;
          Exponent := Exponent - 1;
        end;
        Mantissa := M / $01000000; // exponent biased to match
        if X.Sign then
          Mantissa := Mantissa * -1;
      end;
    fsPositive,
    fsNegative:
      begin
        Exponent := X.Exponent + 1; // exponent biased to match
        Mantissa := X.Fraction / 2;
        if X.Sign then
          Mantissa := Mantissa * -1;
      end;
  end;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)}
begin
  FClearExcept;
  asm
        MOV     EDX, Exponent
        FLD     X
        MOV     dword ptr [edx], 0    { if X = 0, return 0 }

        FTST
        FSTSW   AX
        FWAIT
        SAHF
        MOV     EAX, Mantissa
        JZ      @@Done

        FXTRACT                 // ST(1) = exponent, (pushed) ST = fraction
        FXCH

// The FXTRACT instruction normalizes the fraction 1 bit higher than
// wanted for the definition of frexp() so we need to tweak the result
// by scaling the fraction down and incrementing the exponent.

        FISTP   dword ptr [edx]
        FLD1
        FCHS
        FXCH
        FSCALE                  // scale fraction
        INC     dword ptr [edx] // exponent biased to match
        FSTP ST(1)              // discard -1, leave fraction as TOS

@@Done:
        FSTP    dword ptr [eax]
  end;
  FCheckExcept;
end;
{$ELSE}
{ Mantissa ptr in EAX, Exponent ptr in EDX }
asm // StackAlignSafe
        FLD     X
        PUSH    EAX
        MOV     dword ptr [edx], 0    { if X = 0, return 0 }

        FTST
        FSTSW   AX
        FWAIT
        SAHF
        JZ      @@Done

        FXTRACT                 // ST(1) = exponent, (pushed) ST = fraction
        FXCH

// The FXTRACT instruction normalizes the fraction 1 bit higher than
// wanted for the definition of frexp() so we need to tweak the result
// by scaling the fraction down and incrementing the exponent.

        FISTP   dword ptr [edx]
        FLD1
        FCHS
        FXCH
        FSCALE                  // scale fraction
        INC     dword ptr [edx] // exponent biased to match
        FSTP ST(1)              // discard -1, leave fraction as TOS

@@Done:
        POP     EAX
        FSTP    dword ptr [eax]
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

procedure Frexp(const X: Double; var Mantissa: Double; var Exponent: Integer); overload;
{$IFNDEF X86ASM}
var
  M : UInt64;
begin
  Mantissa := X;
  Exponent := 0;
  case X.SpecialType of
    fsZero,
    fsNZero:
      ;
    fsInf,
    fsNInf:
      begin
        FRaiseExcept(feeINVALID);
        Exponent := -$7FFFFFFF;
      end;
    fsNaN:
      FRaiseExcept(feeINVALID);
    fsDenormal,
    fsNDenormal:
      begin
        Exponent := X.Exponent + 1; // exponent biased to match
        M := X.Mantissa;
        if (M and $1FFFFFFFE00000) = 0 then
        begin
          M := M shl 32;
          Exponent := Exponent - 32;
        end;
        if (M and $1FFFE000000000) = 0 then
        begin
          M := M shl 16;
          Exponent := Exponent - 16;
        end;
        if (M and $1FE00000000000) = 0 then
        begin
          M := M shl 8;
          Exponent := Exponent - 8;
        end;
        if (M and $1E000000000000) = 0 then
        begin
          M := M shl 4;
          Exponent := Exponent - 4;
        end;
        if (M and $18000000000000) = 0 then
        begin
          M := M shl 2;
          Exponent := Exponent - 2;
        end;
        if (M and $10000000000000) = 0 then
        begin
          M := M shl 1;
          Exponent := Exponent - 1;
        end;
        Mantissa := M / $0020000000000000; // exponent biased to match
        if X.Sign then
          Mantissa := Mantissa * -1;
      end;
    fsPositive,
    fsNegative:
      begin
        Exponent := X.Exponent + 1; // exponent biased to match
        Mantissa := X.Fraction / 2;
        if X.Sign then
          Mantissa := Mantissa * -1;
      end;
  end;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        MOV     EDX, Exponent
        FLD     X
        MOV     dword ptr [edx], 0    { if X = 0, return 0 }

        FTST
        FSTSW   AX
        FWAIT
        SAHF
        MOV     EAX, Mantissa
        JZ      @@Done

        FXTRACT                 // ST(1) = exponent, (pushed) ST = fraction
        FXCH

// The FXTRACT instruction normalizes the fraction 1 bit higher than
// wanted for the definition of frexp() so we need to tweak the result
// by scaling the fraction down and incrementing the exponent.

        FISTP   dword ptr [edx]
        FLD1
        FCHS
        FXCH
        FSCALE                  // scale fraction
        INC     dword ptr [edx] // exponent biased to match
        FSTP ST(1)              // discard -1, leave fraction as TOS

@@Done:
        FSTP    qword ptr [eax]
  end;
  FCheckExcept;
end;
{$ELSE}
{ Mantissa ptr in EAX, Exponent ptr in EDX }
asm // StackAlignSafe
        FLD     X
        PUSH    EAX
        MOV     dword ptr [edx], 0    { if X = 0, return 0 }

        FTST
        FSTSW   AX
        FWAIT
        SAHF
        JZ      @@Done

        FXTRACT                 // ST(1) = exponent, (pushed) ST = fraction
        FXCH

// The FXTRACT instruction normalizes the fraction 1 bit higher than
// wanted for the definition of frexp() so we need to tweak the result
// by scaling the fraction down and incrementing the exponent.

        FISTP   dword ptr [edx]
        FLD1
        FCHS
        FXCH
        FSCALE                  // scale fraction
        INC     dword ptr [edx] // exponent biased to match
        FSTP ST(1)              // discard -1, leave fraction as TOS

@@Done:
        POP     EAX
        FSTP    qword ptr [eax]
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

procedure Frexp(const X: Extended; var Mantissa: Extended; var Exponent: Integer); overload;
{$IFNDEF X86ASM}
var
  M : UInt64;
begin
  Mantissa := X;
  Exponent := 0;
  case X.SpecialType of
    fsZero,
    fsNZero:
      ;
    fsInf,
    fsNInf:
      begin
        FRaiseExcept(feeINVALID);
        Exponent := -$7FFFFFFF;
      end;
    fsNaN:
      FRaiseExcept(feeINVALID);
    fsDenormal,
    fsNDenormal:
      begin
        Exponent := X.Exponent + 1; // exponent biased to match
        M := X.Mantissa;
        if (M and {$IFDEF EXTENDEDHAS10BYTES}$FFFFFFFF00000000{$ELSE}$1FFFFFFFE00000{$ENDIF}) = 0 then
        begin
          M := M shl 32;
          Exponent := Exponent - 32;
        end;
        if (M and {$IFDEF EXTENDEDHAS10BYTES}$FFFF000000000000{$ELSE}$1FFFE000000000{$ENDIF}) = 0 then
        begin
          M := M shl 16;
          Exponent := Exponent - 16;
        end;
        if (M and {$IFDEF EXTENDEDHAS10BYTES}$FF00000000000000{$ELSE}$1FE00000000000{$ENDIF}) = 0 then
        begin
          M := M shl 8;
          Exponent := Exponent - 8;
        end;
        if (M and {$IFDEF EXTENDEDHAS10BYTES}$F000000000000000{$ELSE}$1E000000000000{$ENDIF}) = 0 then
        begin
          M := M shl 4;
          Exponent := Exponent - 4;
        end;
        if (M and {$IFDEF EXTENDEDHAS10BYTES}$C000000000000000{$ELSE}$18000000000000{$ENDIF}) = 0 then
        begin
          M := M shl 2;
          Exponent := Exponent - 2;
        end;
        if (M and {$IFDEF EXTENDEDHAS10BYTES}$8000000000000000{$ELSE}$10000000000000{$ENDIF}) = 0 then
        begin
          M := M shl 1;
          Exponent := Exponent - 1;
        end;
{$IFDEF EXTENDEDHAS10BYTES}
        Mantissa := M / $8000000000000000;
        Mantissa := Mantissa / 2;  // exponent biased to match
{$ELSE !EXTENDEDHAS10BYTES}
        Mantissa := M / $0020000000000000; // exponent biased to match
{$ENDIF !EXTENDEDHAS10BYTES}
        if X.Sign then
          Mantissa := Mantissa * -1;
      end;
    fsPositive,
    fsNegative:
      begin
        Exponent := X.Exponent + 1; // exponent biased to match
        Mantissa := X.Fraction / 2;
        if X.Sign then
          Mantissa := Mantissa * -1;
      end;
  end;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        MOV     EDX, Exponent
        FLD     tbyte ptr X
        MOV     dword ptr [edx], 0    { if X = 0, return 0 }

        FTST
        FSTSW   AX
        FWAIT
        SAHF
        MOV     EAX, Mantissa
        JZ      @@Done

        FXTRACT                 // ST(1) = exponent, (pushed) ST = fraction
        FXCH

// The FXTRACT instruction normalizes the fraction 1 bit higher than
// wanted for the definition of frexp() so we need to tweak the result
// by scaling the fraction down and incrementing the exponent.

        FISTP   dword ptr [edx]
        FLD1
        FCHS
        FXCH
        FSCALE                  // scale fraction
        INC     dword ptr [edx] // exponent biased to match
        FSTP ST(1)              // discard -1, leave fraction as TOS

@@Done:
        FSTP    tbyte ptr [eax]
  end;
  FCheckExcept;
end;
{$ELSE}
{ Mantissa ptr in EAX, Exponent ptr in EDX }
asm // StackAlignSafe
        FLD     tbyte ptr X
        PUSH    EAX
        MOV     dword ptr [edx], 0    { if X = 0, return 0 }

        FTST
        FSTSW   AX
        FWAIT
        SAHF
        JZ      @@Done

        FXTRACT                 // ST(1) = exponent, (pushed) ST = fraction
        FXCH

// The FXTRACT instruction normalizes the fraction 1 bit higher than
// wanted for the definition of frexp() so we need to tweak the result
// by scaling the fraction down and incrementing the exponent.

        FISTP   dword ptr [edx]
        FLD1
        FCHS
        FXCH
        FSCALE                  // scale fraction
        INC     dword ptr [edx] // exponent biased to match
        FSTP ST(1)              // discard -1, leave fraction as TOS

@@Done:
        POP     EAX
        FSTP    tbyte ptr [eax]
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Ldexp(const X: Single; const P: Integer): Single;
  { Result := X * (2^P) }
{$IFNDEF X86ASM}
var
  T: Single;
  I: Integer;
const
  MaxExp =  127;
  MinExp = -126;
  FractionOfOne = $00800000;
begin
  T := X;
  Result := X;
  case T.SpecialType of
    fsDenormal,
    fsNDenormal,
    fsPositive,
    fsNegative:
      begin
        FClearExcept;
        I := P;
        if I > MaxExp then
        begin
          T.BuildUp(False, FractionOfOne, MaxExp);
          Result := Result * T;
          I := I - MaxExp;
          if I > MaxExp then I := MaxExp;
        end
        else if I < MinExp then
        begin
          T.BuildUp(False, FractionOfOne, MinExp);
          Result := Result * T;
          I := I - MinExp;
          if I < MinExp then I := MinExp;
        end;
        if I <> 0 then
        begin
          T.BuildUp(False, FractionOfOne, I);
          Result := Result * T;
        end;
        FCheckExcept;
      end;
//    fsZero,
//    fsNZero,
//    fsInf,
//    fsNInf,
//    fsNaN:
  else
    ;
  end;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm
        FILD    P
        FLD     X
        FSCALE
        FSTP    ST(1)
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        PUSH    EAX
        FILD    dword ptr [ESP]
        FLD     X
        FSCALE
        POP     EAX
        FSTP    ST(1)
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Ldexp(const X: Double; const P: Integer): Double;
  { Result := X * (2^P) }
{$IFNDEF X86ASM}
var
  T: Double;
  I: Integer;
const
  MaxExp =  1023;
  MinExp = -1022;
  FractionOfOne = $0010000000000000;
begin
  T := X;
  Result := X;
  case T.SpecialType of
    fsDenormal,
    fsNDenormal,
    fsPositive,
    fsNegative:
      begin
        FClearExcept;
        I := P;
        if I > MaxExp then
        begin
          T.BuildUp(False, FractionOfOne, MaxExp);
          Result := Result * T;
          I := I - MaxExp;
          if I > MaxExp then I := MaxExp;
        end
        else if I < MinExp then
        begin
          T.BuildUp(False, FractionOfOne, MinExp);
          Result := Result * T;
          I := I - MinExp;
          if I < MinExp then I := MinExp;
        end;
        if I <> 0 then
        begin
          T.BuildUp(False, FractionOfOne, I);
          Result := Result * T;
        end;
        FCheckExcept;
      end;
//    fsZero,
//    fsNZero,
//    fsInf,
//    fsNInf,
//    fsNaN:
  else
    ;
  end;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FILD    P
        FLD     X
        FSCALE
        FSTP    ST(1)
        FSTP    Result
        FWAIT
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        PUSH    EAX
        FILD    dword ptr [ESP]
        FLD     X
        FSCALE
        POP     EAX
        FSTP    ST(1)
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Ldexp(const X: Extended; const P: Integer): Extended;
  { Result := X * (2^P) }
{$IFNDEF X86ASM}
var
  T: Extended;
  I: Integer;
const
{$IFDEF EXTENDEDHAS10BYTES}
  MaxExp =  16383;
  MinExp = -16382;
  FractionOfOne = $8000000000000000;
{$ELSE !EXTENDEDHAS10BYTES}
  MaxExp =  1023;
  MinExp = -1022;
  FractionOfOne = $0010000000000000;
{$ENDIF !EXTENDEDHAS10BYTES}
begin
  T := X;
  Result := X;
  case T.SpecialType of
    fsDenormal,
    fsNDenormal,
    fsPositive,
    fsNegative:
      begin
        FClearExcept;
        I := P;
        if I > MaxExp then
        begin
          T.BuildUp(False, FractionOfOne, MaxExp);
          Result := Result * T;
          I := I - MaxExp;
          if I > MaxExp then I := MaxExp;
        end
        else if I < MinExp then
        begin
          T.BuildUp(False, FractionOfOne, MinExp);
          Result := Result * T;
          I := I - MinExp;
          if I < MinExp then I := MinExp;
        end;
        if I <> 0 then
        begin
          T.BuildUp(False, FractionOfOne, I);
          Result := Result * T;
        end;
        FCheckExcept;
      end;
//    fsZero,
//    fsNZero,
//    fsInf,
//    fsNInf,
//    fsNaN:
  else
    ;
  end;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FILD    P
        FLD     tbyte ptr X
        FSCALE
        FSTP    ST(1)
        FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        PUSH    EAX
        FILD    dword ptr [ESP]
        FLD     tbyte ptr X
        FSCALE
        POP     EAX
        FSTP    ST(1)
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Ceil(const X: Single): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
end;

function Ceil(const X: Double): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
end;

function Ceil(const X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
end;

function Floor(const X: Single): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;

function Floor(const X: Double): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;

function Floor(const X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;

{ Conversion of bases:  Log.b(X) = Log.a(X) / Log.a(b)  }

function Log10(const X: Single): Single;
  { Log.10(X) := Ln(X) / Ln(10) }
{$IFNDEF X86ASM}
const
  InvLn10: Cardinal = $3EDE5BD9; // 1/Ln(10)
begin
  FClearExcept;
  Result := Ln(X) * PSingle(@InvLn10)^;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLDLG2     { Log base ten of 2 }
        FLD     X
        FYL2X
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLDLG2     { Log base ten of 2 }
        FLD     X
        FYL2X
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Log10(const X: Double): Double;
  { Log.10(X) := Ln(X) / Ln(10) }
{$IFNDEF X86ASM}
const
  InvLn10 : UInt64 = $3FDBCB7B1526E50E; // 1/Ln(10)
begin
  FClearExcept;
  Result := Ln(X) * PDouble(@InvLn10)^;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLDLG2     { Log base ten of 2 }
        FLD     X
        FYL2X
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLDLG2     { Log base ten of 2 }
        FLD     X
        FYL2X
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Log10(const X: Extended): Extended;
  { Log.10(X) := Ln(X) / Ln(10) }
{$IF Defined(PUREPASCAL)}
{$IFDEF EXTENDEDHAS10BYTES}
const
  InvLn10: array[0..4] of Word = ($7195, $3728, $D8A9, $DE5B, $3FFD); { 1 / Ln(10) }
begin
  FClearExcept;
  Result := Ln(X) * PExtended(@InvLn10)^;
  FCheckExcept;
end;
{$ELSE !EXTENDEDHAS10BYTES}
const
  InvLn10 : UInt64 = $3FDBCB7B1526E50E; // 1/Ln(10)
begin
  FClearExcept;
  Result := Ln(X) * PDouble(@InvLn10)^;
  FCheckExcept;
end;
{$ENDIF !EXTENDEDHAS10BYTES}
{$ELSEIF Defined(X86ASM)}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLDLG2     { Log base ten of 2 }
        FLD     tbyte ptr X
        FYL2X
        FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLDLG2     { Log base ten of 2 }
        FLD     tbyte ptr X
        FYL2X
        FWAIT
end;
{$ENDIF}
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

function Log2(const X: Single): Single;
{$IFNDEF X86ASM}
const
  InvLn2: Cardinal = $3FB8AA3B; // 1/Ln(2)
begin
  FClearExcept;
  Result := Ln(X) * PSingle(@InvLn2)^;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Log2(const X: Double): Double;
{$IFNDEF X86ASM}
const
  InvLn2 : UInt64 = $3FF71547652B82FE; // 1/Ln(2)
begin
  FClearExcept;
  Result := Ln(X) * PDouble(@InvLn2)^;
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Log2(const X: Extended): Extended;
{$IF Defined(PUREPASCAL)}
{$IFDEF EXTENDEDHAS10BYTES}
const
  InvLn2 : array[0..4] of Word = ($F0BC, $5C17, $3B29, $B8AA, $3FFF); { 1/Ln(2) }
begin
  FClearExcept;
  Result := Ln(X) * PExtended(@InvLn2)^;
  FCheckExcept;
end;
{$ELSE !EXTENDEDHAS10BYTES}
const
  InvLn2 : UInt64 = $3FF71547652B82FE; // 1/Ln(2)
begin
  FClearExcept;
  Result := Ln(X) * PDouble(@InvLn2)^;
  FCheckExcept;
end;
{$ENDIF !EXTENDEDHAS10BYTES}
{$ELSEIF Defined(X86ASM)}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD1
        FLD     tbyte ptr X
        FYL2X
        FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD1
        FLD     tbyte ptr X
        FYL2X
        FWAIT
end;
{$ENDIF}
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

function LogN(const Base, X: Single): Single;
{ Log.N(X) := Ln(X) / Ln(N) }
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := Ln(X) / Ln(Base);
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FLD1
        FLD     Base
        FYL2X
        FDIV
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FLD1
        FLD     Base
        FYL2X
        FDIV
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function LogN(const Base, X: Double): Double;
{ Log.N(X) := Ln(X) / Ln(N) }
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := Ln(X) / Ln(Base);
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FLD1
        FLD     Base
        FYL2X
        FDIV
        FSTP    Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD1
        FLD     X
        FYL2X
        FLD1
        FLD     Base
        FYL2X
        FDIV
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function LogN(const Base, X: Extended): Extended;
{ Log.N(X) := Ln(X) / Ln(N) }
{$IFNDEF X86ASM}
begin
  FClearExcept;
  Result := Ln(X) / Ln(Base);
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
begin
  FClearExcept;
  asm // StackAlignSafe
        FLD1
        FLD     tbyte ptr X
        FYL2X
        FLD1
        FLD     tbyte ptr Base
        FYL2X
        FDIV
        FSTP    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
asm // StackAlignSafe
        FLD1
        FLD     tbyte ptr X
        FYL2X
        FLD1
        FLD     tbyte ptr Base
        FYL2X
        FDIV
        FWAIT
end;
{$ENDIF}
{$ENDIF X86ASM}

function Poly(const X: Single; const Coefficients: array of Single): Single;
{ Horner's method }
var
  I: Integer;
begin
  FClearExcept;
  Result := Coefficients[High(Coefficients)];
  for I := High(Coefficients) - 1 downto Low(Coefficients) do
    Result := Result * X + Coefficients[I];
  FCheckExcept;
end;

function Poly(const X: Double; const Coefficients: array of Double): Double;
{ Horner's method }
var
  I: Integer;
begin
  FClearExcept;
  Result := Coefficients[High(Coefficients)];
  for I := High(Coefficients) - 1 downto Low(Coefficients) do
    Result := Result * X + Coefficients[I];
  FCheckExcept;
end;

function Poly(const X: Extended; const Coefficients: array of Extended): Extended;
{ Horner's method }
var
  I: Integer;
begin
  FClearExcept;
  Result := Coefficients[High(Coefficients)];
  for I := High(Coefficients) - 1 downto Low(Coefficients) do
    Result := Result * X + Coefficients[I];
  FCheckExcept;
end;

function Power(const Base, Exponent: Extended): Extended;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Integer(Trunc(Exponent)))
  else if Base < 0 then
  begin
    Error(reInvalidOp);
    Result := 0; // avoid warning W1035 Return value of function '%s' might be undefined
  end
  else
    Result := Exp(Exponent * Ln(Base));
  FCheckExcept;
end;
{$ELSE X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function Power is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow
 *
 * ***** END LICENSE BLOCK ***** *)
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
begin
  FClearExcept;
  asm // StackAlignSafe
    fld     tbyte ptr Exponent
    fld     st             {copy to st(1)}
    fabs                   {abs(exp)}
{$IFDEF PIC}
    push    ebx
    call    GetGOT
    pop     ebx
    fld     qword ptr [eax].Max
{$ELSE !PIC}
    fld     Max
{$ENDIF !PIC}
    fcompp                 {leave exp in st(0)}
    fstsw   ax
    sahf
    jb      @@RealPower    {exp > MaxInt}
    fld     st             {exp in st(0) and st(1)}
    frndint                {round(exp)}
    fcomp                  {compare exp and round(exp)}
    fstsw   ax
    sahf
    jne     @@RealPower
    fistp   IntExp
    mov     eax, IntExp    {eax=Trunc(Exponent)}
    mov     ecx, eax
    cdq
    fld1                   {Result=1}
    xor     eax, edx
    sub     eax, edx       {abs(exp)}
    jz      @@Exit
    fld     tbyte ptr Base
    jmp     @@Entry
@@Loop:
    fmul    st, st         {Base * Base}
@@Entry:
    shr     eax, 1
    jnc     @@Loop
    fmul    st(1), st      {Result * X}
    jnz     @@Loop
    fstp    st
    cmp     ecx, 0
    jge     @@Exit
    fld1
    fdivrp                 {1/Result}
    jmp     @@Exit
@@RealPower:
    fld     tbyte ptr Base
    ftst
    fstsw   ax
    sahf
    jz      @@Done
    fldln2
    fxch
    fyl2x
    fxch
    fmulp   st(1), st
    fldl2e
    fmulp   st(1), st
    fld     st(0)
    frndint
    fsub    st(1), st
    fxch    st(1)
    f2xm1
    fld1
    faddp   st(1), st
    fscale
@@Done:
    fstp    st(1)
@@Exit:
    fstp    tbyte ptr Result
  end;
  FCheckExcept;
end;
{$ELSE}
const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
asm // StackAlignSafe
  fld     tbyte ptr Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}
{$IFDEF PIC}
  push    ebx
  call    GetGOT
  pop     ebx
  fld     qword ptr [eax].Max
{$ELSE !PIC}
  fld     Max
{$ENDIF !PIC}
  fcompp                 {leave exp in st(0)}
  fstsw   ax
  sahf
  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}
  fcomp                  {compare exp and round(exp)}
  fstsw   ax
  sahf
  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Trunc(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     tbyte ptr Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     tbyte ptr Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;
{$ENDIF}
{$ENDIF X86ASM}

function Power(const Base, Exponent: Double): Double; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Integer(Trunc(Exponent)))
  else if Base < 0 then
  begin
    Error(reInvalidOp);
    Result := 0; // avoid warning W1035 Return value of function '%s' might be undefined
  end
  else
    Result := Exp(Exponent * Ln(Base));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
begin
  FClearExcept;
  asm // StackAlignSafe
    fld     Exponent
    fld     st             {copy to st(1)}
    fabs                   {abs(exp)}
{$IFDEF PIC}
    push    ebx
    call    GetGOT
    pop     ebx
    fld     qword ptr [eax].Max
{$ELSE !PIC}
    fld     Max
{$ENDIF !PIC}
    fcompp                 {leave exp in st(0)}
    fstsw   ax
    sahf
    jb      @@RealPower    {exp > MaxInt}
    fld     st             {exp in st(0) and st(1)}
    frndint                {round(exp)}
    fcomp                  {compare exp and round(exp)}
    fstsw   ax
    sahf
    jne     @@RealPower
    fistp   IntExp
    mov     eax, IntExp    {eax=Trunc(Exponent)}
    mov     ecx, eax
    cdq
    fld1                   {Result=1}
    xor     eax, edx
    sub     eax, edx       {abs(exp)}
    jz      @@Exit
    fld     Base
    jmp     @@Entry
@@Loop:
    fmul    st, st         {Base * Base}
@@Entry:
    shr     eax, 1
    jnc     @@Loop
    fmul    st(1), st      {Result * X}
    jnz     @@Loop
    fstp    st
    cmp     ecx, 0
    jge     @@Exit
    fld1
    fdivrp                 {1/Result}
    jmp     @@Exit
@@RealPower:
    fld     Base
    ftst
    fstsw   ax
    sahf
    jz      @@Done
    fldln2
    fxch
    fyl2x
    fxch
    fmulp   st(1), st
    fldl2e
    fmulp   st(1), st
    fld     st(0)
    frndint
    fsub    st(1), st
    fxch    st(1)
    f2xm1
    fld1
    faddp   st(1), st
    fscale
@@Done:
    fstp    st(1)
@@Exit:
    fstp    Result
  end;
  FCheckExcept;
end;
{$ELSE}
const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
asm // StackAlignSafe
  fld     Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}
{$IFDEF PIC}
  push    ebx
  call    GetGOT
  pop     ebx
  fld     qword ptr [eax].Max
{$ELSE !PIC}
  fld     Max
{$ENDIF !PIC}
  fcompp                 {leave exp in st(0)}
  fstsw   ax
  sahf
  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}
  fcomp                  {compare exp and round(exp)}
  fstsw   ax
  sahf
  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Trunc(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;
{$ENDIF}
{$ENDIF X86ASM}

function Power(const Base, Exponent: Single): Single; overload;
{$IFNDEF X86ASM}
begin
  FClearExcept;
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Integer(Trunc(Exponent)))
  else if Base < 0 then
  begin
    Error(reInvalidOp);
    Result := 0; // avoid warning W1035 Return value of function '%s' might be undefined
  end
  else
    Result := Exp(Exponent * Ln(Base));
  FCheckExcept;
end;
{$ELSE X86ASM}
{$IF     defined(CPUX86) and defined(IOS)} // iOS/Simulator
const
  Max : Double = MaxInt;
var
  IntExp : Integer;
begin
  FClearExcept;
  asm // StackAlignSafe
    fld     Exponent
    fld     st             {copy to st(1)}
    fabs                   {abs(exp)}
{$IFDEF PIC}
    push    ebx
    call    GetGOT
    pop     ebx
    fld     qword ptr [eax].Max
{$ELSE !PIC}
    fld     Max
{$ENDIF !PIC}
    fcompp                 {leave exp in st(0)}
    fstsw   ax
    sahf
    jb      @@RealPower    {exp > MaxInt}
    fld     st             {exp in st(0) and st(1)}
    frndint                {round(exp)}
    fcomp                  {compare exp and round(exp)}
    fstsw   ax
    sahf
    jne     @@RealPower
    fistp   IntExp
    mov     eax, IntExp    {eax=Integer(Exponent)}
    mov     ecx, eax
    cdq
    fld1                   {Result=1}
    xor     eax, edx
    sub     eax, edx       {abs(exp)}
    jz      @@Exit
    fld     Base
    jmp     @@Entry
@@Loop:
    fmul    st, st         {Base * Base}
@@Entry:
    shr     eax, 1
    jnc     @@Loop
    fmul    st(1), st      {Result * X}
    jnz     @@Loop
    fstp    st
    cmp     ecx, 0
    jge     @@Exit
    fld1
    fdivrp                 {1/Result}
    jmp     @@Exit
@@RealPower:
    fld     Base
    ftst
    fstsw   ax
    sahf
    jz      @@Done
    fldln2
    fxch
    fyl2x
    fxch
    fmulp   st(1), st
    fldl2e
    fmulp   st(1), st
    fld     st(0)
    frndint
    fsub    st(1), st
    fxch    st(1)
    f2xm1
    fld1
    faddp   st(1), st
    fscale
@@Done:
    fstp    st(1)
@@Exit:
    fstp    Result
  end;
  FCheckExcept;
end;
{$ELSE}
const
  Max : Double = MaxInt;
var
  IntExp : Integer;
asm // StackAlignSafe
  fld     Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}
{$IFDEF PIC}
  push    ebx
  call    GetGOT
  pop     ebx
  fld     qword ptr [eax].Max
{$ELSE !PIC}
  fld     Max
{$ENDIF !PIC}
  fcompp                 {leave exp in st(0)}
  fstsw   ax
  sahf
  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}
  fcomp                  {compare exp and round(exp)}
  fstsw   ax
  sahf
  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Integer(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;
{$ENDIF}
{$ENDIF X86ASM}

{ Hyperbolic functions }

function Cosh(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := 1
  else
    Result := (Exp(X) + Exp(-X)) / 2;
  FCheckExcept;
end;

function Cosh(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := 1
  else
    Result := (Exp(X) + Exp(-X)) / 2;
  FCheckExcept;
end;

function Cosh(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := 1
  else
    Result := (Exp(X) + Exp(-X)) / 2;
  FCheckExcept;
end;

function Sinh(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := 0
  else
    Result := (Exp(X) - Exp(-X)) / 2;
  FCheckExcept;
end;

function Sinh(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := 0
  else
    Result := (Exp(X) - Exp(-X)) / 2;
  FCheckExcept;
end;

function Sinh(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := 0
  else
    Result := (Exp(X) - Exp(-X)) / 2;
  FCheckExcept;
end;

function Tanh(const X: Single): Single;
const
  MaxTanhDomain = 23;
  C1of3 = 1/3;
  CBorder = 1.8145860519450699870567321328132e-5; // 2 ^(-63 / 4)
  CLn2Div2 = 0.34657359027997265470861606072909; // Ln2 / 2
var
  y, z: Extended;
begin
  FClearExcept;
  case X.SpecialType of
    fsPositive,
    fsNegative:
      begin
        z := X;
        if X < 0 then z := -z;
        if (z > MaxTanhDomain) then
          Result := 1.0
        else if (z < CBorder) then
          Result := z  - z * z * z * c1of3
        else if (z < CLn2Div2) then
        begin
          y := ExpMinus1(2*z);
          Result := y / (2 + y);
        end
        else
        begin
          y := Exp(2*z);
          Result := 1 - (2/(y + 1));
        end;
        if X < 0 then Result := -Result;
      end;
    else
      Result := X;
  end;
  FCheckExcept;
end;

function Tanh(const X: Double): Double;
const
  MaxTanhDomain = 23;
  C1of3 = 1/3;
  CBorder = 1.8145860519450699870567321328132e-5; // 2 ^(-63 / 4)
  CLn2Div2 = 0.34657359027997265470861606072909; // Ln2 / 2
var
  y, z: Extended;
begin
  FClearExcept;
  case X.SpecialType of
    fsPositive,
    fsNegative:
      begin
        z := X;
        if X < 0 then z := -z;
        if (z > MaxTanhDomain) then
          Result := 1.0
        else if (z < CBorder) then
          Result := z  - z * z * z * c1of3
        else if (z < CLn2Div2) then
        begin
          y := ExpMinus1(2*z);
          Result := y / (2 + y);
        end
        else
        begin
          y := Exp(2*z);
          Result := 1 - (2/(y + 1));
        end;
        if X < 0 then Result := -Result;
      end;
    else
      Result := X;
  end;
  FCheckExcept;
end;

function Tanh(const X: Extended): Extended; overload;
const
  MaxTanhDomain = 23;
  C1of3 = 1/3;
  CBorder = 1.8145860519450699870567321328132e-5; // 2 ^(-63 / 4)
  CLn2Div2 = 0.34657359027997265470861606072909; // Ln2 / 2
var
  y, z: Extended;
begin
  FClearExcept;
  case TExtendedRec(X).SpecialType of
    fsPositive,
    fsNegative:
      begin
        z := X;
        if X < 0 then z := -z;
        if (z > MaxTanhDomain) then
          Result := 1.0
        else if (z < CBorder) then
          Result := z  - z * z * z * c1of3
        else if (z < CLn2Div2) then
        begin
          y := ExpMinus1(2*z);
          Result := y / (2 + y);
        end
        else
        begin
          y := Exp(2*z);
          Result := 1 - (2/(y + 1));
        end;
        if X < 0 then Result := -Result;
      end;
    else
      Result := X;
  end;
  FCheckExcept;
end;

function ArcCosh(const X: Single): Single;
begin
  FClearExcept;
  Result := Ln(X + Sqrt((X - 1) / (X + 1)) * (X + 1));
  FCheckExcept;
end;

function ArcCosh(const X: Double): Double;
begin
  FClearExcept;
  Result := Ln(X + Sqrt((X - 1) / (X + 1)) * (X + 1));
  FCheckExcept;
end;

function ArcCosh(const X: Extended): Extended;
begin
  FClearExcept;
  Result := Ln(X + Sqrt((X - 1) / (X + 1)) * (X + 1));
  FCheckExcept;
end;

function ArcSinh(const X: Single): Single;
begin
  FClearExcept;
  Result := Ln(X + Sqrt((X * X) + 1));
  FCheckExcept;
end;

function ArcSinh(const X: Double): Double;
begin
  FClearExcept;
  Result := Ln(X + Sqrt((X * X) + 1));
  FCheckExcept;
end;

function ArcSinh(const X: Extended): Extended;
begin
  FClearExcept;
  Result := Ln(X + Sqrt((X * X) + 1));
  FCheckExcept;
end;

function ArcTanh(const X: Single): Single;
begin
  FClearExcept;
  if SameValue(X, 1) then
    Result := Infinity
  else if SameValue(X, -1) then
    Result := NegInfinity
  else
    Result := 0.5 * Ln((1 + X) / (1 - X));
  FCheckExcept;
end;

function ArcTanh(const X: Double): Double;
begin
  FClearExcept;
  if SameValue(X, 1) then
    Result := Infinity
  else if SameValue(X, -1) then
    Result := NegInfinity
  else
    Result := 0.5 * Ln((1 + X) / (1 - X));
  FCheckExcept;
end;

function ArcTanh(const X: Extended): Extended;
begin
  FClearExcept;
  if SameValue(X, 1) then
    Result := Infinity
  else if SameValue(X, -1) then
    Result := NegInfinity
  else
    Result := 0.5 * Ln((1 + X) / (1 - X));
  FCheckExcept;
end;

function Cot(const X: Single): Single;
begin
  Result := CoTan(X);
end;

function Cot(const X: Double): Double;
begin
  Result := CoTan(X);
end;

function Cot(const X: Extended): Extended;
begin
  Result := CoTan(X);
end;

function Sec(const X: Single): Single;
begin
  Result := Secant(X);
end;

function Sec(const X: Double): Double;
begin
  Result := Secant(X);
end;

function Sec(const X: Extended): Extended;
begin
  Result := Secant(X);
end;

function Csc(const X: Single): Single;
begin
  Result := Cosecant(X);
end;

function Csc(const X: Double): Double;
begin
  Result := Cosecant(X);
end;

function Csc(const X: Extended): Extended;
begin
  Result := Cosecant(X);
end;

function CotH(const X: Single): Single;
begin
  FClearExcept;
  Result := 1 / TanH(X);
  FCheckExcept;
end;

function CotH(const X: Double): Double;
begin
  FClearExcept;
  Result := 1 / TanH(X);
  FCheckExcept;
end;

function CotH(const X: Extended): Extended;
begin
  FClearExcept;
  Result := 1 / TanH(X);
  FCheckExcept;
end;

function SecH(const X: Single): Single;
begin
  FClearExcept;
  Result := 1 / CosH(X);
  FCheckExcept;
end;

function SecH(const X: Double): Double;
begin
  FClearExcept;
  Result := 1 / CosH(X);
  FCheckExcept;
end;

function SecH(const X: Extended): Extended;
begin
  FClearExcept;
  Result := 1 / CosH(X);
  FCheckExcept;
end;

function CscH(const X: Single): Single;
begin
  FClearExcept;
  Result := 1 / SinH(X);
  FCheckExcept;
end;

function CscH(const X: Double): Double;
begin
  FClearExcept;
  Result := 1 / SinH(X);
  FCheckExcept;
end;

function CscH(const X: Extended): Extended;
begin
  FClearExcept;
  Result := 1 / SinH(X);
  FCheckExcept;
end;

function ArcCot(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := PI / 2
  else
    Result := ArcTan(1 / X);
  FCheckExcept;
end;

function ArcCot(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := PI / 2
  else
    Result := ArcTan(1 / X);
  FCheckExcept;
end;

function ArcCot(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := PI / 2
  else
    Result := ArcTan(1 / X);
  FCheckExcept;
end;

function ArcSec(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    Result := ArcCos(1 / X);
  FCheckExcept;
end;

function ArcSec(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    Result := ArcCos(1 / X);
  FCheckExcept;
end;

function ArcSec(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    Result := ArcCos(1 / X);
  FCheckExcept;
end;

function ArcCsc(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    Result := ArcSin(1 / X);
  FCheckExcept;
end;

function ArcCsc(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    Result := ArcSin(1 / X);
  FCheckExcept;
end;

function ArcCsc(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    Result := ArcSin(1 / X);
  FCheckExcept;
end;

function ArcCotH(const X: Single): Single;
begin
  FClearExcept;
  if SameValue(X, 1) then
    Result := Infinity
  else if SameValue(X, -1) then
    Result := NegInfinity
  else
    Result := 0.5 * Ln((X + 1) / (X - 1));
  FCheckExcept;
end;

function ArcCotH(const X: Double): Double;
begin
  FClearExcept;
  if SameValue(X, 1) then
    Result := Infinity
  else if SameValue(X, -1) then
    Result := NegInfinity
  else
    Result := 0.5 * Ln((X + 1) / (X - 1));
  FCheckExcept;
end;

function ArcCotH(const X: Extended): Extended;
begin
  FClearExcept;
  if SameValue(X, 1) then
    Result := Infinity
  else if SameValue(X, -1) then
    Result := NegInfinity
  else
    Result := 0.5 * Ln((X + 1) / (X - 1));
  FCheckExcept;
end;

function ArcSecH(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else if SameValue(X, 1) then
    Result := 0
  else
    Result := Ln((Sqrt(1 - X * X) + 1) / X);
  FCheckExcept;
end;


function ArcSecH(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else if SameValue(X, 1) then
    Result := 0
  else
    Result := Ln((Sqrt(1 - X * X) + 1) / X);
  FCheckExcept;
end;

function ArcSecH(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else if SameValue(X, 1) then
    Result := 0
  else
    Result := Ln((Sqrt(1 - X * X) + 1) / X);
  FCheckExcept;
end;

function ArcCscH(const X: Single): Single;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    if X < 0 then
      Result := Ln((1 - Sqrt(1 + X * X)) / X)
    else
      Result := Ln((1 + Sqrt(1 + X * X)) / X);
  FCheckExcept;
end;

function ArcCscH(const X: Double): Double;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    if X < 0 then
      Result := Ln((1 - Sqrt(1 + X * X)) / X)
    else
      Result := Ln((1 + Sqrt(1 + X * X)) / X);
  FCheckExcept;
end;

function ArcCscH(const X: Extended): Extended;
begin
  FClearExcept;
  if IsZero(X) then
    Result := Infinity
  else
    if X < 0 then
      Result := Ln((1 - Sqrt(1 + X * X)) / X)
    else
      Result := Ln((1 + Sqrt(1 + X * X)) / X);
  FCheckExcept;
end;

function IsNan(const AValue: Single): Boolean;
begin
  Result := AValue.SpecialType = TFloatSpecial.fsNaN;
end;

function IsNan(const AValue: Double): Boolean;
begin
  Result := AValue.SpecialType = TFloatSpecial.fsNaN;
end;

function IsNan(const AValue: Extended): Boolean;
begin
  Result := AValue.SpecialType = TFloatSpecial.fsNaN;
end;

function IsInfinite(const AValue: Single): Boolean;
begin
  Result := AValue.SpecialType in [TFloatSpecial.fsInf, TFloatSpecial.fsNInf];
end;

function IsInfinite(const AValue: Double): Boolean;
begin
  Result := AValue.SpecialType in [TFloatSpecial.fsInf, TFloatSpecial.fsNInf];
end;

function IsInfinite(const AValue: Extended): Boolean;
begin
  Result := AValue.SpecialType in [TFloatSpecial.fsInf, TFloatSpecial.fsNInf];
end;

{ Statistical functions }

function Mean(const Data: array of Single): Single;
begin
  Result := SUM(Data) / (High(Data) - Low(Data) + 1);
end;

function Mean(const Data: array of Double): Double;
begin
  Result := SUM(Data) / (High(Data) - Low(Data) + 1);
end;

function Mean(const Data: array of Extended): Extended;
begin
  Result := SUM(Data) / (High(Data) - Low(Data) + 1);
end;

function MinValue(const Data: array of Single): Single;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result > Data[I] then
      Result := Data[I];
end;

function MinValue(const Data: array of Double): Double;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result > Data[I] then
      Result := Data[I];
end;

function MinValue(const Data: array of Extended): Extended;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result > Data[I] then
      Result := Data[I];
end;

function MinIntValue(const Data: array of Integer): Integer;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result > Data[I] then
      Result := Data[I];
end;

function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Min(const A, B: Int64): Int64;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Min(const A, B: UInt64): UInt64;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Min(const A, B: Single): Single;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Min(const A, B: Double): Double;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Min(const A, B: Extended): Extended;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function MaxValue(const Data: array of Single): Single;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then
      Result := Data[I];
end;

function MaxValue(const Data: array of Double): Double;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then
      Result := Data[I];
end;

function MaxValue(const Data: array of Extended): Extended;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then
      Result := Data[I];
end;

function MaxIntValue(const Data: array of Integer): Integer;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then
      Result := Data[I];
end;

function Max(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max(const A, B: Int64): Int64;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max(const A, B: UInt64): UInt64;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max(const A, B: Single): Single;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max(const A, B: Double): Double;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max(const A, B: Extended): Extended;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Sign(const AValue: Integer): TValueSign;
begin
  Result := ZeroValue;
  if AValue < 0 then
    Result := NegativeValue
  else if AValue > 0 then
    Result := PositiveValue;
end;

function Sign(const AValue: Int64): TValueSign;
begin
  Result := ZeroValue;
  if AValue < 0 then
    Result := NegativeValue
  else if AValue > 0 then
    Result := PositiveValue;
end;

function Sign(const AValue: Single): TValueSign;
begin
  if (PInteger(@AValue)^ and $7FFFFFFF) = $00000000 then
    Result := ZeroValue
  else
    if (PInteger(@AValue)^ and $80000000) = $80000000 then
      Result := NegativeValue
    else
      Result := PositiveValue;
end;

function Sign(const AValue: Double): TValueSign;
begin
  if ((PInt64(@AValue)^ and $7FFFFFFFFFFFFFFF) = $0000000000000000) then
    Result := ZeroValue
  else if ((PInt64(@AValue)^ and $8000000000000000) = $8000000000000000) then
    Result := NegativeValue
  else
    Result := PositiveValue;
end;

function Sign(const AValue: Extended): TValueSign;
begin
{$IFDEF EXTENDEDHAS10BYTES}
  if (AValue.Frac and $FFFFFFFFFFFFFFFF) = $0000000000000000 then
    Result := ZeroValue
  else
    if AValue.sign then
      Result := NegativeValue
    else
      Result := PositiveValue;
{$ELSE !EXTENDEDHAS10BYTES}
  if ((PInt64(@AValue)^ and $7FFFFFFFFFFFFFFF) = $0000000000000000) then
    Result := ZeroValue
  else if ((PInt64(@AValue)^ and $8000000000000000) = $8000000000000000) then
    Result := NegativeValue
  else
    Result := PositiveValue;
{$ENDIF !EXTENDEDHAS10BYTES}
end;

const
  FuzzFactor = 1000;
  SingleResolution   = 1E-7 * FuzzFactor;
  DoubleResolution   = 1E-15 * FuzzFactor;
{$IFDEF EXTENDEDHAS10BYTES}
  ExtendedResolution = 1E-19 * FuzzFactor;
{$ELSE !EXTENDEDHAS10BYTES}
  ExtendedResolution = DoubleResolution;
{$ENDIF !EXTENDEDHAS10BYTES}

function CompareValue(const A, B: Extended; Epsilon: Extended): TValueRelationship;
begin
  if SameValue(A, B, Epsilon) then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function CompareValue(const A, B: Double; Epsilon: Double): TValueRelationship;
begin
  if SameValue(A, B, Epsilon) then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function CompareValue(const A, B: Single; Epsilon: Single): TValueRelationship;
begin
  if SameValue(A, B, Epsilon) then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function CompareValue(const A, B: Integer): TValueRelationship;
begin
  if A = B then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function CompareValue(const A, B: Int64): TValueRelationship;
begin
  if A = B then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function CompareValue(const A, B: UInt64): TValueRelationship;
begin
  if A = B then
    Result := EqualsValue
  else if A < B then
    Result := LessThanValue
  else
    Result := GreaterThanValue;
end;

function SameValue(const A, B: Extended; Epsilon: Extended): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := Max(Min(Abs(A), Abs(B)) * ExtendedResolution, ExtendedResolution);
  if A > B then
    Result := (A - B) <= Epsilon
  else
    Result := (B - A) <= Epsilon;
end;

function SameValue(const A, B: Double; Epsilon: Double): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := Max(Min(Abs(A), Abs(B)) * DoubleResolution, DoubleResolution);
  if A > B then
    Result := (A - B) <= Epsilon
  else
    Result := (B - A) <= Epsilon;
end;

function SameValue(const A, B: Single; Epsilon: Single): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := Max(Min(Abs(A), Abs(B)) * SingleResolution, SingleResolution);
  if A > B then
    Result := (A - B) <= Epsilon
  else
    Result := (B - A) <= Epsilon;
end;

function IsZero(const A: Extended; Epsilon: Extended): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := ExtendedResolution;
  Result := Abs(A) <= Epsilon;
end;

function IsZero(const A: Double; Epsilon: Double): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := DoubleResolution;
  Result := Abs(A) <= Epsilon;
end;

function IsZero(const A: Single; Epsilon: Single): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := SingleResolution;
  Result := Abs(A) <= Epsilon;
end;

function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: UInt64; const AFalse: UInt64): UInt64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Single; const AFalse: Single): Single;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double): Double;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Extended; const AFalse: Extended): Extended;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function FMod(const ANumerator, ADenominator: Single): Single;
begin
  Result := ANumerator - Trunc(ANumerator / ADenominator) * ADenominator;
end;

function FMod(const ANumerator, ADenominator: Double): Double;
begin
  Result := ANumerator - Trunc(ANumerator / ADenominator) * ADenominator;
end;

function FMod(const ANumerator, ADenominator: Extended): Extended;
begin
  Result := ANumerator - Trunc(ANumerator / ADenominator) * ADenominator;
end;

function RandomRange(const AFrom, ATo: Integer): Integer;
begin
  if AFrom > ATo then
    Result := Random(AFrom - ATo) + ATo
  else
    Result := Random(ATo - AFrom) + AFrom;
end;

function RandomFrom(const AValues: array of Integer): Integer;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function RandomFrom(const AValues: array of Int64): Int64;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function RandomFrom(const AValues: array of UInt64): UInt64;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function RandomFrom(const AValues: array of Single): Single;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function RandomFrom(const AValues: array of Double): Double;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

function RandomFrom(const AValues: array of Extended): Extended;
begin
  Result := AValues[Random(High(AValues) + 1)];
end;

{ Range testing functions }

function InRange(const AValue, AMin, AMax: Integer): Boolean;
var
  A, B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

function InRange(const AValue, AMin, AMax: Int64): Boolean;
var
  A, B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

function InRange(const AValue, AMin, AMax: UInt64): Boolean;
var
  A, B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

function InRange(const AValue, AMin, AMax: Single): Boolean;
var
  A, B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

function InRange(const AValue, AMin, AMax: Double): Boolean;
var
  A, B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

function InRange(const AValue, AMin, AMax: Extended): Boolean;
var
  A, B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

{ Range truncation functions }

function EnsureRange(const AValue, AMin, AMax: Integer): Integer;
begin
  assert(AMin <= AMax);
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

function EnsureRange(const AValue, AMin, AMax: Int64): Int64;
begin
  assert(AMin <= AMax);
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

function EnsureRange(const AValue, AMin, AMax: UInt64): UInt64;
begin
  assert(AMin <= AMax);
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

function EnsureRange(const AValue, AMin, AMax: Single): Single;
begin
  assert(AMin <= AMax);
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

function EnsureRange(const AValue, AMin, AMax: Double): Double;
begin
  assert(AMin <= AMax);
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

function EnsureRange(const AValue, AMin, AMax: Extended): Extended;
begin
  assert(AMin <= AMax);
  if AValue < AMin then
    Result := AMin
  else if AValue > AMax then
    Result := AMax
  else
    Result := AValue;
end;

procedure KahanSumDouble(var S, R: Double; const D: Double);
var
  T,U: Double;
begin
  T := D - R;
  U := S + T;
  R := (U - S) - T;
  S := U;
end;

procedure KahanSumExtended(var S, R: Extended; const D: Extended);
var
  T,U: Extended;
begin
  T := D - R;
  U := S + T;
  R := (U - S) - T;
  S := U;
end;

procedure MeanAndTotalVariance(const Data: array of Single; var Mean, TotalVariance: Extended); overload;
var
  S: Extended;
  N,I: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Mean := Data[0];
    TotalVariance := Data[0];
    Exit;
  end;
  Mean := Sum(Data) / N;
  S := Sqr(Mean - Data[Low(Data)]);
  for I := Low(Data)+1 to High(Data) do
    S := S + Sqr(Mean - Data[I]);
  TotalVariance := S;
end;

procedure MeanAndTotalVariance(const Data: array of Double; var Mean, TotalVariance: Extended); overload;
var
  S,R: Extended;
  N,I: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Mean := Data[0];
    TotalVariance := Data[0];
    Exit;
  end;
  Mean := Sum(Data) / N;
  S := Sqr(Mean - Data[Low(Data)]);
  R := 0;
  for I := Low(Data)+1 to High(Data) do
    KahanSumExtended(S, R, Sqr(Mean - Data[I]));
  TotalVariance := S;
end;

procedure MeanAndTotalVariance(const Data: array of Extended; var Mean, TotalVariance: Extended); overload;
var
  S, R: Extended;
  N,I: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Mean := Data[0];
    TotalVariance := Data[0];
  end;
  Mean := Sum(Data) / N;
  S := Sqr(Mean - Data[Low(Data)]);
  R := 0;
  for I := Low(Data)+1 to High(Data) do
    KahanSumExtended(S, R, Sqr(Mean - Data[I]));
  TotalVariance := S;
end;

procedure MeanAndStdDev(const Data: array of Single; var Mean, StdDev: Single);
var
  TV,M: Extended;
  N: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Mean := Data[0];
    StdDev := Data[0];
    Exit;
  end;
  MeanAndTotalVariance(Data, M, TV);
  Mean := M;
  StdDev := Sqrt(TV / (N - 1));
end;

procedure MeanAndStdDev(const Data: array of Double; var Mean, StdDev: Double);
var
  TV,M: Extended;
  N: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Mean := Data[0];
    StdDev := Data[0];
    Exit;
  end;
  MeanAndTotalVariance(Data, M, TV);
  Mean := M;
  StdDev := Sqrt(TV / (N - 1));
end;

procedure MeanAndStdDev(const Data: array of Extended; var Mean, StdDev: Extended);
var
  TV,M: Extended;
  N: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Mean := Data[0];
    StdDev := Data[0];
    Exit;
  end;
  MeanAndTotalVariance(Data, M, TV);
  Mean := M;
  StdDev := Sqrt(TV / (N - 1));
end;

procedure MomentSkewKurtosis(const Data: array of Double;
  var M1, M2, M3, M4, Skew, Kurtosis: Extended);
var
  Sum, SumSquares, SumCubes, SumQuads, OverN, Accum, M1Sqr, S2N, S3N: Extended;
  I: Integer;
begin
  OverN := 1 / (High(Data) - Low(Data) + 1);
  Sum := 0;
  SumSquares := 0;
  SumCubes := 0;
  SumQuads := 0;
  for I := Low(Data) to High(Data) do
  begin
    Sum := Sum + Data[I];
    Accum := Sqr(Data[I]);
    SumSquares := SumSquares + Accum;
    Accum := Accum*Data[I];
    SumCubes := SumCubes + Accum;
    SumQuads := SumQuads + Accum*Data[I];
  end;
  M1 := Sum * OverN;
  M1Sqr := Sqr(M1);
  S2N := SumSquares * OverN;
  S3N := SumCubes * OverN;
  M2 := S2N - M1Sqr;
  M3 := S3N - (M1 * 3 * S2N) + 2*M1Sqr*M1;
  M4 := (SumQuads * OverN) - (M1 * 4 * S3N) + (M1Sqr*6*S2N - 3*Sqr(M1Sqr));
  Skew := M3 * Power(M2, -3/2);   // = M3 / Power(M2, 3/2)
  Kurtosis := M4 / Sqr(M2);
end;

function Norm(const Data: array of Single): Single;
begin
  Result := Sqrt(SumOfSquares(Data));
end;

function Norm(const Data: array of Double): Double;
begin
  Result := Sqrt(SumOfSquares(Data));
end;

function Norm(const Data: array of Extended): Extended;
begin
  Result := Sqrt(SumOfSquares(Data));
end;

function PopnStdDev(const Data: array of Single): Single;
begin
  Result := Sqrt(PopnVariance(Data))
end;

function PopnStdDev(const Data: array of Double): Double;
begin
  Result := Sqrt(PopnVariance(Data))
end;

function PopnStdDev(const Data: array of Extended): Extended;
begin
  Result := Sqrt(PopnVariance(Data))
end;

function PopnVariance(const Data: array of Single): Single;
begin
  Result := TotalVariance(Data) / (High(Data) - Low(Data) + 1)
end;

function PopnVariance(const Data: array of Double): Double;
begin
  Result := TotalVariance(Data) / (High(Data) - Low(Data) + 1)
end;

function PopnVariance(const Data: array of Extended): Extended;
begin
  Result := TotalVariance(Data) / (High(Data) - Low(Data) + 1)
end;

function RandG(Mean, StdDev: Single): Single;
{ Marsaglia-Bray algorithm }
var
  U1, S2: Single;
begin
  repeat
    U1 := 2*Random - 1;
    S2 := Sqr(U1) + Sqr(2*Random-1);
  until S2 < 1;
  Result := Sqrt(-2*Ln(S2)/S2) * U1 * StdDev + Mean;
end;

function RandG(Mean, StdDev: Double): Double;
{ Marsaglia-Bray algorithm }
var
  U1, S2: Double;
begin
  repeat
    U1 := 2*Random - 1;
    S2 := Sqr(U1) + Sqr(2*Random-1);
  until S2 < 1;
  Result := Sqrt(-2*Ln(S2)/S2) * U1 * StdDev + Mean;
end;

function RandG(Mean, StdDev: Extended): Extended;
{ Marsaglia-Bray algorithm }
var
  U1, S2: Extended;
begin
  repeat
    U1 := 2*Random - 1;
    S2 := Sqr(U1) + Sqr(2*Random-1);
  until S2 < 1;
  Result := Sqrt(-2*Ln(S2)/S2) * U1 * StdDev + Mean;
end;

function StdDev(const Data: array of Single): Single;
begin
  Result := Sqrt(Variance(Data))
end;

function StdDev(const Data: array of Double): Double;
begin
  Result := Sqrt(Variance(Data))
end;

function StdDev(const Data: array of Extended): Extended;
begin
  Result := Sqrt(Variance(Data))
end;

function SumInt(const Data: array of Integer): Integer;
{$IF not Defined(X86ASM) or Defined(PIC)}
{$IFOPT Q-}
  {$DEFINE __OVERFLOWCHECKS}
  {$OVERFLOWCHECKS ON}
{$ENDIF}
var
  Count: Integer;
  PData: PInteger;
begin
  Result := 0;
  if High(Data) = -1 then Exit;
  PData := @Data[Low(Data)];
  Count := High(Data) - Low(Data)+1;
  while Count and 3 > 0 do
  begin
    Inc(Result, PData^);
    Inc(PData);
    Dec(Count);
  end;
  while Count > 0 do
  begin
{$POINTERMATH ON}
    Result := (Result + (PData)^ + (PData+1)^ + (PData+2)^ + (PData+3)^);
{$POINTERMATH OFF}
    Inc(PData, 4);
    Dec(Count, 4);
  end;
end;
{$IFDEF __OVERFLOWCHECKS}
  {$UNDEF __OVERFLOWCHECKS}
  {$OVERFLOWCHECKS OFF}
{$ENDIF}
{$ELSE X86ASM}
asm  // IN: EAX = ptr to Data, EDX = High(Data) = Count - 1
     // loop unrolled 4 times, 5 clocks per loop, 1.2 clocks per datum
      PUSH EBX
      MOV  ECX, EAX         // ecx = ptr to data
      MOV  EBX, EDX
      XOR  EAX, EAX
      CMP  EBX, 0
      JL   @@Exit
      AND  EDX, not 3
      AND  EBX, 3
      SHL  EDX, 2
      JMP  @Vector.Pointer[EBX*4]
@Vector:
      DD @@1
      DD @@2
      DD @@3
      DD @@4
@@4:
      ADD  EAX, [ECX+12+EDX]
      JO   @@Exit
@@3:
      ADD  EAX, [ECX+8+EDX]
      JO   @@Exit
@@2:
      ADD  EAX, [ECX+4+EDX]
      JO   @@Exit
@@1:
      ADD  EAX, [ECX+EDX]
      JO   @@Exit
      SUB  EDX,16
      JNS  @@4
@@Exit:
      POP  EBX
      JO   RaiseOverflowError
end;
{$ENDIF X86ASM}

function SUM(const Data: array of Single): Single;
{$IF not Defined(X86ASM) or Defined(PIC)}
var
  I: Integer;
  Rslt: Extended;
begin
  Rslt := 0.0;
  for I := Low(Data) to High(Data) do
    Rslt := Rslt + Data[I];
  Result := Rslt;
end;
{$ELSE X86ASM} // StackAlignSafe
asm  // IN: EAX = ptr to Data, EDX = High(Data) = Count - 1
     // Uses 4 accumulators to minimize read-after-write delays and loop overhead
     // 5 clocks per loop, 4 items per loop = 1.2 clocks per item
       FLDZ
       CMP      EDX, 0
       JL       @@Exit
       MOV      ECX, EDX
       FLD      ST(0)
       AND      EDX, not 3
       FLD      ST(0)
       AND      ECX, 3
       FLD      ST(0)
       SHL      EDX, 2      // count * sizeof(Double) = count * 4
       JMP      @Vector.Pointer[ECX*4]
@Vector:
       DD @@1
       DD @@2
       DD @@3
       DD @@4
@@4:   FADD     dword ptr [EAX+EDX+12]    // 1
       FXCH     ST(3)                     // 0
@@3:   FADD     dword ptr [EAX+EDX+8]    // 1
       FXCH     ST(2)                     // 0
@@2:   FADD     dword ptr [EAX+EDX+4]     // 1
       FXCH     ST(1)                     // 0
@@1:   FADD     dword ptr [EAX+EDX]       // 1
       FXCH     ST(2)                     // 0
       SUB      EDX, 16
       JNS      @@4
       FADDP    ST(3),ST                  // ST(3) := ST + ST(3); Pop ST
       FADD                               // ST(1) := ST + ST(1); Pop ST
       FADD                               // ST(1) := ST + ST(1); Pop ST
       FWAIT
@@Exit:
end;
{$ENDIF X86ASM}

function SUM(const Data: array of Double): Double;
{$IF not Defined(X86ASM) or Defined(PIC)}
var
  I: Integer;
  S: Double;
begin
  Result := 0.0;
  S := 0.0;
  for I := Low(Data) to High(Data) do
    KahanSumDouble(Result, S, Data[I]);
end;
{$ELSE X86ASM} // StackAlignSafe
asm  // IN: EAX = ptr to Data, EDX = High(Data) = Count - 1
     // Uses 4 accumulators to minimize read-after-write delays and loop overhead
     // 5 clocks per loop, 4 items per loop = 1.2 clocks per item
       FLDZ
       CMP      EDX, 0
       JL       @@Exit
       MOV      ECX, EDX
       FLD      ST(0)
       AND      EDX, not 3
       FLD      ST(0)
       AND      ECX, 3
       FLD      ST(0)
       SHL      EDX, 3      // count * sizeof(Double) = count * 8
       JMP      @Vector.Pointer[ECX*4]
@Vector:
       DD @@1
       DD @@2
       DD @@3
       DD @@4
@@4:   FADD     qword ptr [EAX+EDX+24]    // 1
       FXCH     ST(3)                     // 0
@@3:   FADD     qword ptr [EAX+EDX+16]    // 1
       FXCH     ST(2)                     // 0
@@2:   FADD     qword ptr [EAX+EDX+8]     // 1
       FXCH     ST(1)                     // 0
@@1:   FADD     qword ptr [EAX+EDX]       // 1
       FXCH     ST(2)                     // 0
       SUB      EDX, 32
       JNS      @@4
       FADDP    ST(3),ST                  // ST(3) := ST + ST(3); Pop ST
       FADD                               // ST(1) := ST + ST(1); Pop ST
       FADD                               // ST(1) := ST + ST(1); Pop ST
       FWAIT
@@Exit:
end;
{$ENDIF X86ASM}

function SUM(const Data: array of Extended): Extended;
{$IF not Defined(X86ASM) or Defined(PIC)}
var
  I: Integer;
  S: Extended;
begin
  Result := 0.0;
  S := 0.0;
  for I := Low(Data) to High(Data) do
    KahanSumExtended(Result, S, Data[I]);
end;
{$ELSE X86ASM} // StackAlignSafe
asm  // IN: EAX = ptr to Data, EDX = High(Data) = Count - 1
     // Uses 4 accumulators to minimize read-after-write delays and loop overhead
     // 5 clocks per loop, 4 items per loop = 1.2 clocks per item
       FLDZ
       CMP      EDX, 0
       JL       @@Exit
       MOV      ECX, EDX
       FLD      ST(0)
       AND      EDX, not 3
       FLD      ST(0)
       AND      ECX, 3
       FLD      ST(0)

       LEA      EDX, [EDX+EDX*4] // count * sizeof(Extended) = count * 10 = count * 8 + count * 2
       SHL      EDX, 1
       JMP      @Vector.Pointer[ECX*4]
@Vector:
       DD @@1
       DD @@2
       DD @@3
       DD @@4
@@4:   FLD      TBYTE PTR [EAX+EDX+30]
       FADDP    ST(4), ST(0)

@@3:   FLD      TBYTE PTR [EAX+EDX+20]
       FADDP    ST(3), ST(0)

@@2:   FLD      TBYTE PTR [EAX+EDX+10]
       FADDP    ST(2), ST(0)

@@1:   FLD      TBYTE PTR [EAX+EDX]
       FADDP    ST(1), ST(0)

       SUB      EDX, 40     // jump to the previous 4 numbers in the array
       JNS      @@4

       FADD                 // calculate ST(1) + ST(2) + ST(3) + ST(4)
       FADD
       FADD
       FWAIT
@@Exit:
end;
{$ENDIF X86ASM}


function SumOfSquares(const Data: array of Single): Single;
var
  I: Integer;
  Rslt: Extended;
begin
  Rslt := 0.0;
  for I := Low(Data) to High(Data) do
    Rslt := Rslt + Sqr(Data[I]);
  Result := Rslt;
end;

function SumOfSquares(const Data: array of Double): Double;
var
  I: Integer;
  S: Double;
begin
  Result := 0.0;
  S := 0.0;
  for I := Low(Data) to High(Data) do
    KahanSumDouble(Result, S, Sqr(Data[I]));
end;

function SumOfSquares(const Data: array of Extended): Extended;
var
  I: Integer;
  S: Extended;
begin
  Result := 0.0;
  S := 0.0;
  for I := Low(Data) to High(Data) do
    KahanSumExtended(Result, S, Sqr(Data[I]));
end;

procedure SumsAndSquares(const Data: array of Single; var Sum, SumOfSquares: Extended);
{$IF not Defined(X86ASM) or Defined(PIC)}
var
  I: Integer;
begin
  Sum := 0;
  SumOfSquares := 0;
  for I := Low(Data) to High(Data) do
  begin
    Sum := Sum + Data[I];
    SumOfSquares := SumOfSquares + Data[I]*Data[I];
  end;
end;
{$ELSE X86ASM} // StackAlignSafe
asm  // IN:  EAX = ptr to Data
     //      EDX = High(Data) = Count - 1
     //      ECX = ptr to Sum
     // Est. 17 clocks per loop, 4 items per loop = 4.5 clocks per data item
       FLDZ                 // init Sum accumulator
       FLD      ST(0)       // init Sqr1 accum.
       CMP      EDX, 0      // List of lengh 0, Return 0, 0
       JL       @@Exit
       PUSH     ECX
       MOV      ECX, EDX
       AND      EDX, not 3
       FLD      ST(0)       // init Sqr2 accum.
       AND      ECX, 3
       FLD      ST(0)       // init/simulate last data item left in ST
       SHL      EDX, 2      // count * sizeof(Single) = count * 4
       JMP      @Vector.Pointer[ECX*4]
@Vector:
       DD @@1
       DD @@2
       DD @@3
       DD @@4
@@4:   FADD                            // Sqr2 := Sqr2 + Sqr(Data4); Pop Data4
       FLD     dword ptr [EAX+EDX+12]  // Load Data1
       FADD    ST(3),ST                // Sum := Sum + Data1
       FMUL    ST,ST                   // Data1 := Sqr(Data1)
@@3:   FLD     dword ptr [EAX+EDX+8]  // Load Data2
       FADD    ST(4),ST                // Sum := Sum + Data2
       FMUL    ST,ST                   // Data2 := Sqr(Data2)
       FXCH                            // Move Sqr(Data1) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data1); Pop Data1
@@2:   FLD     dword ptr [EAX+EDX+4]   // Load Data3
       FADD    ST(4),ST                // Sum := Sum + Data3
       FMUL    ST,ST                   // Data3 := Sqr(Data3)
       FXCH                            // Move Sqr(Data2) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data2); Pop Data2
@@1:   FLD     dword ptr [EAX+EDX]     // Load Data4
       FADD    ST(4),ST                // Sum := Sum + Data4
       FMUL    ST,ST                   // Sqr(Data4)
       FXCH                            // Move Sqr(Data3) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data3); Pop Data3
       SUB     EDX,16
       JNS     @@4
       FADD                         // Sqr2 := Sqr2 + Sqr(Data4); Pop Data4
       POP     ECX
       FADD                         // Sqr1 := Sqr2 + Sqr1; Pop Sqr2
       FXCH                         // Move Sum1 into ST(0)
@@Exit:
       MOV     EAX, SumOfSquares
       FSTP    tbyte ptr [ECX]      // Sum := Sum1; Pop Sum1
       FSTP    tbyte ptr [EAX]      // SumOfSquares := Sum1; Pop Sum1
       FWAIT
end;
{$ENDIF X86ASM}

procedure SumsAndSquares(const Data: array of Double; var Sum, SumOfSquares: Extended);
{$IF not Defined(X86ASM) or Defined(PIC)}
var
  I: Integer;
  R1, R2: Extended;
begin
  Sum := 0; R1 := 0;
  SumOfSquares := 0; R2 := 0;
  for I := Low(Data) to High(Data) do
  begin
    KahanSumExtended(Sum, R1, Data[I]);
    KahanSumExtended(SumOfSquares, R2, sqr(Data[I]));
  end;
end;
{$ELSE X86ASM} // StackAlignSafe
asm  // IN:  EAX = ptr to Data
     //      EDX = High(Data) = Count - 1
     //      ECX = ptr to Sum
     // Est. 17 clocks per loop, 4 items per loop = 4.5 clocks per data item
       FLDZ                 // init Sum accumulator
       FLD      ST(0)       // init Sqr1 accum.
       CMP      EDX, 0      // List of lengh 0, Return 0, 0
       JL       @@Exit
       PUSH     ECX
       MOV      ECX, EDX
       AND      EDX, not 3
       FLD      ST(0)       // init Sqr2 accum.
       AND      ECX, 3
       FLD      ST(0)       // init/simulate last data item left in ST
       SHL      EDX, 3      // count * sizeof(Double) = count * 8
       JMP      @Vector.Pointer[ECX*4]
@Vector:
       DD @@1
       DD @@2
       DD @@3
       DD @@4
@@4:   FADD                            // Sqr2 := Sqr2 + Sqr(Data4); Pop Data4
       FLD     qword ptr [EAX+EDX+24]  // Load Data1
       FADD    ST(3),ST                // Sum := Sum + Data1
       FMUL    ST,ST                   // Data1 := Sqr(Data1)
@@3:   FLD     qword ptr [EAX+EDX+16]  // Load Data2
       FADD    ST(4),ST                // Sum := Sum + Data2
       FMUL    ST,ST                   // Data2 := Sqr(Data2)
       FXCH                            // Move Sqr(Data1) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data1); Pop Data1
@@2:   FLD     qword ptr [EAX+EDX+8]   // Load Data3
       FADD    ST(4),ST                // Sum := Sum + Data3
       FMUL    ST,ST                   // Data3 := Sqr(Data3)
       FXCH                            // Move Sqr(Data2) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data2); Pop Data2
@@1:   FLD     qword ptr [EAX+EDX]     // Load Data4
       FADD    ST(4),ST                // Sum := Sum + Data4
       FMUL    ST,ST                   // Sqr(Data4)
       FXCH                            // Move Sqr(Data3) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data3); Pop Data3
       SUB     EDX,32
       JNS     @@4
       FADD                         // Sqr2 := Sqr2 + Sqr(Data4); Pop Data4
       POP     ECX
       FADD                         // Sqr1 := Sqr2 + Sqr1; Pop Sqr2
       FXCH                         // Move Sum1 into ST(0)
@@Exit:
       MOV     EAX, SumOfSquares
       FSTP    tbyte ptr [ECX]      // Sum := Sum1; Pop Sum1
       FSTP    tbyte ptr [EAX]      // SumOfSquares := Sum1; Pop Sum1
       FWAIT
end;
{$ENDIF X86ASM}

procedure SumsAndSquares(const Data: array of Extended; var Sum, SumOfSquares: Extended);
{$IF not Defined(X86ASM) or Defined(PIC)}
var
  I: Integer;
  R1, R2: Extended;
begin
  Sum := 0; R1 := 0;
  SumOfSquares := 0; R2 := 0;
  for I := Low(Data) to High(Data) do
  begin
    KahanSumExtended(Sum, R1, Data[I]);
    KahanSumExtended(SumOfSquares, R2, sqr(Data[I]));
  end;
end;
{$ELSE X86ASM} // StackAlignSafe
asm  // IN:  EAX = ptr to Data
     //      EDX = High(Data) = Count - 1
     //      ECX = ptr to Sum
     // Est. 17 clocks per loop, 4 items per loop = 4.5 clocks per data item
       FLDZ                 // init Sum accumulator
       FLD      ST(0)       // init Sqr1 accum.
       CMP      EDX, 0      // List of lengh 0, Return 0, 0
       JL       @@Exit
       PUSH     ECX
       MOV      ECX, EDX
       AND      EDX, not 3
       FLD      ST(0)       // init Sqr2 accum.
       AND      ECX, 3
       FLD      ST(0)       // init/simulate last data item left in ST

       {$IF defined(EXTENDEDIS16BYTES)}
       LEA      EDX, [EDX*8] // count * sizeof(Extended) = count * 16 = count * 8 * 2
       SHL      EDX, 1
       {$ELSEIF defined(EXTENDEDIS12BYTES)}
       LEA      EDX, [EDX+EDX*2] // count * sizeof(Extended) = count * 12 = count * 3 * 4
       LEA      EDX, [EDX*4]
       {$ELSEIF defined(EXTENDEDIS10BYTES)}
       LEA      EDX, [EDX+EDX*4] // count * sizeof(Extended) = count * 10 = count * 8 + count * 2
       SHL      EDX, 1
       {$ELSE}
       IMUL     EDX, TYPE Extended // count * sizeof(Extended)
       {$ENDIF}

       JMP      @Vector.Pointer[ECX*4]
@Vector:
       DD @@1
       DD @@2
       DD @@3
       DD @@4
@@4:   FADD                            // Sqr2 := Sqr2 + Sqr(Data4); Pop Data4
       FLD     tbyte ptr [EAX+EDX+TYPE(Extended)*3]  // Load Data1
       FADD    ST(3),ST                // Sum := Sum + Data1
       FMUL    ST,ST                   // Data1 := Sqr(Data1)
@@3:   FLD     tbyte ptr [EAX+EDX+TYPE(Extended)*2]  // Load Data2
       FADD    ST(4),ST                // Sum := Sum + Data2
       FMUL    ST,ST                   // Data2 := Sqr(Data2)
       FXCH                            // Move Sqr(Data1) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data1); Pop Data1
@@2:   FLD     tbyte ptr [EAX+EDX+TYPE(Extended)]  // Load Data3
       FADD    ST(4),ST                // Sum := Sum + Data3
       FMUL    ST,ST                   // Data3 := Sqr(Data3)
       FXCH                            // Move Sqr(Data2) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data2); Pop Data2
@@1:   FLD     tbyte ptr [EAX+EDX]     // Load Data4
       FADD    ST(4),ST                // Sum := Sum + Data4
       FMUL    ST,ST                   // Sqr(Data4)
       FXCH                            // Move Sqr(Data3) into ST(0)
       FADDP   ST(3),ST                // Sqr1 := Sqr1 + Sqr(Data3); Pop Data3
       SUB     EDX,TYPE(Extended)*4
       JNS     @@4
       FADD                         // Sqr2 := Sqr2 + Sqr(Data4); Pop Data4
       POP     ECX
       FADD                         // Sqr1 := Sqr2 + Sqr1; Pop Sqr2
       FXCH                         // Move Sum1 into ST(0)
@@Exit:
       MOV     EAX, SumOfSquares
       FSTP    tbyte ptr [ECX]      // Sum := Sum1; Pop Sum1
       FSTP    tbyte ptr [EAX]      // SumOfSquares := Sum1; Pop Sum1
       FWAIT
end;
{$ENDIF X86ASM}

function TotalVariance(const Data: array of Single): Single;
var
  Mean,S: Extended;
  N: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Result := Data[0];
    Exit;
  end;
  MeanAndTotalVariance(Data, Mean, S);
  Result := S;
end;

function TotalVariance(const Data: array of Double): Double;
var
  Mean,S: Extended;
  N: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Result := Data[0];
    Exit;
  end;
  MeanAndTotalVariance(Data, Mean, S);
  Result := S;
end;

function TotalVariance(const Data: array of Extended): Extended;
var
  Mean,S: Extended;
  N: Integer;
begin
  N := High(Data)- Low(Data) + 1;
  if N = 1 then
  begin
    Result := Data[0];
    Exit;
  end;
  MeanAndTotalVariance(Data, Mean, S);
  Result := S;
end;

function Variance(const Data: array of Single): Single;
begin
  Result := TotalVariance(Data) / (High(Data) - Low(Data))
end;

function Variance(const Data: array of Double): Double;
begin
  Result := TotalVariance(Data) / (High(Data) - Low(Data))
end;

function Variance(const Data: array of Extended): Extended;
begin
  Result := TotalVariance(Data) / (High(Data) - Low(Data))
end;

{ Depreciation functions. }

function DoubleDecliningBalance(const Cost, Salvage: Extended; Life, Period: Integer): Extended;
{ dv := cost * (1 - 2/life)**(period - 1)
  DDB = (2/life) * dv
  if DDB > dv - salvage then DDB := dv - salvage
  if DDB < 0 then DDB := 0
}
var
  DepreciatedVal, Factor: Extended;
begin
  Result := 0;
  if (Period < 1) or (Life < Period) or (Life < 1) or (Cost <= Salvage) then
    Exit;

  {depreciate everything in period 1 if life is only one or two periods}
  if ( Life <= 2 ) then
  begin
    if ( Period = 1 ) then
      DoubleDecliningBalance:=Cost-Salvage
    else
      DoubleDecliningBalance:=0; {all depreciation occurred in first period}
    exit;
  end;
  Factor := 2.0 / Life;

  DepreciatedVal := Cost * IntPower((1.0 - Factor), Period - 1);
  {DepreciatedVal is Cost-(sum of previous depreciation results)}

  Result := Factor * DepreciatedVal;
  {Nominal computed depreciation for this period.  The rest of the
   function applies limits to this nominal value. }

  {Only depreciate until total depreciation equals cost-salvage.}
  if Result > DepreciatedVal - Salvage then
    Result := DepreciatedVal - Salvage;

  {No more depreciation after salvage value is reached.  This is mostly a nit.
   If Result is negative at this point, it's very close to zero.}
  if Result < 0.0 then
    Result := 0.0;
end;

function SLNDepreciation(const Cost, Salvage: Extended; Life: Integer): Extended;
{ Spreads depreciation linearly over life. }
begin
  if Life < 1 then ArgError('SLNDepreciation');
  Result := (Cost - Salvage) / Life
end;

function SYDDepreciation(const Cost, Salvage: Extended; Life, Period: Integer): Extended;
{ SYD = (cost - salvage) * (life - period + 1) / (life*(life + 1)/2) }
{ Note: life*(life+1)/2 = 1+2+3+...+life "sum of years"
        The depreciation factor varies from life/sum_of_years in first period = 1
                                       downto  1/sum_of_years in last period = life.
        Total depreciation over life is cost-salvage.}
var
  X1, X2: Extended;
begin
  Result := 0;
  if (Period < 1) or (Life < Period) or (Cost <= Salvage) then Exit;
  X1 := 2 * (Life - Period + 1);
  X2 := Life * (Life + 1);
  Result := (Cost - Salvage) * X1 / X2
end;

{ Discounted cash flow functions. }

function InternalRateOfReturn(const Guess: Extended; const CashFlows: array of Double): Extended;
{
Use Newton's method to solve NPV = 0, where NPV is a polynomial in
x = 1/(1+rate).  Split the coefficients into negative and postive sets:
  neg + pos = 0, so pos = -neg, so  -neg/pos = 1
Then solve:
  log(-neg/pos) = 0

  Let  t = log(1/(1+r) = -LnXP1(r)
  then r = exp(-t) - 1
Iterate on t, then use the last equation to compute r.
}
var
  T, Y: Extended;
  Poly: TPoly;
  K, Count: Integer;

  function ConditionP(const CashFlows: array of Double): Integer;
  { Guarantees existence and uniqueness of root.  The sign of payments
    must change exactly once, the net payout must be always > 0 for
    first portion, then each payment must be >= 0.
    Returns: 0 if condition not satisfied, > 0 if condition satisfied
    and this is the index of the first value considered a payback. }
  var
    X: Double;
    I, K: Integer;
  begin
    K := High(CashFlows);
    while (K >= 0) and (CashFlows[K] >= 0.0) do Dec(K);
    Inc(K);
    if K > 0 then
    begin
      X := 0.0;
      I := 0;
      while I < K do
      begin
        X := X + CashFlows[I];
        if X >= 0.0 then
        begin
          K := 0;
          Break;
        end;
        Inc(I)
      end
    end;
    ConditionP := K
  end;

begin
  InternalRateOfReturn := 0;
  K := ConditionP(CashFlows);
  if K < 0 then ArgError('InternalRateOfReturn');
  if K = 0 then
  begin
    if Guess <= -1.0 then ArgError('InternalRateOfReturn');
    T := -LnXP1(Guess)
  end else
    T := 0.0;
  for Count := 1 to MaxIterations do
  begin
    PolyX(CashFlows, Exp(T), Poly);
    if Poly.Pos <= Poly.Neg then ArgError('InternalRateOfReturn');
    if (Poly.Neg >= 0.0) or (Poly.Pos <= 0.0) then
    begin
      InternalRateOfReturn := -1.0;
      Exit;
    end;

    Y := Ln(-Poly.Neg/Poly.Pos) / (Poly.DNeg /Poly.Neg - Poly.DPos/Poly.Pos);
    T := T - Y;
    if RelSmall(Y, T) then
    begin
      InternalRateOfReturn := Exp(-T) - 1.0;
      Exit;
    end
  end;
  ArgError('InternalRateOfReturn');
end;

function NetPresentValue(const Rate: Extended; const CashFlows: array of Double;
  PaymentTime: TPaymentTime): Extended;
{ Caution: The sign of NPV is reversed from what would be expected for standard
   cash flows!}
var
  rr: Extended;
  I: Integer;
begin
  if Rate <= -1.0 then ArgError('NetPresentValue');
  rr := 1/(1+Rate);
  result := 0;
  for I := High(CashFlows) downto Low(CashFlows) do
    result := rr * result + CashFlows[I];
  if PaymentTime = TPaymentTime.ptEndOfPeriod then result := rr * result;
end;

{ Annuity functions. }

{---------------
From the point of view of A, amounts received by A are positive and
amounts disbursed by A are negative (e.g. a borrower's loan repayments
are regarded by the borrower as negative).

Given interest rate r, number of periods n:
  compound(r, n) = (1 + r)**n               "Compounding growth factor"
  annuity(r, n) = (compound(r, n)-1) / r   "Annuity growth factor"

Given future value fv, periodic payment pmt, present value pv and type
of payment (start, 1 , or end of period, 0) pmtTime, financial variables satisfy:

  fv = -pmt*(1 + r*pmtTime)*annuity(r, n) - pv*compound(r, n)

For fv, pv, pmt:

  C := compound(r, n)
  A := (1 + r*pmtTime)*annuity(r, n)
  Compute both at once in Annuity2.

  if C > 1E16 then A = C/r, so:
    fv := meaningless
    pv := -pmt*(pmtTime+1/r)
    pmt := -pv*r/(1 + r*pmtTime)
  else
    fv := -pmt(1+r*pmtTime)*A - pv*C
    pv := (-pmt(1+r*pmtTime)*A - fv)/C
    pmt := (-pv*C-fv)/((1+r*pmtTime)*A)
---------------}

function PaymentParts(Period, NPeriods: Integer; Rate, PresentValue,
  FutureValue: Extended; PaymentTime: TPaymentTime; var IntPmt: Extended):
  Extended;
var
  Crn:extended; { =Compound(Rate,NPeriods) }
  Crp:extended; { =Compound(Rate,Period-1) }
  Arn:extended; { =Annuity2(...) }

begin
  if Rate <= -1.0 then ArgError('PaymentParts');
  Crp:=Compound(Rate,Period-1);
  Arn:=Annuity2(Rate,NPeriods,PaymentTime,Crn);
  IntPmt:=(FutureValue*(Crp-1)-PresentValue*(Crn-Crp))/Arn;
  PaymentParts:=(-FutureValue-PresentValue)*Crp/Arn;
end;

function FutureValue(const Rate: Extended; NPeriods: Integer; const Payment,
  PresentValue: Extended; PaymentTime: TPaymentTime): Extended;
var
  Annuity, CompoundRN: Extended;
begin
  if Rate <= -1.0 then ArgError('FutureValue');
  Annuity := Annuity2(Rate, NPeriods, PaymentTime, CompoundRN);
  if CompoundRN > 1.0E16 then ArgError('FutureValue');
  FutureValue := -Payment * Annuity - PresentValue * CompoundRN
end;

function InterestPayment(const Rate: Extended; Period, NPeriods: Integer;
  const PresentValue, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;
var
  Crp:extended; { compound(rate,period-1)}
  Crn:extended; { compound(rate,nperiods)}
  Arn:extended; { annuityf(rate,nperiods)}
begin
  if (Rate <= -1.0)
    or (Period < 1) or (Period > NPeriods) then ArgError('InterestPayment');
  Crp:=Compound(Rate,Period-1);
  Arn:=Annuity2(Rate,Nperiods,PaymentTime,Crn);
  InterestPayment:=(FutureValue*(Crp-1)-PresentValue*(Crn-Crp))/Arn;
end;

function InterestRate(NPeriods: Integer; const Payment, PresentValue,
  FutureValue: Extended; PaymentTime: TPaymentTime): Extended;
{
Given:
  First and last payments are non-zero and of opposite signs.
  Number of periods N >= 2.
Convert data into cash flow of first, N-1 payments, last with
first < 0, payment > 0, last > 0.
Compute the IRR of this cash flow:
  0 = first + pmt*x + pmt*x**2 + ... + pmt*x**(N-1) + last*x**N
where x = 1/(1 + rate).
Substitute x = exp(t) and apply Newton's method to
  f(t) = log(pmt*x + ... + last*x**N) / -first
which has a unique root given the above hypotheses.
}
var
  X, Y, Z, First, Pmt, Last, T, ET, EnT, ET1: Extended;
  Count: Integer;
  Reverse: Boolean;

  function LostPrecision(X: Extended): Boolean;
  begin
    Result := ent = (ent+1);
  end;

begin
  Result := 0;
  if NPeriods <= 0 then ArgError('InterestRate');
  Pmt := Payment;
  if PaymentTime = TPaymentTime.ptEndOfPeriod then
  begin
    X := PresentValue;
    Y := FutureValue + Payment
  end
  else
  begin
    X := PresentValue + Payment;
    Y := FutureValue
  end;
  First := X;
  Last := Y;
  Reverse := False;
  if First * Payment > 0.0 then
  begin
    Reverse := True;
    T := First;
    First := Last;
    Last := T
  end;
  if first > 0.0 then
  begin
    First := -First;
    Pmt := -Pmt;
    Last := -Last
  end;
  if (First = 0.0) or (Last < 0.0) then ArgError('InterestRate');
  T := 0.0;                     { Guess at solution }
  for Count := 1 to MaxIterations do
  begin
    EnT := Exp(NPeriods * T);
    if LostPrecision(EnT) then
    begin
      Result := -Pmt / First;
      if Reverse then
        Result := Exp(-LnXP1(Result)) - 1.0;
      Exit;
    end;
    ET := Exp(T);
    ET1 := ET - 1.0;
    if ET1 = 0.0 then
    begin
      X := NPeriods;
      Y := X * (X - 1.0) / 2.0
    end
    else
    begin
      X := ET * (Exp((NPeriods - 1) * T)-1.0) / ET1;
      Y := (NPeriods * EnT - ET - X * ET) / ET1
    end;
    Z := Pmt * X + Last * EnT;
    Y := Ln(Z / -First) / ((Pmt * Y + Last * NPeriods *EnT) / Z);
    T := T - Y;
    if RelSmall(Y, T) then
    begin
      if not Reverse then T := -T;
      InterestRate := Exp(T)-1.0;
      Exit;
    end
  end;
  ArgError('InterestRate');
end;

function NumberOfPeriods(const Rate: Extended; Payment: Extended;
  const PresentValue, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;

{ If Rate = 0 then nper := -(pv + fv) / pmt
  else cf := pv + pmt * (1 + rate*pmtTime) / rate
       nper := LnXP1(-(pv + fv) / cf) / LnXP1(rate) }

var
  PVRPP: Extended; { =PV*Rate+Payment } {"initial cash flow"}
  T:     Extended;

begin

  if Rate <= -1.0 then ArgError('NumberOfPeriods');

{whenever both Payment and PaymentTime are given together, the PaymentTime has the effect
 of modifying the effective Payment by the interest accrued on the Payment}

  if ( PaymentTime=TPaymentTime.ptStartOfPeriod ) then
    Payment:=Payment*(1+Rate);

{if the payment exactly matches the interest accrued periodically on the
 presentvalue, then an infinite number of payments are going to be
 required to effect a change from presentvalue to futurevalue.  The
 following catches that specific error where payment is exactly equal,
 but opposite in sign to the interest on the present value.  If PVRPP
 ("initial cash flow") is simply close to zero, the computation will
 be numerically unstable, but not as likely to cause an error.}

  PVRPP:=PresentValue*Rate+Payment;
  if PVRPP=0 then ArgError('NumberOfPeriods');

  { 6.1E-5 approx= 2**-14 }
  if ( ABS(Rate)<6.1E-5 ) then
    Result:=-(PresentValue+FutureValue)/PVRPP
  else
  begin

{starting with the initial cash flow, each compounding period cash flow
 should result in the current value approaching the final value.  The
 following test combines a number of simultaneous conditions to ensure
 reasonableness of the cashflow before computing the NPER.}

    T:= -(PresentValue+FutureValue)*Rate/PVRPP;
    if  T<=-1.0  then ArgError('NumberOfPeriods');
    Result := LnXP1(T) / LnXP1(Rate)
  end;
  NumberOfPeriods:=Result;
end;

function Payment(Rate: Extended; NPeriods: Integer; const PresentValue,
  FutureValue: Extended; PaymentTime: TPaymentTime): Extended;
var
  Annuity, CompoundRN: Extended;
begin
  if Rate <= -1.0 then ArgError('Payment');
  Annuity := Annuity2(Rate, NPeriods, PaymentTime, CompoundRN);
  if CompoundRN > 1.0E16 then
    Payment := -PresentValue * Rate / (1 + Integer(PaymentTime) * Rate)
  else
    Payment := (-PresentValue * CompoundRN - FutureValue) / Annuity
end;

function PeriodPayment(const Rate: Extended; Period, NPeriods: Integer;
  const PresentValue, FutureValue: Extended; PaymentTime: TPaymentTime): Extended;
var
  Junk: Extended;
begin
  if (Rate <= -1.0) or (Period < 1) or (Period > NPeriods) then ArgError('PeriodPayment');
  PeriodPayment := PaymentParts(Period, NPeriods, Rate, PresentValue,
       FutureValue, PaymentTime, Junk);
end;

function PresentValue(const Rate: Extended; NPeriods: Integer; const Payment,
  FutureValue: Extended; PaymentTime: TPaymentTime): Extended;
var
  Annuity, CompoundRN: Extended;
begin
  if Rate <= -1.0 then ArgError('PresentValue');
  Annuity := Annuity2(Rate, NPeriods, PaymentTime, CompoundRN);
  if CompoundRN > 1.0E16 then
    PresentValue := -(Payment / Rate * Integer(PaymentTime) * Payment)
  else
    PresentValue := (-Payment * Annuity - FutureValue) / CompoundRN
end;

{$IFNDEF NEXTGEN}
function GetFPURoundMode: TFPURoundingMode;
begin
  Result := TFPURoundingMode((Get8087CW shr 10) and 3);
end;

function GetSSERoundMode: TSSERoundingMode;
begin
  Result := TSSERoundingMode((GetMXCSR shr 13) and 3);
end;
{$ENDIF !NEXTGEN}

{$IFDEF NEXTGEN}
function ToRoundingMode(const RawData: Int32): TRoundingMode;
begin
  case RawData of
    ferTONEAREST:  Result := TRoundingMode.rmNearest;
    ferUPWARD:     Result := TRoundingMode.rmUp;
    ferDOWNWARD:   Result := TRoundingMode.rmDown;
    ferTOWARDZERO: Result := TRoundingMode.rmTruncate;
  else
    Result := TRoundingMode.rmNearest;
  end;
end;
{$ENDIF NEXTGEN}

function GetRoundMode: TRoundingMode;
begin
{$IFDEF NEXTGEN}
  Result := ToRoundingMode(FGetRound);
{$ELSE !NEXTGEN}
{$IF Defined(CPUX86)}
  Result := GetFPURoundMode;
{$ELSEIF Defined(CPUX64)}
  Result := GetSSERoundMode;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}
{$ENDIF !NEXTGEN}
end;

{$IFNDEF NEXTGEN}
function SetFPURoundMode(const RoundMode: TFPURoundingMode): TFPURoundingMode;
var
  CtlWord: Word;
begin
  CtlWord := Get8087CW;
  Set8087CW((CtlWord and $F3FF) or (Ord(RoundMode) shl 10));
  Result := TFPURoundingMode((CtlWord shr 10) and 3);
end;

function SetSSERoundMode(const RoundMode: TSSERoundingMode): TSSERoundingMode;
var
  MXCSR: UInt32;
begin
  MXCSR := GetMXCSR;
  SetMXCSR((MXCSR and $FFFF9FFF) or (Word(RoundMode) shl 13));
  Result := TSSERoundingMode((MXCSR shr 13) and 3);
end;
{$ENDIF !NEXTGEN}

function SetRoundMode(const RoundMode: TRoundingMode): TRoundingMode;
{$IFDEF NEXTGEN}
var
  newRoundMode: Int32;
begin
  case RoundMode of
    TRoundingMode.rmNearest:  newRoundMode := ferTONEAREST;
    TRoundingMode.rmUp:       newRoundMode := ferUPWARD;
    TRoundingMode.rmDown:     newRoundMode := ferDOWNWARD;
    TRoundingMode.rmTruncate: newRoundMode := ferTOWARDZERO;
  else
    newRoundMode := ferTONEAREST;
  end;
  Result := ToRoundingMode(FSetRound(newRoundMode));
end;
{$ELSE !NEXTGEN}
{$IF Defined(CPUX86)}
begin
  Result := SetFPURoundMode(RoundMode);
end;
{$ELSEIF Defined(CPUX64)}
begin
  Result := SetSSERoundMode(RoundMode);
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
function GetPrecisionMode: TFPUPrecisionMode;
begin
  Result := TFPUPrecisionMode((Get8087CW shr 8) and 3);
end;

function SetPrecisionMode(const Precision: TFPUPrecisionMode): TFPUPrecisionMode;
var
  CtlWord: Word;
begin
  CtlWord := Get8087CW;
  Set8087CW((CtlWord and $FCFF) or (Ord(Precision) shl 8));
  Result := TFPUPrecisionMode((CtlWord shr 8) and 3);
end;

function GetFPUExceptionMask: TFPUExceptionMask;
begin
  Byte(Result) := Get8087CW and $3F;
end;

function GetSSEExceptionMask: TSSEExceptionMask;
begin
  Byte(Result) := (GetMXCSR shr 7) and $3F;
end;
{$ENDIF  NEXTGEN}

function GetExceptionMask: TArithmeticExceptionMask;
{$IF Defined(NEXTGEN)}
var
  M: UInt32;
begin
  Result := [];
  M := FGetExceptMask;
  if M and femInvalid <> 0 then    Result := Result + [TArithmeticException.exInvalidOp];
  if M and femDIVBYZERO <> 0 then
    Result := Result + [TArithmeticException.exZeroDivide];
  if M and femOVERFLOW <> 0 then
    Result := Result + [TArithmeticException.exOverflow];
  if M and femUNDERFLOW <> 0 then
    Result := Result + [TArithmeticException.exUnderflow];
  if M and femINEXACT <> 0 then
    Result := Result + [TArithmeticException.exPrecision];
{$IF     defined(CPUARM)}
  if M and femFLUSHTOZERO <> 0 then
    Result := Result + [TArithmeticException.exDenormalized];
{$ELSEIF defined(CPUX86)}
  if M and femDENORMALOPERAND <> 0 then
    Result := Result + [TArithmeticException.exDenormalized];
{$ENDIF}
end;
{$ELSEIF Defined(CPUX86)}
begin
  Result := GetFPUExceptionMask
end;
{$ELSEIF Defined(CPUX64)}
begin
  Result := GetSSEExceptionMask
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

{$IFNDEF NEXTGEN}
function SetFPUExceptionMask(const Mask: TFPUExceptionMask): TFPUExceptionMask;
var
  CtlWord: Word;
begin
  CtlWord := Get8087CW;
  Set8087CW( (CtlWord and $FFC0) or Byte(Mask) );
  Byte(Result) := CtlWord and $3F;
end;

function SetSSEExceptionMask(const Mask: TSSEExceptionMask): TSSEExceptionMask;
var
  MXCSR: Word;
begin
  MXCSR := GetMXCSR;
  SetMXCSR( (MXCSR and $FFFFE07F) or (Byte(Mask) shl 7) );
  Byte(Result) := (MXCSR shr 7) and $3F;
end;
{$ENDIF  NEXTGEN}

function SetExceptionMask(const Mask: TArithmeticExceptionMask): TArithmeticExceptionMask;
{$IF Defined(NEXTGEN)}
var
  MaskBits: UInt32;
begin
  Result := GetExceptionMask;
  MaskBits := 0;
  if TArithmeticException.exInvalidOp in Mask then
    MaskBits := MaskBits or femINVALID;
{$IF     defined(CPUARM)}
  if TArithmeticException.exDenormalized in Mask then
    MaskBits := MaskBits or femFLUSHTOZERO;
{$ELSEIF defined(CPUX86)}
  if TArithmeticException.exDenormalized in Mask then
    MaskBits := MaskBits or femDENORMALOPERAND;
{$ENDIF}
  if TArithmeticException.exZeroDivide in Mask then
    MaskBits := MaskBits or femDIVBYZERO;
  if TArithmeticException.exOverflow in Mask then
    MaskBits := MaskBits or femOVERFLOW;
  if TArithmeticException.exUnderflow in Mask then
    MaskBits := MaskBits or femUNDERFLOW;
  if TArithmeticException.exPrecision in Mask then
    MaskBits := MaskBits or femINEXACT;
  FSetExceptMask(MaskBits);
end;
{$ELSEIF Defined(CPUX86)}
begin
  Result := SetFPUExceptionMask(Mask);
end;
{$ELSEIF Defined(CPUX64)}
begin
  Result := SetSSEExceptionMask(Mask);
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

{$IFNDEF NEXTGEN}
procedure ClearFPUExceptions(RaisePending: Boolean);
{$IF Defined(CPUX86) or Defined(CPUX64)}
asm // StackAlignSafe
  cmp al, 0
  jz @@clear
  fwait
@@clear:
  fnclex
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

procedure ClearSSEExceptions(RaisePending: Boolean);
{$IF Defined(CPUX86) or Defined(CPUX64)}
var
  MXCSR: UInt32;
begin
  MXCSR := GetMXCSR;
  SetMXCSR(MXCSR and $FFFFFFC0);
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

{$ENDIF !NEXTGEN}

procedure ClearExceptions(RaisePending: Boolean; ExceptionFlags: TArithmeticExceptions);
{$IF Defined(NEXTGEN)}
var
  PendingExceptions: TArithmeticExceptions;
  excepts: Int32;
begin
  if ExceptionFlags <> [] then
  begin
    PendingExceptions := GetExceptions * ExceptionFlags;

    excepts := 0;
    if TArithmeticException.exInvalidOp in PendingExceptions then
      excepts := excepts + feeINVALID;
{$IFDEF CPUARM}
    if TArithmeticException.exDenormalized in PendingExceptions then
      excepts := excepts + feeFLUSHTOZERO;
{$ENDIF CPUARM}
{$IFDEF CPUX86}
    if TArithmeticException.exDenormalized in PendingExceptions then
      excepts := excepts + feeDENORMALOPERAND;
{$ENDIF CPUX86}
    if TArithmeticException.exZeroDivide in PendingExceptions then
      excepts := excepts + feeDIVBYZERO;
    if TArithmeticException.exOverflow in PendingExceptions then
      excepts := excepts + feeOVERFLOW;
    if TArithmeticException.exUnderflow in PendingExceptions then
      excepts := excepts + feeUNDERFLOW;
    if TArithmeticException.exPrecision in PendingExceptions then
      excepts := excepts + feeINEXACT;
    FSetExceptFlag(0, excepts);

    if RaisePending then
    begin
      if TArithmeticException.exInvalidOp in PendingExceptions then
        Error(reInvalidOp);
      if TArithmeticException.exDenormalized in PendingExceptions then
        Error(reUnderflow);
      if TArithmeticException.exZeroDivide in PendingExceptions then
        Error(reZeroDivide);
      if TArithmeticException.exOverflow in PendingExceptions then
        Error(reOverflow);
      if TArithmeticException.exUnderflow in PendingExceptions then
        Error(reUnderflow);
      if TArithmeticException.exPrecision in PendingExceptions then
        Error(reInvalidOp);
    end;
  end;
end;
{$ELSEIF Defined(CPUX86)}
begin
  ClearFPUExceptions(RaisePending);
end;
{$ELSEIF Defined(CPUX64)}
begin
  ClearSSEExceptions(RaisePending);
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

function GetExceptions: TArithmeticExceptions;
var
  Flags: UInt32;
begin
  Result := [];
  Flags := FGetExceptFlag;
  if Flags and feeINVALID <> 0 then Result := Result + [TArithmeticException.exInvalidOp];
  if Flags and feeDIVBYZERO <> 0 then Result := Result + [TArithmeticException.exZeroDivide];
  if Flags and feeOVERFLOW <> 0 then Result := Result + [TArithmeticException.exOverflow];
  if Flags and feeUNDERFLOW <> 0 then Result := Result + [TArithmeticException.exUnderflow];
{$IF Defined(CPUARM)}
  if Flags and feeFLUSHTOZERO <> 0 then Result := Result + [TArithmeticException.exDenormalized];
{$ELSEIF (Defined(CPUX86) or Defined(CPUX64)) and not Defined(LINUX)}
  if Flags and feeDENORMALOPERAND <> 0 then Result := Result + [TArithmeticException.exDenormalized];
{$ENDIF !Defined(CPUARM) and !Defined(CPUX86) and !Defined(CPUX64)}
  if Flags and feeINEXACT <> 0 then Result := Result + [TArithmeticException.exPrecision];
end;

function SetExceptions(const Exceptions: TArithmeticExceptions): TArithmeticExceptions;
var
  Flags: Cardinal;
begin
  Flags := 0;
  Result := GetExceptions;
  if exInvalidOp in Exceptions then Flags := Flags + feeINVALID;
  if exZeroDivide in Exceptions then Flags := Flags + feeDIVBYZERO;
  if exOverflow in Exceptions then Flags := Flags + feeOVERFLOW;
  if exUnderflow in Exceptions then Flags := Flags + feeUNDERFLOW;
{$IF Defined(CPUARM)}
  if exDenormalized in Exceptions then Flags := Flags + feeFLUSHTOZERO;
{$ELSEIF (Defined(CPUX86) or Defined(CPUX64)) and not Defined(LINUX)}
  if exDenormalized in Exceptions then Flags := Flags + feeDENORMALOPERAND;
{$ENDIF !Defined(CPUARM) and !Defined(CPUX86) and !Defined(CPUX64)}
  if exPrecision in Exceptions then Flags := Flags + feeINEXACT;
  FSetExceptFlag(Flags)
end;

procedure RaiseExceptions(const ExceptionFlags: TArithmeticExceptions);
begin
  ClearExceptions(True, ExceptionFlags);
end;

{$IFNDEF NEXTGEN}
function GetSSEType: Cardinal;
{$IF Defined(CPUX64)}
asm
      PUSH      RBX
      MOV       EAX, 1
      CPUID
      MOV       EAX, seSSE + seSSE2

      TEST      ECX, $00000001  // ECX 0 bits - SSE3 bit
      JZ        @@CheckSSSE3
      OR        EAX, seSSE3
@@CheckSSSE3:
      TEST      ECX, $00000200  // ECX 9 bits - SSSE3 bit
      JZ        @@CheckSSE41
      OR        EAX, seSSSE3
@@CheckSSE41:
      TEST      ECX, $00080000  // ECX 19 bits - SSSE4.1 bit
      JZ        @@CheckSSE42
      OR        EAX, seSSE41
@@CheckSSE42:
      TEST      ECX, $00100000  // ECX 20 bits - SSSE4.2 bit
      JZ        @@CheckPOPCNT
      OR        EAX, seSSE42
@@CheckPOPCNT:
      TEST      ECX, $00800000  // ECX 23 bits - POPCNT bit
      JZ        @@CheckAESNI
      OR        EAX, sePOPCNT
@@CheckAESNI:
      TEST      ECX, $02000000  // ECX 25 bits - AESNI bit
      JZ        @@CheckPCLMULQDQ
      OR        EAX, sePOPCNT
@@CheckPCLMULQDQ:
      TEST      ECX, $00000002  // ECX 1 bits - PCLMULQDQ bit
      JZ        @@Exit
      OR        EAX, sePCLMULQDQ
@@Exit:
      POP       RBX
end;
{$ELSEIF Defined(CPUX86)}
asm
        PUSH    EBX
        MOV     EAX, 1
        CPUID
        XOR     EAX, EAX
        TEST    EDX, $02000000  // EDX 25 bits - SSE bit
        JZ      @@CheckSSE2
        OR      EAX, seSSE
@@CheckSSE2:
        TEST    EDX, $04000000  // EDX 26 bits - SSE2 bit
        JZ      @@CheckSSE3
        OR      EAX, seSSE2
@@CheckSSE3:
        TEST    ECX, $00000001  // ECX 0 bits - SSE3 bit
        JZ      @@CheckSSSE3
        OR      EAX, seSSE3
@@CheckSSSE3:
        TEST    ECX, $00000200  // ECX 9 bits - SSSE3 bit
        JZ      @@CheckSSE41
        OR      EAX, seSSSE3
@@CheckSSE41:
        TEST    ECX, $00080000  // ECX 19 bits - SSSE4.1 bit
        JZ      @@CheckSSE42
        OR      EAX, seSSE41
@@CheckSSE42:
        TEST    ECX, $00100000  // ECX 20 bits - SSSE4.2 bit
        JZ      @@CheckPOPCNT
        OR      EAX, seSSE42
@@CheckPOPCNT:
        TEST    ECX, $00800000  // ECX 23 bits - POPCNT bit
        JZ      @@CheckAESNI
        OR      EAX, sePOPCNT
@@CheckAESNI:
        TEST    ECX, $02000000  // ECX 25 bits - AESNI bit
        JZ      @@CheckPCLMULQDQ
        OR      EAX, sePOPCNT
@@CheckPCLMULQDQ:
        TEST    ECX, $00000002  // ECX 1 bits - PCLMULQDQ bit
        JZ      @@Exit
        OR      EAX, sePCLMULQDQ
@@Exit:
        POP     EBX
end;
{$ELSE OTHERCPU}
  {$MESSAGE Fatal 'Method not implemented for CPU'}
{$ENDIF OTHERCPU}

procedure InitSSEType;
begin
  if TestSSE <> 0 then
    TestSSE := GetSSEType;
end;
{$ENDIF  NEXTGEN}

{$IFNDEF NEXTGEN}
initialization
  InitSSEType;
{$ENDIF  NEXTGEN}
end.
