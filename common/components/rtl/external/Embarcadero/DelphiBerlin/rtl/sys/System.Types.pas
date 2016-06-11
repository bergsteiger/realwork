{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Types;

interface
{$HPPEMIT LEGACYHPP}

{$IF ( defined(IOS) and not defined(CPUARM) and defined(EXTERNALLINKER))}
  {$DEFINE PUREPASCAL}
{$ENDIF}

type
  PLongInt = System.PLongInt;
  {$EXTERNALSYM PLongInt}
  PInteger = System.PInteger;
  {$EXTERNALSYM PInteger}
  PSmallInt = System.PSmallInt;
  {$EXTERNALSYM PSmallInt}
  PDouble = System.PDouble;
  {$EXTERNALSYM PDouble}
  PByte = System.PByte;
  {$EXTERNALSYM PByte}

  TIntegerDynArray      = array of Integer;
  {$EXTERNALSYM TIntegerDynArray 'System::TIntegerDynArray'}
  TCardinalDynArray     = array of Cardinal;
  {$EXTERNALSYM TCardinalDynArray 'System::TCardinalDynArray'}
  TWordDynArray         = array of Word;
  {$EXTERNALSYM TWordDynArray 'System::TWordDynArray'}
  TSmallIntDynArray     = array of SmallInt;
  {$EXTERNALSYM TSmallIntDynArray 'System::TSmallIntDynArray'}
  TByteDynArray         = array of Byte;
  {$EXTERNALSYM TByteDynArray 'System::TByteDynArray'}
  TShortIntDynArray     = array of ShortInt;
  {$EXTERNALSYM TShortIntDynArray 'System::TShortIntDynArray'}
  TInt64DynArray        = array of Int64;
  {$EXTERNALSYM TInt64DynArray 'System::TInt64DynArray'}
  TLongWordDynArray     = array of LongWord;
  {$EXTERNALSYM TLongWordDynArray 'System::TLongWordDynArray'}
  TSingleDynArray       = array of Single;
  {$EXTERNALSYM TSingleDynArray 'System::TSingleDynArray'}
  TDoubleDynArray       = array of Double;
  {$EXTERNALSYM TDoubleDynArray 'System::TDoubleDynArray'}
  TBooleanDynArray      = array of Boolean;
  {$EXTERNALSYM TBooleanDynArray 'System::TBooleanDynArray'}
  TStringDynArray       = array of string;
  {$EXTERNALSYM TStringDynArray 'System::TStringDynArray'}
{$IFNDEF NEXTGEN}
  TWideStringDynArray   = array of WideString;
  {$EXTERNALSYM TWideStringDynArray 'System::TWideStringDynArray'}
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
  OleStr = WideString;
{$ELSE NEXTGEN}
  OleStr = UnicodeString;
{$ENDIF NEXTGEN}

{ Endianness management }

  TEndian = (Big, Little);
const
  PlatformEndian = TEndian.Little;

{ Duplicate management }
type
  TDuplicates = (dupIgnore, dupAccept, dupError);
  TDirection = (FromBeginning, FromEnd);

  {$NODEFINE TSize}
  {$NODEFINE PSize}

  PSize = ^TSize;
  TSize = record
    cx: FixedInt;
    cy: FixedInt;
  public
    constructor Create(P : TSize); overload;
    constructor Create(const X, Y : Integer); overload;
    // operator overloads
    class operator Equal(const Lhs, Rhs : TSize) : Boolean;
    class operator NotEqual(const Lhs, Rhs : TSize): Boolean;
    class operator Add(const Lhs, Rhs : TSize): TSize;
    class operator Subtract(const Lhs, Rhs : TSize): TSize;

    // methods
    function Add(const Point: TSize): TSize;
    function Distance(const P2 : TSize) : Double;
    function IsZero : Boolean;
    function Subtract(const Point: TSize): TSize;

    // properties
    property Width: Integer read cx write cx;
    property Height: Integer read cy write cy;
  end;

  {$EXTERNALSYM tagSIZE}
  SIZE = TSize;
  tagSize = TSize;
  {$EXTERNALSYM SIZE}

  {$NODEFINE TSmallPoint}
  {$NODEFINE PSmallPoint}

  PSmallPoint = ^TSmallPoint;
  TSmallPoint = record
    x: SmallInt;
    y: SmallInt;
  public
    constructor Create(P : TSmallPoint); overload;
    constructor Create(const X, Y : Word); overload;
    constructor Create(const X, Y : SmallInt); overload;

    // operator overloads
    class operator Equal(const Lhs, Rhs : TSmallPoint) : Boolean;
    class operator NotEqual(const Lhs, Rhs : TSmallPoint): Boolean;
    class operator Add(const Lhs, Rhs : TSmallPoint): TSmallPoint;
    class operator Subtract(const Lhs, Rhs : TSmallPoint): TSmallPoint;

    // methods
    function Add(const Point: TSmallPoint): TSmallPoint;
    function Distance(const P2 : TSmallPoint) : Double;
    function IsZero : Boolean;
    function Subtract(const Point: TSmallPoint): TSmallPoint;
  end;

  PPoint = ^TPoint;
  TPoint = record
    X: FixedInt;
    Y: FixedInt;
  public
    constructor Create(P : TPoint); overload;
    constructor Create(const X, Y : Integer); overload;

    //operator overloads
    class operator Equal(const Lhs, Rhs : TPoint) : Boolean;
    class operator NotEqual(const Lhs, Rhs : TPoint): Boolean;
    class operator Add(const Lhs, Rhs : TPoint): TPoint;
    class operator Subtract(const Lhs, Rhs : TPoint): TPoint;

    class operator Implicit(Value: TSmallPoint): TPoint;
    class operator Explicit(Value: TPoint): TSmallPoint;

    class function PointInCircle(const Point, Center: TPoint; const Radius: Integer): Boolean; static; inline;
    /// <summary> Zero point having values of (0, 0). </summary>
    class function Zero: TPoint; inline; static;

    function Distance(const P2 : TPoint) : Double;

    procedure SetLocation(const X, Y : Integer); overload;
    procedure SetLocation(const P : TPoint); overload;
    procedure Offset(const DX, DY : Integer); overload;
    procedure Offset(const Point: TPoint); overload;
    function Add(const Point: TPoint): TPoint;
    function Subtract(const Point: TPoint): TPoint;
    function IsZero : Boolean;

    function Angle(const APoint: TPoint): Single;
  end;

  {$NODEFINE TPoint}
  tagPOINT = TPoint;
  {$NODEFINE tagPOINT}

type
  TSplitRectType = (
    srLeft,
    srRight,
    srTop,
    srBottom
  );

  {$SCOPEDENUMS ON}
  THorzRectAlign = (Center, Left, Right);
  TVertRectAlign = (Center, Top, Bottom);
  {$SCOPEDENUMS OFF}

  PRect = ^TRect;
  TRect = record
  private
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    function GetSize: TSize;
    procedure SetSize(const Value: TSize);
    function GetLocation: TPoint;
  public
    constructor Create(const Origin: TPoint); overload;                              // empty rect at given origin
    constructor Create(const Origin: TPoint; Width, Height: Integer); overload;      // at TPoint of origin with width and height
    constructor Create(const Left, Top, Right, Bottom: Integer); overload;           // at x, y with width and height
    constructor Create(const P1, P2: TPoint; Normalize: Boolean = False); overload;  // with corners specified by p1 and p2
    constructor Create(const R: TRect; Normalize: Boolean = False); overload;

    // operator overloads
    class operator Equal(const Lhs, Rhs: TRect): Boolean;
    class operator NotEqual(const Lhs, Rhs: TRect): Boolean;

    // union of two rectangles
    class operator Add(const Lhs, Rhs: TRect): TRect;

    // intersection of two rectangles
    class operator Multiply(const Lhs, Rhs: TRect): TRect;

    class function Empty: TRect; inline; static;

    //utility methods
    //makes sure TopLeft is above and to the left of BottomRight
    procedure NormalizeRect;

    //returns true if left = right or top = bottom
    function IsEmpty: Boolean;

    //returns true if the point is inside the rect
    function Contains(const Pt: TPoint): Boolean; overload;

    // returns true if the rect encloses R completely
    function Contains(const R: TRect): Boolean; overload;

    // returns true if any part of the rect covers R
    function IntersectsWith(const R: TRect): Boolean;

    // computes an intersection of R1 and R2
    class function Intersect(const R1: TRect; const R2: TRect): TRect; overload; static;

    // replaces current rectangle with its intersection with R
    procedure Intersect(const R: TRect); overload;

    // computes a union of R1 and R2
    class function Union(const R1: TRect; const R2: TRect): TRect; overload; static;

    // replaces current rectangle with its union with R
    procedure Union(const R: TRect); overload;

    // creates a minimal rectangle that contains all points from array Points
    class function Union(const Points: Array of TPoint): TRect; overload; static;

    // offsets the rectangle origin relative to current position
    procedure Offset(const DX, DY: Integer); overload;
    procedure Offset(const Point: TPoint); overload;

    // sets new origin
    procedure SetLocation(const X, Y: Integer); overload;
    procedure SetLocation(const Point: TPoint); overload;

    // inflate by DX and DY
    procedure Inflate(const DX, DY: Integer); overload;

    // inflate in all directions
    procedure Inflate(const DL, DT, DR, DB: Integer); overload;

    //returns the center point of the rectangle;
    function CenterPoint: TPoint;

    function SplitRect(SplitType: TSplitRectType; Size: Integer): TRect; overload;
    function SplitRect(SplitType: TSplitRectType; Percent: Double): TRect; overload;

    // changing the width is always relative to Left;
    property Width: Integer read GetWidth write SetWidth;
    // changing the Height is always relative to Top
    property Height: Integer read GetHeight write SetHeight;

    property Size: TSize read GetSize write SetSize;

    property Location: TPoint read GetLocation write SetLocation;

  case Integer of
    0: (Left, Top, Right, Bottom: FixedInt);
    1: (TopLeft, BottomRight: TPoint);
  end;
  {$NODEFINE TRect}

  TPointFType = array [0..1] of Single;

  PPointF = ^TPointF;
  TPointF = record
    class function Create(const AX, AY: Single): TPointF; overload; static; inline;
    class function Create(const APoint: TPoint): TPointF; overload; static; inline;

    class operator Add(const APoint1, APoint2: TPointF): TPointF;
    class operator Subtract(const APoint1, APoint2: TPointF): TPointF;
    class operator Equal(const APoint1, APoint2: TPointF): Boolean;
    class operator NotEqual(const APoint1, APoint2: TPointF): Boolean;
    class operator Implicit(const APoint: TPoint): TPointF;
    class operator Negative(const APoint: TPointF): TPointF;
    class operator Multiply(const APoint1, APoint2: TPointF): TPointF;
    class operator Multiply(const APoint: TPointF; const AFactor: Single): TPointF;
    class operator Multiply(const AFactor: Single; const APoint: TPointF): TPointF;
    class operator Divide(const APoint: TPointF; const AFactor: Single): TPointF;

    class function PointInCircle(const Point, Center: TPointF; const Radius: Integer): Boolean; static; inline;
    /// <summary> Zero point having values of (0, 0). </summary>
    class function Zero: TPointF; inline; static;

    function Distance(const APoint: TPointF): Single;
    // 3D cross-product with Z = 0
    function CrossProduct(const APoint: TPointF): Single;
    function DotProduct(const APoint: TPointF): Single; inline;

    procedure Offset(const APoint: TPointF); overload; inline;
    procedure Offset(const ADeltaX, ADeltaY: Single); overload; inline;
    procedure Offset(const APoint: TPoint); overload; inline;

    procedure SetLocation(const X, Y: Single); overload; deprecated 'Use ":=" assignment instead';
    procedure SetLocation(const P: TPointF); overload; deprecated 'Use ":=" assignment instead';
    procedure SetLocation(const P: TPoint); overload; deprecated 'Use ":=" assignment instead';
    function Subtract(const Point: TPointF): TPointF; overload; deprecated 'Use TPointF.Offset instead';
    function Subtract(const Point: TPoint): TPointF; overload; deprecated 'Use TPointF.Offset instead';
    function Add(const Point: TPointF): TPointF; overload; deprecated 'Use TPointF.Offset instead';
    function Add(const Point: TPoint): TPointF; overload; deprecated 'Use TPointF.Offset instead';
    function Scale(const AFactor: Single): TPointF; deprecated;
    function EqualsTo(const Point: TPointF; const Epsilon: Single = 0): Boolean;

    function IsZero: Boolean;
    function Ceiling: TPoint;
    function Truncate: TPoint;
    function Round: TPoint;
    /// <summary> Rounds the current point to the specified scale value
    /// <param name="AScale"> The scale of scene </param>
    /// <param name="APlaceBetweenPixels"> If <c>True</c> (by default) the resulting point moves to half scale </param>
    /// </summary>
    /// <returns> The current point after transformation </returns>
    function SnapToPixel(const AScale: Single; const APlaceBetweenPixels: Boolean = True): TPointF;

    function Normalize: TPointF;
    function Length: Single;
    function Rotate(const AAngle: Single): TPointF;
    function Reflect(const APoint: TPointF): TPointF; inline;
    function MidPoint(const APoint: TPointF): TPointF; inline;
    function AngleCosine(const APoint: TPointF): Single;
    function Angle(const APoint: TPointF): Single;

    case Integer of
      0: (V: TPointFType;);
      1: (X: Single;
          Y: Single;);
  end;

  {$NODEFINE TPointF}
  tagPOINTF = TPointF;
  {$NODEFINE tagPOINTF}

  PSizeF = ^TSizeF;
  TSizeF = record
    cx: Single;
    cy: Single;
  public
    constructor Create(P: TSizeF); overload;
    constructor Create(const X, Y: Single); overload;
    // operator overloads
    class operator Equal(const Lhs, Rhs: TSizeF): Boolean;
    class operator NotEqual(const Lhs, Rhs: TSizeF): Boolean;
    class operator Add(const Lhs, Rhs: TSizeF): TSizeF;
    class operator Subtract(const Lhs, Rhs: TSizeF): TSizeF;

    class operator Implicit(const Size: TSizeF): TPointF;
    class operator Implicit(const Point: TPointF): TSizeF;
    class operator Implicit(const Size: TSize): TSizeF;

    function Ceiling: TSize;
    function Truncate: TSize;
    function Round: TSize;

    // metods
    function Add(const Point: TSizeF): TSizeF;
    function Subtract(const Point: TSizeF): TSizeF;
    function Distance(const P2: TSizeF): Double;
    function IsZero: Boolean;
    // properties
    property Width: Single read cx write cx;
    property Height: Single read cy write cy;
  end;

  PRectF = ^TRectF;
  TRectF = record
  private
    function GetWidth: Single;
    procedure SetWidth(const Value: Single);
    function GetHeight: Single;
    procedure SetHeight(const Value: Single);
    function GetSize: TSizeF;
    procedure SetSize(const Value: TSizeF);
    function GetLocation: TPointF;
  public
    constructor Create(const Origin: TPointF); overload;                               // empty rect at given origin
    constructor Create(const Origin: TPointF; const Width, Height: Single); overload; // at TPoint of origin with width and height
    constructor Create(const Left, Top, Right, Bottom: Single); overload;              // at x, y with width and height
    constructor Create(const P1, P2: TPointF; Normalize: Boolean = False); overload;  // with corners specified by p1 and p2
    constructor Create(const R: TRectF; Normalize: Boolean = False); overload;
    constructor Create(const R: TRect; Normalize: Boolean = False); overload;

    // operator overloads
    class operator Equal(const Lhs, Rhs: TRectF): Boolean;
    class operator NotEqual(const Lhs, Rhs: TRectF): Boolean;
    class operator Implicit(const Source: TRect): TRectF;
    class operator Explicit(const Source: TRectF): TRect;

    // union of two rectangles
    class operator Add(const Lhs, Rhs: TRectF): TRectF;

    // intersection of two rectangles
    class operator Multiply(const Lhs, Rhs: TRectF): TRectF;

    class function Empty: TRectF; inline; static;

    { This method is to be deprecated. It stretches current rectangle into designated area similarly to FitInto,
      but only when current rectangle is bigger than the area; otherwise, it only centers it. }
    function Fit(const BoundsRect: TRectF): Single; // deprecated 'Please consider using FitInto instead.';

    { Stretches current rectangle into the designated area, preserving aspect ratio. Note that unlike Fit, when designated
      area is bigger than current rectangle, the last one will be stretched to fill designated area (while Fit would only
      center it). }
    function FitInto(const ADesignatedArea: TRectF; out Ratio: Single): TRectF; overload;
    function FitInto(const ADesignatedArea: TRectF): TRectF; overload;

    /// <summary> Places the rectangle at center of designated area without scaling </summary>
    function CenterAt(const ADesignatedArea: TRectF): TRectF;

    /// <summary> This method places the rectangle inside the designated area. If the rectangle is greater
    /// than the designated area then the source rectangle is scaled with aspect ratio.
    /// </summary>
    /// <param name="ADesignatedArea"> The place in which the current rectangle will be placed </param>
    /// <param name="AHorzAlign"> The horizontal arrangement, if the width of the rectangle is smaller than the width
    /// of the designated area. The <b>Center</b> by default </param>
    /// <param name="AVertAlign"> The vertical arrangement, if the height of the rectangle is smaller than the height
    /// of the designated area. The <b>Center</b> by default </param>
    /// <returns> The current rectangle after transformation </returns>
    function PlaceInto(const ADesignatedArea: TRectF; const AHorzAlign: THorzRectAlign = THorzRectAlign.Center;
      const AVertAlign: TVertRectAlign = TVertRectAlign.Center): TRectF;

    /// <summary> Rounds the location and size of the current rectangle to the specified value
    /// <param name="AScale"> The scale of scene </param>
    /// <param name="APlaceBetweenPixels"> If <c>True</c> (by default) the resulting rectangle moves to half scale </param>
    /// </summary>
    /// <returns> The current rectangle after transformation </returns>
    function SnapToPixel(const AScale: Single; const APlaceBetweenPixels: Boolean = True): TRectF;

    //makes sure TopLeft is above and to the left of BottomRight
    procedure NormalizeRect;

    //returns true if left = right or top = bottom
    function IsEmpty: Boolean;

    //returns true if the point is inside the rect
    function Contains(const Pt: TPointF): Boolean; overload;

    // returns true if the rect encloses R completely
    function Contains(const R: TRectF): Boolean; overload;

    // returns true if any part of the rect covers R
    function IntersectsWith(const R: TRectF): Boolean;

    // computes an intersection of R1 and R2
    class function Intersect(const R1: TRectF; const R2: TRectF): TRectF; overload; static;

    // replaces current rectangle with its intersection with R
    procedure Intersect(const R: TRectF); overload;

    // computes a union of R1 and R2
    class function Union(const R1: TRectF; const R2: TRectF): TRectF; overload; static;

    // replaces current rectangle with its union with R
    procedure Union(const R: TRectF); overload;

    // creates a minimal rectangle that contains all points from array Points
    class function Union(const Points: Array of TPointF): TRectF; overload; static;

    // offsets the rectangle origin relative to current position
    procedure Offset(const DX, DY: Single); overload;
    procedure Offset(const Point: TPointF); overload;

    // sets new origin
    procedure SetLocation(const X, Y: Single); overload;
    procedure SetLocation(const Point: TPointF); overload;

    // inflate by DX and DY
    procedure Inflate(const DX, DY: Single); overload;

    // inflate in all directions
    procedure Inflate(const DL, DT, DR, DB: Single); overload;

    //returns the center point of the rectangle;
    function CenterPoint: TPointF;

    function Ceiling: TRect;
    function Truncate: TRect;
    function Round: TRect;

    function EqualsTo(const R: TRectF; const Epsilon: Single = 0): Boolean; 

    {
    function SplitRect(SplitType: TSplitRectType; Size: Integer): TRect; overload;
    function SplitRect(SplitType: TSplitRectType; Percent: Double): TRect; overload;
    }

    // changing the width is always relative to Left;
    property Width: Single read GetWidth write SetWidth;
    // changing the Height is always relative to Top
    property Height: Single read GetHeight write SetHeight;

    property Size: TSizeF read GetSize write SetSize;

    property Location: TPointF read GetLocation write SetLocation;

  case Integer of
    0: (Left, Top, Right, Bottom: Single);
    1: (TopLeft, BottomRight: TPointF);
  end;
  {$NODEFINE TPointF}
  {$NODEFINE TRectF}
  {$NODEFINE TSizeF}
 
  (*$HPPEMIT     '#include <SystemTypes.h>'*)
  (*$HPPEMIT END '#define  SYSTEM_TYPES_AT_END /* Round #2 */'*)
  (*$HPPEMIT END '#include <SystemTypes.h>'*)


  /// <summary> TBitConverter class implements converter of an array of bytes
  ///  into Delphi native data types and backward. </summary>
  TBitConverter = class
  protected 
    /// <summary> RangeCheckError is a helper used to raise a range check exception
    ///  if a conversion (From or Into) accesses memory outside the bounds of the 
    ///  Byte array.
    ///  NOTE: Only used by C++; Delphi calls System.Error(reRangeError) directly.</summary>
    class procedure RangeCheckError; static;
  public
    /// <summary> UnsafeFrom method converts Value of T type into array of bytes B.
    ///  The value will be written into B at Offset offset. The method does not check
    ///  that value will fit into B at Offset. </summary>
    class procedure UnsafeFrom<T>(const Value: T; var B: TArray<Byte>; Offset: Integer = 0); static; inline;
    /// <summary> From method converts Value of T type into array of bytes B.
    ///  The value will be written into B at Offset offset. The method checks that
    ///  value will fit into B at Offset. If not, then range check exception is raised. </summary>
    class procedure From<T>(const Value: T; var B: TArray<Byte>; Offset: Integer = 0); static;
    /// <summary> UnsafeInTo method converts array of bytes B into value of T type.
    ///  The value will be read from B at Offset offset. The method does not check
    ///  that value fits into B at Offset. </summary>
    class function UnsafeInTo<T>(const B: TArray<Byte>; Offset: Integer = 0): T; static; inline;
    /// <summary> InTo method converts array of bytes B into value of T type.
    ///  The value will be read from B at Offset offset. The method checks that
    ///  value fits into B at Offset. If not, then range check exception is raised. </summary>
    class function InTo<T>(const B: TArray<Byte>; Offset: Integer = 0): T; static;
  end;

  DWORD = FixedUInt;
  {$EXTERNALSYM DWORD}
const
  RT_RCDATA       = PChar(10);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM RT_RCDATA}
{$ENDIF}  

  NullChar = #0;
  Tabulator = #9;
  Space = #32;
  CarriageReturn = #$D;
  LineFeed = #$A;
  VerticalTab = #$B;
  FormFeed = #$C;
  LineSeparator = #$2028;
  ParagraphSeparator = #$2029;

  BOM_LSB_FIRST = #$FEFF;
  BOM_MSB_FIRST = #$FFFE;

  GUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';

  cPI: Single = 3.141592654;
  {$EXTERNALSYM cPI}  // Moved out of HPP - PCH does not support float constants
  {$HPPEMIT 'extern const System::Single cPI /*= 3.141592654*/;'}
  cPIdiv180: Single = 0.017453292;
  {$EXTERNALSYM cPIdiv180}
  {$HPPEMIT 'extern const System::Single cPIdiv180 /*= 0.017453292*/;'}
  c180divPI: Single = 57.29577951;
  {$EXTERNALSYM c180divPI}
  {$HPPEMIT 'extern const System::Single c180divPI /*= 57.29577951*/;'}
  c2PI: Single = 6.283185307;
  {$EXTERNALSYM c2PI}
  {$HPPEMIT 'extern const System::Single c2PI /*= 6.283185307*/;'}
  cPIdiv2: Single = 1.570796326;
  {$EXTERNALSYM cPIdiv2}
  {$HPPEMIT 'extern const System::Single cPIdiv2 /*= 1.570796326*/;'}
  cPIdiv4: Single = 0.785398163;
  {$EXTERNALSYM cPIdiv4}
  {$HPPEMIT 'extern const System::Single cPIdiv4 /*= 0.785398163*/;'}
  c3PIdiv4: Single = 2.35619449;
  {$EXTERNALSYM c3PIdiv4}
  {$HPPEMIT 'extern const System::Single c3PIdiv4 /*= 2.35619449*/;'}
  cInv2PI: Single = 1 / 6.283185307;
  {$EXTERNALSYM cInv2PI}
  {$HPPEMIT 'extern const System::Single cInv2PI /*= 1 / 6.283185307*/;'}
  cInv360: Single = 1 / 360;
  {$EXTERNALSYM cInv360}
  {$HPPEMIT 'extern const System::Single cInv360 /*= 1 / 360*/;'}
  c180: Single = 180;
  {$EXTERNALSYM c180}
  {$HPPEMIT 'extern const System::Single c180 /*= 180*/;'}
  c360: Single = 360;
  {$EXTERNALSYM c360}
  {$HPPEMIT 'extern const System::Single c360 /*= 360*/;'}
  cOneHalf: Single = 0.5;
  {$EXTERNALSYM cOneHalf}
  {$HPPEMIT 'extern const System::Single cOneHalf /*= 0.5*/;'}

  CurveKappa = 0.5522847498;
  {$EXTERNALSYM CurveKappa}
  {$HPPEMIT 'extern const System::Extended CurveKappa /*= 0.5522847498*/;'}
  CurveKappaInv = 1 - CurveKappa;
  {$EXTERNALSYM CurveKappaInv}
  {$HPPEMIT 'extern const System::Extended CurveKappaInv /*= 1 - CurveKappa*/;'}

  Epsilon: Single = 1E-40;
  {$EXTERNALSYM Epsilon}
  {$HPPEMIT 'extern const System::Single Epsilon /*= 1E-40*/;'}
  Epsilon2: Single = 1E-30;
  {$EXTERNALSYM Epsilon2}
  {$HPPEMIT 'extern const System::Single Epsilon2 /*= 1E-40*/;'}

{$IFDEF MSWINDOWS}
  {$EXTERNALSYM GUID_NULL}
{$ENDIF}
{$IF not Defined(MSWINDOWS) or Defined(NEXTGEN)}
type
  PDisplay = Pointer;
  PEvent = Pointer;
  TXrmOptionDescRec = record end;
  XrmOptionDescRec = TXrmOptionDescRec;
  PXrmOptionDescRec = ^TXrmOptionDescRec;
  Widget = Pointer;
  WidgetClass = Pointer;
  ArgList = Pointer;
  Region = Pointer;
  
 {$IFDEF MACOS}
   EventHandlerCallRef = Pointer;
   EventRef = Pointer;
   CGImageRef = Pointer;
   RgnHandle = Pointer;
   HIShapeRef = Pointer;
   HIMutableShapeRef = Pointer;
   OSMenuRef = Pointer;
 {$ENDIF MACOS}

const
  STGTY_STORAGE   = 1;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STGTY_STORAGE}
{$ENDIF}  
  STGTY_STREAM    = 2;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STGTY_STREAM}
{$ENDIF}
  STGTY_LOCKBYTES = 3;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STGTY_LOCKBYTES}
{$ENDIF}  
  STGTY_PROPERTY  = 4;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STGTY_PROPERTY}
{$ENDIF}

  STREAM_SEEK_SET = 0;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STREAM_SEEK_SET}
{$ENDIF}  
  STREAM_SEEK_CUR = 1;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STREAM_SEEK_CUR}
{$ENDIF}
  STREAM_SEEK_END = 2;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STREAM_SEEK_END}
{$ENDIF}  

// On Android fcntl.h file there is a group of LOCK_* macro definitions. One of
// them is also called LOCK_WRITE, which produces error with the defined here.
  LOCK_WRITE     = 1;
{$IF defined(MSWINDOWS) or defined(ANDROID)}
  {$EXTERNALSYM LOCK_WRITE}
{$ENDIF}  
  LOCK_EXCLUSIVE = 2;
{$IF defined(MSWINDOWS) or defined(ANDROID)}
  {$EXTERNALSYM LOCK_EXCLUSIVE}
{$ENDIF}  
  LOCK_ONLYONCE  = 4;
{$IF defined(MSWINDOWS) or defined(ANDROID)}
  {$EXTERNALSYM LOCK_ONLYONCE}
{$ENDIF}  

  { Unspecified error }
  E_FAIL                      = HRESULT($80004005);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM E_FAIL}
{$ENDIF}

  { Unable to perform requested operation. }
  STG_E_INVALIDFUNCTION       = HRESULT($80030001);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDFUNCTION}
{$ENDIF}  

  { %l could not be found. }
  STG_E_FILENOTFOUND          = HRESULT($80030002);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_FILENOTFOUND}
{$ENDIF}  

  { The path %l could not be found. }
  STG_E_PATHNOTFOUND          = HRESULT($80030003);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_PATHNOTFOUND}
{$ENDIF}

  { There are insufficient resources to open another file. }
  STG_E_TOOMANYOPENFILES      = HRESULT($80030004);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_TOOMANYOPENFILES}
{$ENDIF}  

  { Access Denied. }
  STG_E_ACCESSDENIED          = HRESULT($80030005);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_ACCESSDENIED}
{$ENDIF}

  { Attempted an operation on an invalid object. }
  STG_E_INVALIDHANDLE         = HRESULT($80030006);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDHANDLE}
{$ENDIF}  

  { There is insufficient memory available to complete operation. }
  STG_E_INSUFFICIENTMEMORY    = HRESULT($80030008);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INSUFFICIENTMEMORY}
{$ENDIF}  

  { Invalid pointer error. }
  STG_E_INVALIDPOINTER        = HRESULT($80030009);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDPOINTER}
{$ENDIF}

  { There are no more entries to return. }
  STG_E_NOMOREFILES           = HRESULT($80030012);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_NOMOREFILES}
{$ENDIF}  

  { Disk is write-protected. }
  STG_E_DISKISWRITEPROTECTED  = HRESULT($80030013);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_DISKISWRITEPROTECTED}
{$ENDIF}

  { An error occurred during a seek operation. }
  STG_E_SEEKERROR             = HRESULT($80030019);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_SEEKERROR}
{$ENDIF}  

  { A disk error occurred during a write operation. }
  STG_E_WRITEFAULT            = HRESULT($8003001D);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_WRITEFAULT}
{$ENDIF}  

  { A disk error occurred during a read operation. }
  STG_E_READFAULT             = HRESULT($8003001E);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_READFAULT}
{$ENDIF}  

  { A share violation has occurred. }
  STG_E_SHAREVIOLATION        = HRESULT($80030020);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_SHAREVIOLATION}
{$ENDIF}  

  { A lock violation has occurred. }
  STG_E_LOCKVIOLATION         = HRESULT($80030021);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_LOCKVIOLATION}
{$ENDIF}

  { %l already exists. }
  STG_E_FILEALREADYEXISTS     = HRESULT($80030050);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_FILEALREADYEXISTS}
{$ENDIF}

  { Invalid parameter error. }
  STG_E_INVALIDPARAMETER      = HRESULT($80030057);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDPARAMETER}
{$ENDIF}

  { There is insufficient disk space to complete operation. }
  STG_E_MEDIUMFULL            = HRESULT($80030070);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_MEDIUMFULL}
{$ENDIF}  

  { Illegal write of non-simple property to simple property set. }
  STG_E_PROPSETMISMATCHED     = HRESULT($800300F0);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_PROPSETMISMATCHED}
{$ENDIF}

  { An API call exited abnormally. }
  STG_E_ABNORMALAPIEXIT       = HRESULT($800300FA);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_ABNORMALAPIEXIT}
{$ENDIF}  

  { The file %l is not a valid compound file. }
  STG_E_INVALIDHEADER         = HRESULT($800300FB);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDHEADER}
{$ENDIF}  

  { The name %l is not valid. }
  STG_E_INVALIDNAME           = HRESULT($800300FC);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDNAME}
{$ENDIF}  

  { An unexpected error occurred. }
  STG_E_UNKNOWN               = HRESULT($800300FD);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_UNKNOWN}
{$ENDIF}  

  { That function is not implemented. }
  STG_E_UNIMPLEMENTEDFUNCTION = HRESULT($800300FE);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_UNIMPLEMENTEDFUNCTION}
{$ENDIF}  

  { Invalid flag error. }
  STG_E_INVALIDFLAG           = HRESULT($800300FF);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INVALIDFLAG}
{$ENDIF}  

  { Attempted to use an object that is busy. }
  STG_E_INUSE                 = HRESULT($80030100);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INUSE}
{$ENDIF}  

  { The storage has been changed since the last commit. }
  STG_E_NOTCURRENT            = HRESULT($80030101);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_NOTCURRENT}
{$ENDIF}  

  { Attempted to use an object that has ceased to exist. }
  STG_E_REVERTED              = HRESULT($80030102);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_REVERTED}
{$ENDIF}

  { Can't save. }
  STG_E_CANTSAVE              = HRESULT($80030103);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_CANTSAVE}
{$ENDIF}  

  { The compound file %l was produced with an incompatible version of storage. }
  STG_E_OLDFORMAT             = HRESULT($80030104);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_OLDFORMAT}
{$ENDIF}

  { The compound file %l was produced with a newer version of storage. }
  STG_E_OLDDLL                = HRESULT($80030105);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_OLDDLL}
{$ENDIF}  

  { Share.exe or equivalent is required for operation. }
  STG_E_SHAREREQUIRED         = HRESULT($80030106);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_SHAREREQUIRED}
{$ENDIF}

  { Illegal operation called on non-file based storage. }
  STG_E_NOTFILEBASEDSTORAGE   = HRESULT($80030107);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_NOTFILEBASEDSTORAGE}
{$ENDIF}  

  { Illegal operation called on object with extant marshallings. }
  STG_E_EXTANTMARSHALLINGS    = HRESULT($80030108);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_EXTANTMARSHALLINGS}
{$ENDIF}  

  { The docfile has been corrupted. }
  STG_E_DOCFILECORRUPT        = HRESULT($80030109);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_DOCFILECORRUPT}
{$ENDIF}  

  { OLE32.DLL has been loaded at the wrong address. }
  STG_E_BADBASEADDRESS        = HRESULT($80030110);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_BADBASEADDRESS}
{$ENDIF}  

  { The file download was aborted abnormally.  The file is incomplete. }
  STG_E_INCOMPLETE            = HRESULT($80030201);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_INCOMPLETE}
{$ENDIF}  

  { The file download has been terminated. }
  STG_E_TERMINATED            = HRESULT($80030202);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_E_TERMINATED}
{$ENDIF}  

  { The underlying file was converted to compound file format. }
  STG_S_CONVERTED             = HRESULT($00030200);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_S_CONVERTED}
{$ENDIF}  

  { The storage operation should block until more data is available. }
  STG_S_BLOCK                 = HRESULT($00030201);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_S_BLOCK}
{$ENDIF}  

  { The storage operation should retry immediately. }
  STG_S_RETRYNOW              = HRESULT($00030202);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_S_RETRYNOW}
{$ENDIF}  

  { The notified event sink will not influence the storage operation. }
  STG_S_MONITORING            = HRESULT($00030203);
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM STG_S_MONITORING}
{$ENDIF}


type
  TOleChar = WideChar;
  POleStr = PWideChar;
  PPOleStr = ^POleStr;

  PCLSID = PGUID;
  TCLSID = TGUID;

{ 64-bit large integer }

  LargeInt = Int64;
  {$EXTERNALSYM LargeInt}
  LargeUInt = UInt64;
  {$EXTERNALSYM LargeUInt}
  PLargeInt = ^LargeInt;
  {$EXTERNALSYM PLargeInt}
  PLargeUInt = ^LargeUInt;
  {$EXTERNALSYM PLargeUInt}

  PDWORD = ^DWORD;
  {$EXTERNALSYM PDWORD}

  { File System time stamps are represented with the following structure: }
  PFileTime = ^TFileTime;
  _FILETIME = record
    dwLowDateTime: DWORD;
    dwHighDateTime: DWORD;
  end;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM _FILETIME}
{$ENDIF}  
  TFileTime = _FILETIME;
  FILETIME = _FILETIME;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM FILETIME}
{$ENDIF}  

{ IStream interface }

  PStatStg = ^TStatStg;
  tagSTATSTG = record
    pwcsName: POleStr;
    dwType: FixedInt;
    cbSize: Largeint;
    mtime: TFileTime;
    ctime: TFileTime;
    atime: TFileTime;
    grfMode: FixedInt;
    grfLocksSupported: FixedInt;
    clsid: TCLSID;
    grfStateBits: FixedInt;
    reserved: FixedInt;
  end;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM tagSTATSTG}
{$ENDIF}  
  TStatStg = tagSTATSTG;
  STATSTG = TStatStg;

  IClassFactory = interface(IUnknown)
    ['{00000001-0000-0000-C000-000000000046}']
    function CreateInstance(const unkOuter: IUnknown; const iid: TGUID; out obj): HResult; stdcall;
    function LockServer(fLock: LongBool): HResult; stdcall;
  end;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM IClassFactory}
{$ENDIF}

  ISequentialStream = interface(IUnknown)
    ['{0c733a30-2a1c-11ce-ade5-00aa0044773d}']
    function Read(pv: Pointer; cb: FixedUInt; pcbRead: PFixedUInt): HResult; stdcall;
    function Write(pv: Pointer; cb: FixedUInt; pcbWritten: PFixedUInt): HResult; stdcall;
  end;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM ISequentialStream}
{$ENDIF}  

  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function Seek(dlibMove: Largeint; dwOrigin: DWORD; out libNewPosition: LargeUInt): HResult; stdcall;
    function SetSize(libNewSize: LargeUInt): HResult; stdcall;
    function CopyTo(stm: IStream; cb: LargeUInt; out cbRead: LargeUInt; out cbWritten: LargeUInt): HResult; stdcall;
    function Commit(grfCommitFlags: DWORD): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: LargeUInt; cb: LargeUInt; dwLockType: DWORD): HResult; stdcall;
    function UnlockRegion(libOffset: LargeUInt; cb: LargeUInt; dwLockType: DWORD): HResult; stdcall;
    function Stat(out statstg: TStatStg; grfStatFlag: DWORD): HResult; stdcall;
    function Clone(out stm: IStream): HResult; stdcall;
  end;
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM IStream}
{$ENDIF}  
{$ENDIF} { !MSWINDOWS }

function EqualRect(const R1, R2: TRect): Boolean; overload;
function EqualRect(const R1, R2: TRectF): Boolean; overload;
function Rect(Left, Top, Right, Bottom: Integer): TRect;
{$EXTERNALSYM Rect}
function RectF(Left, Top, Right, Bottom: Single): TRectF; inline; overload;
function NormalizeRectF(const Pts: array of TPointF): TRectF; overload;
function NormalizeRect(const ARect: TRectF): TRectF; overload;
function RectWidth(const Rect: TRect): Integer; inline; overload;
function RectWidth(const Rect: TRectF): Single; inline; overload;
function RectHeight(const Rect: TRect): Integer; inline; overload;
function RectHeight(const Rect: TRectF): Single; inline; overload;
function RectCenter(var R: TRect; const Bounds: TRect): TRect; overload;
function RectCenter(var R: TRectF; const Bounds: TRectF): TRectF; overload;
function Bounds(ALeft, ATop, AWidth, AHeight: Integer): TRect;
{$EXTERNALSYM Bounds}
function Point(X, Y: Integer): TPoint; inline; overload;
{$EXTERNALSYM Point}
function PointF(X, Y: Single): TPointF; inline; overload;
function MinPoint(const P1, P2: TPointF): TPointF; overload;
function MinPoint(const P1, P2: TPoint): TPoint; overload;
function ScalePoint(const P: TPointF; dX, dY: Single): TPointF; overload;
function ScalePoint(const P: TPoint; dX, dY: Single): TPoint; overload;
function SmallPoint(X, Y: Integer): TSmallPoint; inline; overload;
function SmallPoint(XY: LongWord): TSmallPoint; overload;
function PtInRect(const Rect: TRect; const P: TPoint): Boolean; overload;
function PtInRect(const Rect: TRectF; const P: TPointF): Boolean; overload;
function PtInCircle(const Point, Center: TPoint; Radius: Integer): Boolean; overload; deprecated 'use TPoint.PointInCircle instead';
function IntersectRect(const Rect1, Rect2: TRect): Boolean; overload;
function IntersectRect(out Rect: TRect; const R1, R2: TRect): Boolean; overload;
function IntersectRect(const Rect1, Rect2: TRectF): Boolean; overload;
function IntersectRect(out Rect: TRectF; const R1, R2: TRectF): Boolean; overload;
function UnionRect(out Rect: TRect; const R1, R2: TRect): Boolean; overload;
function UnionRect(out Rect: TRectF; const R1, R2: TRectF): Boolean; overload;
function UnionRect(const ARect1, ARect2: TRect): TRect; inline; overload;
function UnionRect(const ARect1, ARect2: TRectF): TRectF; inline; overload;
function IsRectEmpty(const Rect: TRect): Boolean; overload;
function IsRectEmpty(const Rect: TRectF): Boolean; overload;
function OffsetRect(var R: TRect; DX, DY: Integer): Boolean; overload;
function OffsetRect(var R: TRectF; DX, DY: Single): Boolean; overload;
procedure MultiplyRect(var R: TRectF; const DX, DY: Single);
procedure InflateRect(var R: TRectF; const DX, DY: Single); overload;
procedure InflateRect(var R: TRect; const DX, DY: Integer); overload;
function CenterPoint(const Rect: TRect): TPoint;
function SplitRect(const Rect: TRect; SplitType: TSplitRectType; Size: Integer): TRect; overload;
function SplitRect(const Rect: TRect; SplitType: TSplitRectType; Percent: Double): TRect; overload;
function CenteredRect(const SourceRect: TRect; const CenteredRect: TRect): TRect;

function IntersectRectF(out Rect: TRectF; const R1, R2: TRectF): Boolean;
function UnionRectF(out Rect: TRectF; const R1, R2: TRectF): Boolean;

type
  TValueRelationship = -1..1;

const
  LessThanValue = Low(TValueRelationship);
  EqualsValue = 0;
  GreaterThanValue = High(TValueRelationship);

type
  TWaitResult = (wrSignaled, wrTimeout, wrAbandoned, wrError, wrIOCompletion);

  /// <summary>
  ///    Abstract base class fully implemented in System.Classes and returned by IAsyncResult.GetAsyncWaitEvent.
  ///    This class allows for blocking with any number of these events using WaitForAll() and WaitForAny()
  ///    While this class can be implemented by creating a descendant, it is expected that the implementation
  ///    will be provided by System.Classes. Any attempt at creating an alternate implementation must adhere to
  ///    the "contracts" laid out in the abstract virtual methods.
  /// </summary>
  TMultiWaitEvent = class abstract
  protected type
    TWaiterFlag = (Waiting, WaitAll);
    TWaiterFlags = set of TWaiterFlag;
    TMultiWaiter = class
      FCond: TObject;
      FRefCount: Integer;
      FFlags: TWaiterFlags;
      FStatus:
        record
          case Boolean of
            False: (FiredEvent: Integer);
            True: (EventCount: Integer);
        end;
      constructor Create;
      destructor Destroy; override;
    end;
    TWaitInfo = record
      FWaiter: TMultiWaiter;
      FIndex: Integer;
    end;
    PWaitInfo = ^TWaitInfo;
    PMultiWaitEvent = ^TMultiWaitEvent;
    TMultiWaitEventClass = class of TMultiWaitEvent;
  private
    class procedure FreeAndNil(var Obj); static; inline;
    class function DoWait(const Events: array of TMultiWaitEvent; WaitAll: Boolean; Index: PInteger; Event: PMultiWaitEvent; Timeout: Cardinal): TWaitResult; static;
    function WaiterExpired(var Info: TWaitInfo): Boolean;
    procedure RemoveExpiredWaiters;
  protected class var
    ///  <summary>
    ///    This class variable will be set by a single descendent. The expectation is that one and only one descedent
    ///    of this class exists. That one descendent provides the actual implementation. This class variable is
    ///    used by the static class function Create to construct an instance of that one class that implements the
    ///    needed functionality.
    ///  </summary>
    FMultiEventType: TMultiWaitEventClass;
  protected
    ///  <summary>
    ///    Abstract virtual class overridden in descendant classes to create the proper type for the instance.
    ///  </summary>
    class function CreateInstance: TMultiWaitEvent; virtual; abstract;
    ///  <summary>
    ///    Since This unit doesn't cannot use System.SysUtls, this virtual allows descendants which do have access to
    ///    System.SysUtils to provide a means for this base ancestor class to raise exceptions when validating arguments.
    ///  </summary>
    class procedure ArgumentException; virtual; abstract;
    ///  <summary>
    ///    Since This unit doesn't cannot use System.Classes, this virtual allows descendants which do have access to
    ///    System.Classes to provide a means for this base ancestor to call System.Classes.TThread.GetTickCount.
    ///  </summary>
    class function GetTickCount: Cardinal; virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. This explicitly locks this specific instance.
    ///  </summary>
    procedure Lock; virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. This explicitly unlocks this specific instance.
    ///  </summary>
    procedure Unlock; virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. This must <strong>atomically</strong> set the state of the event.
    ///  </summary>
    procedure AtomicSetEventState(State: Boolean); virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. Notifies all current waiters this event is signaled.
    ///  </summary>
    procedure NotifyWaiters; virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. Clears the storage used for the waiters.
    ///  </summary>
    procedure ClearWaiters; virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. Add a new waiter to the list of waiters.
    ///  </summary>
    procedure PushWaiter(const Waiter: TWaitInfo); virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. Removed a waiter from the list of waiters.
    ///  </summary>
    procedure RemoveWaiter(Index: Integer); virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. Returns the current number of waiters in the list of waiters.
    ///  </summary>
    function GetWaiterCount: Integer; virtual; abstract;
    ///  <summary>
    ///    Overridden in descendents. Returns the index'th waiter from the waiter list.
    ///  </summary>
    function GetWaiter(Index: Integer): PWaitInfo; virtual; abstract;
    /// <summary>
    ///    Current number of threads waiting on this event.
    /// </summary>
    property WaiterCount: Integer read GetWaiterCount;
    /// <summary>
    ///    Array of PWaitInfo references which contain information about each waiting thread.
    /// </summary>
    property Waiters[Index: Integer]: PWaitInfo read GetWaiter;
  public
    ///  <summary>
    ///    Rather than use a constructor which will create an instance of <strong>this</strong> class, this will
    ///    return an instance of the registered descendent type that provides the actual implementation.
    ///  </summary>
    class function Create: TMultiWaitEvent; static;
    destructor Destroy; override;

    /// <summary>Wait for this event instance to be signaled or Timeout is reached.</summary>
    function WaitFor(Timeout: Cardinal = INFINITE): TWaitResult; virtual; abstract;
    /// <summary>Explicitly set the event as signaled. This procedure is typically called by the implementation of
    ///    a specific IAsyncResult.
    /// </summary>
    procedure SetEvent;
    /// <summary>Explicitly reset the event as unsignaled. This procedure is rarely if ever called. If it is called, it
    ///    is called by the implementation of a specific IAsyncResult.
    /// </summary>
    procedure ResetEvent;

    /// <summary>Wait until all of the indicated TMultiWaitEvents are signaled or Timeout is reached</summary>
    class function WaitForAll(const Events: array of TMultiWaitEvent; Timeout: Cardinal = INFINITE): TWaitResult; static;
    /// <summary>Wait until at least one of the indicated TMultiWaitEvents are signaled or Timeout is reached</summary>
    class function WaitForAny(const Events: array of TMultiWaitEvent; Timeout: Cardinal = INFINITE): TWaitResult; overload; static;
    /// <summary>Wait until at least one of the indicated TMultiWaitEvents are signaled or Timeout is reached.
    ///   Index out parameter is set to the index of the TMultiWaitEvent in the provided array which was signaled.
    ///   More than one event may be signaled; Index only indicates which one caused the function to return. Index is undefined if
    ///   Timeout was reached.
    /// </summary>
    class function WaitForAny(const Events: array of TMultiWaitEvent; out Index: Integer; Timeout: Cardinal = INFINITE): TWaitResult; overload; static;
    /// <summary>Wait until at least one of the indicated TMultiWaitEvents are signaled or Timeout is reached.
    ///    Returns the TMultiWaitEvent instance which was signaled and caused the function to return. Event is
    ///    undefined if Timeout is reached.
    /// </summary>
    class function WaitForAny(const Events: array of TMultiWaitEvent; out Event: TMultiWaitEvent; Timeout: Cardinal = INFINITE): TWaitResult; overload; static;
  end;

  /// <summary>
  ///    Interface returned from various "BeginXXX" methods in order to provide asynchronous execution of code.
  /// </summary>
  IAsyncResult = interface
    ///  <summary>
    ///    Returns the user-specified context associated with this instance.
    ///  </summary>
    function GetAsyncContext: TObject;
    ///  <summary>
    ///    Returns an event suitable for use to block until the asynchronous call is complete. This event is also suitable for
    ///    use in a list to allow waiting for all or any to be signaled. See the TMultiWaitEvent.WaitForXXX class
    ///    functions.
    ///  </summary>
    function GetAsyncWaitEvent: TMultiWaitEvent;
    ///  <summary>
    ///    Returns true if a given asynchronous call was able to be completed synchronously. In other words, the specific
    ///    call completed before returning.
    ///  </summary>
    function GetCompletedSynchronously: Boolean;
    ///  <summary>
    ///    Returns True when the asynchronous call is finished.
    ///  </summary>
    function GetIsCompleted: Boolean;

    ///  <summary>
    ///    The user-specified context associated with this instance.
    ///  </summary>
    property AsyncContext: TObject read GetAsyncContext;
    ///  <summary>
    ///    Event suitable for use to block until the asynchronous call is complete. This event is also suitable for
    ///    use in a list to allow waiting for all or any to be signaled. See the TMultiWaitEvent.WaitForXXX class
    ///    functions.
    ///  </summary>
    property AsyncWaitEvent: TMultiWaitEvent read GetAsyncWaitEvent;
    ///  <summary>
    ///    Set to true if a given asynchronous call was able to be completed synchronously. In other words, the specific
    ///    call completed before returning.
    ///  </summary>
    property CompletedSynchronously: Boolean read GetCompletedSynchronously;
    ///  <summary>
    ///    Set to True when the asynchronous call is finished.
    ///  </summary>
    property IsCompleted: Boolean read GetIsCompleted;
  end;

implementation

const
  // Single, 4bytes:    1-sign,  8-exp, 23-mantissa - 2^23 ~ 1E3*1E3*8 ~ 8E6 (really 8388608),
  //                          relative resolution = 1/(8E6) ~ 1.25E-7 (really 1.19E-7),
  //                          zero = 1/(2^(2^(8-1)) = 1/2^128 ~ 0.0625E-36 ~ 6.25E-38 (really 3E-39)
  FuzzFactorSingle = 10;
  SingleResolution: Single = 1.25E-7 * FuzzFactorSingle; // this is relative resolution of mantissa
  SingleZero: Single = 6.25E-37; // 6.25E-38 * FuzzFactorSingle;
  // Double, 8bytes:    1-sign, 11-exp, 52-mantissa - 2^52 ~ 1E3*1E3*1E3*1E3*1E3*4 = 4E15,
  //                             relative resolution = 2.5*E-16
  // FuzzFactorDouble = 10;
  // DoubleResolution: Double = 2.5E-16 * FuzzFactorDouble;
  // Extended, 10bytes: 1-sign, 15-exp, 64-mantissa - relative resolution = 0.0625*E-18
  // Real, 6bytes:      1-sign,  7-exp, 40-mantissa - 1.0*E-12 - deprecated

  // Example: for mantissa length=2 (0,xx - binary) resolution in mantissa is the last binary bite 0,01b = 1/4,
  //  for mantissa length=3 (0,xxx - binary) resolution in mantissa is the last binary bite 0,001b = 1/8, etc
  //  really the high digit is assumed to 1 (0,1xx or 0,1xxx) and the precision is 2 times higher

function Max(a, b: Integer): Integer; overload;
begin
  if a > b then Result := a else Result := b;
end;

function Max(a, b: Single): Single; overload;
begin
  if a > b then Result := a else Result := b;
end;

function Min(a, b: Integer): Integer; overload;
begin
  if a < b then Result := a else Result := b;
end;

function Min(a, b: Single): Single; overload;
begin
  if a < b then Result := a else Result := b;
end;

function Arctan2(const Y, X: Single): Single;
begin
  Result := 0;
  if X > 0 then
    Result := System.ArcTan(Y / X)
  else if X < 0 then
  begin
    Result := System.ArcTan(Y / X);
    if Y < 0 then
      Result := Result - Pi
    else
      Result := Result + Pi;
  end
  else
    if Y < 0 then
      Result := - Pi / 2
    else if Y > 0 then
      Result := Pi / 2;
end;

procedure SinCosSingle(const Theta: Single; var Sin, Cos: Single);
var
{$IF SizeOf(Extended) > SizeOf(Double)}
  S, C: Extended;
{$ELSE}
  S, C: Double;
{$ENDIF}
begin
  System.SineCosine(Theta, S, C);
  Sin := S;
  Cos := C;
end;

function Ceil(const X: Single): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
end;

function SameValue(const A, B: Single; Epsilon: Single = 0): Boolean;
begin
{$EXCESSPRECISION OFF}
  if Epsilon = 0 then
    Epsilon := Max(Abs(A), Abs(B)) * SingleResolution;
  if Epsilon = 0 then
     Epsilon := SingleZero; // both A and B are very little, Epsilon was 0 because of normalization
  if A > B then
    Result := (A - B) <= Epsilon
  else
    Result := (B - A) <= Epsilon;
{$EXCESSPRECISION ON}
end;
{ TPoint }
class operator TPoint.Equal(const Lhs, Rhs: TPoint): Boolean;
begin
  Result := (Lhs.X = Rhs.X) and (Lhs.Y = Rhs.Y);
end;

class operator TPoint.NotEqual(const Lhs, Rhs: TPoint): Boolean;
begin
  Result := (Lhs.X <> Rhs.X) or (Lhs.Y <> Rhs.Y);
end;

class operator TPoint.Add(const Lhs, Rhs: TPoint): TPoint;
begin
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
end;

class operator TPoint.Subtract(const Lhs, Rhs: TPoint): TPoint;
begin
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
end;

class operator TPoint.Implicit(Value: TSmallPoint): TPoint;
begin
  Result.x := Value.x;
  Result.y := Value.y;
end;

class operator TPoint.Explicit(Value: TPoint): TSmallPoint;
begin
  if Value.x < Low(SmallInt) then
    Result.x := Low(SmallInt)
  else if Value.x > High(SmallInt) then
    Result.x := High(SmallInt)
  else
    Result.x := SmallInt(Result.x);

  if Value.y < Low(SmallInt) then
    Result.y := Low(SmallInt)
  else if Value.y > High(SmallInt) then
    Result.y := High(SmallInt)
  else
    Result.y := SmallInt(Result.y);
end;



constructor TPoint.Create(P: TPoint);
begin
  Self.X := p.X;
  Self.Y := p.Y;
end;

constructor TPoint.Create(const X, Y: Integer);
begin
  Self.X := X;
  Self.Y := Y;
end;

function TPoint.Distance(const P2: TPoint): Double;
begin
  // We Add 0.0 int the expression to cast all operations to floating point.
  // This avoids overflow in signed integer operations.
  Result := Sqrt(Sqr(0.0 + Self.X - P2.X) + Sqr(0.0 + Self.Y - P2.Y));
end;

procedure TPoint.SetLocation(const X, Y: Integer);
begin
  Self.X := X;
  Self.Y := Y;
end;

procedure TPoint.SetLocation(const P: TPoint);
begin
  Self := P;
end;

procedure TPoint.Offset(const DX, DY: Integer);
begin
  Inc(Self.X, DX);
  Inc(Self.Y, DY);
end;

procedure TPoint.Offset(const Point: TPoint);
begin
  Self.Offset(Point.X, Point.Y);
end;

class function TPoint.PointInCircle(const Point, Center: TPoint; const Radius: Integer): Boolean;
begin
  Result := Point.Distance(Center) <= Radius;
end;

class function TPoint.Zero: TPoint;
begin
  Result.X := 0;
  Result.Y := 0;
end;

function TPoint.Add(const Point: TPoint): TPoint;
begin
  Result.SetLocation(Self.X + Point.X, Self.Y + Point.Y);
end;

function TPoint.Angle(const APoint: TPoint): Single;
begin
  Result := Arctan2(Self.Y - APoint.Y, Self.X - APoint.X);
end;

function TPoint.Subtract(const Point: TPoint): TPoint;
begin
  Result.SetLocation(Self.X - Point.X, Self.Y - Point.Y);
end;

function TPoint.IsZero: Boolean;
begin
  Result := (X = 0) and (Y = 0);
end;

{ TRect }

class function TRect.Empty: TRect;
begin
  Result := TRect.Create(0,0,0,0);
end;

constructor TRect.Create(const Origin: TPoint);
begin
  Create(Origin.X, Origin.Y, Origin.X, Origin.Y);
end;

constructor TRect.Create(const Origin: TPoint; Width, Height: Integer);
begin
  Create(Origin.X, Origin.Y, Origin.X + Width, Origin.Y + Height);
end;

constructor TRect.Create(const Left, Top, Right, Bottom: Integer);
begin
  Self.Left  := Left;
  Self.Top   := Top;
  Self.Right := Right;
  Self.Bottom:= Bottom;
end;

constructor TRect.Create(const P1, P2: TPoint; Normalize: Boolean);
begin
  Self.TopLeft := P1;
  Self.BottomRight := P2;
  if Normalize then Self.NormalizeRect;
end;

constructor TRect.Create(const R: TRect; Normalize: Boolean);
begin
  Self.TopLeft := R.TopLeft;
  Self.BottomRight := R.BottomRight;
  if Normalize then Self.NormalizeRect;
end;

function TRect.GetLocation: TPoint;
begin
  Result := TopLeft;
end;

procedure TRect.SetWidth(const Value: Integer);
begin
  Self.Right := Self.Left + Value;
end;

function TRect.GetWidth: Integer;
begin
  Result := Self.Right - Self.Left;
end;

procedure TRect.SetHeight(const Value: Integer);
begin
  Self.Bottom := Self.Top + Value;
end;

function TRect.GetHeight: Integer;
begin
  Result := Self.Bottom - Self.Top;
end;

function TRect.GetSize: TSize;
begin
  Result.cx := Width;
  Result.cy := Height;
end;

procedure TRect.SetSize(const Value: TSize);
begin
  Width := Value.cx;
  Height := Value.cy;
end;

class operator TRect.Equal(const Lhs, Rhs: TRect): Boolean;
begin
  Result := (Lhs.Left = Rhs.Left) and (Lhs.Right = Rhs.Right) and
            (Lhs.Top = Rhs.Top) and (Lhs.Bottom = Rhs.Bottom);
end;

class operator TRect.NotEqual(const Lhs, Rhs: TRect): Boolean;
begin
  Result := not(Lhs = Rhs);
end;

class operator TRect.Add(const Lhs, Rhs: TRect): TRect;
begin
  Result := TRect.Union(Lhs, Rhs);
end;

class operator TRect.Multiply(const Lhs, Rhs: TRect): TRect;
begin
  Result := TRect.Intersect(Lhs, Rhs);
end;

procedure TRect.NormalizeRect;
begin
  if Top > Bottom then
  begin
    Top := Top xor Bottom;
    Bottom := Top xor Bottom;
    Top := Top xor Bottom;
  end;
  if Left > Right then
  begin
    Left := Left xor Right;
    Right:= Left xor Right;
    Left := Left xor Right;
  end
end;

function TRect.IsEmpty: Boolean;
begin
  Result := IsRectEmpty(Self);
end;

function PtInRect(const Rect: TRect; const P: TPoint): Boolean;
begin
  Result := (P.X >= Rect.Left) and (P.X < Rect.Right) and (P.Y >= Rect.Top)
    and (P.Y < Rect.Bottom);
end;

function TRect.Contains(const PT: TPoint): Boolean;
begin
  Result := PtInRect(self, PT);
end;

function TRect.Contains(const R: TRect): Boolean;
begin
  Result := (Self.Left <= R.Left)
        and (Self.Right >= R.Right)
        and (Self.Top <= R.Top)
        and (Self.Bottom >= R.Bottom);
end;

function TRect.IntersectsWith(const R: TRect): Boolean;
begin
  Result := (Self.Left < R.Right)
        and (Self.Right > R.Left)
        and (Self.Top < R.Bottom)
        and (Self.Bottom > R.Top);
end;
    
class function TRect.Intersect(const R1: TRect; const R2: TRect): TRect;
begin
  IntersectRect(Result, R1, R2);
end;

procedure TRect.Intersect(const R: TRect);
begin
  Self := Intersect(Self, R);
end;

class function TRect.Union(const R1: TRect; const R2: TRect): TRect;
begin
  UnionRect(Result, R1, R2);
end;

procedure TRect.Union(const R: TRect);
begin
  Self := Union(Self, R);
end;

class function TRect.Union(const Points: Array of TPoint): TRect;
var
  i: Integer;
  TLCorner, BRCorner: TPoint;
begin
  if Length(Points) > 0 then
  begin
    TLCorner := Points[Low(Points)];
    BRCorner := Points[Low(Points)];

    if Length(Points) > 1 then
    begin
      for i := Low(Points) + 1 to High(Points) do
      begin
        if Points[i].X < TLCorner.X then TLCorner.X := Points[i].X;
        if Points[i].X > BRCorner.X then BRCorner.X := Points[i].X;
        if Points[i].Y < TLCorner.Y then TLCorner.Y := Points[i].Y;
        if Points[i].Y > BRCorner.Y then BRCorner.Y := Points[i].Y;
      end;
    end;

    Result := TRect.Create(TLCorner, BRCorner);

  end
  else begin
    Result := TRect.Empty;
  end;
end;


procedure TRect.Offset(const DX, DY: Integer);
begin
  TopLeft.Offset(DX, DY);
  BottomRight.Offset(DX, DY);
end;

procedure TRect.Offset(const Point: TPoint);
begin
  TopLeft.Offset(Point);
  BottomRight.Offset(Point);
end;

// sets new origin
procedure TRect.SetLocation(const X, Y: Integer);
begin
  Offset(X - Left, Y - Top);
end;

procedure TRect.SetLocation(const Point: TPoint);
begin
  Offset(Point.X - Left, Point.Y - Top);
end;

procedure TRect.Inflate(const DX, DY: Integer);
begin
  TopLeft.Offset(-DX, -DY);
  BottomRight.Offset(DX, DY);
end;

procedure TRect.Inflate(const DL, DT, DR, DB: Integer);
begin
  TopLeft.Offset(-DL, -DT);
  BottomRight.Offset(DR, DB);
end;

function TRect.CenterPoint: TPoint;
begin
  Result.X := (Right - Left) div 2 + Left;
  Result.Y := (Bottom - Top) div 2 + Top;
end;

function TRect.SplitRect(SplitType: TSplitRectType; Size: Integer): TRect;
begin
  Result := Self;

  case SplitType of
    srLeft:
      Result.Right := Self.Left + Size;
    srRight:
      Result.Left := Self.Right - Size;
    srTop:
      Result.Bottom := Self.Top + Size;
    srBottom:
      Result.Top := Self.Bottom - Size;
  end;
end;

function TRect.SplitRect(SplitType: TSplitRectType; Percent: Double): TRect;
begin
  Result := Self;
  case SplitType of
    srLeft:
      Result.Right := Self.Left + Trunc(Percent * Self.Width);
    srRight:
      Result.Left := Self.Right - Trunc(Percent * Self.Width);
    srTop:
      Result.Bottom := Self.Top + Trunc(Percent * Self.Height);
    srBottom:
      Result.Top := Self.Bottom - Trunc(Percent * Self.Height);
  end;
end;

{}

function SplitRect(const Rect: TRect; SplitType: TSplitRectType; Size: Integer): TRect;
begin
  Result := Rect;
  case SplitType of
    srLeft:
      Result.Right := Rect.Left + Size;
    srRight:
      Result.Left := Rect.Right - Size;
    srTop:
      Result.Bottom := Rect.Top + Size;
    srBottom:
      Result.Top := Rect.Bottom - Size;
  end;
end;

function SplitRect(const Rect: TRect; SplitType: TSplitRectType; Percent: Double): TRect;
begin
  Result := Rect;
  case SplitType of
    srLeft:
      Result.Right := Rect.Left + Trunc(Percent * RectWidth(Rect));
    srRight:
      Result.Left := Rect.Right - Trunc(Percent * RectWidth(Rect));
    srTop:
      Result.Bottom := Rect.Top + Trunc(Percent * RectHeight(Rect));
    srBottom:
      Result.Top := Rect.Bottom - Trunc(Percent * RectHeight(Rect));
  end;
end;

function CenteredRect(const SourceRect: TRect; const CenteredRect: TRect): TRect;
var
  Width, Height: Integer;
  X, Y: Integer;
begin
  Width := RectWidth(CenteredRect);
  Height := RectHeight(CenteredRect);
  X := (SourceRect.Right + SourceRect.Left) div 2;
  Y := (SourceRect.Top + SourceRect.Bottom) div 2;
  Result := Rect(X - Width div 2, Y - Height div 2, X + (Width + 1) div 2, Y + (Height + 1) div 2);
end;

function MinPoint(const P1, P2: TPointF): TPointF;
begin
  Result := P1;
  if (P2.Y < P1.Y) or ((P2.Y = P1.Y) and (P2.X < P1.X)) then
    Result := P2;
end;

function MinPoint(const P1, P2: TPoint): TPoint;
begin
  Result := P1;
  if (P2.Y < P1.Y) or ((P2.Y = P1.Y) and (P2.X < P1.X)) then
    Result := P2;
end;

procedure MultiplyRect(var R: TRectF; const DX, DY: Single);
begin
  R.Left := R.Left * dX;
  R.Right := R.Right * dX;
  R.Top := R.Top * dY;
  R.Bottom := R.Bottom * dY;
end;

function NormalizeRectF(const Pts: array of TPointF): TRectF;
var
  Pt: TPointF;
begin
  Result.Left := $F000;
  Result.Top := $F000;
  Result.Right := -$F000;
  Result.Bottom := -$F000;
  for Pt in Pts do
  begin
    if Pt.X < Result.Left then
      Result.Left := Pt.X;
    if Pt.Y < Result.Top then
      Result.Top := Pt.Y;
    if Pt.X > Result.Right then
      Result.Right := Pt.X;
    if Pt.Y > Result.Bottom then
      Result.Bottom := Pt.Y;
  end;
end;

function NormalizeRect(const ARect: TRectF): TRectF;
begin
  Result := NormalizeRectF([TPointF.Create(ARect.Left, ARect.Top), TPointF.Create(ARect.Right, ARect.Top),
    TPointF.Create(ARect.Right, ARect.Bottom), TPointF.Create(ARect.Left, ARect.Bottom)]);
end;

function ScalePoint(const P: TPointF; dX, dY: Single): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := P.X * dX;
  Result.Y := P.Y * dY;
{$EXCESSPRECISION ON}
end;

function ScalePoint(const P: TPoint; dX, dY: Single): TPoint;
begin
  Result.X := Round(P.X * dX);
  Result.Y := Round(P.Y * dY);
end;

function EqualRect(const R1, R2: TRect): Boolean;
begin
  Result := (R1.Left = R2.Left) and (R1.Right = R2.Right) and
    (R1.Top = R2.Top) and (R1.Bottom = R2.Bottom);
end;

function EqualRect(const R1, R2: TRectF): Boolean;
begin
  Result := (R1.Left = R2.Left) and (R1.Right = R2.Right) and
    (R1.Top = R2.Top) and (R1.Bottom = R2.Bottom);
end;

function Rect(Left, Top, Right, Bottom: Integer): TRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Bottom := Bottom;
  Result.Right := Right;
end;

function RectF(Left, Top, Right, Bottom: Single): TRectF;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Bottom := Bottom;
  Result.Right := Right;
end;

function RectWidth(const Rect: TRect): Integer;
begin
  Result := Rect.Right - Rect.Left;
end;

function RectHeight(const Rect: TRect): Integer;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function RectWidth(const Rect: TRectF): Single;
begin
  Result := Rect.Right - Rect.Left;
end;

function RectHeight(const Rect: TRectF): Single;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function RectCenter(var R: TRect; const Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, (RectWidth(Bounds) - RectWidth(R)) div 2, (RectHeight(Bounds) - RectHeight(R)) div 2);
  OffsetRect(R, Bounds.Left, Bounds.Top);
  Result := R;
end;

function RectCenter(var R: TRectF; const Bounds: TRectF): TRectF;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, Round((RectWidth(Bounds) - RectWidth(R)) / 2), Round((RectHeight(Bounds) - RectHeight(R)) / 2));
  OffsetRect(R, Bounds.Left, Bounds.Top);
  Result := R;
end;

function Point(X, Y: Integer): TPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function PointF(X, Y: Single): TPointF;
begin
  Result.X := X;
  Result.Y := Y;
end;

function SmallPoint(X, Y: Integer): TSmallPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function SmallPoint(XY: LongWord): TSmallPoint;
begin
  Result.X := SmallInt(XY and $0000FFFF);
  Result.Y := SmallInt(XY shr 16);
end;

function PtInCircle(const Point, Center: TPoint; Radius: Integer): Boolean;
begin
  if Radius > 0 then
  begin
    Result := Sqr((Point.X - Center.X) / Radius) +
      Sqr((Point.Y - Center.Y) / Radius) <= 1;
  end
  else
  begin
    Result := False;
  end;
end;

function IntersectRect(const Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left < Rect2.Right)
        and (Rect1.Right > Rect2.Left)
        and (Rect1.Top < Rect2.Bottom)
        and (Rect1.Bottom > Rect2.Top);
end;

function IntersectRect(out Rect: TRect; const R1, R2: TRect): Boolean;
var
  tmpRect: TRect;
begin
  tmpRect := R1;
  if R2.Left > R1.Left then tmpRect.Left := R2.Left;
  if R2.Top > R1.Top then tmpRect.Top := R2.Top;
  if R2.Right < R1.Right then tmpRect.Right := R2.Right;
  if R2.Bottom < R1.Bottom then tmpRect.Bottom := R2.Bottom;
  Result := not IsRectEmpty(tmpRect);
  if not Result then FillChar(tmpRect, SizeOf(Rect), 0);
  Rect := tmpRect;
end;

function IntersectRect(const Rect1, Rect2: TRectF): Boolean;
begin
  Result := (Rect1.Left < Rect2.Right)
        and (Rect1.Right > Rect2.Left)
        and (Rect1.Top < Rect2.Bottom)
        and (Rect1.Bottom > Rect2.Top);
end;

function IntersectRect(out Rect: TRectF; const R1, R2: TRectF): Boolean;
var
  tmpRect: TRectF;
begin
  tmpRect := R1;
  if R2.Left > R1.Left then tmpRect.Left := R2.Left;
  if R2.Top > R1.Top then tmpRect.Top := R2.Top;
  if R2.Right < R1.Right then tmpRect.Right := R2.Right;
  if R2.Bottom < R1.Bottom then tmpRect.Bottom := R2.Bottom;
  Result := not IsRectEmpty(tmpRect);
  if not Result then FillChar(tmpRect, SizeOf(Rect), 0);
  Rect := tmpRect;
end;

function UnionRect(out Rect: TRect; const R1, R2: TRect): Boolean;
var
  tmpRect: TRect;
begin
  tmpRect := R1;
  if not IsRectEmpty(R2) then
  begin
    if R2.Left < R1.Left then tmpRect.Left := R2.Left;
    if R2.Top < R1.Top then tmpRect.Top := R2.Top;
    if R2.Right > R1.Right then tmpRect.Right := R2.Right;
    if R2.Bottom > R1.Bottom then tmpRect.Bottom := R2.Bottom;
  end;
  Result := not IsRectEmpty(tmpRect);
  if not Result then FillChar(tmpRect, SizeOf(Rect), 0);
  Rect := tmpRect;
end;

function UnionRect(out Rect: TRectF; const R1, R2: TRectF): Boolean;
var
  tmpRect: TRectF;
begin
  tmpRect := R1;
  if not IsRectEmpty(R2) then
  begin
    if R2.Left < R1.Left then tmpRect.Left := R2.Left;
    if R2.Top < R1.Top then tmpRect.Top := R2.Top;
    if R2.Right > R1.Right then tmpRect.Right := R2.Right;
    if R2.Bottom > R1.Bottom then tmpRect.Bottom := R2.Bottom;
  end;
  Result := not IsRectEmpty(tmpRect);
  if not Result then FillChar(tmpRect, SizeOf(Rect), 0);
  Rect := tmpRect;
end;

function UnionRect(const ARect1, ARect2: TRect): TRect;
begin
  UnionRect(Result, ARect1, ARect2);
end;

function UnionRect(const ARect1, ARect2: TRectF): TRectF;
begin
  UnionRect(Result, ARect1, ARect2);
end;

procedure InflateRect(var R: TRectF; const DX, DY: Single);
begin
{$EXCESSPRECISION OFF}
  R.Left := R.Left - DX;
  R.Right := R.Right + DX;
  R.Top := R.Top - DY;
  R.Bottom := R.Bottom + DY;
{$EXCESSPRECISION ON}
end;

procedure InflateRect(var R: TRect; const DX, DY: Integer);
begin
  R.Left := R.Left - DX;
  R.Right := R.Right + DX;
  R.Top := R.Top - DY;
  R.Bottom := R.Bottom + DY;
end;

function IsRectEmpty(const Rect: TRect): Boolean;
begin
  Result := (Rect.Right <= Rect.Left) or (Rect.Bottom <= Rect.Top);
end;

function IsRectEmpty(const Rect: TRectF): Boolean;
begin
  Result := (Rect.Right <= Rect.Left) or (Rect.Bottom <= Rect.Top);
end;

function OffsetRect(var R: TRect; DX, DY: Integer): Boolean;
begin
  if @R <> nil then // Test to increase compatiblity with Windows
  begin
    Inc(R.Left, DX);
    Inc(R.Right, DX);
    Inc(R.Top, DY);
    Inc(R.Bottom, DY);
    Result := True;
  end
  else
    Result := False;
end;

function OffsetRect(var R: TRectF; DX, DY: Single): Boolean;
begin
{$EXCESSPRECISION OFF}
  if @R <> nil then // Test to increase compatiblity with Windows
  begin
    R.Left := R.Left + DX;
    R.Right := R.Right + DX;
    R.Top := R.Top + DY;
    R.Bottom := R.Bottom + DY;
    Result := True;
  end
  else
    Result := False;
{$EXCESSPRECISION ON}
end;

function Bounds(ALeft, ATop, AWidth, AHeight: Integer): TRect;
begin
  Result.Left := ALeft;
  Result.Top := ATop;
  Result.Right := ALeft + AWidth;
  Result.Bottom :=  ATop + AHeight;
end;

function CenterPoint(const Rect: TRect): TPoint;
begin
  Result.X := (Rect.Right - Rect.Left) div 2 + Rect.Left;
  Result.Y := (Rect.Bottom - Rect.Top) div 2 + Rect.Top;
end;

function IntersectRectF(out Rect: TRectF; const R1, R2: TRectF): Boolean;
var
  tmpRect: TRectF;
begin
  tmpRect := R1;
  if R2.Left > R1.Left then tmpRect.Left := R2.Left;
  if R2.Top > R1.Top then tmpRect.Top := R2.Top;
  if R2.Right < R1.Right then tmpRect.Right := R2.Right;
  if R2.Bottom < R1.Bottom then tmpRect.Bottom := R2.Bottom;
  Result := not tmpRect.IsEmpty;
  if not Result then
  begin
    tmpRect.Top := 0.0;
    tmpRect.Bottom := 0.0;
    tmpRect.Left := 0.0;
    tmpRect.Right := 0.0;
  end;
  Rect := tmpRect;
end;

function UnionRectF(out Rect: TRectF; const R1, R2: TRectF): Boolean;
var
  tmpRect: TRectF;
begin
  tmpRect := R1;
  if not R2.IsEmpty then
  begin
    if R2.Left < R1.Left then tmpRect.Left := R2.Left;
    if R2.Top < R1.Top then tmpRect.Top := R2.Top;
    if R2.Right > R1.Right then tmpRect.Right := R2.Right;
    if R2.Bottom > R1.Bottom then tmpRect.Bottom := R2.Bottom;
  end;
  Result := not tmpRect.IsEmpty;
  if not Result then
  begin
    tmpRect.Top :=0.0;
    tmpRect.Bottom := 0.0;
    tmpRect.Left := 0.0;
    tmpRect.Right := 0.0;
  end;
  Rect := tmpRect;
end;

{ TPointF }

class function TPointF.Create(const AX, AY: Single): TPointF;
begin
  Result.X := AX;
  Result.Y := AY;
end;

class function TPointF.Create(const APoint: TPoint): TPointF;
begin
  Result.X := APoint.X;
  Result.Y := APoint.Y;
end;

class operator TPointF.Add(const APoint1, APoint2: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint1.X + APoint2.X;
  Result.Y := APoint1.Y + APoint2.Y;
{$EXCESSPRECISION ON}
end;

class operator TPointF.Subtract(const APoint1, APoint2: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint1.X - APoint2.X;
  Result.Y := APoint1.Y - APoint2.Y;
{$EXCESSPRECISION ON}
end;

class operator TPointF.Equal(const APoint1, APoint2: TPointF): Boolean;
begin
  Result := SameValue(APoint1.X, APoint2.X) and SameValue(APoint1.Y, APoint2.Y);
end;

function TPointF.EqualsTo(const Point: TPointF; const Epsilon: Single): Boolean;
begin
  Result := SameValue(X, Point.X, Epsilon) and SameValue(Y, Point.Y, Epsilon);
end;

class operator TPointF.NotEqual(const APoint1, APoint2: TPointF): Boolean;
begin
  Result := not (APoint1 = APoint2);
end;

class operator TPointF.Implicit(const APoint: TPoint): TPointF;
begin
  Result.X := APoint.X;
  Result.Y := APoint.Y;
end;

class operator TPointF.Negative(const APoint: TPointF): TPointF;
begin
  Result.X := - APoint.X;
  Result.Y := - APoint.Y;
end;

class operator TPointF.Multiply(const APoint1, APoint2: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint1.X * APoint2.X;
  Result.Y := APoint1.Y * APoint2.Y;
{$EXCESSPRECISION ON}
end;

class operator TPointF.Multiply(const APoint: TPointF; const AFactor: Single): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint.X * AFactor;
  Result.Y := APoint.Y * AFactor;
{$EXCESSPRECISION ON}
end;

class operator TPointF.Multiply(const AFactor: Single; const APoint: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := AFactor * APoint.X;
  Result.Y := AFactor * APoint.Y;
{$EXCESSPRECISION ON}
end;

class operator TPointF.Divide(const APoint: TPointF; const AFactor: Single): TPointF;
var
  InvFactor: Single;
begin
{$EXCESSPRECISION OFF}
  if AFactor <> 0 then
  begin
    InvFactor := 1 / AFactor;

    Result.X := APoint.X * InvFactor;
    Result.Y := APoint.Y * InvFactor;
  end else
    Result := APoint;
{$EXCESSPRECISION ON}
end;

function TPointF.Add(const Point: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X + Point.X;
  Result.Y := Self.Y + Point.Y;
{$EXCESSPRECISION ON}
end;

function TPointF.Add(const Point: TPoint): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X + Point.X;
  Result.Y := Self.Y + Point.Y;
{$EXCESSPRECISION ON}
end;

function TPointF.Distance(const APoint: TPointF): Single;
begin
{$EXCESSPRECISION OFF}
  Result := (APoint - Self).Length;
{$EXCESSPRECISION ON}
end;

function TPointF.CrossProduct(const APoint: TPointF): Single;
begin
  Result := Self.X * APoint.Y - Self.Y * APoint.X;
end;

function TPointF.DotProduct(const APoint: TPointF): Single;
begin
  Result := (Self.X * APoint.X) + (Self.Y * APoint.Y);
end;

procedure TPointF.Offset(const APoint: TPointF);
begin
  Self := Self + APoint;
end;

procedure TPointF.Offset(const ADeltaX, ADeltaY: Single);
begin
  Self.Offset(TPointF.Create(ADeltaX, ADeltaY));
end;

procedure TPointF.Offset(const APoint: TPoint);
begin
  Self.Offset(TPointF.Create(APoint));
end;

class function TPointF.PointInCircle(const Point, Center: TPointF; const Radius: Integer): Boolean;
begin
  Result := Point.Distance(Center) <= Radius;
end;

class function TPointF.Zero: TPointF;
begin
  Result.X := 0;
  Result.Y := 0;
end;

function TPointF.IsZero: Boolean;
begin
  Result := SameValue(X, 0.0) and SameValue(Y, 0.0);
end;

function TPointF.Ceiling: TPoint;
begin
  Result.X := Ceil(X);
  Result.Y := Ceil(Y);
end;

function TPointF.Truncate: TPoint;
begin
  Result.X := Trunc(X);
  Result.Y := Trunc(Y);
end;

function TPointF.Round: TPoint;
begin
  Result.X := System.Round(X);
  Result.Y := System.Round(Y);
end;

function TPointF.SnapToPixel(const AScale: Single; const APlaceBetweenPixels: Boolean): TPointF;
var
  LScale: Single;
begin
  if AScale <= 0 then
    LScale := 1
  else
    LScale := AScale;
  Result.X := System.Round(Self.X * LScale) / LScale;
  Result.Y := System.Round(Self.Y * LScale) / LScale;
  if APlaceBetweenPixels then
  begin
    LScale := LScale / 2;
    Result.Offset(LScale, LScale);
  end;
end;

function TPointF.Scale(const AFactor: Single): TPointF;
begin
  Result := Self * AFactor;
end;

function TPointF.Normalize: TPointF;
var
  Len: Single;
begin
  Len := Sqrt(Sqr(X) + Sqr(Y));

  if (Len <> 0.0) then
  begin
    Result.X := X / Len;
    Result.Y := Y / Len;
  end
  else
    Result := Self;
end;

function TPointF.Length: Single;
begin
  Result := Sqrt(Sqr(X) + Sqr(Y));
end;

procedure TPointF.SetLocation(const P: TPoint);
begin
  Self.X := P.X;
  Self.Y := P.Y;
end;

procedure TPointF.SetLocation(const P: TPointF);
begin
  Self := P;
end;

procedure TPointF.SetLocation(const X, Y: Single);
begin
  Self.X := X;
  Self.Y := Y;
end;

function TPointF.Subtract(const Point: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X - Point.X;
  Result.Y := Self.Y - Point.Y;
{$EXCESSPRECISION ON}
end;

function TPointF.Subtract(const Point: TPoint): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X - Point.X;
  Result.Y := Self.Y - Point.Y;
{$EXCESSPRECISION ON}
end;

function TPointF.Rotate(const AAngle: Single): TPointF;
var
  Sine, Cosine: Single;
begin
  SinCosSingle(AAngle, Sine, Cosine);
  Result.X := X * Cosine - Y * Sine;
  Result.Y := X * Sine + Y * Cosine;
end;

function TPointF.Reflect(const APoint: TPointF): TPointF;
begin
  Result := Self + APoint * (-2 * Self.DotProduct(APoint));
end;

function TPointF.MidPoint(const APoint: TPointF): TPointF;
begin
  Result.X := (Self.X + APoint.X) / 2;
  Result.Y := (Self.Y + APoint.Y) / 2;
end;

function TPointF.Angle(const APoint: TPointF): Single;
begin
  Result := Arctan2(Self.Y - APoint.Y, Self.X - APoint.X);
end;

function TPointF.AngleCosine(const APoint: TPointF): Single;
begin
  Result := Self.Length * APoint.Length;

  if Abs(Result) > Epsilon then
    Result := Self.DotProduct(APoint) / Result
  else
    Result := Self.DotProduct(APoint) / Epsilon;

  Result := Max(Min(Result, 1), -1);
end;

{ TRectF }
constructor TRectF.Create(const R: TRectF; Normalize: Boolean);
begin
  Self := R;
  if Normalize then NormalizeRect;
end;

constructor TRectF.Create(const R: TRect; Normalize: Boolean);
begin
  Self.Left := R.Left;
  Self.Top  := R.Top;
  Self.Right := R.Right;
  Self.Bottom := R.Bottom;
  if Normalize then NormalizeRect;
end;


constructor TRectF.Create(const Origin: TPointF);
begin
  TopLeft := Origin;
  BottomRight := Origin;
end;

constructor TRectF.Create(const Left, Top, Right, Bottom: Single);
begin
  Self.Left := Left; Self.Top := Top;
  Self.Right := Right; Self.Bottom := Bottom;
end;

constructor TRectF.Create(const P1, P2: TPointF; Normalize: Boolean);
begin
  Self.TopLeft := P1;
  Self.BottomRight := P2;
  if Normalize then NormalizeRect;
end;

constructor TRectF.Create(const Origin: TPointF; const Width, Height: Single);
begin
  Self.TopLeft := Origin;
  Self.Width := Width;
  Self.Height := Height;
end;

class operator TRectF.Equal(const Lhs, Rhs: TRectF): Boolean;
begin
  Result := (Lhs.TopLeft = Rhs.TopLeft) and
            (Lhs.BottomRight = Rhs.BottomRight);
end;

function TRectF.EqualsTo(const R: TRectF; const Epsilon: Single): Boolean;
begin
  Result := TopLeft.EqualsTo(R.TopLeft, Epsilon) and BottomRight.EqualsTo(R.BottomRight, Epsilon);
end;

function TRectF.FitInto(const ADesignatedArea: TRectF; out Ratio: Single): TRectF;
begin
  if (ADesignatedArea.Width <= 0) or (ADesignatedArea.Height <= 0) then
  begin
    Ratio := 1;
    Exit(Self);
  end;

  if (Self.Width / ADesignatedArea.Width) > (Self.Height / ADesignatedArea.Height) then
    Ratio := Self.Width / ADesignatedArea.Width
  else
    Ratio := Self.Height / ADesignatedArea.Height;

  Result := TRectF.Create(0, 0, Self.Width / Ratio, Self.Height / Ratio);
  RectCenter(Result, ADesignatedArea);
end;

function TRectF.FitInto(const ADesignatedArea: TRectF): TRectF;
var
  Ratio: Single;
begin
  Result := FitInto(ADesignatedArea, Ratio);
end;

function TRectF.CenterAt(const ADesignatedArea: TRectF): TRectF;
begin
  Result := Self;
  RectCenter(Result, ADesignatedArea);
end;

function TRectF.PlaceInto(const ADesignatedArea: TRectF; const AHorzAlign: THorzRectAlign;
  const AVertAlign: TVertRectAlign): TRectF;
var
  LLocation: TPointF;
begin
  Result := Self;
  if (Self.Width > ADesignatedArea.Width) or (Self.Height > ADesignatedArea.Height) then
    Result := Result.FitInto(ADesignatedArea);
 case AHorzAlign of
   THorzRectAlign.Center: LLocation.X := (ADesignatedArea.Left + ADesignatedArea.Right - Result.Width) / 2;
   THorzRectAlign.Left: LLocation.X := ADesignatedArea.Left;
   THorzRectAlign.Right: LLocation.X := ADesignatedArea.Right - Result.Width;
 end;
 case AVertAlign of
   TVertRectAlign.Center: LLocation.Y := (ADesignatedArea.Top + ADesignatedArea.Bottom - Result.Height) / 2;
   TVertRectAlign.Top: LLocation.Y := ADesignatedArea.Top;
   TVertRectAlign.Bottom: LLocation.Y := ADesignatedArea.Bottom - Result.Height;
 end;
 Result.SetLocation(LLocation);
end;

function TRectF.SnapToPixel(const AScale: Single; const APlaceBetweenPixels: Boolean): TRectF;
var
  LScale: Single;
begin
  if AScale <= 0 then
    LScale := 1
  else
    LScale := AScale;
  Result.Left := System.Round(Self.Left * LScale) / LScale;
  Result.Top := System.Round(Self.Top * LScale) / LScale;
  Result.Width := System.Round(Self.Width * LScale) / LScale;
  Result.Height := System.Round(Self.Height * LScale) / LScale;
  if APlaceBetweenPixels then
  begin
    LScale := LScale / 2;
    Result.Offset(LScale, LScale);
  end;
end;

function TRectF.Fit(const BoundsRect: TRectF): Single;
var
  Ratio: Single;
begin
  Result := 1;
  if (BoundsRect.Width <= 0) or (BoundsRect.Height <= 0) then
    Exit;

  if (Self.Width / BoundsRect.Width) > (Self.Height / BoundsRect.Height) then
    Ratio := Self.Width / BoundsRect.Width
  else
    Ratio := Self.Height / BoundsRect.Height;

  if Ratio < 1 then
    Self := TRectF.Create(0, 0, Self.Width, Self.Height)
  else
    Self := TRectF.Create(0, 0, Self.Width / Ratio, Self.Height / Ratio);

  Result := Ratio;
  RectCenter(Self, BoundsRect);
end;

class operator TRectF.NotEqual(const Lhs, Rhs: TRectF): Boolean;
begin
  Result := not (Lhs = Rhs);
end;

class operator TRectF.Implicit(const Source: TRect): TRectF;
begin
  Result := TRectF.Create(Source);
end;

class operator TRectF.Explicit(const Source: TRectF): TRect;
begin
  Result := Source.Round;
end;

class operator TRectF.Add(const Lhs, Rhs: TRectF): TRectF;
begin
  Result := TRectF.Union(Lhs, Rhs);
end;

class operator TRectF.Multiply(const Lhs, Rhs: TRectF): TRectF;
begin
  Result := TRectF.Intersect(Lhs, Rhs);
end;

function TRectF.CenterPoint: TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := (Right - Left)/2.0 + Left;
  Result.Y := (Bottom - Top)/2.0 + Top;
{$EXCESSPRECISION ON}
end;

function TRectF.Contains(const R: TRectF): Boolean;
begin
  Result := (Self.Left <= R.Left)
        and (Self.Right >= R.Right)
        and (Self.Top <= R.Top)
        and (Self.Bottom >= R.Bottom);
end;

function PtInRect(const Rect: TRectF; const P: TPointF): Boolean;
begin
  Result := (P.X >= Rect.Left) and (P.X < Rect.Right) and (P.Y >= Rect.Top)
    and (P.Y < Rect.Bottom);
end;

function TRectF.Contains(const Pt: TPointF): Boolean;
begin
  Result := (Pt.X >= Self.Left)
        and (Pt.X < Self.Right)
        and (Pt.Y >= Self.Top)
        and (Pt.Y < Self.Bottom);
end;

class function TRectF.Empty: TRectF;
begin
  Result := TRectF.Create(0,0,0,0);
end;

function TRectF.GetHeight: Single;
begin
{$EXCESSPRECISION OFF}
  Result := Self.Bottom - Self.Top;
{$EXCESSPRECISION ON}
end;

procedure TRectF.SetHeight(const Value: Single);
begin
{$EXCESSPRECISION OFF}
  Self.Bottom := Self.Top + Value;
{$EXCESSPRECISION ON}
end;

function TRectF.GetWidth: Single;
begin
{$EXCESSPRECISION OFF}
  Result := Self.Right - Self.Left;
{$EXCESSPRECISION ON}
end;

procedure TRectF.SetWidth(const Value: Single);
begin
{$EXCESSPRECISION OFF}
  Self.Right := Self.Left + Value;
{$EXCESSPRECISION ON}
end;

function TRectF.GetSize: TSizeF;
begin
  Result.cx := Width;
  Result.cy := Height;
end;

procedure TRectF.SetSize(const Value: TSizeF);
begin
  Width := Value.cx;
  Height := Value.cy;
end;

procedure TRectF.Inflate(const DX, DY: Single);
begin
{$EXCESSPRECISION OFF}
  TopLeft.Offset(-DX, -DY);
  BottomRight.Offset(DX, DY);
{$EXCESSPRECISION ON}
end;

procedure TRectF.Inflate(const DL, DT, DR, DB: Single);
begin
{$EXCESSPRECISION OFF}
  TopLeft.Offset(-DL, -DT);
  BottomRight.Offset(DR, DB);
{$EXCESSPRECISION ON}
end;

procedure TRectF.Offset(const Point: TPointF);
begin
  TopLeft.Offset(Point);
  BottomRight.Offset(Point);
end;

procedure TRectF.Offset(const DX, DY: Single);
begin
  TopLeft.Offset(DX, DY);
  BottomRight.Offset(DX, DY);
end;

function TRectF.GetLocation: TPointF;
begin
  Result := TopLeft;
end;

procedure TRectF.SetLocation(const Point: TPointF);
begin
{$EXCESSPRECISION OFF}
  Offset(Point.X - Left, Point.Y - Top);
{$EXCESSPRECISION ON}
end;

procedure TRectF.SetLocation(const X, Y: Single);
begin
{$EXCESSPRECISION OFF}
  Offset(X - Left, Y - Top);
{$EXCESSPRECISION ON}
end;

function TRectF.IntersectsWith(const R: TRectF): Boolean;
begin
  Result := (Self.Left < R.Right)
        and (Self.Right > R.Left)
        and (Self.Top < R.Bottom)
        and (Self.Bottom > R.Top);
end;

function TRectF.IsEmpty: Boolean;
begin
  Result := (Right <= Left) or (Bottom <= Top);
end;

procedure TRectF.NormalizeRect;
var
  temp: Single;
begin
  if Top > Bottom then
  begin
    temp := Top;
    Top := Bottom;
    Bottom := temp;
  end;
  if Left > Right then
  begin
    temp := Left;
    Left := Right;
    Right := temp;
  end
end;

function TRectF.Ceiling: TRect;
begin
  Result.TopLeft := TopLeft.Ceiling;
  Result.BottomRight := BottomRight.Ceiling;
end;

function TRectF.Truncate: TRect;
begin
  Result.TopLeft := TopLeft.Truncate;
  Result.BottomRight := BottomRight.Truncate;
end;

function TRectF.Round: TRect;
begin
  Result.TopLeft := TopLeft.Round;
  Result.BottomRight := BottomRight.Round;
end;

class function TRectF.Intersect(const R1, R2: TRectF): TRectF;
begin
  IntersectRectF(Result, R1, R2);
end;

procedure TRectF.Intersect(const R: TRectF);
begin
  Self := Intersect(Self, R);
end;

class function TRectF.Union(const R1, R2: TRectF): TRectF;
begin
  UnionRectF(Result, R1, R2);
end;

procedure TRectF.Union(const R: TRectF);
begin
  Self := TRectF.Union(Self, R);
end;

class function TRectF.Union(const Points: Array of TPointF): TRectF;
var
  I: Integer;
  TLCorner, BRCorner: TPointF;
begin
  if Length(Points) > 0 then
  begin
    TLCorner := Points[Low(Points)];
    BRCorner := Points[Low(Points)];

    if Length(Points) > 1 then
    begin 
      for I := Low(Points) + 1 to High(Points) do
      begin
        if Points[I].X < TLCorner.X then TLCorner.X := Points[I].X;
        if Points[I].X > BRCorner.X then BRCorner.X := Points[I].X;
        if Points[I].Y < TLCorner.Y then TLCorner.Y := Points[I].Y;
        if Points[I].Y > BRCorner.Y then BRCorner.Y := Points[I].Y;
      end;
    end;

    Result := TRectF.Create(TLCorner, BRCorner);
  end
  else begin
    Result := TRectF.Empty;
  end;
end;

{ tagSIZE, TSize }
constructor TSize.Create(P: TSize);
begin
  cx := P.cx;
  cy := P.cy;
end;

constructor TSize.Create(const X, Y: Integer);
begin
  cx := X;
  cy := Y;
end;

class operator TSize.Add(const Lhs, Rhs: TSize): TSize;
begin
  Result.cx := Lhs.cx + Rhs.cx;
  Result.cy := Lhs.cy + Rhs.cy;
end;

function TSize.Add(const Point: TSize): TSize;
begin
  Result.cx := cx + Point.cx;
  Result.cy := cy + Point.cy;
end;

function TSize.Distance(const P2: TSize): Double;
begin
  // We Add 0.0 int the expression to cast all operations to floating point.
  // This avoids overflow in signed integer operations.
  Result := Sqrt(Sqr(0.0+ Self.cx - P2.cx) + Sqr(0.0 + Self.cy - P2.cy));
end;

function TSize.IsZero: Boolean;
begin
  Result := (cx = 0) and (cy = 0);
end;

class operator TSize.Equal(const Lhs, Rhs: TSize): Boolean;
begin
  Result := (Lhs.cx = Rhs.cx) and (Lhs.cy = Rhs.cy);
end;

class operator TSize.NotEqual(const Lhs, Rhs: TSize): Boolean;
begin
  Result := not (Lhs = Rhs);
end;

class operator TSize.Subtract(const Lhs, Rhs: TSize): TSize;
begin
  Result.cx := Lhs.cx - Rhs.cx;
  Result.cy := Lhs.cy - Rhs.cy;
end;

function TSize.Subtract(const Point: TSize): TSize;
begin
  Result.cx := cx - Point.cx;
  Result.cy := cy - Point.cy;
end;

{ TSizeF }
function TSizeF.Add(const Point: TSizeF): TSizeF;
begin
{$EXCESSPRECISION OFF}
  Result.cx := cx + Point.cx;
  Result.cy := cy + Point.cy;
{$EXCESSPRECISION ON}
end;

class operator TSizeF.Add(const Lhs, Rhs: TSizeF): TSizeF;
begin
{$EXCESSPRECISION OFF}
  Result.cx := Lhs.cx + Rhs.cx;
  Result.cy := Lhs.cy + Rhs.cy;
{$EXCESSPRECISION ON}
end;

constructor TSizeF.Create(const X, Y: Single);
begin
  cx := X;
  cy := Y;
end;

constructor TSizeF.Create(P: TSizeF);
begin
  cx := P.cx;
  cy := P.cy;
end;

function TSizeF.Distance(const P2: TSizeF): Double;
begin
  Result := Sqrt(Sqr(Self.cx - P2.cx) + Sqr(Self.cy - P2.cy));
end;

class operator TSizeF.Implicit(const Point: TPointF): TSizeF;
begin
  Result.cx := Point.X;
  Result.cy := Point.Y;
end;

class operator TSizeF.Implicit(const Size: TSizeF): TPointF;
begin
  Result.X := Size.cx;
  Result.Y := Size.cy;
end;

function TSizeF.IsZero: Boolean;
begin
  Result := SameValue(cx, 0.0) and SameValue(cy, 0.0);
end;

class operator TSizeF.Equal(const Lhs, Rhs: TSizeF): Boolean;
begin
  Result := SameValue(Lhs.cx, Rhs.cx) and SameValue(Lhs.cy, Rhs.cy);
end;

class operator TSizeF.NotEqual(const Lhs, Rhs: TSizeF): Boolean;
begin
  Result := not (Lhs = Rhs);
end;

function TSizeF.Subtract(const Point: TSizeF): TSizeF;
begin
{$EXCESSPRECISION OFF}
  Result.cx := cx - Point.cx;
  Result.cy := cy - Point.cy;
{$EXCESSPRECISION ON}
end;

class operator TSizeF.Subtract(const Lhs, Rhs: TSizeF): TSizeF;
begin
{$EXCESSPRECISION OFF}
  Result.cx := Lhs.cx - Rhs.cx;
  Result.cy := Lhs.cy - Rhs.cy;
{$EXCESSPRECISION ON}
end;

function TSizeF.Ceiling: TSize;
begin
  Result.cx := Ceil(cx);
  Result.cy := Ceil(cy);
end;

function TSizeF.Round: TSize;
begin
  Result.cx := Trunc(cx + 0.5);
  Result.cy := Trunc(cy + 0.5);
end;

function TSizeF.Truncate: TSize;
begin
  Result.cx := Trunc(cx);
  Result.cy := Trunc(cy);
end;

class operator TSizeF.Implicit(const Size: TSize): TSizeF;
begin
  Result.cx := Size.cx;
  Result.cy := Size.cy;
end;

{ TSmallPoint }
constructor TSmallPoint.Create(P: TSmallPoint);
begin
  x := P.x;
  y := P.y;
end;

constructor TSmallPoint.Create(const X, Y: Word);
begin
  Self.x := X;
  Self.y := Y;
end;

constructor TSmallPoint.Create(const X, Y: SmallInt);
begin
  Self.x := X;
  Self.y := Y;
end;

function TSmallPoint.Add(const Point: TSmallPoint): TSmallPoint;
begin
  Result.x := x + Point.x;
  Result.y := y + Point.y;
end;

class operator TSmallPoint.Add(const Lhs, Rhs: TSmallPoint): TSmallPoint;
begin
  Result.x := Lhs.x + Rhs.x;
  Result.y := Lhs.y + Rhs.y;
end;

function TSmallPoint.Subtract(const Point: TSmallPoint): TSmallPoint;
begin
  Result.x := x - Point.x;
  Result.y := y - Point.y;
end;

class operator TSmallPoint.Subtract(const Lhs, Rhs: TSmallPoint): TSmallPoint;
begin
  Result.x := Lhs.x - Rhs.x;
  Result.y := Lhs.y - Rhs.y;
end;

function TSmallPoint.Distance(const P2: TSmallPoint): Double;
begin
  // We Add 0.0 int the expression to cast all operations to floating point.
  // This avoids overflow in signed integer operations.
  Result := Sqrt(Sqr(0.0+ Self.X - P2.X) + Sqr(0.0 + Self.Y - P2.Y));
end;

class operator TSmallPoint.Equal(const Lhs, Rhs: TSmallPoint): Boolean;
begin
  Result := (Lhs.x = Rhs.x) and (Lhs.y = Rhs.y);
end;

class operator TSmallPoint.NotEqual(const Lhs, Rhs: TSmallPoint): Boolean;
begin
  Result := not (Lhs = Rhs);
end;

//class operator TSmallPoint.Implicit(Value: TSmallPoint): Cardinal;
//begin
//  Result := (Value.x shl 16) or Value.y;
//end;

function TSmallPoint.IsZero: Boolean;
begin
  Result := (x = 0) and (y = 0);
end;

{ TBitConverter }
class procedure TBitConverter.RangeCheckError; 
begin 
  System.Error(reRangeError); 
end;

class procedure TBitConverter.UnsafeFrom<T>(const Value: T;
  var B: TArray<Byte>; Offset: Integer);
type
  PT = ^T;
begin
  PT(@B[Offset])^ := Value;
end;

class procedure TBitConverter.From<T>(const Value: T; var B: TArray<Byte>;
  Offset: Integer);
begin
  if (Offset < 0) or (Offset + SizeOf(T) > Length(B)) then
    System.Error(reRangeError);
  UnsafeFrom<T>(Value, B, Offset);
end;

class function TBitConverter.UnsafeInTo<T>(const B: TArray<Byte>;
  Offset: Integer): T;
type
  PT = ^T;
begin
  Result := PT(@B[Offset])^;
end;

class function TBitConverter.InTo<T>(const B: TArray<Byte>;
  Offset: Integer): T;
begin
  if (Offset < 0) or (Offset + SizeOf(T) > Length(B)) then
    System.Error(reRangeError);
  Result := UnsafeInTo<T>(B, Offset);
end;

{ TMultiWaitEvent }

class procedure TMultiWaitEvent.FreeAndNil(var Obj);
{$IF not Defined(AUTOREFCOUNT)}
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;
{$ELSE}
begin
  TObject(Obj) := nil;
end;
{$ENDIF}

class function TMultiWaitEvent.Create: TMultiWaitEvent;
begin
  if TMultiWaitEvent.FMultiEventType <> nil then
    Result := TMultiWaitEvent.FMultiEventType.CreateInstance
  else
  begin
    System.Error(TRuntimeError.rePlatformNotImplemented);
    Result := nil;
  end;
end;

destructor TMultiWaitEvent.Destroy;
begin
  RemoveExpiredWaiters;
  inherited Destroy;
end;

class function TMultiWaitEvent.DoWait(const Events: array of TMultiWaitEvent; WaitAll: Boolean; Index: PInteger; Event: PMultiWaitEvent; Timeout: Cardinal): TWaitResult;
var
  I, WaitIndex: Integer;
  Info: TWaitInfo;
  Done: Boolean;
  CurrentTicks, Now: Cardinal;
begin
  if Length(Events) < 2 then
  begin
    if Length(Events) < 1 then
      ArgumentException;
    Result := Events[0].WaitFor(Timeout);
    if Result = TWaitResult.wrSignaled then
    begin
      if Index <> nil then
        Index^ := 0;
      if Event <> nil then
        Event^ := Events[0];
    end;
  end else
  begin
    CurrentTicks := FMultiEventType.GetTickCount;
    Info.FWaiter := TMultiWaiter.Create;
    try
      Info.FIndex := -1;
      Include(Info.FWaiter.FFlags, TWaiterFlag.Waiting);
      if WaitAll then
        Include(Info.FWaiter.FFlags, TWaiterFlag.WaitAll);
      Info.FWaiter.FRefCount := 1;
      if WaitAll then
        Info.FWaiter.FStatus.EventCount := Length(Events)
      else
        Info.FWaiter.FStatus.FiredEvent := -1;
      System.TMonitor.Enter(Info.FWaiter);
      try
        Done := False;
        WaitIndex := -1;
        for I := Low(Events) to High(Events) do
        begin
          Info.FIndex := I;
          Events[I].Lock;
          try
            Events[I].RemoveExpiredWaiters;
          finally
            if Events[I].WaitFor(0) = TWaitResult.wrSignaled then
            begin
              Events[I].Unlock;
              if WaitAll then
                Dec(Info.FWaiter.FStatus.EventCount)
              else begin
                Info.FWaiter.FStatus.FiredEvent := I;
                WaitIndex := I;
                Done := True;
              end;
            end else
            begin
              Events[I].PushWaiter(Info);
              Inc(Info.FWaiter.FRefCount);
              Events[I].Unlock;
            end;
          end;
          if Done then Break;
        end;

        if not Done and (Timeout = 0) then
        begin
          Done := True;
          Result := TWaitResult.wrTimeout;
        end else
          Result := TWaitResult.wrSignaled;

        while not Done do
        begin
          Done := (WaitAll and (Info.FWaiter.FStatus.EventCount = 0)) or (not WaitAll and (Info.FWaiter.FStatus.FiredEvent <> -1));
          if not Done then
          begin
            if Timeout <> INFINITE then
            begin
              Now := GetTickCount;
              if Now - CurrentTicks >= Timeout then
              begin
                Result := TWaitResult.wrTimeout;
                Break;
              end;
              Dec(Timeout, Now - CurrentTicks);
              CurrentTicks := Now;
            end;
            if System.TMonitor.Wait(Info.FWaiter.FCond, Info.FWaiter, Timeout) then
              Result := TWaitResult.wrSignaled
            else
              Result := TWaitResult.wrTimeout;
            if Result <> TWaitResult.wrSignaled then
              Break;
          end;
        end;

        WaitIndex := Info.FWaiter.FStatus.FiredEvent;
        Exclude(Info.FWaiter.FFlags, TWaiterFlag.Waiting);
        Dec(Info.FWaiter.FRefCount);
      finally
        if Info.FWaiter.FRefCount = 0 then
        begin
          System.TMonitor.Exit(Info.FWaiter);
          FreeAndNil(Info.FWaiter); // If we're unwinding from an exception, make sure the except handler doesn't fail
        end else
          System.TMonitor.Exit(Info.FWaiter);
      end;
    except
      Info.FWaiter.Free;
      raise;
    end;
    if Index <> nil then
      Index^ := WaitIndex;
    if Event <> nil then
      Event^ := Events[WaitIndex];
  end;
end;

procedure TMultiWaitEvent.RemoveExpiredWaiters;
var
  I: Integer;
  Info: PWaitInfo;
begin
  for I := WaiterCount - 1 downto 0 do
  begin
    Info := Waiters[I];
    if WaiterExpired(Info^) then
      RemoveWaiter(I);
  end;
end;

procedure TMultiWaitEvent.ResetEvent;
begin
  AtomicSetEventState(False);
end;

procedure TMultiWaitEvent.SetEvent;
var
  I: Integer;
  Info: PWaitInfo;
begin
  Lock;
  try
    AtomicSetEventState(True);
    for I := 0 to WaiterCount - 1 do
    begin
      Info := Waiters[I];
      System.TMonitor.Enter(Info.FWaiter);
      if not (TWaiterFlag.Waiting in Info.FWaiter.FFlags) then
      begin
        Dec(Info.FWaiter.FRefCount);
        if Info.FWaiter.FRefCount = 0 then
        begin
          System.TMonitor.Exit(Info.FWaiter);
          FreeAndNil(Info.FWaiter);
        end else
          System.TMonitor.Exit(Info.FWaiter);
        Continue;
      end;
      if TWaiterFlag.WaitAll in Info.FWaiter.FFlags then
        Dec(Info.FWaiter.FStatus.EventCount)
      else
      begin
        Info.FWaiter.FStatus.FiredEvent := Info.FIndex;
        Exclude(Info.FWaiter.FFlags, TWaiterFlag.Waiting);
      end;
      System.TMonitor.Exit(Info.FWaiter);
      System.TMonitor.Pulse(Info.FWaiter.FCond);
    end;
    ClearWaiters;
  finally
    Unlock;
  end;
  NotifyWaiters;
end;

function TMultiWaitEvent.WaiterExpired(var Info: TWaitInfo): Boolean;
begin
  Result := System.TMonitor.TryEnter(Info.FWaiter);
  if Result then
  try
    if not (TWaiterFlag.Waiting in Info.FWaiter.FFlags) then
      Dec(Info.FWaiter.FRefCount);
  finally
    if Info.FWaiter.FRefCount = 0 then
    begin
      System.TMonitor.Exit(Info.FWaiter);
      FreeAndNil(Info.FWaiter);
    end else
    begin
      System.TMonitor.Exit(Info.FWaiter);
      Result := False;
    end;
  end;
end;

class function TMultiWaitEvent.WaitForAll(const Events: array of TMultiWaitEvent; Timeout: Cardinal): TWaitResult;
begin
  Result := DoWait(Events, True, nil, nil, Timeout);
end;

class function TMultiWaitEvent.WaitForAny(const Events: array of TMultiWaitEvent; Timeout: Cardinal): TWaitResult;
begin
  Result := DoWait(Events, False, nil, nil, Timeout);
end;

class function TMultiWaitEvent.WaitForAny(const Events: array of TMultiWaitEvent; out Event: TMultiWaitEvent; Timeout: Cardinal): TWaitResult;
begin
  Result := DoWait(Events, False, nil, @Event, Timeout);
end;

class function TMultiWaitEvent.WaitForAny(const Events: array of TMultiWaitEvent; out Index: Integer; Timeout: Cardinal): TWaitResult;
begin
  Result := DoWait(Events, False, @Index, nil, Timeout);
end;

{ TMultiWaitEvent.TMultiWaiter }

constructor TMultiWaitEvent.TMultiWaiter.Create;
begin
  inherited Create;
  FCond := TObject.Create;
end;

destructor TMultiWaitEvent.TMultiWaiter.Destroy;
begin
  FCond.Free;
  inherited;
end;

end.
