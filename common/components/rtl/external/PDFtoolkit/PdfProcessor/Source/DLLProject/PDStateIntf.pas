unit PDStateIntf;

interface

uses
  gtObjectIntf, PDMatrixIntf, PDBaseObjectIntf;

type

  IgtPDState = class(IgtObject)

    function Copy: IgtPDState; virtual; abstract;

  // Transforms.
    procedure Transform(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      virtual; abstract;
    procedure TransformDelta(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      virtual; abstract;
    procedure TextTransform(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      virtual; abstract;
    procedure TextTransformDelta(X1: Double; Y1: Double; var X2: Double; var Y2: Double);
      virtual; abstract;
    function TransformWidth(Width: Double): Double; virtual; abstract;
    function GetTransformedLineWidth: Double; virtual; abstract;
    function GetTransformedFontSize: Double; virtual; abstract;
    function GetFontTransMatrix: IgtPDMatrix; virtual; abstract;

    procedure ConcatCTM(Matrix: IgtPDMatrix); virtual; abstract;
    procedure ShiftCTM(Tx: Double; Ty: Double); virtual; abstract;

  //Path Operations
    procedure MoveTo(X: Double; Y: Double); virtual; abstract;
    procedure LineTo(X: Double; Y: Double); virtual; abstract;
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double); virtual; abstract;
    procedure ClosePath; virtual; abstract;
    procedure ClearPath; virtual; abstract;
    procedure Clip; virtual; abstract;
    procedure ClipToStrokePath; virtual; abstract;

  // Text position.
    procedure TextSetPos(Tx, Ty: Double); virtual; abstract;
    procedure TextMoveTo(Tx, Ty: Double); virtual; abstract;
    procedure TextShift(Tx, Ty: Double); virtual; abstract;
    procedure Shift(Dx, Dy: Double); virtual; abstract;

  // Push/pop GfxState on/off stack.
    function Save: IgtPDState; virtual; abstract;
    function Restore: IgtPDState; virtual; abstract;
    function HasSaves: Boolean; virtual; abstract;

//    function ParseBlendMode(BlendModeObj: IgtPDBaseObject;      Blend mode
//      var Mode: TgtBlendMode): Boolean; virtual; abstract;
(*
  // properties
    procedure SethDPI(const Value: Double); virtual; abstract;
    procedure SetvDPI(const Value: Double); virtual; abstract;
    procedure SetCTM(const Value: IgtPDMatrix); virtual; abstract;
    procedure SetX1(const Value: Double); virtual; abstract;
    procedure SetX2(const Value: Double); virtual; abstract;
    procedure SetY1(const Value: Double); virtual; abstract;
    procedure SetY2(const Value: Double); virtual; abstract;
    procedure SetPageHeight(const Value: Double); virtual; abstract;
    procedure SetPageWidth(const Value: Double); virtual; abstract;
    procedure SetRotate(const Value: Integer); virtual; abstract;
*)
  End;

implementation

end.
