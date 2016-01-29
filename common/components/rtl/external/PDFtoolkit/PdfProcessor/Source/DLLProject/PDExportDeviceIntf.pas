unit PDExportDeviceIntf;

interface

uses
  gtObjectIntf, PDMatrixIntf, PDStateIntf;

type

  TUnicode = Word;

  TUnicodes = array of TUnicode;

  TCharCode = Word;

  IgtPDExportDevice = class(TInterfacedObject, IgtObject)
    function GetUpsideDown: WordBool; virtual; abstract;
    function UseDrawChar: WordBool; virtual; abstract;
    function UseTillingPatternFill: WordBool; virtual; abstract;
    function UseShadedFill: WordBool; virtual; abstract;
    function UseDrawForm: WordBool; virtual; abstract;
    function InterpretType3Chars: WordBool; virtual; abstract;
    function NeedNonText: WordBool; virtual; abstract;


    function CheckPageSlice(Page: IgtObject; hDPI: Double; vDPI: Double;
      Rotate: Integer; UseMediaBox: WordBool; Crop: WordBool; SliceX: Double;
      SliceY: Double; SliceW: Double; SliceH: Double): WordBool; virtual; abstract;
    procedure StartPage(nPage: Integer; State: IgtPDState); virtual; abstract;
    procedure EndPage; virtual; abstract;
    procedure Dump; virtual; abstract;

    procedure ConvertDevToUser(Dx: Double; Dy: Double; var Ux: Double;
      var Uy: Double); virtual; abstract;
    procedure ConvertUserToDev(Ux: Double; Uy: Double; var Dx: Double;
      var Dy: Double); virtual; abstract;
    function GetDefaultCTM: IgtPDMatrix; virtual; abstract;
    procedure SetDefaultCTM(Matrix: IgtPDMatrix); virtual; abstract;
    function GetDefaultInverseCTM: IgtPDMatrix; virtual; abstract;
    procedure SetDefaultInverseCTM(const Value: IgtPDMatrix); virtual; abstract;

    procedure SaveState(State: IgtPDState); virtual; abstract;
    procedure RestoreState(State: IgtPDState); virtual; abstract;

    procedure UpdateAll(State: IgtPDState); virtual; abstract;
    procedure UpdateCTM(State: IgtPDState; CTM: IgtPDMatrix); virtual; abstract;
    procedure UpdateLineDash(State: IgtPDState); virtual; abstract;
    procedure UpdateFlatness(State: IgtPDState); virtual; abstract;
    procedure UpdateLineJoin(State: IgtPDState); virtual; abstract;
    procedure UpdateLineCap(State: IgtPDState); virtual; abstract;
    procedure UpdateMiterLimit(State: IgtPDState); virtual; abstract;
    procedure UpdateLineWidth(State: IgtPDState); virtual; abstract;
    procedure UpdateStrokeAdjust(State: IgtPDState); virtual; abstract;
    procedure UpdateFillColorSpace(State: IgtPDState); virtual; abstract;
    procedure UpdateStrokeColorSpace(State: IgtPDState); virtual; abstract;
    procedure UpdateFillColor(State: IgtPDState); virtual; abstract;
    procedure UpdateStrokeColor(State: IgtPDState); virtual; abstract;
    procedure UpdateBlendMode(State: IgtPDState); virtual; abstract;
    procedure UpdateFillOpacity(State: IgtPDState); virtual; abstract;
    procedure UpdateStrokeOpacity(State: IgtPDState); virtual; abstract;
    procedure UpdateFillOverPrint(State: IgtPDState); virtual; abstract;
    procedure UpdateStrokeOverPrint(State:  IgtPDState); virtual; abstract;
    procedure UpdateTransfer(State: IgtPDState); virtual; abstract;
    procedure ClearSoftMask(State: IgtPDState); virtual; abstract;

    procedure UpdateFont(State: IgtPDState); virtual; abstract;
    procedure UpdateTextMatrix(State: IgtPDState); virtual; abstract;
    procedure UpdateCharSpace(State: IgtPDState); virtual; abstract;
    procedure UpdateRender(State: IgtPDState); virtual; abstract;
    procedure UpdateRise(State: IgtPDState); virtual; abstract;
    procedure UpdateWordSpace(State: IgtPDState); virtual; abstract;
    procedure UpdateHorizScaling(State: IgtPDState); virtual; abstract;
    procedure UpdateTextPos(State: IgtPDState); virtual; abstract;
    procedure UpdateTextShift(State: IgtPDState; Shift: Double); virtual; abstract;

    procedure Stroke(State: IgtPDState); virtual; abstract;
    procedure Fill(State: IgtPDState); virtual; abstract;
    procedure EvenOddFill(State: IgtPDState); virtual; abstract;

    procedure Clip(State: IgtPDState); virtual; abstract;
    procedure EvenOddClip(State: IgtPDState); virtual; abstract;
    procedure ClipToStrokePath(State: IgtPDState); virtual; abstract;

    procedure BeginStringOp(State: IgtPDState); virtual; abstract;
    procedure EndStringOp(State: IgtPDState); virtual; abstract;
    procedure BeginString(State: IgtPDState; Str: WideString); virtual; abstract;
    procedure EndString(State: IgtPDState); virtual; abstract;
    procedure DrawChar(State: IgtPDState; X: Double; Y: Double;
      Dx: Double; Dy: Double; OrginX: Double; OrginY: Double;
      Code: TCharCode; Unicode: TUnicodes); virtual; abstract;
    procedure DrawString(const Str: WideString; State: IgtPDState); virtual; abstract;
    function BeginType3Char(State: IgtPDState; X: Double; Y: Double;
      Dx: Double; Dy: Double; Code: TCharCode; Unicode: TUnicodes;
      Len: Integer): WordBool; virtual; abstract;
    procedure EndType3Char(State: IgtPDState); virtual; abstract;
    procedure EndTextObject(State: IgtPDState); virtual; abstract;
    //procedure DrawImage(State: IgtPDState; Image: TgtPDImage); virtual; abstract;
  End;

implementation

end.
