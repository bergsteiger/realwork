{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit System.Math.Vectors;

interface

uses
  System.Types;

type
  TEpsilon = record
  const
    Matrix = 1E-5;
    Vector = 1E-4;
  end;

  TVector3DType = array [0..3] of Single;

  TVectorArray = array [0..2] of Single;

  TPolygon = array of TPointF;

  TCubicBezier = array [0..3] of TPointF;

  tagVECTOR = record
    case Integer of
      0: (V: TVectorArray;);
      1: (X: Single;
          Y: Single;
          W: Single;);
  end;

  PVector = ^TVector;
  TVector = record
    class function Create(const AX, AY: Single; const AW: Single = 1.0): TVector; overload; static; inline;
    class function Create(const APoint: TPointF): TVector; overload; static; inline;

    class operator Add(const AVector1, AVector2: TVector): TVector;
    class operator Subtract(const AVector1, AVector2: TVector): TVector;
    class operator Equal(const AVector1, AVector2: TVector): Boolean; inline;
    class operator NotEqual(const AVector1, AVector2: TVector): Boolean; inline;
    class operator Implicit(const APoint: TPointF): TVector; inline;
    class operator Explicit(const APoint: TVector): TPointF;
    class operator Implicit(const APoint: TVector): TPointF; inline; deprecated 'Implicit conversion from TVector to TPointF requires homogenization';
    class operator Implicit(const ASize: TSizeF): TVector; inline;
    class operator Multiply(const AVector: TVector; const AFactor: Single): TVector;
    class operator Multiply(const AFactor: Single; const AVector: TVector): TVector; inline;
    class operator Divide(const AVector: TVector; const AFactor: Single): TVector;

    /// <summary> Zero vector having values of (0, 0, 0). </summary>
    class function Zero: TVector; inline; static;

    function Length: Single;
    function Normalize: TVector;
    function CrossProduct(const AVector: TVector): TVector;
    function DotProduct(const AVector: TVector): Single;
    function MidVector(const AVector: TVector): TVector;

    function ToPointF: TPointF; inline; deprecated 'Use explicit typecast instead.';

    case Integer of
      0: (V: TVectorArray;);
      1: (X: Single;
          Y: Single;
          W: Single;);
  end;

  TPoint3D = record
    type
      TPoint3DArray = array [0..2] of Single;
    class function Create(const AX, AY, AZ: Single): TPoint3D; overload; static; inline;
    class function Create(const P: TVector3DType): TPoint3D; overload; static; inline;
    class function Create(const APoint: TPointF; const AZ: Single = 0.0): TPoint3D; overload; static; inline;

    class operator Add(const APoint1, APoint2: TPoint3D): TPoint3D;
    class operator Subtract(const APoint1, APoint2: TPoint3D): TPoint3D;
    class operator Equal(const APoint1, APoint2: TPoint3D): Boolean; inline;
    class operator NotEqual(const APoint1, APoint2: TPoint3D): Boolean; inline;
    class operator Negative(const APoint: TPoint3D): TPoint3D;
    class operator Multiply(const APoint1, APoint2: TPoint3D): TPoint3D;
    class operator Multiply(const APoint: TPoint3D; const AFactor: Single): TPoint3D; inline;
    class operator Multiply(const AFactor: Single; const APoint: TPoint3D): TPoint3D; inline;
    class operator Divide(const APoint: TPoint3D; const AFactor: Single): TPoint3D;

    /// <summary> Zero point having values of (0, 0, 0). </summary>
    class function Zero: TPoint3D; inline; static;

    procedure Offset(const ADelta: TPoint3D); overload; inline;
    procedure Offset(const ADeltaX, ADeltaY, ADeltaZ: Single); overload; inline;

    function CrossProduct(const APoint: TPoint3D): TPoint3D;
    function DotProduct(const APoint: TPoint3D): Single; inline;
    function EqualsTo(const APoint: TPoint3D; const Epsilon: Single = 0): Boolean; inline;

    function Length: Single; inline;
    function Normalize: TPoint3D;
    function Distance(const APoint: TPoint3D): Single;
    function Rotate(const AAxis: TPoint3D; const AAngle: Single): TPoint3D; inline;
    function Reflect(const APoint: TPoint3D): TPoint3D; inline;
    function MidPoint(const APoint: TPoint3D): TPoint3D; inline;
    function AngleCosine(const APoint: TPoint3D): Single;

    case Integer of
      0: (V: TPoint3DArray;);
      1: (X: Single;
          Y: Single;
          Z: Single;);
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


  TMatrixArray = array [0..2] of TVector;
  TMaxtrixArrayBase = array[0..2] of tagVECTOR;
  {$NODEFINE TMatrixArray 'System::Math::Vectors::TMatrixArray' 'System::Math::Vectors::TMaxtrixArrayBase'}
  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END 'typedef TVector TMatrixArray[3];'*)
  (*$HPPEMIT END CLOSENAMESPACE*)

  TMatrix = record
  private
    function Scale(const AFactor: Single): TMatrix;
  public
    class function CreateRotation(const AAngle: Single): TMatrix; static;
    class function CreateScaling(const AScaleX, AScaleY: Single): TMatrix; static;
    class function CreateTranslation(const ADeltaX, ADeltaY: Single): TMatrix; static;

    class operator Multiply(const AMatrix1, AMatrix2: TMatrix): TMatrix;
    class operator Multiply(const APoint: TPointF; const AMatrix: TMatrix): TPointF;
    class operator Multiply(const AVector: TVector; const AMatrix: TMatrix): TVector;
    class operator Multiply(const AVector: TPoint3D; const AMatrix: TMatrix): TPoint3D;
    /// <summary>Equal operator, calls to EqualsTo function with a default epsilon.</summary>
    class operator Equal(const RightMatrix, LeftMatrix: TMatrix): Boolean; static;

    function Determinant: Single;
    function Adjoint: TMatrix;
    function Inverse: TMatrix;
    function ExtractScale: TPointF;
    /// <summary>This function returns true if all the values are the same than the given matrix using an epsilon error
    /// threshold, and returns false otherwise.</summary>
    function EqualsTo(const AMatrix: TMatrix; const Epsilon: Single = TEpsilon.Matrix): Boolean;

    case Integer of
      0: (M: TMatrixArray;);
      1: (m11, m12, m13: Single;
          m21, m22, m23: Single;
          m31, m32, m33: Single);
  end;

  TMatrixConstants = record helper for TMatrix
    const Identity: TMatrix = (m11: 1; m12: 0; m13: 0; m21: 0; m22: 1; m23: 0; m31: 0; m32: 0; m33: 1);
  end;

  PVector3D = ^TVector3D;
  TVector3D = record
    class function Create(const AX, AY, AZ: Single; const AW: Single = 1.0): TVector3D; overload; static; inline;
    class function Create(const APoint: TPoint3D; const AW: Single = 1.0): TVector3D; overload; static; inline;

    class operator Add(const AVector1, AVector2: TVector3D): TVector3D;
    class operator Subtract(const AVector1, AVector2: TVector3D): TVector3D;
    class operator Equal(const AVector1, AVector2: TVector3D): Boolean;
    class operator NotEqual(const AVector1, AVector2: TVector3D): Boolean;
    class operator Negative(const AVector: TVector3D): TVector3D;
    class operator Implicit(const APoint: TPoint3D): TVector3D;
    class operator Explicit(const AVector: TVector3D): TPoint3D;
    class operator Implicit(const AVector: TVector3D): TPoint3D; inline; deprecated 'Implicit conversion from TVector3D to TPoint3D requires homogenization';
    class operator Multiply(const AVector1, AVector2: TVector3D): TVector3D;
    class operator Multiply(const AVector: TVector3D; const AFactor: Single): TVector3D; inline;
    class operator Multiply(const AFactor: Single; const AVector: TVector3D): TVector3D; inline;
    class operator Divide(const AVector: TVector3D; const AFactor: Single): TVector3D;

    /// <summary> Zero vector having values of (0, 0, 0, 0). </summary>
    class function Zero: TVector3D; inline; static;

    procedure Offset(const ADelta: TPoint3D); overload; inline; deprecated 'Use TPoint3D.Offset';
    procedure Offset(const ADeltaX, ADeltaY, ADeltaZ: Single); overload; inline; deprecated 'Use TPoint3D.Offset';

    function CrossProduct(const AVector: TVector3D): TVector3D; deprecated 'Use TPoint3D.CrossProduct';
    function DotProduct(const AVector: TVector3D): Single; deprecated 'Use TPoint3D.DotProduct';
    function EqualsTo(const AVector: TVector3D; const Epsilon: Single = 0): Boolean; inline;

    function Length: Single;
    function Normalize: TVector3D;
    function Distance(const AVector: TVector3D): Single;
    function Rotate(const AAxis: TPoint3D; const AAngle: Single): TVector3D; inline; deprecated 'Use TPoint3D.Rotate';
    function Reflect(const AVector: TVector3D): TVector3D; inline; deprecated 'Use TPoint3D.Reflect';
    function MidVector(const AVector: TVector3D): TVector3D;
    function AngleCosine(const AVector: TVector3D): Single; deprecated 'Use TPoint3D.AngleCosine';

    // converts 4D (3D + W) vector into 3D vector (when ATransform is True, divides by W)
    function ToPoint3D(const ATransform: Boolean = False): TPoint3D; deprecated 'Use explicit typecast instead.';

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
  {$NODEFINE TMatrix3DType 'System::Math::Vectors::TMatrix3DType' 'System::Math::Vectors::TMatrix3DTypeBase'}
  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END 'typedef TVector3D TMatrix3DType[3];'*)
  (*$HPPEMIT END CLOSENAMESPACE*)
  TMatrix3DTypeBase = array[0..3] of tagVECTOR3D;

  TMatrix3D = record
  private
    function DetInternal(const a1, a2, a3, b1, b2, b3, c1, c2, c3: Single): Single; inline;
    function Scale(const AFactor: Single): TMatrix3D;
  public
    // Creation of matrix by specifying individual values.
    constructor Create(const AM11, AM12, AM13, AM14, AM21, AM22, AM23, AM24, AM31, AM32, AM33,
      AM34, AM41, AM42, AM43, AM44: Single); overload;
    constructor Create(const AArray: TSingleDynArray); overload;

    // Creation of simple transformation matrices.
    class function CreateScaling(const AScale: TPoint3D): TMatrix3D; static;
    class function CreateTranslation(const ATranslation: TPoint3D): TMatrix3D; static;

    // Creation of rotation matrix around only one of the axes (work faster than composite variants)
    class function CreateRotationX(const AAngle: Single): TMatrix3D; static;
    class function CreateRotationY(const AAngle: Single): TMatrix3D; static;
    class function CreateRotationZ(const AAngle: Single): TMatrix3D; static;

    // Creation of a composite rotation matrix (slower but more flexible than simple variants)
    class function CreateRotation(const AAxis: TPoint3D; const AAngle: Single): TMatrix3D; static;
    class function CreateRotationYawPitchRoll(const AYaw, APitch, ARoll: Single): TMatrix3D; static;
    class function CreateRotationHeadingPitchBank(const AHeading, APitch, ABank: Single): TMatrix3D; static;

    // Creation of view/camera matrices.
    class function CreateLookAtRH(const ASource, ATarget, ACeiling: TPoint3D): TMatrix3D; static;
    class function CreateLookAtLH(const ASource, ATarget, ACeiling: TPoint3D): TMatrix3D; static;
    class function CreateLookAtDirRH(const ASource, ADirection, ACeiling: TPoint3D): TMatrix3D; static;
    class function CreateLookAtDirLH(const ASource, ADirection, ACeiling: TPoint3D): TMatrix3D; static;
    class function CreateOrthoLH(const AWidth, AHeight, AZNear, AZFar: Single): TMatrix3D; static;
    class function CreateOrthoRH(const AWidth, AHeight, AZNear, AZFar: Single): TMatrix3D; static;
    class function CreateOrthoOffCenterLH(const ALeft, ATop, ARight, ABottom, AZNear, AZFar: Single): TMatrix3D; static;
    class function CreateOrthoOffCenterRH(const ALeft, ATop, ARight, ABottom, AZNear, AZFar: Single): TMatrix3D; static;
    class function CreatePerspectiveFovLH(const AFOV, AAspect, AZNear, AZFar: Single;
     const AHorizontalFOV: Boolean = False): TMatrix3D; static;
    class function CreatePerspectiveFovRH(const AFOV, AAspect, AZNear, AZFar: Single;
     const AHorizontalFOV: Boolean = False): TMatrix3D; static;
    // multiplication of two 3D matrices
    class operator Multiply(const APoint1, APoint2: TMatrix3D): TMatrix3D;
    // multiplication of 3D vector and matrix
    class operator Multiply(const APoint: TPoint3D; const AMatrix: TMatrix3D): TPoint3D;
    // multiplication of 4D(3D + w) vector and 3D (4x4) matrix
    class operator Multiply(const AVector: TVector3D; const AMatrix: TMatrix3D): TVector3D;

    function Transpose: TMatrix3D;
    function Determinant: Single;
    function Adjoint: TMatrix3D;
    function Inverse: TMatrix3D;

    function ToMatrix: TMatrix;

    // calculates eye position from 3D matrix
    function EyePosition: TPoint3D;

    case Integer of
      0: (M: TMatrix3DType;);
      1: (m11, m12, m13, m14: Single;
          m21, m22, m23, m24: Single;
          m31, m32, m33, m34: Single;
          m41, m42, m43, m44: Single);
  end;

  TMatrix3DConstants = record helper for TMatrix3D
    const Identity: TMatrix3D = (m11: 1; m12: 0; m13: 0; m14: 0; m21: 0; m22: 1; m23: 0; m24: 0; m31: 0; m32: 0;
      m33: 1; m34: 0; m41: 0; m42: 0; m43: 0; m44: 1;);
  end;

  TQuaternion3D = record
    constructor Create(const AAxis: TPoint3D; const AAngle: Single); overload;
    constructor Create(const AYaw, APitch, ARoll: Single); overload;
    constructor Create(const AMatrix: TMatrix3D); overload;

    class operator Implicit(const AQuaternion: TQuaternion3D): TMatrix3D;
    class operator Multiply(const AQuaternion1, AQuaternion2: TQuaternion3D): TQuaternion3D;

    // calculates quaternion magnitude
    function Length: Single;
    function Normalize: TQuaternion3D;

    case Integer of
      0: (V: TVector3DType;);
      1: (ImagPart: TPoint3D;
          RealPart: Single;);
  end;

  TQuaternion3DConstants = record helper for TQuaternion3D
    const Identity: TQuaternion3D = (ImagPart: (X: 0; Y: 0; Z: 0); RealPart: 1);
  end;

const
  NullVector3D: TVector3D = (X: 0; Y: 0; Z: 0; W: 1);
  NullPoint3D: TPoint3D = (X: 0; Y: 0; Z: 0);

function Vector(const X, Y: Single; const W: Single = 1.0): TVector; overload;
function Vector(const P: TPointF; const W: Single = 1.0): TVector; overload;
function Vector3D(const X, Y, Z: Single; const W: Single = 1.0): TVector3D; overload;
function Vector3D(const P: TPoint3D; const W: Single = 1.0): TVector3D; overload;
function Point3D(const X, Y, Z: Single): TPoint3D; overload;
function Point3D(const AVector3D: TVector3D; const ATransform: Boolean = False): TPoint3D; overload; deprecated 'Use direct typecast instead.';
function PointF(const V: TVector): TPointF; inline; overload;

implementation

uses
  System.Math;

const
  FuzzFactorSingle = 10;
  SingleResolution: Single = 1.25E-7 * FuzzFactorSingle; // this is relative resolution of mantissa


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

function Point3D(const AVector3D: TVector3D; const ATransform: Boolean): TPoint3D; overload;
begin
  Result := AVector3D.ToPoint3D(ATransform);
end;

function PointF(const V: TVector): TPointF;
begin
  Result := TPointF(V);
end;

{ TVector }

class function TVector.Create(const APoint: TPointF): TVector;
begin
  Result.X := APoint.X;
  Result.Y := APoint.Y;
  Result.W := 1;
end;

class function TVector.Create(const AX, AY, AW: Single): TVector;
begin
  Result.X := AX;
  Result.Y := AY;
  Result.W := AW;
end;

class operator TVector.Add(const AVector1, AVector2: TVector): TVector;
begin
{$EXCESSPRECISION OFF}
  Result.V[0] := AVector1.V[0] + AVector2.V[0];
  Result.V[1] := AVector1.V[1] + AVector2.V[1];
  Result.V[2] := AVector1.V[2] + AVector2.V[2];
{$EXCESSPRECISION ON}
end;

class operator TVector.Subtract(const AVector1, AVector2: TVector): TVector;
begin
{$EXCESSPRECISION OFF}
  Result.V[0] := AVector1.V[0] - AVector2.V[0];
  Result.V[1] := AVector1.V[1] - AVector2.V[1];
  Result.V[2] := AVector1.V[2] - AVector2.V[2];
{$EXCESSPRECISION ON}
end;

class operator TVector.Equal(const AVector1, AVector2: TVector): Boolean;
begin
  Result := SameValue(AVector1.X, AVector2.X, TEpsilon.Vector) and
    SameValue(AVector1.Y, AVector2.Y, TEpsilon.Vector) and
    SameValue(AVector1.W, AVector2.W, TEpsilon.Vector);
end;

class operator TVector.NotEqual(const AVector1, AVector2: TVector): Boolean;
begin
  Result := not (AVector1 =  AVector2);
end;

class operator TVector.Implicit(const APoint: TPointF): TVector;
begin
  Result := TVector.Create(APoint);
end;

class operator TVector.Explicit(const APoint: TVector): TPointF;
var
  ReciprocalW: Single;
begin
{$EXCESSPRECISION OFF}
  if not SameValue(APoint.W, 0, TEpsilon.Vector) then
  begin
    ReciprocalW := 1 / APoint.W;
    Result.X := APoint.X * ReciprocalW;
    Result.Y := APoint.Y * ReciprocalW;
  end
  else
  begin
    Result.X := APoint.X;
    Result.Y := APoint.Y;
  end;
{$EXCESSPRECISION ON}
end;

class operator TVector.Implicit(const APoint: TVector): TPointF;
begin
  Result := TPointF(APoint);
end;

class operator TVector.Implicit(const ASize: TSizeF): TVector;
begin
  Result := TVector.Create(ASize);
end;

class operator TVector.Multiply(const AVector: TVector; const AFactor: Single): TVector;
begin
{$EXCESSPRECISION OFF}
  Result.X := AVector.X * AFactor;
  Result.Y := AVector.Y * AFactor;
  Result.W := AVector.W * AFactor;
{$EXCESSPRECISION ON}
end;

class operator TVector.Multiply(const AFactor: Single; const AVector: TVector): TVector;
begin
  Result := AVector * AFactor;
end;

class operator TVector.Divide(const AVector: TVector; const AFactor: Single): TVector;
begin
  if Abs(AFactor) > Epsilon then
    Result := AVector * (1 / AFactor)
  else
    Result := AVector;
end;

function TVector.CrossProduct(const AVector: TVector): TVector;
begin
  Result.X := (Self.Y * AVector.W) - (Self.W * AVector.Y);
  Result.Y := (Self.W * AVector.X) - (Self.X * AVector.W);
  Result.W := (Self.X * AVector.Y) - (Self.Y * AVector.X);
end;

function TVector.DotProduct(const AVector: TVector): Single;
begin
  Result := (Self.X * AVector.X) + (Self.Y * AVector.Y) + (Self.W * AVector.W);
end;

function TVector.Length: Single;
begin
  Result := Sqrt(Self.DotProduct(Self));
end;

function TVector.Normalize: TVector;
var
  VecLen: Single;
begin
  VecLen := Self.Length;

  if VecLen > Epsilon then
    Result := Self * (1 / VecLen)
  else
    Result := Self;
end;

function TVector.MidVector(const AVector: TVector): TVector;
begin
  Result := (Self + AVector) * 0.5;
end;

function TVector.ToPointF: TPointF;
begin
  Result := TPointF(Self);
end;

class function TVector.Zero: TVector;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.W := 0;
end;

{TMatrix}

class function TMatrix.CreateRotation(const AAngle: Single): TMatrix;
var
  Sine, Cosine: Single;
begin
  SinCosSingle(AAngle, Sine, Cosine);

  Result := Identity;
  Result.m11 := Cosine;
  Result.m12 := Sine;
  Result.m21 := -Sine;
  Result.m22 := Cosine;
end;

class function TMatrix.CreateScaling(const AScaleX, AScaleY: Single): TMatrix;
begin
  Result := Identity;
  Result.m11 := AScaleX;
  Result.m22 := AScaleY;
end;

class function TMatrix.CreateTranslation(const ADeltaX, ADeltaY: Single): TMatrix;
begin
  Result := Identity;
  Result.m31 := ADeltaX;
  Result.m32 := ADeltaY;
end;

class operator TMatrix.Multiply(const AMatrix1, AMatrix2: TMatrix): TMatrix;
begin
  Result.m11 := AMatrix1.m11 * AMatrix2.m11 + AMatrix1.m12 * AMatrix2.m21 + AMatrix1.m13 * AMatrix2.m31;
  Result.m12 := AMatrix1.m11 * AMatrix2.m12 + AMatrix1.m12 * AMatrix2.m22 + AMatrix1.m13 * AMatrix2.m32;
  Result.m13 := AMatrix1.m11 * AMatrix2.m13 + AMatrix1.m12 * AMatrix2.m23 + AMatrix1.m13 * AMatrix2.m33;
  Result.m21 := AMatrix1.m21 * AMatrix2.m11 + AMatrix1.m22 * AMatrix2.m21 + AMatrix1.m23 * AMatrix2.m31;
  Result.m22 := AMatrix1.m21 * AMatrix2.m12 + AMatrix1.m22 * AMatrix2.m22 + AMatrix1.m23 * AMatrix2.m32;
  Result.m23 := AMatrix1.m21 * AMatrix2.m13 + AMatrix1.m22 * AMatrix2.m23 + AMatrix1.m23 * AMatrix2.m33;
  Result.m31 := AMatrix1.m31 * AMatrix2.m11 + AMatrix1.m32 * AMatrix2.m21 + AMatrix1.m33 * AMatrix2.m31;
  Result.m32 := AMatrix1.m31 * AMatrix2.m12 + AMatrix1.m32 * AMatrix2.m22 + AMatrix1.m33 * AMatrix2.m32;
  Result.m33 := AMatrix1.m31 * AMatrix2.m13 + AMatrix1.m32 * AMatrix2.m23 + AMatrix1.m33 * AMatrix2.m33;
end;

class operator TMatrix.Multiply(const APoint: TPointF; const AMatrix: TMatrix): TPointF;
begin
  Result.X := APoint.X * AMatrix.M[0].V[0] + APoint.Y * AMatrix.M[1].V[0]
    + AMatrix.M[2].V[0];
  Result.Y := APoint.X * AMatrix.M[0].V[1] + APoint.Y * AMatrix.M[1].V[1]
    + AMatrix.M[2].V[1];
end;

class operator TMatrix.Multiply(const AVector: TVector; const AMatrix: TMatrix): TVector;
begin
  Result.V[0] := AVector.V[0] * AMatrix.M[0].V[0] + AVector.V[1] * AMatrix.M[1].V[0]
    + AVector.V[2] * AMatrix.M[2].V[0];
  Result.V[1] := AVector.V[0] * AMatrix.M[0].V[1] + AVector.V[1] * AMatrix.M[1].V[1]
    + AVector.V[2] * AMatrix.M[2].V[1];
  Result.V[2] := AVector.V[0] * AMatrix.M[0].V[2] + AVector.V[1] * AMatrix.M[1].V[2]
    + AVector.V[2] * AMatrix.M[2].V[2];
end;

class operator TMatrix.Multiply(const AVector: TPoint3D; const AMatrix: TMatrix): TPoint3D;
begin
  Result.V[0] := AVector.V[0] * AMatrix.M[0].V[0] + AVector.V[1] * AMatrix.M[1].V[0]
    + AVector.V[2] * AMatrix.M[2].V[0];
  Result.V[1] := AVector.V[0] * AMatrix.M[0].V[1] + AVector.V[1] * AMatrix.M[1].V[1]
    + AVector.V[2] * AMatrix.M[2].V[1];
  Result.V[2] := AVector.V[0] * AMatrix.M[0].V[2] + AVector.V[1] * AMatrix.M[1].V[2]
    + AVector.V[2] * AMatrix.M[2].V[2];
end;

function TMatrix.Scale(const AFactor: Single): TMatrix;
var
  I: Integer;
begin
  for I := 0 to 2 do
  begin
    Result.M[I].V[0] := Self.M[I].V[0] * AFactor;
    Result.M[I].V[1] := Self.M[I].V[1] * AFactor;
    Result.M[I].V[2] := Self.M[I].V[2] * AFactor;
  end;
end;

function TMatrix.Determinant: Single;
begin
  Result := Self.M[0].V[0] * (Self.M[1].V[1] * Self.M[2].V[2] - Self.M[2].V[1] * Self.M[1].V[2]) - Self.M[0].V[1]
    * (Self.M[1].V[0] * Self.M[2].V[2] - Self.M[2].V[0] * Self.M[1].V[2]) + Self.M[0].V[2] * (Self.M[1].V[0]
    * Self.M[2].V[1] - Self.M[2].V[0] * Self.M[1].V[1]);
end;

class operator TMatrix.Equal(const RightMatrix, LeftMatrix: TMatrix): Boolean;
begin
  Result := RightMatrix.EqualsTo(LeftMatrix);
end;

function TMatrix.EqualsTo(const AMatrix: TMatrix; const Epsilon: Single): Boolean;
begin
  Result := SameValue(Self.m11, AMatrix.m11, Epsilon) and SameValue(Self.m12, AMatrix.m12, Epsilon) and
    SameValue(Self.m13, AMatrix.m13, Epsilon) and SameValue(Self.m21, AMatrix.m21, Epsilon) and
    SameValue(Self.m22, AMatrix.m22, Epsilon) and SameValue(Self.m23, AMatrix.m23, Epsilon) and
    SameValue(Self.m31, AMatrix.m31, Epsilon) and SameValue(Self.m32, AMatrix.m32, Epsilon) and
    SameValue(Self.m33, AMatrix.m33, Epsilon);
end;

function TMatrix.ExtractScale: TPointF;
const
  BaseVector: TPointF = (X: 0; Y: 0);
begin
  Result.X := (PointF(1, 0) * Self).Distance(BaseVector * Self);
  Result.Y := (PointF(0, 1) * Self).Distance(BaseVector * Self);
end;

function TMatrix.Adjoint: TMatrix;
var
  a1, a2, a3, b1, b2, b3, c1, c2, c3: Single;
begin
  a1 := Self.M[0].V[0];
  a2 := Self.M[0].V[1];
  a3 := Self.M[0].V[2];
  b1 := Self.M[1].V[0];
  b2 := Self.M[1].V[1];
  b3 := Self.M[1].V[2];
  c1 := Self.M[2].V[0];
  c2 := Self.M[2].V[1];
  c3 := Self.M[2].V[2];

  Result.M[0].V[0] := (b2 * c3 - c2 * b3);
  Result.M[1].V[0] := -(b1 * c3 - c1 * b3);
  Result.M[2].V[0] := (b1 * c2 - c1 * b2);

  Result.M[0].V[1] := -(a2 * c3 - c2 * a3);
  Result.M[1].V[1] := (a1 * c3 - c1 * a3);
  Result.M[2].V[1] := -(a1 * c2 - c1 * a2);

  Result.M[0].V[2] := (a2 * b3 - b2 * a3);
  Result.M[1].V[2] := -(a1 * b3 - b1 * a3);
  Result.M[2].V[2] := (a1 * b2 - b1 * a2);
end;

function TMatrix.Inverse: TMatrix;
const
  DefaultValue: TMatrix = (m11: 1.0; m12: 0.0; m13: 0.0; m21: 0.0; m22: 1.0; m23: 0.0; m31: 0.0; m32: 0.0; m33: 1.0);
var
  Det: Single;
begin
  Det := Self.Determinant;
  if Abs(Det) < Epsilon then
    Result := DefaultValue
  else
    Result:= Self.Adjoint.Scale(1 / Det);
end;

{ TPoint3D }

class function TPoint3D.Create(const AX, AY, AZ: Single): TPoint3D;
begin
  Result.X := AX;
  Result.Y := AY;
  Result.Z := AZ;
end;

class function TPoint3D.Create(const P: TVector3DType): TPoint3D;
begin
  Result.X := P[0];
  Result.Y := P[1];
  Result.Z := P[2];
end;

class function TPoint3D.Create(const APoint: TPointF; const AZ: Single): TPoint3D;
begin
  Result.X := APoint.X;
  Result.Y := APoint.Y;
  Result.Z := AZ;
end;

class operator TPoint3D.Add(const APoint1, APoint2: TPoint3D): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint1.X + APoint2.X;
  Result.Y := APoint1.Y + APoint2.Y;
  Result.Z := APoint1.Z + APoint2.Z;
{$EXCESSPRECISION ON}
end;

class operator TPoint3D.Subtract(const APoint1, APoint2: TPoint3D): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint1.X - APoint2.X;
  Result.Y := APoint1.Y - APoint2.Y;
  Result.Z := APoint1.Z - APoint2.Z;
{$EXCESSPRECISION ON}
end;

class operator TPoint3D.Equal(const APoint1, APoint2: TPoint3D): Boolean;
begin
  Result := SameValue(APoint1.X, APoint2.X, TEpsilon.Vector) and
    SameValue(APoint1.Y, APoint2.Y, TEpsilon.Vector) and
    SameValue(APoint1.Z, APoint2.Z, TEpsilon.Vector);
end;

function TPoint3D.EqualsTo(const APoint: TPoint3D; const Epsilon: Single): Boolean;
begin
  Result := SameValue(X, APoint.X, Epsilon) and SameValue(Y, APoint.Y, Epsilon) and SameValue(Z, APoint.Z, Epsilon);
end;

class operator TPoint3D.NotEqual(const APoint1, APoint2: TPoint3D): Boolean;
begin
  Result := not (APoint1 = APoint2);
end;

class operator TPoint3D.Negative(const APoint: TPoint3D): TPoint3D;
begin
  Result.X := - APoint.X;
  Result.Y := - APoint.Y;
  Result.Z := - APoint.Z;
end;

class operator TPoint3D.Multiply(const APoint1, APoint2: TPoint3D): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := APoint1.X * APoint2.X;
  Result.Y := APoint1.Y * APoint2.Y;
  Result.Z := APoint1.Z * APoint2.Z;
{$EXCESSPRECISION ON}
end;

class operator TPoint3D.Multiply(const APoint: TPoint3D; const AFactor: Single): TPoint3D;
begin
  Result := APoint * TPoint3D.Create(AFactor, AFactor, AFactor);
end;

class operator TPoint3D.Multiply(const AFactor: Single; const APoint: TPoint3D): TPoint3D;
begin
  Result := APoint * AFactor;
end;

class operator TPoint3D.Divide(const APoint: TPoint3D; const AFactor: Single): TPoint3D;
begin
{$EXCESSPRECISION OFF}
  if AFactor <> 0 then
    Result := APoint * (1 / AFactor)
  else
    Result := APoint;
{$EXCESSPRECISION ON}
end;

procedure TPoint3D.Offset(const ADelta: TPoint3D);
begin
  Self := Self + ADelta;
end;

procedure TPoint3D.Offset(const ADeltaX, ADeltaY, ADeltaZ: Single);
begin
  Self.Offset(TPoint3D.Create(ADeltaX, ADeltaY, ADeltaZ));
end;

function TPoint3D.CrossProduct(const APoint: TPoint3D): TPoint3D;
begin
  Result.X := (Self.Y * APoint.Z) - (Self.Z * APoint.Y);
  Result.Y := (Self.Z * APoint.X) - (Self.X * APoint.Z);
  Result.Z := (Self.X * APoint.Y) - (Self.Y * APoint.X);
end;

function TPoint3D.DotProduct(const APoint: TPoint3D): Single;
begin
  Result := (Self.X * APoint.X) + (Self.Y * APoint.Y) + (Self.Z * APoint.Z);
end;

function TPoint3D.Length: Single;
begin
  Result := Sqrt(Self.DotProduct(Self));
end;

function TPoint3D.Normalize: TPoint3D;
var
  VecLen: Single;
begin
  VecLen := Self.Length;

  if VecLen > 0.0 then
    Result := Self / VecLen
  else
    Result := Self;
end;

function TPoint3D.Distance(const APoint: TPoint3D): Single;
begin
  Result := (Self - APoint).Length;
end;

function TPoint3D.Rotate(const AAxis: TPoint3D; const AAngle: Single): TPoint3D;
begin
  Result := Self * TMatrix3D.CreateRotation(AAxis, AAngle);
end;

function TPoint3D.Reflect(const APoint: TPoint3D): TPoint3D;
begin
  Result := Self + APoint * (-2 * Self.DotProduct(APoint));
end;

function TPoint3D.MidPoint(const APoint: TPoint3D): TPoint3D;
begin
  Result := (Self + APoint) * 0.5;
end;

function TPoint3D.AngleCosine(const APoint: TPoint3D): Single;
begin
  Result := Self.Length * APoint.Length;

  if Abs(Result) > Epsilon then
    Result := Self.DotProduct(APoint) / Result
  else
    Result := Self.DotProduct(APoint) / Epsilon;

  Result := Max(Min(Result, 1), -1);
end;

class function TPoint3D.Zero: TPoint3D;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Z := 0;
end;

{ TVector3D }

class function TVector3D.Create(const AX, AY, AZ, AW: Single): TVector3D;
begin
  Result.X := AX;
  Result.Y := AY;
  Result.Z := AZ;
  Result.W := AW;
end;

class function TVector3D.Create(const APoint: TPoint3D; const AW: Single): TVector3D;
begin
  Result.X := APoint.X;
  Result.Y := APoint.Y;
  Result.Z := APoint.Z;
  Result.W := AW;
end;

class operator TVector3D.Add(const AVector1, AVector2: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := AVector1.X + AVector2.X;
  Result.Y := AVector1.Y + AVector2.Y;
  Result.Z := AVector1.Z + AVector2.Z;
  Result.W := AVector1.W + AVector2.W;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Subtract(const AVector1, AVector2: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := AVector1.X - AVector2.X;
  Result.Y := AVector1.Y - AVector2.Y;
  Result.Z := AVector1.Z - AVector2.Z;
  Result.W := AVector1.W - AVector2.W;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Equal(const AVector1, AVector2: TVector3D): Boolean;
begin
  Result := SameValue(AVector1.X, AVector2.X, TEpsilon.Vector) and SameValue(AVector1.Y, AVector2.Y,
    TEpsilon.Vector) and SameValue(AVector1.Z, AVector2.Z, TEpsilon.Vector) and
    SameValue(AVector1.W, AVector2.W, TEpsilon.Vector);
end;

function TVector3D.EqualsTo(const AVector: TVector3D; const Epsilon: Single): Boolean;
begin
  Result := SameValue(X, AVector.X, Epsilon) and SameValue(Y, AVector.Y, Epsilon) and
    SameValue(Z, AVector.Z, Epsilon) and SameValue(W, AVector.W, Epsilon);
end;

class operator TVector3D.NotEqual(const AVector1, AVector2: TVector3D): Boolean;
begin
  Result := not (AVector1 = AVector2);
end;

class operator TVector3D.Negative(const AVector: TVector3D): TVector3D;
begin
  Result.X := - AVector.X;
  Result.Y := - AVector.Y;
  Result.Z := - AVector.Z;
  Result.W := - AVector.W;
end;

class operator TVector3D.Implicit(const APoint: TPoint3D): TVector3D;
begin
  Result := TVector3D.Create(APoint);
end;

class operator TVector3D.Explicit(const AVector: TVector3D): TPoint3D;
var
  ReciprocalW: Single;
begin
{$EXCESSPRECISION OFF}
  if not SameValue(AVector.W, 0, TEpsilon.Vector) then
  begin
    ReciprocalW := 1 / AVector.W;
    Result.X := AVector.X * ReciprocalW;
    Result.Y := AVector.Y * ReciprocalW;
    Result.Z := AVector.Z * ReciprocalW;
  end
  else
  begin
    Result.X := AVector.X;
    Result.Y := AVector.Y;
    Result.Z := AVector.Z;
  end;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Implicit(const AVector: TVector3D): TPoint3D;
begin
  Result := TPoint3D(AVector);
end;

class operator TVector3D.Multiply(const AVector1, AVector2: TVector3D): TVector3D;
begin
{$EXCESSPRECISION OFF}
  Result.X := AVector1.X * AVector2.X;
  Result.Y := AVector1.Y * AVector2.Y;
  Result.Z := AVector1.Z * AVector2.Z;
  Result.W := AVector1.W * AVector2.W;
{$EXCESSPRECISION ON}
end;

class operator TVector3D.Multiply(const AVector: TVector3D; const AFactor: Single): TVector3D;
begin
  Result := AVector * TVector3D.Create(AFactor, AFactor, AFactor, AFactor);
end;

class operator TVector3D.Multiply(const AFactor: Single; const AVector: TVector3D): TVector3D;
begin
  Result := AVector * AFactor;
end;

class operator TVector3D.Divide(const AVector: TVector3D; const AFactor: Single): TVector3D;
begin
{$EXCESSPRECISION OFF}
  if not SameValue(AFactor, 0, TEpsilon.Vector) then
    Result := AVector * (1 / AFactor)
  else
    Result := AVector;
{$EXCESSPRECISION ON}
end;

procedure TVector3D.Offset(const ADelta: TPoint3D);
begin
{$EXCESSPRECISION OFF}
  Self.X := Self.X + ADelta.X;
  Self.Y := Self.Y + ADelta.Y;
  Self.Z := Self.Z + ADelta.Z;
  Self.W := Self.W;
{$EXCESSPRECISION ON}
end;

procedure TVector3D.Offset(const ADeltaX, ADeltaY, ADeltaZ: Single);
begin
  Self.X := Self.X + ADeltaX;
  Self.Y := Self.Y + ADeltaY;
  Self.Z := Self.Z + ADeltaZ;
  Self.W := Self.W;
end;

function TVector3D.CrossProduct(const AVector: TVector3D): TVector3D;
begin
  Result.X := Self.Y * AVector.Z - Self.Z * AVector.Y;
  Result.Y := Self.Z * AVector.X - Self.X * AVector.Z;
  Result.Z := Self.X * AVector.Y - Self.Y * AVector.X;
  Result.W := 1;
end;

function TVector3D.DotProduct(const AVector: TVector3D): Single;
begin
  Result := Self.X * AVector.X + Self.Y * AVector.Y + Self.Z * AVector.Z;
end;

function TVector3D.Length: Single;
begin
  Result := Sqrt(Self.X * Self.X + Self.Y * Self.Y + Self.Z * Self.Z + Self.W * Self.W);
end;

function TVector3D.Normalize: TVector3D;
var
  VecLen: Single;
begin
  VecLen := Self.Length;
  if VecLen > 0 then
    Result := Self / VecLen
  else
    Result := Self;
end;

function TVector3D.Distance(const AVector: TVector3D): Single;
begin
  Result := (AVector - Self).Length;
end;

function TVector3D.Rotate(const AAxis: TPoint3D; const AAngle: Single): TVector3D;
begin
  Result := Self * TMatrix3D.CreateRotation(AAxis, AAngle);
end;

function TVector3D.Reflect(const AVector: TVector3D): TVector3D;
begin
  Result := TPoint3D(Self) + TPoint3D(AVector) * (-2 * TPoint3D(Self).DotProduct(TPoint3D(AVector)));
end;

function TVector3D.MidVector(const AVector: TVector3D): TVector3D;
begin
  Result := (Self + AVector) * 0.5;
end;

function TVector3D.AngleCosine(const AVector: TVector3D): Single;
begin
  Result := TPoint3D(Self).Length * TPoint3D(AVector).Length;

  if not SameValue(Result, 0, TEpsilon.Vector) then
    Result := TPoint3D(Self).DotProduct(TPoint3D(AVector)) / Result
  else
    Result := TPoint3D(Self).DotProduct(TPoint3D(AVector)) / SingleResolution;

  Result := Max(Min(Result, 1), -1);
end;

function TVector3D.ToPoint3D(const ATransform: Boolean): TPoint3D;
var
  ReciprocalW: Single;
begin
{$EXCESSPRECISION OFF}
  if (not ATransform) or SameValue(Self.W, 0, TEpsilon.Vector) then
  begin
    Result.X := Self.X;
    Result.Y := Self.Y;
    Result.Z := Self.Z;
  end
  else
  begin
    ReciprocalW := 1 / Self.W;
    Result.X := Self.X * ReciprocalW;
    Result.Y := Self.Y * ReciprocalW;
    Result.Z := Self.Z * ReciprocalW;
  end;
{$EXCESSPRECISION ON}
end;

class function TVector3D.Zero: TVector3D;
begin
  Result.X := 0;
  Result.Y := 0;
  Result.Z := 0;
  Result.W := 0;
end;

{ TMatrix3D }

constructor TMatrix3D.Create(const AM11, AM12, AM13, AM14, AM21, AM22, AM23, AM24, AM31, AM32, AM33, AM34, AM41, AM42,
  AM43, AM44: Single);
begin
  Self.m11 := AM11;
  Self.m12 := AM12;
  Self.m13 := AM13;
  Self.m14 := AM14;
  Self.m21 := AM21;
  Self.m22 := AM22;
  Self.m23 := AM23;
  Self.m24 := AM24;
  Self.m31 := AM31;
  Self.m32 := AM32;
  Self.m33 := AM33;
  Self.m34 := AM34;
  Self.m41 := AM41;
  Self.m42 := AM42;
  Self.m43 := AM43;
  Self.m44 := AM44;
end;

constructor TMatrix3D.Create(const AArray: TSingleDynArray);
begin
  Self := TMatrix3D.Create(AArray[0], AArray[4], AArray[8], AArray[12], AArray[1], AArray[5], AArray[9], AArray[13],
    AArray[2], AArray[6], AArray[10], AArray[14], AArray[3], AArray[7], AArray[11], AArray[15]);
end;

class function TMatrix3D.CreateScaling(const AScale: TPoint3D): TMatrix3D;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.m11 := AScale.X;
  Result.m22 := AScale.Y;
  Result.m33 := AScale.Z;
  Result.m44 := 1;
end;

class function TMatrix3D.CreateTranslation(const ATranslation: TPoint3D): TMatrix3D;
begin
  Result := Identity;
  Result.m41 := ATranslation.X;
  Result.m42 := ATranslation.Y;
  Result.m43 := ATranslation.Z;
end;

class function TMatrix3D.CreateRotationX(const AAngle: Single): TMatrix3D;
var
  Sine, Cosine: Single;
begin
  SinCosSingle(AAngle, Sine, Cosine);

  Result := Identity;
  Result.m22 := Cosine;
  Result.m23 := Sine;
  Result.m32 := - Result.m23;
  Result.m33 := Result.m22;
end;

class function TMatrix3D.CreateRotationY(const AAngle: Single): TMatrix3D;
var
  Sine, Cosine: Single;
begin
  SinCosSingle(AAngle, Sine, Cosine);

  Result := Identity;
  Result.m11 := Cosine;
  Result.m13 := - Sine;
  Result.m31 := - Result.m13;
  Result.m33 := Result.m11;
end;

class function TMatrix3D.CreateRotationZ(const AAngle: Single): TMatrix3D;
var
  Sine, Cosine: Single;
begin
  SinCosSingle(AAngle, Sine, Cosine);

  Result := Identity;
  Result.m11 := Cosine;
  Result.m12 := Sine;
  Result.m21 := - Result.m12;
  Result.m22 := Result.m11;
end;

class function TMatrix3D.CreateRotation(const AAxis: TPoint3D; const AAngle: Single): TMatrix3D;
var
  NormAxis: TPoint3D;
  Cosine, Sine, OneMinusCos: Single;
begin
  SinCosSingle(AAngle, Sine, Cosine);
  OneMinusCos := 1 - Cosine;
  NormAxis := AAxis.Normalize;

  Result := Identity;
  Result.m11 := (OneMinusCos * NormAxis.X * NormAxis.X) + Cosine;
  Result.m12 := (OneMinusCos * NormAxis.X * NormAxis.Y) + (NormAxis.Z * Sine);
  Result.m13 := (OneMinusCos * NormAxis.Z * NormAxis.X) - (NormAxis.Y * Sine);
  Result.m21 := (OneMinusCos * NormAxis.X * NormAxis.Y) - (NormAxis.Z * Sine);
  Result.m22 := (OneMinusCos * NormAxis.Y * NormAxis.Y) + Cosine;
  Result.m23 := (OneMinusCos * NormAxis.Y * NormAxis.Z) + (NormAxis.X * Sine);
  Result.m31 := (OneMinusCos * NormAxis.Z * NormAxis.X) + (NormAxis.Y * Sine);
  Result.m32 := (OneMinusCos * NormAxis.Y * NormAxis.Z) - (NormAxis.X * Sine);
  Result.m33 := (OneMinusCos * NormAxis.Z * NormAxis.Z) + Cosine;
end;

class function TMatrix3D.CreateRotationYawPitchRoll(const AYaw, APitch, ARoll: Single): TMatrix3D;
var
  SineYaw, SinePitch, SineRoll: Single;
  CosineYaw, CosinePitch, CosineRoll: Single;
begin
  SinCosSingle(AYaw, SineYaw, CosineYaw);
  SinCosSingle(APitch, SinePitch, CosinePitch);
  SinCosSingle(ARoll, SineRoll, CosineRoll);

  Result := Identity;
  Result.m11 := CosineRoll * CosineYaw + SinePitch * SineRoll * SineYaw;
  Result.m12 := CosineYaw * SinePitch * SineRoll - CosineRoll * SineYaw;
  Result.m13 := - CosinePitch * SineRoll;
  Result.m21 := CosinePitch * SineYaw;
  Result.m22 := CosinePitch * CosineYaw;
  Result.m23 := SinePitch;
  Result.m31 := CosineYaw * SineRoll - CosineRoll * SinePitch * SineYaw;
  Result.m32 := - CosineRoll * CosineYaw * SinePitch - SineRoll * SineYaw;
  Result.m33 := CosinePitch * CosineRoll;
end;

class function TMatrix3D.CreateRotationHeadingPitchBank(const AHeading, APitch, ABank: Single): TMatrix3D;
var
  SineHeading, SinePitch, SineBank: Single;
  CosineHeading, CosinePitch, CosineBank: Single;
begin
  SinCosSingle(AHeading, SineHeading, CosineHeading);
  SinCosSingle(APitch, SinePitch, CosinePitch);
  SinCosSingle(ABank, SineBank, CosineBank);

  Result := Identity;
  Result.m11 := (CosineHeading * CosineBank) + (SineHeading * SinePitch * SineBank);
  Result.m12 := (- CosineHeading * SineBank) + (SineHeading * SinePitch * CosineBank);
  Result.m13 := SineHeading * CosinePitch;
  Result.m21 := SineBank * CosinePitch;
  Result.m22 := CosineBank * CosinePitch;
  Result.m23 := - SinePitch;
  Result.m31 := (- SineHeading * CosineBank) + (CosineHeading * SinePitch * SineBank);
  Result.m32 := (SineBank * SineHeading) + (CosineHeading * SinePitch * CosineBank);
  Result.m33 := CosineHeading * CosinePitch;
end;

class function TMatrix3D.CreateLookAtRH(const ASource, ATarget, ACeiling: TPoint3D): TMatrix3D;
var
  ZAxis, XAxis, YAxis: TPoint3D;
begin
  ZAxis := (ASource - ATarget).Normalize;
  XAxis := ACeiling.CrossProduct(ZAxis).Normalize;
  YAxis := ZAxis.CrossProduct(XAxis);

  Result := Identity;
  Result.m11 := XAxis.X;
  Result.m12 := YAxis.X;
  Result.m13 := ZAxis.X;
  Result.m21 := XAxis.Y;
  Result.m22 := YAxis.Y;
  Result.m23 := ZAxis.Y;
  Result.m31 := XAxis.Z;
  Result.m32 := YAxis.Z;
  Result.m33 := ZAxis.Z;
  Result.m41 := - XAxis.DotProduct(ASource);
  Result.m42 := - YAxis.DotProduct(ASource);
  Result.m43 := - ZAxis.DotProduct(ASource);
end;

class function TMatrix3D.CreateLookAtLH(const ASource, ATarget, ACeiling: TPoint3D): TMatrix3D;
var
  ZAxis, XAxis, YAxis: TPoint3D;
begin
  ZAxis := (ATarget - ASource).Normalize;
  XAxis := ACeiling.CrossProduct(ZAxis).Normalize;
  YAxis := ZAxis.CrossProduct(XAxis);

  Result := Identity;
  Result.m11 := XAxis.X;
  Result.m12 := YAxis.X;
  Result.m13 := ZAxis.X;
  Result.m21 := XAxis.Y;
  Result.m22 := YAxis.Y;
  Result.m23 := ZAxis.Y;
  Result.m31 := XAxis.Z;
  Result.m32 := YAxis.Z;
  Result.m33 := ZAxis.Z;
  Result.m41 := - XAxis.DotProduct(ASource);
  Result.m42 := - YAxis.DotProduct(ASource);
  Result.m43 := - ZAxis.DotProduct(ASource);
end;

class function TMatrix3D.CreateLookAtDirRH(const ASource, ADirection, ACeiling: TPoint3D): TMatrix3D;
var
  ZAxis, XAxis, YAxis: TPoint3D;
begin
  ZAxis := ADirection.Normalize;
  XAxis := ACeiling.CrossProduct(ZAxis).Normalize;
  YAxis := ZAxis.CrossProduct(XAxis);

  Result := Identity;
  Result.m11 := XAxis.X;
  Result.m12 := YAxis.X;
  Result.m13 := ZAxis.X;
  Result.m21 := XAxis.Y;
  Result.m22 := YAxis.Y;
  Result.m23 := ZAxis.Y;
  Result.m31 := XAxis.Z;
  Result.m32 := YAxis.Z;
  Result.m33 := ZAxis.Z;
  Result.m41 := - XAxis.DotProduct(ASource);
  Result.m42 := - YAxis.DotProduct(ASource);
  Result.m43 := - ZAxis.DotProduct(ASource);
end;

class function TMatrix3D.CreateLookAtDirLH(const ASource, ADirection, ACeiling: TPoint3D): TMatrix3D;
var
  ZAxis, XAxis, YAxis: TPoint3D;
begin
  ZAxis := - ADirection.Normalize;
  XAxis := ACeiling.CrossProduct(ZAxis).Normalize;
  YAxis := ZAxis.CrossProduct(XAxis);

  Result := Identity;
  Result.m11 := XAxis.X;
  Result.m12 := YAxis.X;
  Result.m13 := ZAxis.X;
  Result.m21 := XAxis.Y;
  Result.m22 := YAxis.Y;
  Result.m23 := ZAxis.Y;
  Result.m31 := XAxis.Z;
  Result.m32 := YAxis.Z;
  Result.m33 := ZAxis.Z;
  Result.m41 := - XAxis.DotProduct(ASource);
  Result.m42 := - YAxis.DotProduct(ASource);
  Result.m43 := - ZAxis.DotProduct(ASource);
end;

class function TMatrix3D.CreateOrthoLH(const AWidth, AHeight, AZNear, AZFar: Single): TMatrix3D;
begin
  Result := TMatrix3D.Identity;
  Result.m11 := 2 / AWidth;
  Result.m22 := 2 / AHeight;
  Result.m33 := 1 / (AZFar - AZNear);
  Result.m42 := AZNear / (AZNear - AZFar);
end;

class function TMatrix3D.CreateOrthoRH(const AWidth, AHeight, AZNear, AZFar: Single): TMatrix3D;
begin
  Result := TMatrix3D.Identity;
  Result.m11 := 2 / AWidth;
  Result.m22 := 2 / AHeight;
  Result.m33 := 1 / (AZNear - AZFar);
  Result.m42 := AZNear / (AZNear - AZFar);
end;

class function TMatrix3D.CreateOrthoOffCenterLH(const ALeft, ATop, ARight, ABottom, AZNear, AZFar: Single): TMatrix3D;
begin
  Result := TMatrix3D.Identity;
  Result.m11 := 2 / (ARight - ALeft);
  Result.m22 := 2 / (ATop - ABottom);
  Result.m33 := 1 / (AZFar - AZNear);
  Result.m41 := (ALeft + ARight) / (ALeft - ARight);
  Result.m42 := (ATop + ABottom) / (ABottom - ATop);
  Result.m43 := AZNear / (AZNear - AZFar);
end;

class function TMatrix3D.CreateOrthoOffCenterRH(const ALeft, ATop, ARight, ABottom, AZNear, AZFar: Single): TMatrix3D;
begin
  Result := TMatrix3D.Identity;
  Result.m11 := 2 / (ARight - ALeft);
  Result.m22 := 2 / (ATop - ABottom);
  Result.m33 := 1 / (AZNear - AZFar);
  Result.m41 := (ALeft + ARight) / (ALeft - ARight);
  Result.m42 := (ATop + ABottom) / (ABottom - ATop);
  Result.m43 := AZNear / (AZNear - AZFar);
end;

class function TMatrix3D.CreatePerspectiveFovLH(const AFOV, AAspect, AZNear, AZFar: Single;
  const AHorizontalFOV: Boolean = False): TMatrix3D;
var
  XScale, YScale: Single;
begin
  if AHorizontalFOV then
  begin
    XScale := 1 / Tangent(AFOV / 2);
    YScale := XScale / AAspect;
  end else
  begin
    YScale := 1 / Tangent(AFOV / 2);
    XScale := YScale / AAspect;
  end;

  Result := TMatrix3D.Identity;
  Result.m11 := XScale;
  Result.m22 := YScale;
  Result.m33 := AZFar / (AZFar - AZNear);
  Result.m34 := 1;
  Result.m43 := -AZNear * AZFar / (AZFar - AZNear);
  Result.m44 := 0;
end;

class function TMatrix3D.CreatePerspectiveFovRH(const AFOV, AAspect, AZNear, AZFar: Single;
  const AHorizontalFOV: Boolean = False): TMatrix3D;
var
  XScale, YScale: Single;
begin
  if AHorizontalFOV then
  begin
    XScale := 1 / Tangent(AFOV / 2);
    YScale := XScale / AAspect;
  end else
  begin
    YScale := 1 / Tangent(AFOV / 2);
    XScale := YScale / AAspect;
  end;

  Result := TMatrix3D.Identity;
  Result.m11 := XScale;
  Result.m22 := YScale;
  Result.m33 := AZFar / (AZNear - AZFar);
  Result.m34 := -1;
  Result.m43 := AZNear * AZFar / (AZNear - AZFar);
  Result.m44 := 0;
end;

class operator TMatrix3D.Multiply(const APoint1, APoint2: TMatrix3D): TMatrix3D;
begin
  Result.M[0].V[0] := APoint1.M[0].V[0] * APoint2.M[0].V[0] + APoint1.M[0].V[1] * APoint2.M[1].V[0]
    + APoint1.M[0].V[2] * APoint2.M[2].V[0] + APoint1.M[0].V[3] * APoint2.M[3].V[0];
  Result.M[0].V[1] := APoint1.M[0].V[0] * APoint2.M[0].V[1] + APoint1.M[0].V[1] * APoint2.M[1].V[1]
    + APoint1.M[0].V[2] * APoint2.M[2].V[1] + APoint1.M[0].V[3] * APoint2.M[3].V[1];
  Result.M[0].V[2] := APoint1.M[0].V[0] * APoint2.M[0].V[2] + APoint1.M[0].V[1] * APoint2.M[1].V[2]
    + APoint1.M[0].V[2] * APoint2.M[2].V[2] + APoint1.M[0].V[3] * APoint2.M[3].V[2];
  Result.M[0].V[3] := APoint1.M[0].V[0] * APoint2.M[0].V[3] + APoint1.M[0].V[1] * APoint2.M[1].V[3]
    + APoint1.M[0].V[2] * APoint2.M[2].V[3] + APoint1.M[0].V[3] * APoint2.M[3].V[3];
  Result.M[1].V[0] := APoint1.M[1].V[0] * APoint2.M[0].V[0] + APoint1.M[1].V[1] * APoint2.M[1].V[0]
    + APoint1.M[1].V[2] * APoint2.M[2].V[0] + APoint1.M[1].V[3] * APoint2.M[3].V[0];
  Result.M[1].V[1] := APoint1.M[1].V[0] * APoint2.M[0].V[1] + APoint1.M[1].V[1] * APoint2.M[1].V[1]
    + APoint1.M[1].V[2] * APoint2.M[2].V[1] + APoint1.M[1].V[3] * APoint2.M[3].V[1];
  Result.M[1].V[2] := APoint1.M[1].V[0] * APoint2.M[0].V[2] + APoint1.M[1].V[1] * APoint2.M[1].V[2]
    + APoint1.M[1].V[2] * APoint2.M[2].V[2] + APoint1.M[1].V[3] * APoint2.M[3].V[2];
  Result.M[1].V[3] := APoint1.M[1].V[0] * APoint2.M[0].V[3] + APoint1.M[1].V[1] * APoint2.M[1].V[3]
    + APoint1.M[1].V[2] * APoint2.M[2].V[3] + APoint1.M[1].V[3] * APoint2.M[3].V[3];
  Result.M[2].V[0] := APoint1.M[2].V[0] * APoint2.M[0].V[0] + APoint1.M[2].V[1] * APoint2.M[1].V[0]
    + APoint1.M[2].V[2] * APoint2.M[2].V[0] + APoint1.M[2].V[3] * APoint2.M[3].V[0];
  Result.M[2].V[1] := APoint1.M[2].V[0] * APoint2.M[0].V[1] + APoint1.M[2].V[1] * APoint2.M[1].V[1]
    + APoint1.M[2].V[2] * APoint2.M[2].V[1] + APoint1.M[2].V[3] * APoint2.M[3].V[1];
  Result.M[2].V[2] := APoint1.M[2].V[0] * APoint2.M[0].V[2] + APoint1.M[2].V[1] * APoint2.M[1].V[2]
    + APoint1.M[2].V[2] * APoint2.M[2].V[2] + APoint1.M[2].V[3] * APoint2.M[3].V[2];
  Result.M[2].V[3] := APoint1.M[2].V[0] * APoint2.M[0].V[3] + APoint1.M[2].V[1] * APoint2.M[1].V[3]
    + APoint1.M[2].V[2] * APoint2.M[2].V[3] + APoint1.M[2].V[3] * APoint2.M[3].V[3];
  Result.M[3].V[0] := APoint1.M[3].V[0] * APoint2.M[0].V[0] + APoint1.M[3].V[1] * APoint2.M[1].V[0]
    + APoint1.M[3].V[2] * APoint2.M[2].V[0] + APoint1.M[3].V[3] * APoint2.M[3].V[0];
  Result.M[3].V[1] := APoint1.M[3].V[0] * APoint2.M[0].V[1] + APoint1.M[3].V[1] * APoint2.M[1].V[1]
    + APoint1.M[3].V[2] * APoint2.M[2].V[1] + APoint1.M[3].V[3] * APoint2.M[3].V[1];
  Result.M[3].V[2] := APoint1.M[3].V[0] * APoint2.M[0].V[2] + APoint1.M[3].V[1] * APoint2.M[1].V[2]
    + APoint1.M[3].V[2] * APoint2.M[2].V[2] + APoint1.M[3].V[3] * APoint2.M[3].V[2];
  Result.M[3].V[3] := APoint1.M[3].V[0] * APoint2.M[0].V[3] + APoint1.M[3].V[1] * APoint2.M[1].V[3]
    + APoint1.M[3].V[2] * APoint2.M[2].V[3] + APoint1.M[3].V[3] * APoint2.M[3].V[3];
end;

class operator TMatrix3D.Multiply(const APoint: TPoint3D; const AMatrix: TMatrix3D): TPoint3D;
begin
  Result.X := (APoint.X * AMatrix.m11) + (APoint.Y * AMatrix.m21) + (APoint.Z * AMatrix.m31) + AMatrix.m41;
  Result.Y := (APoint.X * AMatrix.m12) + (APoint.Y * AMatrix.m22) + (APoint.Z * AMatrix.m32) + AMatrix.m42;
  Result.Z := (APoint.X * AMatrix.m13) + (APoint.Y * AMatrix.m23) + (APoint.Z * AMatrix.m33) + AMatrix.m43;
end;

class operator TMatrix3D.Multiply(const AVector: TVector3D;
 const AMatrix: TMatrix3D): TVector3D;
begin
  Result.X := (AVector.X * AMatrix.m11) + (AVector.Y * AMatrix.m21) + (AVector.Z * AMatrix.m31) + (AVector.W * AMatrix.m41);
  Result.Y := (AVector.X * AMatrix.m12) + (AVector.Y * AMatrix.m22) + (AVector.Z * AMatrix.m32) + (AVector.W * AMatrix.m42);
  Result.Z := (AVector.X * AMatrix.m13) + (AVector.Y * AMatrix.m23) + (AVector.Z * AMatrix.m33) + (AVector.W * AMatrix.m43);
  Result.W := (AVector.X * AMatrix.m14) + (AVector.Y * AMatrix.m24) + (AVector.Z * AMatrix.m34) + (AVector.W * AMatrix.m44);
end;

function TMatrix3D.Scale(const AFactor: single): TMatrix3D;
var
  i: Integer;
begin
{$EXCESSPRECISION OFF}
  for i := 0 to 3 do
  begin
    Result.M[i].V[0] := Self.M[i].V[0] * AFactor;
    Result.M[i].V[1] := Self.M[i].V[1] * AFactor;
    Result.M[i].V[2] := Self.M[i].V[2] * AFactor;
    Result.M[i].V[3] := Self.M[i].V[3] * AFactor;
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

function TMatrix3D.EyePosition: TPoint3D;
type
  TMatrix3DArray = array [0 .. 15] of Single;
begin
  Result.X := - TMatrix3DArray(Self)[0] * TMatrix3DArray(Self)[12] - TMatrix3DArray(Self)[1] * TMatrix3DArray(Self)[13]
    - TMatrix3DArray(Self)[2] * TMatrix3DArray(Self)[14];
  Result.Y := - TMatrix3DArray(Self)[4] * TMatrix3DArray(Self)[12] - TMatrix3DArray(Self)[5] * TMatrix3DArray(Self)[13]
    - TMatrix3DArray(Self)[6] * TMatrix3DArray(Self)[14];
  Result.Z := - TMatrix3DArray(Self)[8] * TMatrix3DArray(Self)[12] - TMatrix3DArray(Self)[9] * TMatrix3DArray(Self)[13]
    - TMatrix3DArray(Self)[10] * TMatrix3DArray(Self)[14];
end;

function TMatrix3D.DetInternal(const a1, a2, a3, b1, b2, b3, c1, c2, c3: Single): Single;
begin
  Result := a1 * (b2 * c3 - b3 * c2) - b1 * (a2 * c3 - a3 * c2) + c1 * (a2 * b3 - a3 * b2);
end;

function TMatrix3D.Determinant: Single;
begin
  Result :=
    Self.M[0].V[0] * DetInternal(Self.M[1].V[1], Self.M[2].V[1], Self.M[3].V[1], Self.M[1].V[2],
    Self.M[2].V[2], Self.M[3].V[2], Self.M[1].V[3], Self.M[2].V[3], Self.M[3].V[3])
    - Self.M[0].V[1] * DetInternal(Self.M[1].V[0], Self.M[2].V[0], Self.M[3].V[0], Self.M[1].V[2], Self.M[2].V[2],
    Self.M[3].V[2], Self.M[1].V[3], Self.M[2].V[3], Self.M[3].V[3])
    + Self.M[0].V[2] * DetInternal(Self.M[1].V[0], Self.M[2].V[0], Self.M[3].V[0], Self.M[1].V[1], Self.M[2].V[1],
    Self.M[3].V[1], Self.M[1].V[3], Self.M[2].V[3], Self.M[3].V[3])
    - Self.M[0].V[3] * DetInternal(Self.M[1].V[0], Self.M[2].V[0], Self.M[3].V[0], Self.M[1].V[1], Self.M[2].V[1],
    Self.M[3].V[1], Self.M[1].V[2], Self.M[2].V[2], Self.M[3].V[2]);
end;

function TMatrix3D.Adjoint: TMatrix3D;
var
  a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4: Single;
begin
  a1 := Self.M[0].V[0];
  b1 := Self.M[0].V[1];
  c1 := Self.M[0].V[2];
  d1 := Self.M[0].V[3];
  a2 := Self.M[1].V[0];
  b2 := Self.M[1].V[1];
  c2 := Self.M[1].V[2];
  d2 := Self.M[1].V[3];
  a3 := Self.M[2].V[0];
  b3 := Self.M[2].V[1];
  c3 := Self.M[2].V[2];
  d3 := Self.M[2].V[3];
  a4 := Self.M[3].V[0];
  b4 := Self.M[3].V[1];
  c4 := Self.M[3].V[2];
  d4 := Self.M[3].V[3];

  Result.M[0].V[0] := DetInternal(b2, b3, b4, c2, c3, c4, d2, d3, d4);
  Result.M[1].V[0] := -DetInternal(a2, a3, a4, c2, c3, c4, d2, d3, d4);
  Result.M[2].V[0] := DetInternal(a2, a3, a4, b2, b3, b4, d2, d3, d4);
  Result.M[3].V[0] := -DetInternal(a2, a3, a4, b2, b3, b4, c2, c3, c4);

  Result.M[0].V[1] := -DetInternal(b1, b3, b4, c1, c3, c4, d1, d3, d4);
  Result.M[1].V[1] := DetInternal(a1, a3, a4, c1, c3, c4, d1, d3, d4);
  Result.M[2].V[1] := -DetInternal(a1, a3, a4, b1, b3, b4, d1, d3, d4);
  Result.M[3].V[1] := DetInternal(a1, a3, a4, b1, b3, b4, c1, c3, c4);

  Result.M[0].V[2] := DetInternal(b1, b2, b4, c1, c2, c4, d1, d2, d4);
  Result.M[1].V[2] := -DetInternal(a1, a2, a4, c1, c2, c4, d1, d2, d4);
  Result.M[2].V[2] := DetInternal(a1, a2, a4, b1, b2, b4, d1, d2, d4);
  Result.M[3].V[2] := -DetInternal(a1, a2, a4, b1, b2, b4, c1, c2, c4);

  Result.M[0].V[3] := -DetInternal(b1, b2, b3, c1, c2, c3, d1, d2, d3);
  Result.M[1].V[3] := DetInternal(a1, a2, a3, c1, c2, c3, d1, d2, d3);
  Result.M[2].V[3] := -DetInternal(a1, a2, a3, b1, b2, b3, d1, d2, d3);
  Result.M[3].V[3] := DetInternal(a1, a2, a3, b1, b2, b3, c1, c2, c3);
end;

function TMatrix3D.Inverse: TMatrix3D;
const
  DefaultValue: TMatrix3D = (m11: 1.0; m12: 0.0; m13: 0.0; m14: 0.0; m21: 0.0; m22: 1.0; m23: 0.0; m24: 0.0; m31: 0.0;
    m32: 0.0; m33: 1.0; m34: 0.0; m41: 0.0; m42: 0.0; m43: 0.0; m44: 1.0;);
var
  Det: Single;
begin
  Det := Self.Determinant;
  if Abs(Det) < Epsilon then
    Result := DefaultValue
  else
    Result := Self.Adjoint.Scale(1 / Det);
end;

function TMatrix3D.ToMatrix: TMatrix;
begin
  Result.m11 := Self.m11;
  Result.m12 := Self.m12;
  Result.m13 := Self.m13;
  Result.m21 := Self.m21;
  Result.m22 := Self.m22;
  Result.m23 := Self.m23;
  Result.m31 := Self.m31;
  Result.m32 := Self.m32;
  Result.m33 := Self.m33;
end;

{ TQuaternion3D }

constructor TQuaternion3D.Create(const AAxis: TPoint3D; const AAngle: Single);
var
  AxisLen, Sine, Cosine: Single;
begin
  AxisLen := AAxis.Length;

  if AxisLen > 0 then
  begin
    SinCosSingle(AAngle / 2, Sine, Cosine);

    Self.RealPart := Cosine;
    Self.ImagPart := AAxis * (Sine / AxisLen);
  end else Self := Identity;
end;

constructor TQuaternion3D.Create(const AYaw, APitch, ARoll: Single);
begin
  Self := TQuaternion3D.Create(Point3D(0, 1, 0), AYaw) * TQuaternion3D.Create(Point3D(1, 0, 0), APitch)
    * TQuaternion3D.Create(Point3D(0, 0, 1), ARoll);
end;

constructor TQuaternion3D.Create(const AMatrix: TMatrix3D);
var
  Trace, S: double;
  NewQuat: TQuaternion3D;
begin
  Trace := AMatrix.m11 + AMatrix.m22 + AMatrix.m33;
  if Trace > EPSILON then
  begin
    S := 0.5 / Sqrt(Trace + 1.0);
    NewQuat.ImagPart.X := (AMatrix.M23 - AMatrix.M32) * S;
    NewQuat.ImagPart.Y := (AMatrix.M31 - AMatrix.M13) * S;
    NewQuat.ImagPart.Z := (AMatrix.M12 - AMatrix.M21) * S;
    NewQuat.RealPart := 0.25 / S;
  end
  else if (AMatrix.M11 > AMatrix.M22) and (AMatrix.M11 > AMatrix.M33) then
  begin
    S := Sqrt(Max(EPSILON, 1 + AMatrix.M11 - AMatrix.M22 - AMatrix.M33)) * 2.0;
    NewQuat.ImagPart.X := 0.25 * S;
    NewQuat.ImagPart.Y := (AMatrix.M12 + AMatrix.M21) / S;
    NewQuat.ImagPart.Z := (AMatrix.M31 + AMatrix.M13) / S;
    NewQuat.RealPart := (AMatrix.M23 - AMatrix.M32) / S;
  end
  else if (AMatrix.M22 > AMatrix.M33) then
  begin
    S := Sqrt(Max(EPSILON, 1 + AMatrix.M22 - AMatrix.M11 - AMatrix.M33)) * 2.0;
    NewQuat.ImagPart.X := (AMatrix.M12 + AMatrix.M21) / S;
    NewQuat.ImagPart.Y := 0.25 * S;
    NewQuat.ImagPart.X := (AMatrix.M23 + AMatrix.M32) / S;
    NewQuat.RealPart := (AMatrix.M31 - AMatrix.M13) / S;
  end else
  begin
    S := Sqrt(Max(EPSILON, 1 + AMatrix.M33 - AMatrix.M11 - AMatrix.M22)) * 2.0;
    NewQuat.ImagPart.X := (AMatrix.M31 + AMatrix.M13) / S;
    NewQuat.ImagPart.Y := (AMatrix.M23 + AMatrix.M32) / S;
    NewQuat.ImagPart.Z := 0.25 * S;
    NewQuat.RealPart := (AMatrix.M12 - AMatrix.M21) / S;
  end;
  Self := NewQuat.Normalize;
end;

class operator TQuaternion3D.Implicit(const AQuaternion: TQuaternion3D): TMatrix3D;
var
  NormQuat: TQuaternion3D;
  xx, xy, xz, xw, yy, yz, yw, zz, zw: Single;
begin
  NormQuat := AQuaternion.Normalize;

{$EXCESSPRECISION OFF}
  xx := NormQuat.ImagPart.X * NormQuat.ImagPart.X;
  xy := NormQuat.ImagPart.X * NormQuat.ImagPart.Y;
  xz := NormQuat.ImagPart.X * NormQuat.ImagPart.Z;
  xw := NormQuat.ImagPart.X * NormQuat.RealPart;
  yy := NormQuat.ImagPart.Y * NormQuat.ImagPart.Y;
  yz := NormQuat.ImagPart.Y * NormQuat.ImagPart.Z;
  yw := NormQuat.ImagPart.Y * NormQuat.RealPart;
  zz := NormQuat.ImagPart.Z * NormQuat.ImagPart.Z;
  zw := NormQuat.ImagPart.Z * NormQuat.RealPart;
{$EXCESSPRECISION ON}

  FillChar(Result, Sizeof(Result), 0);
  Result.M11 := 1 - 2 * (yy + zz);
  Result.M21 := 2 * (xy - zw);
  Result.M31 := 2 * (xz + yw);
  Result.M12 := 2 * (xy + zw);
  Result.M22 := 1 - 2 * (xx + zz);
  Result.M32 := 2 * (yz - xw);
  Result.M13 := 2 * (xz - yw);
  Result.M23 := 2 * (yz + xw);
  Result.M33 := 1 - 2 * (xx + yy);
  Result.M44 := 1;
end;

class operator TQuaternion3D.Multiply(const AQuaternion1, AQuaternion2: TQuaternion3D): TQuaternion3D;
begin
  Result.RealPart := AQuaternion1.RealPart * AQuaternion2.RealPart - AQuaternion1.ImagPart.X * AQuaternion2.ImagPart.X
    - AQuaternion1.ImagPart.Y * AQuaternion2.ImagPart.Y - AQuaternion1.ImagPart.Z * AQuaternion2.ImagPart.Z;
  Result.ImagPart.X := AQuaternion1.RealPart * AQuaternion2.ImagPart.X + AQuaternion2.RealPart * AQuaternion1.ImagPart.X
    + AQuaternion1.ImagPart.Y * AQuaternion2.ImagPart.Z - AQuaternion1.ImagPart.Z * AQuaternion2.ImagPart.Y;
  Result.ImagPart.Y := AQuaternion1.RealPart * AQuaternion2.ImagPart.Y + AQuaternion2.RealPart * AQuaternion1.ImagPart.Y
    + AQuaternion1.ImagPart.Z * AQuaternion2.ImagPart.X - AQuaternion1.ImagPart.X * AQuaternion2.ImagPart.Z;
  Result.ImagPart.Z := AQuaternion1.RealPart * AQuaternion2.ImagPart.Z + AQuaternion2.RealPart * AQuaternion1.ImagPart.Z
    + AQuaternion1.ImagPart.X * AQuaternion2.ImagPart.Y - AQuaternion1.ImagPart.Y * AQuaternion2.ImagPart.X;
end;

function TQuaternion3D.Length: Single;
begin
  Result := Sqrt(Self.ImagPart.DotProduct(Self.ImagPart) + Self.RealPart * Self.RealPart);
end;

function TQuaternion3D.Normalize: TQuaternion3D;
var
  QuatLen, InvLen: Single;
begin
  QuatLen := Self.Length;
  if QuatLen > EPSILON2 then
  begin
{$EXCESSPRECISION OFF}
    InvLen := 1 / QuatLen;
    Result.ImagPart := Self.ImagPart * InvLen;
    Result.RealPart := Self.RealPart * InvLen;
{$EXCESSPRECISION ON}
  end
  else
    Result := Identity;
end;

end.
