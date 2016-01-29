{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.inc}

unit gtPDFClasses;

interface

uses
  Classes, SysUtils, Graphics, gtPDFUtils {$IFDEF gtDelphi6Up}, Types {$ELSE}, Windows{$ENDIF}
{$IFDEF gtActiveX}
  , Controls, Buttons
{$ENDIF};

type
{$IFDEF gtActiveX}
  TgtPDFBaseComponent = class(TCustomControl)
{$ELSE}
  TgtPDFBaseComponent = class(TComponent)
{$ENDIF}
  private
    FAbout: string;
    FVersion: string;
{$IFDEF gtActiveX}
    FIconBmp: TBitmap;
    function GetControlCanvas: TCanvas;
{$ENDIF}
    procedure SetAbout(const Value: string);
    procedure SetVersion(const Value: string);
  protected
{$IFDEF gtActiveX}
    property ControlCanvas: TCanvas read GetControlCanvas;
    property IconBmp: TBitmap read FIconBmp write FIconBmp;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{$IFDEF gtActiveX}
    procedure Paint; override;
{$ENDIF}
  published
    property About: string read FAbout write SetAbout;
    property Version: string read FVersion write SetVersion;
  end;
{$IFDEF gtActiveX}
  const AX_SIZE = 28;
{$ENDIF}

type
  TgtPDFPageElement = class;
  TgtPathOperation = (poStroke, poFill, poEOFill, poClip, poEvenOddClip);
  
  TgtPDFElementType = (etText, etImage, etPath, etFormField);
    TgtTextOutputPrecision = (tpAlignment, tpDefault);

  TgtPDFTextType = (ttChar, ttWord, ttLine);
  TgtTextRenderMode = (trFill, trStroke, trFillStroke, trNoFillStroke,
    trFillClip, trStrokeClip, trFillStrokeClip, trClip);

  TgtEnumPageElementCallBack = procedure (Sender: TObject;
    PageElement: TgtPDFPageElement; ElementType: TgtPDFElementType;
    PageNumber: Integer) of object;

   TgtFontType = (ftTrueType, ftType1);

  TgtElementTypes = set of TgtPDFElementType;
  
  TgtPDFFont = class
  private
    FName: string;
//    FStream: TStream;
    FSize: Integer;
    FFontType: TgtFontType;
    FFontStyle: TFontStyles;
    FPenColor, FFillColor: TColor;
  public
    constructor Create;
    property Name: string read FName write FName;
//    property Stream: TStream read FStream;
    property Size: Integer read FSize write FSize;
    property FontType: TgtFontType read FFontType write FFontType;
    property Style: TFontStyles read FFontStyle write FFontStyle;
    property PenColor: TColor read FPenColor write FPenColor;
    property FillColor: TColor read FFillColor write FFillColor;
  end;

  TgtCharProp = class
  private
    FRect: TgtRect;
    FFont: TgtPDFFont;
    FRenderMode: TgtTextRenderMode;
  public
    constructor Create(ARect: TRect);
    destructor Destroy; override;

    property Rect: TgtRect read FRect;
    property Font: TgtPDFFont read FFont write FFont;
//    property RenderMode: TgtTextRenderMode read FRenderMode;
  end;

  TgtCharPropList = class(TList)
  private
    function GetItem(Index: Integer): TgtCharProp;
  public
    destructor Destroy; override;
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    property Items[Index: Integer]: TgtCharProp read GetItem; default;
  end;

  TgtPDFPageElement = class
  private
//    FRect: TgtRect;
    FX: Double;
    FY: Double;
    FPageNum: Integer;
    FRect: TRect;
  protected
    FElementType: TgtPDFElementType;
    property Rect: TRect read FRect write FRect;
  public
    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property ElementType: TgtPDFElementType read FElementType;
    property PageNum: Integer read FPageNum write FPageNum;
//    property Rect: TgtRect read FRect write FRect;
  end;

  TgtPDFTextElement = class(TgtPDFPageElement)
  private
//    FCharProps: TgtCharPropList;
    FText: string;
    FLineNum: Integer;
  public
    constructor Create;
    destructor Destroy; override;

//    function GetCharProp(Index: Integer): TgtCharProp;
    property Text: string read FText write FText;
//    property CharProps: TgtCharPropList read FCharProps;
//    property LineNum: Integer read FLineNum write FLineNum;
    property Rect;
  end;

  TgtPDFImageElement = class(TgtPDFPageElement)
  private
    FImage: TStream;
    FWidth: Double;
    FHeight: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property Image: TStream read FImage;
    property Width: Double read FWidth write FWidth;
    property Height: Double read FHeight write FHeight;
  end;

  TgtPDFPathElement = class(TgtPDFPageElement)
  private
    FOperation: TgtPathOperation;
    FPen: TColor;
    FBrush: TColor;
    function GetIsCurve(Index: Integer): Boolean;
    function GetPoint(Index: Integer): TgtPoint;
  public
    constructor Create;
    property Points[Index: Integer]: TgtPoint read GetPoint;
    property IsCurve[Index: Integer]: Boolean read GetIsCurve;
    property Operation: TgtPathOperation read FOperation;
    property Pen: TColor read FPen;
    property Brush: TColor read FBrush;
  end;

  TgtPDFFormElement = class(TgtPDFPageElement)
  public
    constructor Create;
  end;

  TgtPDFPageElementList = class(TList)
    function GetItem(Index: Integer): TgtPDFPageElement;
  public
    destructor Destroy; override;
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    property Items[Index: Integer]: TgtPDFPageElement read GetItem; default;
  end;

implementation

{ TgtPDFBaseComponent }

constructor TgtPDFBaseComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF gtActiveX}
  FIconBmp := TBitmap.Create;
  FIconBmp.Transparent := True;
  FIconBmp.TransparentMode := tmAuto;
  SetBounds(Left, Top, AX_SIZE, AX_SIZE);
  Constraints.MinHeight := AX_SIZE;
  Constraints.MinWidth := AX_SIZE;
  Constraints.MaxHeight := AX_SIZE;
  Constraints.MaxWidth := AX_SIZE;
{$ENDIF}
end;

destructor TgtPDFBaseComponent.Destroy;
begin
{$IFDEF gtActiveX}
  FreeAndNil(FIconBmp);
{$ENDIF}
  inherited;
end;

{$IFDEF gtActiveX}

procedure TgtPDFBaseComponent.Paint;
begin
  inherited;
  DrawButtonFace(Canvas, Rect(0, 0, AX_SIZE, AX_SIZE), 1, bsNew, False, False, True);
end;

function TgtPDFBaseComponent.GetControlCanvas: TCanvas;
begin
  Result := Canvas;
end;
{$ENDIF}

procedure TgtPDFBaseComponent.SetAbout(const Value: string);
begin

end;

procedure TgtPDFBaseComponent.SetVersion(const Value: string);
begin

end;

{ TgtPDFFont }

constructor TgtPDFFont.Create;
begin

end;

{ TgtPDFImageElement }

constructor TgtPDFImageElement.Create;
begin
  FElementType := etImage;
  FImage := TMemoryStream.Create;
end;

destructor TgtPDFImageElement.Destroy;
begin
  if Assigned(FImage) then FreeAndNil(FImage);
  
  inherited;
end;

{ TgtPDFPathElement }

constructor TgtPDFPathElement.Create;
begin
  FElementType := etPath;
end;

function TgtPDFPathElement.GetIsCurve(Index: Integer): Boolean;
begin

end;

function TgtPDFPathElement.GetPoint(Index: Integer): TgtPoint;
begin

end;

{ TgtPDFPageElementList }

destructor TgtPDFPageElementList.Destroy;
var
  I: Integer;
begin
  // Done in the TList Notify

//  for I := 0 to Count - 1 do
//    if Assigned(Items[I]) then Items[I].Free;

  inherited;
end;

function TgtPDFPageElementList.GetItem(Index: Integer): TgtPDFPageElement;
begin
  Result := TgtPDFPageElement(inherited Get(Index));
end;

procedure TgtPDFPageElementList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action in [lnExtracted, lnDeleted] then
    TgtPDFPageElement(Ptr).Free;
end;

{ TgtCharProp }

constructor TgtCharProp.Create(ARect:TRect);
begin
  with FRect do
  begin
    Left := ARect.Left;
    Top := ARect.Top;
    Right := ARect.Right;
    Bottom := ARect.Bottom;
  end;
end;

destructor TgtCharProp.Destroy;
begin
  if Assigned(FFont) then FreeAndNil(FFont);

  inherited;
end;

{ TgtPDFTextElement }

constructor TgtPDFTextElement.Create;
begin
  FElementType := etText;
//  FCharProps := TgtCharPropList.Create;
end;

destructor TgtPDFTextElement.Destroy;
begin
//  if Assigned(FCharProps) then FreeAndNil(FCharProps);
  
  inherited;
end;

(*
function TgtPDFTextElement.GetCharProp(Index: Integer): TgtCharProp;
begin
  if Assigned(FCharProps) then
  begin
    if ((Index >0) and (Index < FCharProps.Count)) then
      Result := TgtCharProp(FCharProps[Index]);
  end;
end;
*)

{ TgtPDFFormElement }

constructor TgtPDFFormElement.Create;
begin
  FElementType := etFormField;
end;

{ TgtCharPropList }

destructor TgtCharPropList.Destroy;
begin

  inherited;
end;

function TgtCharPropList.GetItem(Index: Integer): TgtCharProp;
begin
  Result := TgtCharProp(inherited Get(Index));
end;

procedure TgtCharPropList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action in [lnExtracted, lnDeleted] then
    TgtCharProp(Ptr).Free;
end;


end.
