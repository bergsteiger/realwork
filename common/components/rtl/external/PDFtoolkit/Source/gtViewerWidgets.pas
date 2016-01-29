unit gtViewerWidgets;
{$I gtDefines.inc}

interface

uses
  ExtCtrls, Classes, Graphics, {$IFDEF gtDelphi6Up} Types, {$ELSE} Windows, {$ENDIF} gtViewerTypes;

{$IFDEF gtDelphi5}
const
  clSkyBlue = TColor($F0CAA6);
{$ENDIF}

type

  TgtRgnSelectionLabelPos = (rslpTopLeft, rslpTopRight, rslpBottomLeft,
    rslpBottomRight);

  TgtRegionSelectorSettings = class(TPersistent)
  private
    FShowLabel: Boolean;
    FLabelPrefix: string;
    FLabelOffset: Integer;
    FLabelPosition: TgtRgnSelectionLabelPos;
    FFrameWidth: Integer;
    FDrawFrame: Boolean;
    FFrameColor: TColor;
    FColor: TColor;
    FLabelColor: TColor;
    FLabelFont: TFont;
    function IsLabelPrefixStored: Boolean;
    procedure LabelFontChanged(Sender: TObject);
    procedure SetLabelFont(const Value: TFont);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Color: TColor read FColor write FColor default clSkyBlue;
    property DrawFrame: Boolean read FDrawFrame write FDrawFrame default True;
    property FrameColor: TColor read FFrameColor write FFrameColor default clBlue;
    property FrameWidth: Integer read FFrameWidth write FFrameWidth default 1;
    property ShowLabel: Boolean read FShowLabel write FShowLabel default True;
    property LabelPrefix: string read FLabelPrefix write FLabelPrefix stored IsLabelPrefixStored;
    property LabelPosition: TgtRgnSelectionLabelPos read FLabelPosition
      write FLabelPosition default rslpTopLeft;
    property LabelOffset: Integer read FLabelOffset write FLabelOffset default 4;
    property LabelFont: TFont read FLabelFont write SetLabelFont;
    property LabelColor: TColor read FLabelColor write FLabelColor default clSkyBlue;
  end;

  TgtViewerWidget = class(TShape)
  private
    FActualBoundsRect: TRect;
    FPageIndex: Integer;
    FAssociatedObj: TObject;
    FAssociatedRgn: TObject;
  public
//    procedure ViewerChanged(ANewZoom: Double; ANewRotation: TgtRotationAngle);
    property AssociatedObj: TObject read FAssociatedObj write FAssociatedObj;
    property ActualBoundsRect: TRect read FActualBoundsRect write FActualBoundsRect;
    property PageIndex: Integer read FPageIndex write FPageIndex;
    property AssociatedRgn: TObject read FAssociatedRgn write FAssociatedRgn;
  end;

  TgtHighlightWidget = class(TgtViewerWidget)
  private
    function GetBrushColor: TColor;
    procedure SetBrushColor(const Value: TColor);
  public
    constructor Create(AOwner: TComponent); override;
    property BrushColor: TColor read GetBrushColor write SetBrushColor;
  end;

  TgtRegionSelectionWidget = class(TgtHighlightWidget)
  private
    FSelectionType: TgtSelectionType;
//    FRegionSettings: TgtRegionSelectorSettings;
    FLabelColor: TColor;
    FLabelFont: TFont;
    FLabelText: string;
    procedure SetSelectionType(const Value: TgtSelectionType);
    procedure SetLabelFont(const Value: TFont);
//  protected
//    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property LabelColor: TColor read FLabelColor write FLabelColor;
    property LabelFont: TFont read FLabelFont write SetLabelFont;
    property LabelText: string read FLabelText write FLabelText;
    property SelectionType: TgtSelectionType read FSelectionType write SetSelectionType;
  end;

  TgtAnnotationWidget = class(TgtHighlightWidget)

  end;

  TgtLinkAnnotationWidget = class(TgtAnnotationWidget)

  end;

  TgtHighlightWidgetClass = class of TgtHighlightWidget;
  TgtSelectionWidgetClass = class of TgtRegionSelectionWidget;
  TgtAnnotationWidgetClass = class of TgtAnnotationWidget;

const
  SelectionTypeToShapeType: array[TgtSelectionType] of
    TShapeType = (stCircle, stRectangle);

implementation

{ TgtViewerWidget }

//procedure TgtViewerWidget.ViewerChanged(ANewZoom: Double;
//  ANewRotation: TgtRotationAngle);
//begin
//
//end;

{ TgtHighlightWidget }

constructor TgtHighlightWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Pen.Mode := pmMask;
  Pen.Style := psClear;
  Width := 0;
  Height := 0;
  BrushColor := clSkyBlue;
end;

function TgtHighlightWidget.GetBrushColor: TColor;
begin
  Result := Brush.Color;
end;

procedure TgtHighlightWidget.SetBrushColor(const Value: TColor);
begin
  Brush.Color := Value;
end;

{ TgtSelectionWidget }

constructor TgtRegionSelectionWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  FRegionSettings := TgtRegionSelectorSettings.Create;
  Pen.Color := clBlue;
  Pen.Style := psSolid;
  FLabelFont := TFont.Create;
  FLabelFont.Name := 'Arial';
  FLabelFont.Size := 7;
  FLabelFont.Color := clRed;
  FLabelColor := clSkyBlue;
  FSelectionType := stRect;
end;

destructor TgtRegionSelectionWidget.Destroy;
begin
  FLabelFont.Free;
  inherited;
end;

//procedure TgtRegionSelectionWidget.Paint;
//var
//  LLabelHeight, LLabelWidth: Integer;
//  LRect: TRect;
//begin
//  inherited Paint;
//  if SelectionType = stPoint then
//    Exit;
//  // Draw label if SelectionType = stRect
//
////  if BrushColor = LabelColor then
////    Canvas.Brush.Style := bsClear
////  else
////    Canvas.Brush.Color := LabelColor;
////  Canvas.Brush.Style := bsSolid;
////  Canvas.Pen.Style := psSolid;
////  Canvas.Pen.Color := LabelFont.Color;
////  Canvas.Font := LabelFont;
////  LLabelHeight := Canvas.TextHeight(LabelText);
////  LLabelWidth := Canvas.TextWidth(LabelText);
////  LRect := Rect(Left + Width + 5,
////    Top - LLabelHeight - 1, Left + Width + 5 + LLabelWidth, Top);
////  Canvas.TextOut(LRect.Left, LRect.Top, LabelText);
////  Canvas.TextRect(LRect, LRect.Left, LRect.Top, LabelText);
//
////  case FRegionSettings.LabelPosition of
////    rslpTopLeft:
////     ;
////    rslpTopRight: ;
////    rslpBottomLeft: ;
////    rslpBottomRight: ;
////  end;
//
//end;

procedure TgtRegionSelectionWidget.SetLabelFont(const Value: TFont);
begin
  FLabelFont.Assign(Value);
end;

procedure TgtRegionSelectionWidget.SetSelectionType(const Value: TgtSelectionType);
begin
  FSelectionType := Value;
  Shape := SelectionTypeToShapeType[FSelectionType];
  if FSelectionType = stRect then // Rect
  begin
    Brush.Color := BrushColor;
//    Brush.Style := bsClear;
    Pen.Style := psSolid;
  end
  else                            // Point
  begin
    Width := 6;
    Height := 6;
    Brush.Color := clRed;
    Pen.Style := psClear;
  end;
end;

{ TgtRegionSelectorSettings }

constructor TgtRegionSelectorSettings.Create;
begin
  FShowLabel := True;
  FLabelPrefix := sRegionSelectorLabelPrefix;
  FLabelOffset := 4;
  FLabelPosition := rslpTopLeft;
  FFrameWidth := 1;
  FDrawFrame := True;
  FFrameColor := clBlue;
  FColor := clSkyBlue;
  FLabelColor := clSkyBlue;
  FLabelFont := TFont.Create;
  FLabelFont.Style := [fsItalic];
  FLabelFont.Color := clGray;
  FLabelFont.OnChange := LabelFontChanged;
end;

destructor TgtRegionSelectorSettings.Destroy;
begin
  FLabelFont.Free;
  inherited;
end;

function TgtRegionSelectorSettings.IsLabelPrefixStored: Boolean;
begin
  Result := LabelPrefix <> sRegionSelectorLabelPrefix;
end;

procedure TgtRegionSelectorSettings.LabelFontChanged(Sender: TObject);
begin
//
end;

procedure TgtRegionSelectorSettings.SetLabelFont(const Value: TFont);
begin
  FLabelFont.Assign(Value);
end;

end.
