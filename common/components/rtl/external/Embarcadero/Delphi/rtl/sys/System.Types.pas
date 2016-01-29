{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Types;

interface

type
  PLongint = System.PLongint;
  {$EXTERNALSYM PLongint}
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

{ Duplicate management }

  TDuplicates = (dupIgnore, dupAccept, dupError);
  TDirection = (FromBeginning, FromEnd);

  {$NODEFINE TSize}
  {$NODEFINE PSize}

  PSize = ^TSize;
  TSize = record
    cx: Longint;
    cy: Longint;
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

  TVectorArray = array [0..2] of Single;

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
    X: Longint;
    Y: Longint;
  public
    constructor Create(P : TPoint); overload;
    constructor Create(const X, Y : Integer); overload;

    //operator overloads
    class operator Equal(const Lhs, Rhs : TPoint) : Boolean;
    class operator NotEqual(const Lhs, Rhs : TPoint): Boolean;
    class operator Add(const Lhs, Rhs : TPoint): TPoint;
    class operator Subtract(const Lhs, Rhs : TPoint): TPoint;
{$IFDEF FALSE}
    class operator Explicit(const Size: TSize): TPoint;
    class operator Explicit(const Point: TPoint): TSize;
    class operator Explicit(const SmallPoint: TSmallPoint): TPoint;
    class operator Explicit(const Point: TPoint): TSmallPoint;
    class operator Implicit(const Size: TSize): TPoint;
    class operator Implicit(const Point: TPoint): TSize;
{$ENDIF}

    class operator Implicit(Value: TSmallPoint): TPoint;
    class operator Explicit(Value: TPoint): TSmallPoint;

    function Distance(const P2 : TPoint) : Double;

    procedure SetLocation(const X, Y : Integer); overload;
    procedure SetLocation(const P : TPoint); overload;
    procedure Offset(const DX, DY : Integer); overload;
    procedure Offset(const Point: TPoint); overload;
    function Add(const Point: TPoint): TPoint;
    function Subtract(const Point: TPoint): TPoint;
    function IsZero : Boolean;
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
    0: (Left, Top, Right, Bottom: Longint);
    1: (TopLeft, BottomRight: TPoint);
  end;
  {$NODEFINE TRect}

  PPointF = ^TPointF;
  TPointF = record
    X: Single;
    Y: Single;
  public
    constructor Create(const P: TPointF); overload;
    constructor Create(const X, Y: Single); overload;
    constructor Create(P: TPoint); overload;

    //operator overloads
    class operator Equal(const Lhs, Rhs: TPointF): Boolean;
    class operator NotEqual(const Lhs, Rhs: TPointF): Boolean;
    class operator Add(const Lhs, Rhs: TPointF): TPointF;
    class operator Subtract(const Lhs, Rhs: TPointF): TPointF;

    // vector multiplication
    class operator Multiply(const Lhs, Rhs: TPointF): TPointF;

    function Distance(const P2: TPointF): Double;

    procedure SetLocation(const X, Y: Single); overload;
    procedure SetLocation(const P: TPointF); overload;
    procedure SetLocation(const P: TPoint); overload;

    procedure Offset(const DX, DY: Single); overload;
    procedure Offset(const Point: TPointF); overload;
    procedure Offset(const Point: TPoint); overload;

    function Add(const Point: TPointF): TPointF; overload;
    function Add(const Point: TPoint): TPointF; overload;

    function Subtract(const Point: TPointF): TPointF; overload;
    function Subtract(const Point: TPoint): TPointF; overload;
    function IsZero: Boolean;

    function Ceiling: TPoint;
    function Truncate: TPoint;
    function Round: TPoint;

    // vector scaling by constant factor
    function Scale(const AFactor: Single): TPointF;
    // vector normalization
    function Normalize: TPointF;
  end;

  TPolygon = array of TPointF;

  TCubicBezier = array [0..3] of TPointF;

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

    // union of two rectangles
    class operator Add(const Lhs, Rhs: TRectF): TRectF;

    // intersection of two rectangles
    class operator Multiply(const Lhs, Rhs: TRectF): TRectF;

    class function Empty: TRectF; inline; static;

    //utility methods

    // Current rect enters into the boundaries of the rectangle with keeping
    // aspect ratio and return ratio's value
    function Fit(BoundsRect: TRectF): Single;

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
  
  tagVECTOR = record
    case Integer of
      0: (V: TVectorArray;);
      1: (X: Single;
          Y: Single;
          W: Single;);
  end;
  
  TVector = record
  private
    // sum of squares coords
    function Norm: Single;

    // 1 div square root, when square root is not null
    function RSqrt(const AValue: Single): Single;

    function Add(const AVector: TVector): TVector;
    function Subtract(const AVector: TVector): TVector;
  public
    constructor Create(const AX, AY, AW : Single); overload;
    constructor Create(const APoint : TPointF); overload;

    function Normalize: TVector;

    // proportional change vector's length
    function Scale(const AFactor: Single): TVector;

    // calc vector's length
    function Length: Single;

    // multiplying the vector's coordinates
    function DotProduct(const AVector: TVector): Single;

    function Reflect(const AVector: TVector): TVector;

    // get TPointF value
    function ToPointF: TPointF;
    class operator Add(const AFirstVector, ASecondVector : TVector) : TVector ;
    class operator Subtract(const AFirstVector, ASecondVector : TVector) : TVector ;
    class operator Equal(const AFirstVector, ASecondVector : TVector) : Boolean;
    class operator NotEqual(const AFirstVector, ASecondVector : TVector): Boolean;
    class operator Implicit(AVector : TVector) : TPointF;
    class operator Explicit(AVector : TVector) : TPointF;
    class operator Implicit(APointF : TPointF) : TVector;
    class operator Explicit(APointF : TPointF) : TVector;
    class operator Implicit(ASizeF : TSizeF) : TVector;
    class operator Explicit(ASizeF : TSizeF) : TVector;
    case Integer of
      0: (V: TVectorArray;);
      1: (X: Single;
          Y: Single;
          W: Single;);
  end;

  TMatrixArray = array [0..2] of TVector;
  {$NODEFINE TMatrixArray 'System::Types::TMatrixArray' 'System::Types::TMaxtrixArrayBase'} 
  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END 'typedef TVector TMatrixArray[3];'*)
  (*$HPPEMIT END CLOSENAMESPACE*)
  TMaxtrixArrayBase = array[0..2] of tagVECTOR;
  
  TMatrix = record
  private
  public
    function Transform(const AVector: TVector): TVector;
    case Integer of
      0: (M: TMatrixArray;);
      1: (m11, m12, m13: Single;
          m21, m22, m23: Single;
          m31, m32, m33: Single);
  end;

  TVector3DType = array [0..3] of Single;

  TPoint3D = record
  public
    X: Single;
    Y: Single;
    Z: Single;
  private
    // for class operator's
    function Add(const APoint3D: TPoint3D): TPoint3D;
    function Subtract(const APoint3D: TPoint3D): TPoint3D;
    function Equal(const APoint3D: TPoint3D) : Boolean;
    function NotEqual(const APoint3D: TPoint3D) : Boolean;
    function Multiply(const APoint3D: TPoint3D): TPoint3D;
  public
    constructor Create(X, Y, Z: Single); overload;
    constructor Create(const P: TVector3DType); overload;
    // multiplying by constant
    function Scale(const AFactor: Single): TPoint3D;
    // cross product
    function CrossProduct(const APoint3D: TPoint3D): TPoint3D;
    // sum of multiplying by each coordinates
    function DotProduct(const APoint3D: TPoint3D): Single;
    // length from null point to this point
    function Length: Single;
    // normalize point
    function Normalize: TPoint3D;
    // length from this point to APoint
    function Distance(const APoint3D: TPoint3D): Single;
    // negative all coordinates
    function Negative: TPoint3D;
    class operator Add(const APoint1, APoint2: TPoint3D) : TPoint3D;
    class operator Subtract(const APoint1, APoint2: TPoint3D) : TPoint3D;
    class operator Equal(const APoint1, APoint2: TPoint3D) : Boolean;
    class operator NotEqual(const APoint1, APoint2: TPoint3D) : Boolean;
    class operator Multiply(const APoint1, APoint2: TPoint3D) : TPoint3D;
  end;
  PPoint3D = ^TPoint3D;

  tagVECTOR3D = record 
    case Integer of
      0: (V: TVector3DType;);
      1: (X: Single;
          Y: Single;
          Z: Single;
          W: Single;);
  end;

  TVector3D = record
  private
    // for class operator's
    function Norm: Single;
    function RSqrt(const AValue: Single): Single; inline;
    function Add(const AVector3D: TVector3D): TVector3D; inline;
    function Subtract(const AVector3D: TVector3D): TVector3D; inline;
  public
    constructor Create(const X, Y, Z: Single; const W: Single = 1.0); overload;
    constructor Create(const APoint3D: TPoint3D; const W: Single = 1.0); overload;
    // average of two vector's
    function MidVector(const AVector3D: TVector3D): TVector3D;
    // do self Normalize
    procedure Normalize;
    // get normalized vector
    function GetNormalize: TVector3D;
    // add by self
    procedure AddVector3D(const AVector3D: TVector3D);
    // sum of multiplying by each coordinates
    function DotProduct(const AVector3D: TVector3D): Single;
    //
    function Reflect(const AVector3D: TVector3D): TVector3D;
    // add to each coondinates some const
    function AddScale(const AValue: Single): TVector3D;
    // mult each coordinates by some const
    function Scale(factor: Single): TVector3D;
    //
    function PointProject(const AOrigin, ADirection: TVector3D): Single;
    //
    function Distance(const AVector3D: TVector3D): Single;
    // lentgh of this vector
    function Length: Single;
    // cross product
    function CrossProduct(const AVector3D: TVector3D): TVector3D;
    //
    function CalcPlaneNormal(const AVector3D1, AVector3D2: TVector3D): TVector3D;
    class operator Add(const AFirstVector3D, ASecondVector3D: TVector3D): TVector3D;
    class operator Subtract(const AFirstVector3D, ASecondVector3D: TVector3D): TVector3D;
    class operator Equal(const AFirstVector3D, ASecondVector3D: TVector3D): Boolean;
    class operator NotEqual(const AFirstVector3D, ASecondVector3D: TVector3D): Boolean;
    class operator Implicit(AVector3D: TVector3D): TPoint3D;
    class operator Explicit(AVector3D: TVector3D): TPoint3D;
    class operator Implicit(APoint3D: TPoint3D): TVector3D;
    class operator Explicit(APoint3D: TPoint3D): TVector3D;
    class operator Multiply(const AVector3D1, AVector3D2: TVector3D): TVector3D;
    case Integer of
      0: (V: TVector3DType;);
      1: (X: Single;
          Y: Single;
          Z: Single;
          W: Single;);
  end;

  TVector3DArray = array [0..2] of TVector3D;
  {$NODEFINE TVector3DArray 'System::Types::TVector3DArray' 'System::Types::TVector3DArrayBase'}
  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END 'typedef TVector3D TVector3DArray[3];'*)
  (*$HPPEMIT END CLOSENAMESPACE*)
  TVector3DArrayBase = array[0..2] of tagVECTOR3D;

  TMatrix3DType = array [0..3] of TVector3D;
  {$NODEFINE TMatrix3DType 'System::Types::TMatrix3DType' 'System::Types::TMatrix3DTypeBase'}
  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END 'typedef TVector3D TMatrix3DType[3];'*)
  (*$HPPEMIT END CLOSENAMESPACE*)
  TMatrix3DTypeBase = array[0..3] of tagVECTOR3D;

  TMatrix3D = record
  public
    // multiplication of two 3D matrices
    class operator Multiply(const Lhs, Rhs: TMatrix3D): TMatrix3D;
    // multiplication of 4D(3D + w) vector and 3D (4x4) matrix
    class operator Multiply(const AVector: TVector3D;
     const AMatrix: TMatrix3D): TVector3D;

    function Transpose:TMatrix3D;
    function Scale(const factor: single):TMatrix3D;
    class function TransposeMatrix3D(const AMatrix: TMatrix3D):TMatrix3D; static;
    class function ScaleMatrix3D(const AMatrix: TMatrix3D; const factor: single):TMatrix3D; static;
    // calculates eye position from 3D matrix
    function EyePosition(): TPoint3D;
    case Integer of
      0: (M: TMatrix3DType;);
      1: (m11, m12, m13, m14: Single;
          m21, m22, m23, m24: Single;
          m31, m32, m33, m34: Single;
          m41, m42, m43, m44: Single);
  end;

  TQuaternion3D = record
    ImagPart: TVector3D;
    RealPart: Single;
  end;


  (*$HPPEMIT '#include <SystemTypes.h>'*)

  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END '  inline bool TRect::IntersectRect(const TRect &R1, const TRect &R2)'*)
  (*$HPPEMIT END '  {'*)
  (*$HPPEMIT END '    return Types::IntersectRect(*this, R1, R2) != 0;'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline TRect TRect::Intersect(const TRect &r1, const TRect &r2) {'*)
  (*$HPPEMIT END '    TRect result;'*)
  (*$HPPEMIT END '    Types::IntersectRect(result, r1, r2);'*)
  (*$HPPEMIT END '    return result;'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline void TRect::Intersect(const TRect &r) {'*)
  (*$HPPEMIT END '    Types::IntersectRect(*this, *this, r);'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline bool TRect::UnionRect(const TRect &R1, const TRect &R2)'*)
  (*$HPPEMIT END '  {'*)
  (*$HPPEMIT END '    return Types::UnionRect(*this, R1, R2) != 0;'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline TRect TRect::Union(const TRect &r1, const TRect& r2) {'*)
  (*$HPPEMIT END '    TRect result;'*)
  (*$HPPEMIT END '    Types::UnionRect(result, r1, r2);'*)
  (*$HPPEMIT END '    return result;'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline void TRect::Union(const TRect &r) {'*)
  (*$HPPEMIT END '    Types::UnionRect(*this, *this, r);'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline TRectF TRectF::Intersect(const TRectF &r1, const TRectF &r2) {'*)
  (*$HPPEMIT END '    TRectF result;'*)
  (*$HPPEMIT END '    Types::IntersectRectF(result, r1, r2);'*)
  (*$HPPEMIT END '    return result;'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline void TRectF::Intersect(const TRectF &r) {'*)
  (*$HPPEMIT END '    Types::IntersectRectF(*this, *this, r);'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline TRectF TRectF::Union(const TRectF &r1, const TRectF &r2) {'*)
  (*$HPPEMIT END '    TRectF result;'*)
  (*$HPPEMIT END '    Types::UnionRectF(result, r1, r2);'*)
  (*$HPPEMIT END '    return result;'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END '  inline void TRectF::Union(const TRectF &r) {'*)
  (*$HPPEMIT END '    Types::UnionRectF(*this, *this, r);'*)
  (*$HPPEMIT END '  }'*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END ''*)
  (*$HPPEMIT END CLOSENAMESPACE*)

  //NOTE: DWORD should really be CppULongInt
  DWORD = LongWord;
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
  STGTY_STREAM    = 2;
  STGTY_LOCKBYTES = 3;
  STGTY_PROPERTY  = 4;

  STREAM_SEEK_SET = 0;
  STREAM_SEEK_CUR = 1;
  STREAM_SEEK_END = 2;

  LOCK_WRITE     = 1;
  LOCK_EXCLUSIVE = 2;
  LOCK_ONLYONCE  = 4;

  { Unspecified error }
  E_FAIL                      = HRESULT($80004005);

  { Unable to perform requested operation. }
  STG_E_INVALIDFUNCTION       = HRESULT($80030001);

  { %l could not be found. }
  STG_E_FILENOTFOUND          = HRESULT($80030002);

  { The path %l could not be found. }
  STG_E_PATHNOTFOUND          = HRESULT($80030003);

  { There are insufficient resources to open another file. }
  STG_E_TOOMANYOPENFILES      = HRESULT($80030004);

  { Access Denied. }
  STG_E_ACCESSDENIED          = HRESULT($80030005);

  { Attempted an operation on an invalid object. }
  STG_E_INVALIDHANDLE         = HRESULT($80030006);

  { There is insufficient memory available to complete operation. }
  STG_E_INSUFFICIENTMEMORY    = HRESULT($80030008);

  { Invalid pointer error. }
  STG_E_INVALIDPOINTER        = HRESULT($80030009);

  { There are no more entries to return. }
  STG_E_NOMOREFILES           = HRESULT($80030012);

  { Disk is write-protected. }
  STG_E_DISKISWRITEPROTECTED  = HRESULT($80030013);

  { An error occurred during a seek operation. }
  STG_E_SEEKERROR             = HRESULT($80030019);

  { A disk error occurred during a write operation. }
  STG_E_WRITEFAULT            = HRESULT($8003001D);

  { A disk error occurred during a read operation. }
  STG_E_READFAULT             = HRESULT($8003001E);

  { A share violation has occurred. }
  STG_E_SHAREVIOLATION        = HRESULT($80030020);

  { A lock violation has occurred. }
  STG_E_LOCKVIOLATION         = HRESULT($80030021);

  { %l already exists. }
  STG_E_FILEALREADYEXISTS     = HRESULT($80030050);

  { Invalid parameter error. }
  STG_E_INVALIDPARAMETER      = HRESULT($80030057);

  { There is insufficient disk space to complete operation. }
  STG_E_MEDIUMFULL            = HRESULT($80030070);

  { Illegal write of non-simple property to simple property set. }
  STG_E_PROPSETMISMATCHED     = HRESULT($800300F0);

  { An API call exited abnormally. }
  STG_E_ABNORMALAPIEXIT       = HRESULT($800300FA);

  { The file %l is not a valid compound file. }
  STG_E_INVALIDHEADER         = HRESULT($800300FB);

  { The name %l is not valid. }
  STG_E_INVALIDNAME           = HRESULT($800300FC);

  { An unexpected error occurred. }
  STG_E_UNKNOWN               = HRESULT($800300FD);

  { That function is not implemented. }
  STG_E_UNIMPLEMENTEDFUNCTION = HRESULT($800300FE);

  { Invalid flag error. }
  STG_E_INVALIDFLAG           = HRESULT($800300FF);

  { Attempted to use an object that is busy. }
  STG_E_INUSE                 = HRESULT($80030100);

  { The storage has been changed since the last commit. }
  STG_E_NOTCURRENT            = HRESULT($80030101);

  { Attempted to use an object that has ceased to exist. }
  STG_E_REVERTED              = HRESULT($80030102);

  { Can't save. }
  STG_E_CANTSAVE              = HRESULT($80030103);

  { The compound file %l was produced with an incompatible version of storage. }
  STG_E_OLDFORMAT             = HRESULT($80030104);

  { The compound file %l was produced with a newer version of storage. }
  STG_E_OLDDLL                = HRESULT($80030105);

  { Share.exe or equivalent is required for operation. }
  STG_E_SHAREREQUIRED         = HRESULT($80030106);

  { Illegal operation called on non-file based storage. }
  STG_E_NOTFILEBASEDSTORAGE   = HRESULT($80030107);

  { Illegal operation called on object with extant marshallings. }
  STG_E_EXTANTMARSHALLINGS    = HRESULT($80030108);

  { The docfile has been corrupted. }
  STG_E_DOCFILECORRUPT        = HRESULT($80030109);

  { OLE32.DLL has been loaded at the wrong address. }
  STG_E_BADBASEADDRESS        = HRESULT($80030110);

  { The file download was aborted abnormally.  The file is incomplete. }
  STG_E_INCOMPLETE            = HRESULT($80030201);

  { The file download has been terminated. }
  STG_E_TERMINATED            = HRESULT($80030202);

  { The underlying file was converted to compound file format. }
  STG_S_CONVERTED             = HRESULT($00030200);

  { The storage operation should block until more data is available. }
  STG_S_BLOCK                 = HRESULT($00030201);

  { The storage operation should retry immediately. }
  STG_S_RETRYNOW              = HRESULT($00030202);

  { The notified event sink will not influence the storage operation. }
  STG_S_MONITORING            = HRESULT($00030203);


type
  TOleChar = WideChar;
  POleStr = PWideChar;
  PPOleStr = ^POleStr;

  PCLSID = PGUID;
  TCLSID = TGUID;

{ 64-bit large integer }

  Largeint = Int64;
  {$EXTERNALSYM Largeint}

  PDWORD = ^DWORD;
  {$EXTERNALSYM PDWORD}

  { File System time stamps are represented with the following structure: }
  PFileTime = ^TFileTime;
  _FILETIME = record
    dwLowDateTime: DWORD;
    dwHighDateTime: DWORD;
  end;
  TFileTime = _FILETIME;
  FILETIME = _FILETIME;

{ IStream interface }

  PStatStg = ^TStatStg;
  tagSTATSTG = record
    pwcsName: POleStr;
    dwType: Longint;
    cbSize: Largeint;
    mtime: TFileTime;
    ctime: TFileTime;
    atime: TFileTime;
    grfMode: Longint;
    grfLocksSupported: Longint;
    clsid: TCLSID;
    grfStateBits: Longint;
    reserved: Longint;
  end;
  TStatStg = tagSTATSTG;
  STATSTG = TStatStg;

  IClassFactory = interface(IUnknown)
    ['{00000001-0000-0000-C000-000000000046}']
    function CreateInstance(const unkOuter: IUnknown; const iid: TGUID;
      out obj): HResult; stdcall;
    function LockServer(fLock: LongBool): HResult; stdcall;
  end;

  ISequentialStream = interface(IUnknown)
    ['{0c733a30-2a1c-11ce-ade5-00aa0044773d}']
    function Read(pv: Pointer; cb: Longint; pcbRead: PLongint): HResult;
      stdcall;
    function Write(pv: Pointer; cb: Longint; pcbWritten: PLongint): HResult;
      stdcall;
  end;

  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function Seek(dlibMove: Largeint; dwOrigin: Longint;
      out libNewPosition: Largeint): HResult; stdcall;
    function SetSize(libNewSize: Largeint): HResult; stdcall;
    function CopyTo(stm: IStream; cb: Largeint; out cbRead: Largeint;
      out cbWritten: Largeint): HResult; stdcall;
    function Commit(grfCommitFlags: Longint): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; stdcall;
    function UnlockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; stdcall;
    function Stat(out statstg: TStatStg; grfStatFlag: Longint): HResult;
      stdcall;
    function Clone(out stm: IStream): HResult; stdcall;
  end;
{$ENDIF} { !MSWINDOWS }

function EqualRect(const R1, R2: TRect): Boolean; overload;
function EqualRect(const R1, R2: TRectF): Boolean; overload;
function Rect(Left, Top, Right, Bottom: Integer): TRect;
function RectF(Left, Top, Right, Bottom: Single): TRectF; inline; overload;
function Vector(const X, Y: Single; const W: Single = 1.0): TVector; overload;
function Vector(const P: TPointF; const W: Single = 1.0): TVector; overload;
function Vector3D(const X, Y, Z: Single; const W: Single = 1.0): TVector3D; overload;
function Vector3D(const P: TPoint3D; const W: Single = 1.0): TVector3D; overload;
function Point3D(const X, Y, Z: Single): TPoint3D; overload;
function Point3D(const AVector3D : TVector3D): TPoint3D; overload;
function NormalizeRectF(const Pts: array of TPointF): TRectF; overload;
function NormalizeRect(const ARect: TRectF): TRectF; overload;
function RectWidth(const Rect: TRect): Integer; inline; overload;
function RectWidth(const Rect: TRectF): Single; inline; overload;
function RectHeight(const Rect: TRect): Integer; inline; overload;
function RectHeight(const Rect: TRectF): Single; inline; overload;
function RectCenter(var R: TRect; const Bounds: TRect): TRect; overload;
function RectCenter(var R: TRectF; const Bounds: TRectF): TRectF; overload;
{$EXTERNALSYM Rect}
function Bounds(ALeft, ATop, AWidth, AHeight: Integer): TRect;
{$EXTERNALSYM Bounds}
function Point(X, Y: Integer): TPoint; inline; overload;
{$EXTERNALSYM Point}
function PointF(X, Y: Single): TPointF; inline; overload;
function PointF(const V: TVector): TPointF; inline; overload;
function MinPoint(const P1, P2: TPointF): TPointF; overload;
function MinPoint(const P1, P2: TPoint): TPoint; overload;
function ScalePoint(const P: TPointF; dX, dY: Single): TPointF; overload;
function ScalePoint(const P: TPoint; dX, dY: Single): TPoint; overload;
function SmallPoint(X, Y: Integer): TSmallPoint; inline; overload;
function SmallPoint(XY: LongWord): TSmallPoint; overload;
function PtInRect(const Rect: TRect; const P: TPoint): Boolean; overload;
function PtInRect(const Rect: TRectF; const P: TPointF): Boolean; overload;
function PtInCircle(const Point, Center: TPoint; Radius: Integer): Boolean;
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

{ TVector }

function TVector.RSqrt(const AValue: Single): Single;
begin
  if (AValue > 0) then
    Result := 1 / Sqrt(AValue)
  else if (AValue < 0) then
    Result := 1 / Sqrt(-AValue)
  else
    Result := 1;
end;

function TVector.Add(const AVector: TVector): TVector;
begin
{$EXCESSPRECISION OFF}
  Result.V[0] := Self.V[0] + AVector.V[0];
  Result.V[1] := Self.V[1] + AVector.V[1];
  Result.W := 1.0;
{$EXCESSPRECISION ON}
end;

function TVector.Subtract(const AVector: TVector): TVector;
begin
{$EXCESSPRECISION OFF}
  Result.V[0] := Self.V[0] - AVector.V[0];
  Result.V[1] := Self.V[1] - AVector.V[1];
  Result.W := 1.0;
{$EXCESSPRECISION ON}
end;

function TVector.ToPointF: TPointF;
begin
  Result.X := Self.X;
  Result.Y := Self.Y;
end;

function TVector.Norm: Single;
begin
  Result := Self.V[0] * Self.V[0] + Self.V[1] * Self.V[1];
end;

function TVector.Normalize: TVector;
var
  LInvLen: Single;
begin
{$EXCESSPRECISION OFF}
  LInvLen := RSqrt((Self.Norm));
  Result.V[0] := Self.V[0] * LInvLen;
  Result.V[1] := Self.V[1] * LInvLen;
  Result.V[2] := 0.0;
{$EXCESSPRECISION ON}
end;

class operator TVector.NotEqual(const AFirstVector,
  ASecondVector: TVector): Boolean;
begin
  Result := not (AFirstVector =  ASecondVector);
end;

function TVector.Scale(const AFactor: Single): TVector;
begin
{$EXCESSPRECISION OFF}
  Result.V[0] := Self.V[0] * AFactor;
  Result.V[1] := Self.V[1] * AFactor;
  Result.W := 1;
{$EXCESSPRECISION ON}
end;

class operator TVector.Subtract(const AFirstVector,
  ASecondVector: TVector): TVector;
begin
  Result := AFirstVector.Subtract(ASecondVector) ;
end;

function TVector.Length: Single;
begin
  Result := Sqrt(Self.Norm);
end;

function TVector.DotProduct(const AVector: TVector): Single;
begin
  Result := Self.V[0] * AVector.V[0] + Self.V[1] * AVector.V[1];
end;

class operator TVector.Equal(const AFirstVector,
  ASecondVector: TVector): Boolean;
begin
  Result := SameValue(AFirstVector.X, ASecondVector.X)
    and SameValue(AFirstVector.Y, ASecondVector.Y);
end;

class operator TVector.Explicit(AVector: TVector): TPointF;
begin
  Result := PointF(AVector);
end;

class operator TVector.Explicit(APointF: TPointF): TVector;
begin
  Result := Vector(APointF);
end;

class operator TVector.Explicit(ASizeF: TSizeF): TVector;
begin
  Result := Vector(ASizeF.cx,ASizeF.cy);
end;

class operator TVector.Implicit(AVector: TVector): TPointF;
begin
  Result := PointF(AVector);
end;

class operator TVector.Implicit(APointF: TPointF): TVector;
begin
  Result := Vector(APointF);
end;

class operator TVector.Implicit(ASizeF: TSizeF): TVector;
begin
  Result := Vector(ASizeF.cx,ASizeF.cy);
end;

constructor TVector.Create(const APoint: TPointF);
begin
  Self.X := APoint.X;
  Self.Y := APoint.Y;
  Self.W := 1;
end;

constructor TVector.Create(const AX, AY, AW: Single);
begin
  Self.X := AX;
  Self.Y := AY;
  Self.W := AW;
end;

function TVector.Reflect(const AVector: TVector): TVector;
begin
  Result := Self.Add( AVector.Scale(-2 * Self.DotProduct(AVector)));
end;

class operator TVector.Add(const AFirstVector, ASecondVector: TVector): TVector;
begin
  Result := AFirstVector.Add(ASecondVector) ;
end;

function TMatrix.Transform(const AVector: TVector): TVector;
begin
  Result.V[0] := AVector.V[0] * Self.M[0].V[0] + AVector.V[1] * Self.M[1].V[0]
    + AVector.V[2] * Self.M[2].V[0];
  Result.V[1] := AVector.V[0] * Self.M[0].V[1] + AVector.V[1] * Self.M[1].V[1]
    + AVector.V[2] * Self.M[2].V[1];
  Result.V[2] := 1.0;
end;

{ TPoint3D }

constructor TPoint3D.Create(X, Y, Z: Single);
begin
  Self.X := X;
  Self.Y := Y;
  Self.Z := Z;
end;

class operator TPoint3D.Add(const APoint1, APoint2: TPoint3D): TPoint3D;
begin
  Result := APoint1.Add(APoint2) ;
end;

function TPoint3D.Add(const APoint3D: TPoint3D): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X + APoint3D.X;
  Result.Y := Self.Y + APoint3D.Y;
  Result.Z := Self.Z + APoint3D.Z;
{$EXCESSPRECISION ON}
end;

constructor TPoint3D.Create(const P: TVector3DType);
begin
  Self.X := P[0];
  Self.Y := P[1];
  Self.Z := P[2];
end;

function TPoint3D.CrossProduct(const APoint3D: TPoint3D): TPoint3D;
begin
  Result.X := (Self.Y * APoint3D.Z) - (Self.Z * APoint3D.Y);
  Result.Y := (Self.Z * APoint3D.X) - (Self.X * APoint3D.Z);
  Result.Z := (Self.X * APoint3D.Y) - (Self.Y * APoint3D.X);
end;

function TPoint3D.Distance(const APoint3D: TPoint3D): Single;
begin
{$EXCESSPRECISION OFF}
  Result := (Self - APoint3D).Length;
{$EXCESSPRECISION ON}
end;

function TPoint3D.DotProduct(const APoint3D: TPoint3D): Single;
begin
  Result := (Self.X * APoint3D.X) + (Self.Y * APoint3D.Y) +
    (Self.Z * APoint3D.Z);
end;

class operator TPoint3D.Equal(const APoint1, APoint2: TPoint3D): Boolean;
begin
  Result := APoint1.Equal(APoint2);
end;

function TPoint3D.Equal(const APoint3D: TPoint3D): Boolean;
begin
  Result := SameValue(Self.X, APoint3D.X) and SameValue(Self.Y, APoint3D.Y)
    and SameValue(Self.Z, APoint3D.Z);
end;

function TPoint3D.Length: Single;
begin
  Result := Sqrt(Self.X * Self.X + Self.Y * Self.Y + Self.Z * Self.Z);
end;

class operator TPoint3D.Multiply(const APoint1, APoint2: TPoint3D): TPoint3D;
begin
  Result := APoint1.Multiply(APoint2);
end;

function TPoint3D.Multiply(const APoint3D: TPoint3D): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X * APoint3D.X;
  Result.Y := Self.Y * APoint3D.Y;
  Result.Z := Self.Z * APoint3D.Z;
{$EXCESSPRECISION ON}
end;

function TPoint3D.Negative: TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := - Self.X;
  Result.Y := - Self.Y;
  Result.Z := - Self.Z;
{$EXCESSPRECISION ON}
end;

function TPoint3D.Normalize: TPoint3D;
var
  Magn: Single;
begin
  Magn := Self.Length;
  if (Magn <> 0.0) then
    Result := Self.Scale(1.0 / Magn)
  else
    Result := TPoint3D.Create(0.0, 0.0, 0.0);
end;

function TPoint3D.NotEqual(const APoint3D: TPoint3D): Boolean;
begin
  Result := Not (Self = APoint3D);
end;

class operator TPoint3D.NotEqual(const APoint1, APoint2: TPoint3D): Boolean;
begin
  Result := APoint1.NotEqual(APoint2) ;
end;

function TPoint3D.Scale(const AFactor: Single): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X * AFactor;
  Result.Y := Self.Y * AFactor;
  Result.Z := Self.Z * AFactor;
{$EXCESSPRECISION ON}
end;

function TPoint3D.Subtract(const APoint3D: TPoint3D): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X - APoint3D.X;
  Result.Y := Self.Y - APoint3D.Y;
  Result.Z := Self.Z - APoint3D.Z;
{$EXCESSPRECISION ON}
end;

class operator TPoint3D.Subtract(const APoint1, APoint2: TPoint3D): TPoint3D;
begin
  Result := APoint1.Subtract(APoint2);
end;

{ TVector3D }

function TVector3D.Add(const AVector3D: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X + AVector3D.X;
  Result.Y := Self.Y + AVector3D.Y;
  Result.Z := Self.Z + AVector3D.Z;
  Result.W := 1.0;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Add(const AFirstVector3D,
  ASecondVector3D: TVector3D): TVector3D;
begin
  Result := AFirstVector3D.Add(ASecondVector3D);
end;

procedure TVector3D.AddVector3D(const AVector3D: TVector3D);
begin
  Self := Self + AVector3D;
end;

function TVector3D.CalcPlaneNormal(const AVector3D1, AVector3D2: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result := (AVector3D1 - Self).CrossProduct(AVector3D2 - Self) ;
  Result := Result.GetNormalize ;
{$EXCESSPRECISION ON}
end;

constructor TVector3D.Create(const X, Y, Z, W: Single);
begin
  Self.X := X;
  Self.Y := Y;
  Self.Z := Z;
  Self.W := W;
end;

constructor TVector3D.Create(const APoint3D: TPoint3D; const W: Single);
begin
  Self.X := APoint3D.X;
  Self.Y := APoint3D.Y;
  Self.Z := APoint3D.Z;
  Self.W := W;
end;

function TVector3D.DotProduct(const AVector3D: TVector3D): Single;
begin
  Result := Self.X * AVector3D.X + Self.Y * AVector3D.Y + Self.Z * AVector3D.Z;
end;

class operator TVector3D.Equal(const AFirstVector3D,
  ASecondVector3D: TVector3D): Boolean;
begin
  Result := SameValue(AFirstVector3D.X, ASecondVector3D.X)
    and SameValue(AFirstVector3D.Y, ASecondVector3D.Y)
    and SameValue(AFirstVector3D.Z, ASecondVector3D.Z);
end;

class operator TVector3D.Explicit(AVector3D: TVector3D): TPoint3D;
begin
  Result := Point3D(AVector3D);
end;

class operator TVector3D.Explicit(APoint3D: TPoint3D): TVector3D;
begin
  Result := Vector3D(APoint3D);
end;

function TVector3D.MidVector(const AVector3D: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := (Self.X + AVector3D.X) / 2;
  Result.Y := (Self.Y + AVector3D.Y) / 2;
  Result.Z := (Self.Z + AVector3D.Z) / 2;
  Result.W := 1;
{$EXCESSPRECISION ON}
end;

function TVector3D.Norm: Single;
begin
  Result := (Self.X * Self.X) + (Self.Y * Self.Y) + (Self.Z * Self.Z);
end;

function TVector3D.GetNormalize: TVector3D;
var
  invLen: Single;
begin
{$EXCESSPRECISION OFF}
  invLen := RSqrt(Self.Norm);
  Result.X := Self.X * invLen;
  Result.Y := Self.Y * invLen;
  Result.Z := Self.Z * invLen;
  Result.W := 0.0;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Implicit(AVector3D: TVector3D): TPoint3D;
begin
  Result := Point3D(AVector3D);
end;

class operator TVector3D.Implicit(APoint3D: TPoint3D): TVector3D;
begin
  Result := Vector3D(APoint3D);
end;

procedure TVector3D.Normalize;
begin
  Self := Self.GetNormalize;
end;

class operator TVector3D.NotEqual(const AFirstVector3D,
  ASecondVector3D: TVector3D): Boolean;
begin
  Result := Not (AFirstVector3D = ASecondVector3D);
end;

function TVector3D.PointProject(const AOrigin, ADirection: TVector3D): Single;
begin
  Result := ADirection.X * (Self.X - AOrigin.X)
    + ADirection.Y * (Self.Y - AOrigin.Y)
    + ADirection.Z * (Self.Z - AOrigin.Z);
end;

function TVector3D.RSqrt(const AValue: Single): Single;
begin
  if AValue > 0 then
    Result := 1 / Sqrt(AValue)
  else if AValue < 0 then
    Result := 1 / Sqrt(-AValue)
  else
    Result := 1;
end;

function TVector3D.Scale(factor: Single): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X * factor;
  Result.Y := Self.Y * factor;
  Result.Z := Self.Z * factor;
  Result.W := 1;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Subtract(const AFirstVector3D,
  ASecondVector3D: TVector3D): TVector3D;
begin
  Result := AFirstVector3D.Subtract(ASecondVector3D);
end;

function TVector3D.Subtract(const AVector3D: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X - AVector3D.X;
  Result.Y := Self.Y - AVector3D.Y;
  Result.Z := Self.Z - AVector3D.Z;
  Result.W := 1.0;
{$EXCESSPRECISION ON}
end;

function TVector3D.AddScale(const AValue: Single): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := Self.X + AValue;
  Result.Y := Self.Y + AValue;
  Result.Z := Self.Z + AValue;
  Result.W := 1.0;
{$EXCESSPRECISION ON}
end;

function TVector3D.CrossProduct(const AVector3D: TVector3D): TVector3D;
begin
  Result.X := Self.Y * AVector3D.Z - Self.Z * AVector3D.Y;
  Result.Y := Self.Z * AVector3D.X - Self.X * AVector3D.Z;
  Result.Z := Self.X * AVector3D.Y - Self.Y * AVector3D.X;
  Result.W := 1.0;
end;

function TVector3D.Length: Single;
begin
  Result := Sqrt(Self.Norm);
end;

function TVector3D.Reflect(const AVector3D: TVector3D): TVector3D;
begin
  Result := Self.Scale(1) + AVector3D.Scale(-2 * Self.DotProduct(AVector3D))
end;

function TVector3D.Distance(const AVector3D: TVector3D): Single;
begin
  Result := Sqr(AVector3D.X - Self.X) + Sqr(AVector3D.Y - Self.Y) + Sqr(AVector3D.Z - Self.Z);
end;

class operator TVector3D.Multiply(const AVector3D1,
  AVector3D2: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := AVector3D1.X * AVector3D2.X;
  Result.Y := AVector3D1.Y * AVector3D2.Y;
  Result.Z := AVector3D1.Z * AVector3D2.Z;
  Result.W := AVector3D1.W * AVector3D2.W;
{$EXCESSPRECISION ON}
end;

{ TMatrix3D }
class operator TMatrix3D.Multiply(const Lhs, Rhs: TMatrix3D): TMatrix3D;
begin
  Result.M[0].V[0] := Lhs.M[0].V[0] * Rhs.M[0].V[0] + Lhs.M[0].V[1] * Rhs.M[1].V[0] + Lhs.M[0].V[2] * Rhs.M[2].V[0] + Lhs.M[0].V[3] * Rhs.M[3].V[0];
  Result.M[0].V[1] := Lhs.M[0].V[0] * Rhs.M[0].V[1] + Lhs.M[0].V[1] * Rhs.M[1].V[1] + Lhs.M[0].V[2] * Rhs.M[2].V[1] + Lhs.M[0].V[3] * Rhs.M[3].V[1];
  Result.M[0].V[2] := Lhs.M[0].V[0] * Rhs.M[0].V[2] + Lhs.M[0].V[1] * Rhs.M[1].V[2] + Lhs.M[0].V[2] * Rhs.M[2].V[2] + Lhs.M[0].V[3] * Rhs.M[3].V[2];
  Result.M[0].V[3] := Lhs.M[0].V[0] * Rhs.M[0].V[3] + Lhs.M[0].V[1] * Rhs.M[1].V[3] + Lhs.M[0].V[2] * Rhs.M[2].V[3] + Lhs.M[0].V[3] * Rhs.M[3].V[3];
  Result.M[1].V[0] := Lhs.M[1].V[0] * Rhs.M[0].V[0] + Lhs.M[1].V[1] * Rhs.M[1].V[0] + Lhs.M[1].V[2] * Rhs.M[2].V[0] + Lhs.M[1].V[3] * Rhs.M[3].V[0];
  Result.M[1].V[1] := Lhs.M[1].V[0] * Rhs.M[0].V[1] + Lhs.M[1].V[1] * Rhs.M[1].V[1] + Lhs.M[1].V[2] * Rhs.M[2].V[1] + Lhs.M[1].V[3] * Rhs.M[3].V[1];
  Result.M[1].V[2] := Lhs.M[1].V[0] * Rhs.M[0].V[2] + Lhs.M[1].V[1] * Rhs.M[1].V[2] + Lhs.M[1].V[2] * Rhs.M[2].V[2] + Lhs.M[1].V[3] * Rhs.M[3].V[2];
  Result.M[1].V[3] := Lhs.M[1].V[0] * Rhs.M[0].V[3] + Lhs.M[1].V[1] * Rhs.M[1].V[3] + Lhs.M[1].V[2] * Rhs.M[2].V[3] + Lhs.M[1].V[3] * Rhs.M[3].V[3];
  Result.M[2].V[0] := Lhs.M[2].V[0] * Rhs.M[0].V[0] + Lhs.M[2].V[1] * Rhs.M[1].V[0] + Lhs.M[2].V[2] * Rhs.M[2].V[0] + Lhs.M[2].V[3] * Rhs.M[3].V[0];
  Result.M[2].V[1] := Lhs.M[2].V[0] * Rhs.M[0].V[1] + Lhs.M[2].V[1] * Rhs.M[1].V[1] + Lhs.M[2].V[2] * Rhs.M[2].V[1] + Lhs.M[2].V[3] * Rhs.M[3].V[1];
  Result.M[2].V[2] := Lhs.M[2].V[0] * Rhs.M[0].V[2] + Lhs.M[2].V[1] * Rhs.M[1].V[2] + Lhs.M[2].V[2] * Rhs.M[2].V[2] + Lhs.M[2].V[3] * Rhs.M[3].V[2];
  Result.M[2].V[3] := Lhs.M[2].V[0] * Rhs.M[0].V[3] + Lhs.M[2].V[1] * Rhs.M[1].V[3] + Lhs.M[2].V[2] * Rhs.M[2].V[3] + Lhs.M[2].V[3] * Rhs.M[3].V[3];
  Result.M[3].V[0] := Lhs.M[3].V[0] * Rhs.M[0].V[0] + Lhs.M[3].V[1] * Rhs.M[1].V[0] + Lhs.M[3].V[2] * Rhs.M[2].V[0] + Lhs.M[3].V[3] * Rhs.M[3].V[0];
  Result.M[3].V[1] := Lhs.M[3].V[0] * Rhs.M[0].V[1] + Lhs.M[3].V[1] * Rhs.M[1].V[1] + Lhs.M[3].V[2] * Rhs.M[2].V[1] + Lhs.M[3].V[3] * Rhs.M[3].V[1];
  Result.M[3].V[2] := Lhs.M[3].V[0] * Rhs.M[0].V[2] + Lhs.M[3].V[1] * Rhs.M[1].V[2] + Lhs.M[3].V[2] * Rhs.M[2].V[2] + Lhs.M[3].V[3] * Rhs.M[3].V[2];
  Result.M[3].V[3] := Lhs.M[3].V[0] * Rhs.M[0].V[3] + Lhs.M[3].V[1] * Rhs.M[1].V[3] + Lhs.M[3].V[2] * Rhs.M[2].V[3] + Lhs.M[3].V[3] * Rhs.M[3].V[3];
end;

class operator TMatrix3D.Multiply(const AVector: TVector3D;
 const AMatrix: TMatrix3D): TVector3D;
begin
  Result.X := (AVector.X * AMatrix.m11) + (AVector.Y * AMatrix.m21) + (AVector.Z * AMatrix.m31) + (AVector.W * AMatrix.m41);
  Result.Y := (AVector.X * AMatrix.m12) + (AVector.Y * AMatrix.m22) + (AVector.Z * AMatrix.m32) + (AVector.W * AMatrix.m42);
  Result.Z := (AVector.X * AMatrix.m13) + (AVector.Y * AMatrix.m23) + (AVector.Z * AMatrix.m33) + (AVector.W * AMatrix.m43);
  Result.W := (AVector.X * AMatrix.m14) + (AVector.Y * AMatrix.m24) + (AVector.Z * AMatrix.m34) + (AVector.W * AMatrix.m44);
end;

function TMatrix3D.Scale(const factor: single): TMatrix3D;
var
  i: Integer;
begin
{$EXCESSPRECISION OFF}
  for i := 0 to 3 do
  begin
    Result.M[i].V[0] := Self.M[i].V[0] * factor;
    Result.M[i].V[1] := Self.M[i].V[1] * factor;
    Result.M[i].V[2] := Self.M[i].V[2] * factor;
    Result.M[i].V[3] := Self.M[i].V[3] * factor;
  end;
{$EXCESSPRECISION ON}
end;

class function TMatrix3D.ScaleMatrix3D(const AMatrix: TMatrix3D;
  const factor: single): TMatrix3D;
var
  i: Integer;
begin
{$EXCESSPRECISION OFF}
  for i := 0 to 3 do
  begin
    Result.M[i].V[0] := AMatrix.M[i].V[0] * factor;
    Result.M[i].V[1] := AMatrix.M[i].V[1] * factor;
    Result.M[i].V[2] := AMatrix.M[i].V[2] * factor;
    Result.M[i].V[3] := AMatrix.M[i].V[3] * factor;
  end;
{$EXCESSPRECISION ON}
end;

function TMatrix3D.Transpose: TMatrix3D;
begin
  Result.M[0].V[0] := Self.M[0].V[0];
  Result.M[0].V[1] := Self.M[1].V[0];
  Result.M[0].V[2] := Self.M[2].V[0];
  Result.M[0].V[3] := Self.M[3].V[0];
  Result.M[1].V[0] := Self.M[0].V[1];
  Result.M[1].V[1] := Self.M[1].V[1];
  Result.M[1].V[2] := Self.M[2].V[1];
  Result.M[1].V[3] := Self.M[3].V[1];
  Result.M[2].V[0] := Self.M[0].V[2];
  Result.M[2].V[1] := Self.M[1].V[2];
  Result.M[2].V[2] := Self.M[2].V[2];
  Result.M[2].V[3] := Self.M[3].V[2];
  Result.M[3].V[0] := Self.M[0].V[3];
  Result.M[3].V[1] := Self.M[1].V[3];
  Result.M[3].V[2] := Self.M[2].V[3];
  Result.M[3].V[3] := Self.M[3].V[3];
end;

class function TMatrix3D.TransposeMatrix3D(const AMatrix: TMatrix3D): TMatrix3D;
begin
  Result.M[0].V[0] := AMatrix.M[0].V[0];
  Result.M[0].V[1] := AMatrix.M[1].V[0];
  Result.M[0].V[2] := AMatrix.M[2].V[0];
  Result.M[0].V[3] := AMatrix.M[3].V[0];
  Result.M[1].V[0] := AMatrix.M[0].V[1];
  Result.M[1].V[1] := AMatrix.M[1].V[1];
  Result.M[1].V[2] := AMatrix.M[2].V[1];
  Result.M[1].V[3] := AMatrix.M[3].V[1];
  Result.M[2].V[0] := AMatrix.M[0].V[2];
  Result.M[2].V[1] := AMatrix.M[1].V[2];
  Result.M[2].V[2] := AMatrix.M[2].V[2];
  Result.M[2].V[3] := AMatrix.M[3].V[2];
  Result.M[3].V[0] := AMatrix.M[0].V[3];
  Result.M[3].V[1] := AMatrix.M[1].V[3];
  Result.M[3].V[2] := AMatrix.M[2].V[3];
  Result.M[3].V[3] := AMatrix.M[3].V[3];
end;

function TMatrix3D.EyePosition: TPoint3D;
type
  TMatrix3DArray = array [0 .. 15] of Single;
begin
  Result.X := -TMatrix3DArray(Self)[0] * TMatrix3DArray(Self)[12] - TMatrix3DArray(Self)[1] * TMatrix3DArray(Self)[13] - TMatrix3DArray(Self)[2] * TMatrix3DArray(Self)[14];
  Result.Y := -TMatrix3DArray(Self)[4] * TMatrix3DArray(Self)[12] - TMatrix3DArray(Self)[5] * TMatrix3DArray(Self)[13] - TMatrix3DArray(Self)[6] * TMatrix3DArray(Self)[14];
  Result.Z := -TMatrix3DArray(Self)[8] * TMatrix3DArray(Self)[12] - TMatrix3DArray(Self)[9] * TMatrix3DArray(Self)[13] - TMatrix3DArray(Self)[10] * TMatrix3DArray(Self)[14];
end;

function Ceil(const X: Single): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) > 0 then
    Inc(Result);
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

{$IFDEF FALSE}
class operator TPoint.Explicit(const Size: TSize): TPoint;
begin
  Result.X := Size.cx;
  Result.Y := Size.cy;
end;

class operator TPoint.Explicit(const Point: TPoint): TSize;
begin
  Result.cx := Point.X;
  Result.cy := Point.Y;
end;

class operator TPoint.Explicit(const SmallPoint: TSmallPoint): TPoint;
begin
  Result.X := SmallPoint.x;
  Result.Y := SmallPoint.y;
end;

class operator TPoint.Explicit(const Point: TPoint): TSmallPoint;
begin
  Result.x := Point.X;
  Result.y := Point.Y;
end;

class operator TPoint.Implicit(const Size: TSize): TPoint;
begin
  Result.X := Size.cx;
  Result.Y := Size.cy;
end;

class operator TPoint.Implicit(const Point: TPoint): TSize;
begin
  Result.cx := Point.X;
  Result.cy := Point.Y;
end;

{$ENDIF}

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
  Result := Sqrt(Sqr(0.0+ Self.X - P2.X) + Sqr(0.0 + Self.Y - P2.Y));
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

function TPoint.Add(const Point: TPoint): TPoint;
begin
  Result.SetLocation(Self.X + Point.X, Self.Y + Point.Y);
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
  if Top > Bottom then begin
    Top := Top xor Bottom;
    Bottom := Top xor Bottom;
    Top := Top xor Bottom;
  end;
  if Left > Right then begin
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
  Result := Contains(R.TopLeft) and Contains(R.BottomRight);
end;

function TRect.IntersectsWith(const R: TRect): Boolean;
begin
  Result := not ( (Self.BottomRight.X < R.TopLeft.X) or
                  (Self.BottomRight.Y < R.TopLeft.Y) or
                  (R.BottomRight.X < Self.TopLeft.X) or
                  (R.BottomRight.Y < Self.TopLeft.Y) );
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

function Vector(const X, Y: Single; const W: Single = 1.0): TVector;
begin
  Result.X := X;
  Result.Y := Y;
  Result.W := W;
end;

function Vector(const P: TPointF; const W: Single = 1.0): TVector;
begin
  Result.X := P.X;
  Result.Y := P.Y;
  Result.W := W;
end;

function Vector3D(const X, Y, Z: Single; const W: Single = 1.0): TVector3D; overload;
begin
  Result := TVector3D.Create(X,Y,Z,W);
end;

function Vector3D(const P: TPoint3D; const W: Single = 1.0): TVector3D; overload;
begin
  Result := TVector3D.Create(P,W);
end;

function Point3D(const X, Y, Z: Single): TPoint3D; overload;
begin
  Result := TPoint3D.Create(X,Y,Z);
end;

function Point3D(const AVector3D : TVector3D): TPoint3D; overload;
begin
  Result := TPoint3D.Create(AVector3D.V);
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

function PointF(const V: TVector): TPointF;
begin
  Result.X := V.X;
  Result.Y := V.Y;
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
  Result := (Rect1.Left <= Rect2.Right) and (Rect1.Right >= Rect2.Left) and (Rect1.Top <= Rect2.Bottom) and
    (Rect1.Bottom >= Rect2.Top);
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
  Result := (Rect1.Left <= Rect2.Right) and (Rect1.Right >= Rect2.Left) and (Rect1.Top <= Rect2.Bottom) and
    (Rect1.Bottom >= Rect2.Top);
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
  if not Result then begin
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
  if not Result then begin
    tmpRect.Top :=0.0;
    tmpRect.Bottom := 0.0;
    tmpRect.Left := 0.0;
    tmpRect.Right := 0.0;
  end;
  Rect := tmpRect;
end;

{ TPointF }
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

class operator TPointF.Add(const Lhs, Rhs: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
{$EXCESSPRECISION ON}
end;

constructor TPointF.Create(const P: TPointF);
begin
  Self.X := P.X;
  Self.Y := P.Y;
end;

constructor TPointF.Create(const X, Y: Single);
begin
  Self.X := X;
  Self.Y := Y;
end;

constructor TPointF.Create(P: TPoint);
begin
  Self.X := P.X;
  Self.Y := P.Y;
end;

function TPointF.Distance(const P2: TPointF): Double;
begin
  Result := Sqrt(Sqr(Self.X - P2.X) + Sqr(Self.Y - P2.Y));
end;

class operator TPointF.Equal(const Lhs, Rhs: TPointF): Boolean;
begin
  Result := SameValue(Lhs.X, Rhs.X) and SameValue(Lhs.Y, Rhs.Y);
end;

class operator TPointF.NotEqual(const Lhs, Rhs: TPointF): Boolean;
begin
  Result := not (Lhs = Rhs);
end;

class operator TPointF.Multiply(const Lhs, Rhs: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Lhs.X * Rhs.X;
  Result.Y := Lhs.Y * Rhs.Y;
{$EXCESSPRECISION ON}
end;

function TPointF.IsZero: Boolean;
begin
  Result := SameValue(X, 0.0) and SameValue(Y, 0.0);
end;

procedure TPointF.Offset(const Point: TPoint);
begin
{$EXCESSPRECISION OFF}
  Self.X := Self.X + Point.X;
  Self.Y := Self.Y + Point.Y;
{$EXCESSPRECISION ON}
end;

procedure TPointF.Offset(const DX, DY: Single);
begin
{$EXCESSPRECISION OFF}
  Self.X := Self.X + DX;
  Self.Y := Self.Y + DY;
{$EXCESSPRECISION ON}
end;

procedure TPointF.Offset(const Point: TPointF);
begin
{$EXCESSPRECISION OFF}
  Self.X := Self.X + Point.X;
  Self.Y := Self.Y + Point.Y;
{$EXCESSPRECISION ON}
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

class operator TPointF.Subtract(const Lhs, Rhs: TPointF): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
{$EXCESSPRECISION ON}
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

function TPointF.Scale(const AFactor: Single): TPointF;
begin
{$EXCESSPRECISION OFF}
  Result.X := X * AFactor;
  Result.Y := Y * AFactor;
{$EXCESSPRECISION ON}
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

function TRectF.Fit(BoundsRect: TRectF): Single;
var
  ratio: Single;
begin
  Result := 1;
  if BoundsRect.Width * BoundsRect.Height = 0 then
    Exit;

  if (Self.Width / BoundsRect.Width) > (Self.Height / BoundsRect.Height) then
    ratio := Self.Width / BoundsRect.Width
  else
    ratio := Self.Height / BoundsRect.Height;

  if ratio < 1 then
  begin
    Self := RectF(0, 0, Self.Width, Self.Height);
  end
  else
  begin
    Self := RectF(0, 0, Self.Width / ratio, Self.Height / ratio);
  end;

  Result := ratio;
  RectCenter(Self, BoundsRect);
end;

class operator TRectF.NotEqual(const Lhs, Rhs: TRectF): Boolean;
begin
  Result := not (Lhs = Rhs);
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
  Result := Contains(R.TopLeft) and Contains(R.BottomRight);
end;

function PtInRect(const Rect: TRectF; const P: TPointF): Boolean;
begin
  Result := (P.X >= Rect.Left) and (P.X < Rect.Right) and (P.Y >= Rect.Top)
    and (P.Y < Rect.Bottom);
end;

function TRectF.Contains(const Pt: TPointF): Boolean;
begin
  Result := ((Pt.X > Self.Left) or SameValue(Pt.X, Self.Left)) and
            (Pt.X < Self.Right) and
            ((Pt.Y > Self.Top) or SameValue(Pt.Y, Self.Top)) and
            (Pt.Y < Self.Bottom);
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
  Result := not ( (Self.BottomRight.X < R.TopLeft.X) or
                  (Self.BottomRight.Y < R.TopLeft.Y) or
                  (R.BottomRight.X < Self.TopLeft.X) or
                  (R.BottomRight.Y < Self.TopLeft.Y) );
end;

function TRectF.IsEmpty: Boolean;
begin
  Result := (Right < Left) or SameValue(Right, Left)
         or (Bottom < Top) or SameValue(Bottom, Top);
end;

procedure TRectF.NormalizeRect;
var
  temp: Single;
begin
  if Top > Bottom then begin
    temp := Top;
    Top := Bottom;
    Bottom := temp;
  end;
  if Left > Right then begin
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

end.


