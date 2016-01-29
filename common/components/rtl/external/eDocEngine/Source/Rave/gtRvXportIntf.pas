{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }
{$I ..\gtExpIntf.inc}
{$I ..\gtDefines.inc}
// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- RaveReports Version Support ---
// Below v4.07: DISABLE Rave407Up, Rave50Up, Rave60Up
// v4.07 & above, but below v5.0: ENABLE Rave407Up & DISABLE Rave50Up, Rave60Up
// v5.0 & above, but below v5.08: ENABLE Rave407Up, Rave50Up & DISABLE Rave60Up
// v5.08 & above: ENABLE Rave407Up, Rave50Up, Rave60Up
// {$DEFINE Rave407Up}
// {$DEFINE Rave50Up}
// {$DEFINE Rave508Up}
// {$DEFINE Rave60Up}

unit gtRvXportIntf;

interface

uses
  Windows, Classes, Graphics, SysUtils, StdCtrls, RpRender, RpDefine, RpSystem,
  RpRave, gtConsts3, gtDocConsts, gtDocUtils, gtXportIntf, gtUtils3,
  gtCstDocEng, Math,
  Printers;

type
  TgtEncodeGraphicEvent = procedure(AObject: TObject; var UniqueImage: Boolean;
    var ReuseImageIndex: Integer) of object;
  TgtEncodeGraphicDoneEvent = procedure(AObject: TObject;
    ObjectImageIndex: Integer) of object;

  TgtRaveXport = class(TRPRenderStream)
  private
    FParent: TObject;
    FEngine: TgtCustomDocumentEngine;
    function CalcYDisp(FontSize: Integer; LineHeight: single;
      Superscript: Boolean): Double;
    procedure GetgtPoints(APointArray: array of
{$IFDEF Rave60Up} TFloatPoint; {$ELSE} TPoint; {$ENDIF}
      var AgtPoints: TgtPoints);
{$IFNDEF Rave50Up}
    function TextSize(const Text: string; AFont: TFont): TSize;
{$ENDIF}
    procedure SetEngine(const Value: TgtCustomDocumentEngine);

  protected
    // from TRPRenderStream
    procedure DocBegin; override;
    procedure DocEnd; override;
    procedure PageBegin; override;

    procedure Arc(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double); override;
    procedure Chord(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double); override;
    procedure Ellipse(const X1, Y1, X2, Y2: Double); override;
    procedure LineTo(const X1, Y1: Double); override;
    procedure MoveTo(const X1, Y1: Double); override;
{$IFDEF Rave407Up}
    procedure PolyLine(const PolyLineArr: array of
{$IFDEF Rave60Up} TFloatPoint); {$ELSE} TPoint); {$ENDIF} override;
    procedure Polygon(const PolyLineArr: array of
{$IFDEF Rave60Up} TFloatPoint); {$ELSE} TPoint); {$ENDIF} override;
{$ENDIF}
    procedure Rectangle(const X1, Y1, X2, Y2: Double); override;
    procedure FillRect(const ARect: TRect); override;
    procedure RoundRect(const X1, Y1, X2, Y2, X3, Y3: Double); override;
    procedure Pie(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double); override;
    procedure Draw(const X1, Y1: Double; AGraphic: TGraphic); override;
    procedure PrintBitmapRect(const X1, Y1, X2, Y2: Double;
      AGraphic: Graphics.TBitmap); override;
    procedure PrintBitmap(const X1, Y1, ScaleX, ScaleY: Double;
      AGraphic: Graphics.TBitmap); override;
    procedure StretchDraw(const ARect: TRect; AGraphic: TGraphic); override;
{$IFDEF Rave60Up}
    procedure PrintRightWidth(var X1, Y1: Double; Text: string;
      Width: Double); override;
{$ENDIF}
    procedure PrintSpaces(const AText: string;
      const X1, Y1, AWidth: Double); override;
    procedure TextRect(Rect: TRect; X1, Y1: Double; S1: string); override;
    procedure CenterText(const AText: string; const X1, Y1: Double); override;
    procedure LeftText(const AText: string; const X1, Y1: Double); override;
    procedure RightText(const AText: string; const X1, Y1: Double); override;

    property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;

  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AEngine: TgtCustomDocumentEngine);
      reintroduce; overload;
    destructor Destroy; override;
{$IFNDEF Rave50Up}
    procedure PrintRender(ANDRStream: TStream;
      AOutputFileName: TFileName); override;
{$ENDIF}
  end;

  TgtRaveExportInterface = class(TgtExportInterface)
  private
    FRaveXport: TgtRaveXport;
    FEncodeGraphic: TgtEncodeGraphicEvent; //
    FEncodeGraphicDone: TgtEncodeGraphicDoneEvent; //
    procedure ExecuteReport(ARPComponent: TRPComponent; AFileName: string;
      AShowPrepareStatus: Boolean);
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    function GetEncodeGraphic: TgtEncodeGraphicEvent; //
    function GetOnEncodeGraphicDone: TgtEncodeGraphicDoneEvent; //
    procedure SetOnEncodeGraphic(const Value: TgtEncodeGraphicEvent); //
    procedure SetOnEncodeGraphicDone(const Value: TgtEncodeGraphicDoneEvent); //
    function GetUserStream: TStream;
    procedure SetUserStream(Value: TStream);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(ANDRStream: TStream); overload;
    procedure RenderDocument(ANDRFileName: TFileName); overload;
    procedure RenderDocument(ARPComponent: TRPComponent;
      AShowPrepareStatus: Boolean); overload;
    property UserStream: TStream read GetUserStream write SetUserStream;
  published
    property Engine write SetEngine;
    property Visible write SetVisible;
    property OnEncodeGraphic: TgtEncodeGraphicEvent read GetEncodeGraphic
      write SetOnEncodeGraphic;
    property OnEncodeGraphicDone: TgtEncodeGraphicDoneEvent
      read GetOnEncodeGraphicDone write SetOnEncodeGraphicDone;
  end;

procedure Register;

var
  EncodeGraphic: TgtEncodeGraphicEvent;
  EncodeGraphicDone: TgtEncodeGraphicDoneEvent;
  MetafileAsRaster: Boolean;

implementation

{ TgtRaveXport }

procedure TgtRaveXport.Arc(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

procedure TgtRaveXport.Chord(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4,
    (Converter.Brush.Style <> bsClear));
end;

destructor TgtRaveXport.Destroy;
begin
  inherited;
end;

procedure TgtRaveXport.DocBegin;
begin
  inherited;
  if FEngine = nil then
    Exit;
  if (OutputStream <> nil) then
  begin
    IgtDocumentEngine(Engine).Preferences.OutputToUserStream := True;
    Engine.UserStream := TMemoryStream(OutputStream);
  end
  else
  begin
    IgtDocumentEngine(Engine).Preferences.OutputToUserStream := False;
    Engine.UserStream := nil;
  end;
{$IFDEF Rave60Up}
  IgtDocumentEngine(Engine).FileName := OutputFileName;
{$ENDIF}
  IgtDocumentEngine(Engine).Font := Converter.Font;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Page.PaperSize := Custom;
end;

procedure TgtRaveXport.DocEnd;
begin
  inherited;
  if FEngine = nil then
    Exit;
  if FParent is TgtRaveExportInterface then
    TgtRaveExportInterface(FParent).EndDocument
  else
    IgtDocumentEngine(Engine).EndDoc;
end;

procedure TgtRaveXport.Ellipse(const X1, Y1, X2, Y2: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Pen.Width := Round(PenWidth * CPixelsPerInch);
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Ellipse(X1, Y1, X2, Y2,
    (Converter.Brush.Style <> bsClear));
end;

procedure TgtRaveXport.LineTo(const X1, Y1: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Pen.Width := Round(PenWidth * CPixelsPerInch);
  IgtDocumentEngine(Engine).Line(Converter.CurrX, Converter.CurrY, X1, Y1);
end;

procedure TgtRaveXport.PageBegin;
begin
  inherited;
  if FEngine = nil then
    Exit;
{$IFDEF Rave60Up}
  IgtDocumentEngine(Engine).FileName := OutputFileName;
{$ENDIF}
  IgtDocumentEngine(Engine).Font := Converter.Font;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
{$IFDEF Rave50Up}
  case (Converter.ReportHeader.Orientation) of
    RpDefine.poDefault, RpDefine.poPortrait:
      begin
        IgtDocumentEngine(Engine).Page.Orientation := Printers.poPortrait;
      end;
    RpDefine.poLandScape:
      begin
        IgtDocumentEngine(Engine).Page.Orientation := Printers.poLandScape;
      end;
  end;
{$ENDIF}
  IgtDocumentEngine(Engine).Page.Height := snPaperHeight;
  IgtDocumentEngine(Engine).Page.Width := snPaperWidth;
  if (Converter.PageNo <> 1) then
    IgtDocumentEngine(Engine).NewPage
  else
  begin
    if FParent is TgtRaveExportInterface then
      TgtRaveExportInterface(FParent).StartDocument
    else
      IgtDocumentEngine(Engine).BeginDoc;
  end;
end;

{$IFDEF Rave407Up}

procedure TgtRaveXport.Polygon(const PolyLineArr: array of
{$IFDEF Rave60Up} TFloatPoint {$ELSE} TPoint {$ENDIF});
var
  LgtPoints: TgtPoints;
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  GetgtPoints(PolyLineArr, LgtPoints);
  IgtDocumentEngine(Engine).Polygon(LgtPoints,
    (Converter.Brush.Style <> bsClear));
end;

procedure TgtRaveXport.PolyLine(const PolyLineArr: array of
{$IFDEF Rave60Up} TFloatPoint {$ELSE} TPoint {$ENDIF});
var
  LgtPoints: TgtPoints;
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  GetgtPoints(PolyLineArr, LgtPoints);
  IgtDocumentEngine(Engine).PolyLine(LgtPoints);
end;
{$ENDIF}

procedure TgtRaveXport.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
  if (FEngine <> nil) then
  begin
    FEngine.MeasurementUnit := muInches;
    DisplayName := IgtDocumentEngine(Value).FileDescription;
    FileExtension := '*.' + IgtDocumentEngine(Value).FileExtension;
  end
  else
  begin
    DisplayName := '';
    FileExtension := '';
  end;
end;

procedure TgtRaveXport.GetgtPoints(APointArray: array of
{$IFDEF Rave60Up} TFloatPoint {$ELSE} TPoint
{$ENDIF}; var AgtPoints: TgtPoints);
var
  LI: Integer;
begin
  SetLength(AgtPoints, Length(APointArray));
  for LI := Low(APointArray) to High(APointArray) do
    AgtPoints[LI] := gtPoint(APointArray[LI].X, APointArray[LI].Y);
end;

procedure TgtRaveXport.Rectangle(const X1, Y1, X2, Y2: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Pen.Width := Round(PenWidth * CPixelsPerInch);

  if (Converter.Brush <> nil) and (Converter.Brush.Style <> bsSolid) and
    (Converter.Brush.Style <> bsClear) and
    (Converter.Brush.Style <> bsHorizontal) and
    (Converter.Brush.Style <> bsVertical) and
    (Converter.Brush.Style <> bsFDiagonal) and
    (Converter.Brush.Style <> bsBDiagonal) and
    (Converter.Brush.Style <> bsCross) and
    (Converter.Brush.Style <> bsDiagCross) then
    Converter.Brush.Style := bsClear;

  IgtDocumentEngine(Engine).Brush := Converter.Brush;

  IgtDocumentEngine(Engine).Rectangle(X1, Y1, X2, Y2,
    (Converter.Brush.Style <> bsClear));
end;

procedure TgtRaveXport.RoundRect(const X1, Y1, X2, Y2, X3, Y3: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).RoundRect(X1, Y1, X2, Y2, X3, Y3,
    (Converter.Brush.Style <> bsClear));
end;

procedure TgtRaveXport.FillRect(const ARect: TRect);
var
  LUnit: TgtUnitType;
begin
  if FEngine = nil then
    Exit;
  LUnit := Engine.MeasurementUnit;
  // FillRect provides Rect in Points only
  Engine.MeasurementUnit := muPoints;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Rectangle(ARect.TopLeft.X, ARect.TopLeft.Y,
    ARect.BottomRight.X, ARect.BottomRight.Y,
    (Converter.Brush.Style <> bsClear));
  Engine.MeasurementUnit := LUnit;
end;

procedure TgtRaveXport.Pie(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4,
    (Converter.Brush.Style <> bsClear));
end;

procedure TgtRaveXport.Draw(const X1, Y1: Double; AGraphic: TGraphic);
var
  LReuseImageIndex: Integer;
  LUniqueImage: Boolean;
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).ImageSettings.Stretch := False;
  LUniqueImage := True;
  LReuseImageIndex := -1;
  if Assigned(EncodeGraphic) then
    EncodeGraphic(TObject(AGraphic), LUniqueImage, LReuseImageIndex);
  if LUniqueImage then
    IgtDocumentEngine(Engine).DrawImage(X1, Y1, AGraphic)
  else
  begin
    if LReuseImageIndex = -1 then
      LReuseImageIndex := IgtDocumentEngine(Engine)
        .AddImageAsResource(AGraphic);
    IgtDocumentEngine(Engine).ImageSettings.AutoSize := True;
    IgtDocumentEngine(Engine).DrawImage(gtRect(X1, Y1, X1 + AGraphic.Width,
      Y1 + AGraphic.Height), LReuseImageIndex);
    if Assigned(EncodeGraphicDone) then
      EncodeGraphicDone(AGraphic, LReuseImageIndex);
  end;
end;

procedure TgtRaveXport.PrintBitmapRect(const X1, Y1, X2, Y2: Double;
  AGraphic: TBitmap);
var
  LReuseImageIndex: Integer;
  LUniqueImage: Boolean;
begin

  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).ImageSettings.Stretch := True;
  LUniqueImage := True;
  LReuseImageIndex := -1;
  if Assigned(EncodeGraphic) then
    EncodeGraphic(TObject(AGraphic), LUniqueImage, LReuseImageIndex);
  if LUniqueImage then
    IgtDocumentEngine(Engine).DrawImage(gtRect(Max(X1, 0.0), Max(Y1, 0.0), X2,
      Y2), AGraphic)
  else
  begin
    if LReuseImageIndex = -1 then
      LReuseImageIndex := IgtDocumentEngine(Engine)
        .AddImageAsResource(AGraphic);
    IgtDocumentEngine(Engine).DrawImage(gtRect(X1, Y1, X2, Y2),
      LReuseImageIndex);
    if Assigned(EncodeGraphicDone) then
      EncodeGraphicDone(AGraphic, LReuseImageIndex);
  end;
end;

procedure TgtRaveXport.PrintBitmap(const X1, Y1, ScaleX, ScaleY: Double;
  AGraphic: TBitmap);
var
  LReuseImageIndex: Integer;
  LUniqueImage: Boolean;
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).ImageSettings.Stretch := True;
  LUniqueImage := True;
  LReuseImageIndex := -1;
  if Assigned(EncodeGraphic) then
    EncodeGraphic(TObject(AGraphic), LUniqueImage, LReuseImageIndex);
  if LUniqueImage then
    IgtDocumentEngine(Engine)
      .DrawImage(gtRect(X1, Y1, X1 + (AGraphic.Width * ScaleX / CPixelsPerInch),
      Y1 + (AGraphic.Height * ScaleY / CPixelsPerInch)), AGraphic)
  else
  begin
    if LReuseImageIndex = -1 then
      LReuseImageIndex := IgtDocumentEngine(Engine)
        .AddImageAsResource(AGraphic);
    IgtDocumentEngine(Engine)
      .DrawImage(gtRect(X1, Y1, X1 + (AGraphic.Width * ScaleX / CPixelsPerInch),
      Y1 + (AGraphic.Height * ScaleY / CPixelsPerInch)), LReuseImageIndex);
    if Assigned(EncodeGraphicDone) then
      EncodeGraphicDone(AGraphic, LReuseImageIndex);

  end;
end;

procedure TgtRaveXport.StretchDraw(const ARect: TRect; AGraphic: TGraphic);
var
  LOldUnit: TgtUnitType;
  LMeta: TMetafile;
  LMetaCanvas: TMetafileCanvas;
  LRect: TRect;
  LReuseImageIndex: Integer;
  LUniqueImage: Boolean;
begin
  if FEngine = nil then
    Exit;
  LOldUnit := Engine.MeasurementUnit;
  Engine.MeasurementUnit := muPoints;
  if (AGraphic is TMetafile) then
  begin
    LRect := Rect(Round(ARect.Left * CPointsToPixels),
      Round(ARect.Top * CPointsToPixels), Round(ARect.Right * CPointsToPixels),
      Round(ARect.Bottom * CPointsToPixels));
    LMeta := TMetafile.Create;
    LMeta.Width := Abs(LRect.Right - LRect.Left);
    LMeta.Height := Abs(LRect.Bottom - LRect.Top);
    LMetaCanvas := TMetafileCanvas.Create(LMeta, 0);

    LMetaCanvas.StretchDraw(Rect(0, 0, Abs(LRect.Right - LRect.Left),
      Abs(LRect.Bottom - LRect.Top)), AGraphic);
    LMetaCanvas.Free;
    IgtDocumentEngine(Engine).PlayMetafile(ARect.Left, ARect.Top, LMeta);
    LMeta.Free;
  end
  else
  begin
    IgtDocumentEngine(Engine).Pen := Converter.Pen;
    IgtDocumentEngine(Engine).Brush := Converter.Brush;
    IgtDocumentEngine(Engine).ImageSettings.Stretch := True;
    LUniqueImage := True;
    LReuseImageIndex := -1;
    if Assigned(EncodeGraphic) then
      EncodeGraphic(TObject(AGraphic), LUniqueImage, LReuseImageIndex);
    if LUniqueImage then
      IgtDocumentEngine(Engine).DrawImage(gtRect(ARect.Left, ARect.Top,
        ARect.Right, ARect.Bottom), AGraphic)
    else
    begin
      if LReuseImageIndex = -1 then
        LReuseImageIndex := IgtDocumentEngine(Engine)
          .AddImageAsResource(AGraphic);
      IgtDocumentEngine(Engine).DrawImage(gtRect(ARect.Left, ARect.Top,
        ARect.Right, ARect.Bottom), LReuseImageIndex);
      if Assigned(EncodeGraphicDone) then
        EncodeGraphicDone(AGraphic, LReuseImageIndex);
    end;
  end;
  Engine.MeasurementUnit := LOldUnit;
end;

function TgtRaveXport.CalcYDisp(FontSize: Integer; LineHeight: single;
  Superscript: Boolean): Double;
begin
  if Superscript then
  begin
    if FontSize <= 10 then
      Result := (LineHeight / 8) * -1
    else if FontSize <= 40 then
      Result := (LineHeight / 5) * -1
    else
      Result := (LineHeight / 4) * -1
  end
  else
  begin
    if FontSize <= 10 then
      Result := (LineHeight / 2)
    else if FontSize < 30 then
      Result := (LineHeight)
    else
      Result := (LineHeight * 2)
  end
end;

procedure TgtRaveXport.CenterText(const AText: string; const X1, Y1: Double);
var
  LY: Double;
begin
  if FEngine = nil then
    Exit;
  LY := Y1;
  IgtDocumentEngine(Engine).Font := Converter.Font;
{$IFDEF Rave50Up}
  if Converter.FontData.Superscript or Converter.FontData.Subscript then
  begin
    LY := Y1 + CalcYDisp(Converter.Font.Size, Converter.LineHeight,
      Converter.FontData.Superscript);
    IgtDocumentEngine(Engine).Font.Size :=
      Round(Converter.FontData.Size * 0.62);
  end;
{$ELSE}
  if Converter.FontSuperscript or Converter.FontSubscript then
  begin
    LY := Y1 + CalcYDisp(Converter.Font.Size, Converter.FontHeight,
      Converter.FontSuperscript);
    IgtDocumentEngine(Engine).Font.Size := Round(Converter.Font.Size * 0.62);
  end;
{$ENDIF}
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Brush.Style := bsClear;
{$IFDEF Rave50Up}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontData.Rotation);
{$ELSE}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontRotation);
{$ENDIF}
  IgtDocumentEngine(FEngine).TextFormatting.Alignment := haCenter;
  IgtDocumentEngine(FEngine).SetTextAlignment(IgtDocumentEngine(FEngine)
    .TextFormatting.Alignment);
  IgtDocumentEngine(Engine).TextOut((Abs(X1) -
{$IFDEF Rave50Up} Converter.RPTFTextWidth(AText)
{$ELSE} TextSize(AText, Converter.Font).cx / CPixelsPerInch
{$ENDIF} / 2), Abs(LY) - {$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight {$ENDIF}, AText);
end;

procedure TgtRaveXport.LeftText(const AText: string; const X1, Y1: Double);
var
  LY: Double;
begin
  if FEngine = nil then
    Exit;
  LY := Y1;
  IgtDocumentEngine(Engine).Font := Converter.Font;
{$IFDEF Rave50Up}
  if Converter.FontData.Superscript or Converter.FontData.Subscript then
  begin
    LY := Y1 + CalcYDisp(Converter.Font.Size, Converter.LineHeight,
      Converter.FontData.Superscript);
    IgtDocumentEngine(Engine).Font.Size :=
      Round(Converter.FontData.Size * 0.62);
  end;
{$ELSE}
  if Converter.FontSuperscript or Converter.FontSubscript then
  begin
    LY := Y1 + CalcYDisp(Converter.Font.Size, Converter.FontHeight,
      Converter.FontSuperscript);
    IgtDocumentEngine(Engine).Font.Size := Round(Converter.Font.Size * 0.62);
  end;
{$ENDIF}
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Brush.Style := bsClear;
{$IFDEF Rave50Up}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontData.Rotation);
{$ELSE}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontRotation);
{$ENDIF}
  IgtDocumentEngine(FEngine).TextFormatting.Alignment := haLeft;
  IgtDocumentEngine(FEngine).SetTextAlignment(IgtDocumentEngine(FEngine)
    .TextFormatting.Alignment);
  IgtDocumentEngine(Engine).TextOut(X1, LY -
{$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight {$ENDIF}, AText);
end;

procedure TgtRaveXport.RightText(const AText: string; const X1, Y1: Double);
var
  LY: Double;
begin
  if FEngine = nil then
    Exit;
  LY := Y1;
  IgtDocumentEngine(Engine).Font := Converter.Font;
{$IFDEF Rave50Up}
  if Converter.FontData.Superscript or Converter.FontData.Subscript then
  begin
    LY := Y1 + CalcYDisp(Converter.Font.Size, Converter.LineHeight,
      Converter.FontData.Superscript);
    IgtDocumentEngine(Engine).Font.Size :=
      Round(Converter.FontData.Size * 0.62);
  end;
{$ELSE}
  if Converter.FontSuperscript or Converter.FontSubscript then
  begin
    LY := Y1 + CalcYDisp(Converter.Font.Size, Converter.FontHeight,
      Converter.FontSuperscript);
    IgtDocumentEngine(Engine).Font.Size := Round(Converter.Font.Size * 0.62);
  end;
{$ENDIF}
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Brush.Style := bsClear;
{$IFDEF Rave50Up}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontData.Rotation);
{$ELSE}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontRotation);
{$ENDIF}
  IgtDocumentEngine(FEngine).TextFormatting.Alignment := haRight;
  IgtDocumentEngine(FEngine).SetTextAlignment(IgtDocumentEngine(FEngine)
    .TextFormatting.Alignment);

{$IFDEF gtDelphi6}   // Delphi 6
  IgtDocumentEngine(Engine).TextOut(X1 - TextSize(AText, Converter.Font).cx /
    CPixelsPerInch, LY - {$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight {$ENDIF}, AText);
{$ELSE}
    IgtDocumentEngine(Engine).TextOut((X1 - {$IFDEF Rave50Up}
    IgtDocumentEngine(Engine).TextSize(AText, IgtDocumentEngine(Engine).Font).cx
    / CPixelsPerInch
{$ELSE} TextSize(AText, Converter.Font).cx / CPixelsPerInch
{$ENDIF}), LY - {$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight {$ENDIF}, AText);
{$ENDIF}
end;

procedure TgtRaveXport.TextRect(Rect: TRect; X1, Y1: Double; S1: string);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Brush.Style := bsClear;
  IgtDocumentEngine(FEngine).SetTextAlignment(IgtDocumentEngine(FEngine)
    .TextFormatting.Alignment);
  IgtDocumentEngine(Engine).Pen := Converter.Pen;
  IgtDocumentEngine(Engine).Font := Converter.Font;
{$IFDEF Rave50Up}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontData.Rotation);
{$ELSE}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontRotation);
{$ENDIF}
  IgtDocumentEngine(Engine).Rectangle(Rect.TopLeft.X, Rect.TopLeft.Y,
    Rect.BottomRight.X, Rect.BottomRight.Y, (Converter.Brush.Style <> bsClear));
  IgtDocumentEngine(Engine).TextOut(X1, Y1 -
{$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight {$ENDIF}, S1);
end;

procedure TgtRaveXport.PrintSpaces(const AText: string;
  const X1, Y1, AWidth: Double);
var
  LStrings: TStringList;
  I, LTextLength, LTemp, LExtraSpace: Integer;
  LFlag: Boolean;
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Font := Converter.Font;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Brush.Style := bsClear;
{$IFDEF Rave50Up}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontData.Rotation);
{$ELSE}
  IgtDocumentEngine(Engine).SetTextRotation(Converter.FontRotation);
{$ENDIF}
  IgtDocumentEngine(FEngine).SetTextAlignment(IgtDocumentEngine(FEngine)
    .TextFormatting.Alignment);

  // To check whether AText is single word
  LFlag := True;
  LStrings := TStringList.Create;
  LTextLength := Length(AText);

  LTemp := 1;
  I := 1;

  while (I <= LTextLength) and (AText[I] = ' ') do // To remove initial spaces
    Inc(I);

  while I <= LTextLength do // divide into strings and add to String list
  begin
    if LFlag and ((I = LTextLength) or (AText[I] = ' ')) then
    begin
      LStrings.Add(Copy(AText, LTemp, I - LTemp + 1));
      LTemp := I + 1;
    end
    else
      LFlag := True;
    Inc(I);
  end;
  // If AText is contains more then one word then justify the words other wise write the word as it is.
  if LStrings.Count > 1 then
    IgtDocumentEngine(Engine).TextOut(X1, Y1 -
{$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight
{$ENDIF}, GetJustifiedText(AText, Converter.Font, AWidth * CPixelsPerInch))
  else
    IgtDocumentEngine(Engine).TextOut(X1, Y1 -
{$IFDEF Rave50Up} Converter.FontData.Height
{$ELSE} Converter.FontHeight
{$ENDIF}, AText);
  LStrings.Free;
end;

{$IFDEF Rave60Up}

procedure TgtRaveXport.PrintRightWidth(var X1, Y1: Double; Text: string;
  Width: Double);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Font := Converter.Font;
  IgtDocumentEngine(Engine).Brush := Converter.Brush;
  IgtDocumentEngine(Engine).Brush.Style := bsClear;
  AdjustXY(X1, Y1, Width - Converter.RPTFTextWidth(Text));
  AdjustXY(X1, Y1, Converter.RPTFTextWidth(Text));
  RightText(Text, X1, Y1);
end;
{$ENDIF}

constructor TgtRaveXport.Create(AOwner: TComponent);
begin
  inherited;
  FParent := AOwner;
end;

constructor TgtRaveXport.Create(AOwner: TComponent;
  AEngine: TgtCustomDocumentEngine);
begin

end;

{$IFNDEF Rave50Up}

function TgtRaveXport.TextSize(const Text: string; AFont: TFont): TSize;
var
  DC: HDC;
  SaveFont: HFont;
  LSize: TSize;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, AFont.Handle);
  GetTextExtentPoint32A(DC, PChar(Text), Length(Text), LSize);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := LSize;
end;

procedure TgtRaveXport.PrintRender(ANDRStream: TStream;
  AOutputFileName: TFileName);
begin
  if FEngine = nil then
    Exit;
  IgtDocumentEngine(Engine).Page.Width := snPaperWidth;
  IgtDocumentEngine(Engine).Page.Height := snPaperHeight;
  IgtDocumentEngine(Engine).FileName := AOutputFileName;
  with TRPConverter.Create(ANDRStream, Self) do
    try
      Generate;
    finally
      Free;
    end;
end;
{$ENDIF}

procedure TgtRaveXport.MoveTo(const X1, Y1: Double);
begin
  inherited;
  if FEngine = nil then
    Exit;
  Converter.CurrX := X1;
  Converter.CurrY := Y1;
end;

{ TgtRaveExportInterface }

constructor TgtRaveExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  FRaveXport := TgtRaveXport.Create(Self);
end;

destructor TgtRaveExportInterface.Destroy;
begin
  if (FRaveXport <> nil) then
    FRaveXport.Free;
  inherited;
end;

function TgtRaveExportInterface.GetEncodeGraphic: TgtEncodeGraphicEvent;
begin
  Result := FEncodeGraphic;
  EncodeGraphic := FEncodeGraphic;
end;

function TgtRaveExportInterface.GetOnEncodeGraphicDone
  : TgtEncodeGraphicDoneEvent;
begin
  Result := FEncodeGraphicDone;
  EncodeGraphicDone := FEncodeGraphicDone;
end;

procedure TgtRaveExportInterface.SetOnEncodeGraphic
  (const Value: TgtEncodeGraphicEvent);
begin
  FEncodeGraphic := Value;
  EncodeGraphic := Value;
end;

procedure TgtRaveExportInterface.SetOnEncodeGraphicDone
  (const Value: TgtEncodeGraphicDoneEvent);
begin
  FEncodeGraphicDone := Value;
  EncodeGraphicDone := Value;
end;

procedure TgtRaveExportInterface.ExecuteReport(ARPComponent: TRPComponent;
  AFileName: string; AShowPrepareStatus: Boolean);
{$IFDEF Rave50Up}
  procedure SetReportSystemProperties(AReportSystem: TRvSystem);
{$ELSE}
  procedure SetReportSystemProperties(AReportSystem: TReportSystem);
{$ENDIF}
  begin
    with AReportSystem do
    begin
      DefaultDest := rdFile;
      DoNativeOutput := False;
      OutputFileName := AFileName;
      SystemSetups := SystemSetups - [ssAllowSetup];
      if not AShowPrepareStatus then
        SystemOptions := SystemOptions - [soShowStatus];
    end;
{$IFDEF Rave60Up}
    FRaveXport.OnDecodeImage := AReportSystem.OnDecodeImage;
{$ENDIF}
  end;

begin
{$IFDEF Rave50Up}
  if ARPComponent is TRvSystem then
  begin
{$ELSE}
  if ARPComponent is TReportSystem then
  begin
{$ENDIF}
{$IFDEF Rave50Up}
    SetReportSystemProperties(TRvSystem(ARPComponent));
    TRvSystem(ARPComponent).Execute;
{$ELSE}
    SetReportSystemProperties(TReportSystem(ARPComponent));
    TReportSystem(ARPComponent).Execute;
{$ENDIF}
  end
{$IFDEF Rave50Up}
  else if ARPComponent is TRvProject then
    with ARPComponent as TRvProject do
    begin
      if Engine is TRvSystem then
        SetReportSystemProperties(TRvSystem(Engine));
      Execute;
    end;
{$ELSE}
  else if ARPComponent is TRaveProject then
    with ARPComponent as TRaveProject do
    begin
      if Engine is TReportSystem then
        SetReportSystemProperties(TReportSystem(Engine));
      Execute;
    end;
{$ENDIF}
end;

procedure TgtRaveExportInterface.SetEngine(const Value
  : TgtCustomDocumentEngine);
begin
  inherited Engine := Value;
  if Visible then
    FRaveXport.Engine := Value
  else
    FRaveXport.Engine := nil;
end;

procedure TgtRaveExportInterface.SetVisible(const Value: Boolean);
begin
  if Value then
    FRaveXport.Engine := Engine
  else
    FRaveXport.Engine := nil;
  inherited Visible := Value;
end;

function TgtRaveExportInterface.GetUserStream: TStream;
begin
  if (FRaveXport <> nil) then
    Result := FRaveXport.OutputStream
  else
    Result := nil;
end;

procedure TgtRaveExportInterface.SetUserStream(Value: TStream);
begin
  if (FRaveXport <> nil) then
    FRaveXport.OutputStream := Value;
end;

procedure TgtRaveExportInterface.RenderDocument(ANDRStream: TStream);
begin
  if (ANDRStream <> nil) then
{$IFDEF Rave60Up}
  begin
    FRaveXport.OutputFileName := IgtDocumentEngine(Engine).FileName;
    FRaveXport.Render(ANDRStream);
  end;
{$ELSE}
  FRaveXport.OutputFileName := IgtDocumentEngine(Engine).FileName;
  FRaveXport.Render(ANDRStream);
{$ENDIF}
end;

procedure TgtRaveExportInterface.RenderDocument(ANDRFileName: TFileName);
begin
  if (ANDRFileName <> '') then
{$IFDEF Rave60Up}
  begin
    FRaveXport.OutputFileName := IgtDocumentEngine(Engine).FileName;
    FRaveXport.Render(ANDRFileName);
  end;
{$ELSE}
  FRaveXport.OutputFileName := IgtDocumentEngine(Engine).FileName;
  FRaveXport.Render(ANDRFileName);
{$ENDIF}
end;

procedure TgtRaveExportInterface.RenderDocument(ARPComponent: TRPComponent;
  AShowPrepareStatus: Boolean);
begin
  Visible := True;
  FRaveXport.Engine := Engine;

  // Set the RenderObject
{$IFDEF Rave50Up}
  if ARPComponent is TRvSystem then
    TRvSystem(ARPComponent).RenderObject := FRaveXport
  else if ARPComponent is TRvProject then
    with ARPComponent as TRvProject do
      if Engine is TRvSystem then
        TRvSystem(Engine).RenderObject := FRaveXport;
{$ELSE}
  if ARPComponent is TReportSystem then
    TReportSystem(ARPComponent).RenderObject := FRaveXport
  else if ARPComponent is TRaveProject then
    with ARPComponent as TRaveProject do
      if Engine is TReportSystem then
        TReportSystem(Engine).RenderObject := FRaveXport;
{$ENDIF}
  ExecuteReport(ARPComponent, IgtDocumentEngine(Engine).FileName,
    AShowPrepareStatus);
end;

{ Registeration procedure }

procedure Register;
begin
  RegisterComponents('Gnostice Interface', [TgtRaveExportInterface]);
end;

end.
