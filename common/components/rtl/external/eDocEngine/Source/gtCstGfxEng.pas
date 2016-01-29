{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtCstGfxEng;

interface
uses
  Classes, Windows, Dialogs, SysUtils, Graphics, gtDocUtils, gtCstDocEng, gtUtils3;

type

  TgtGfxMetafileItem = class(TgtDocumentItem)
  private
    FX: Double;
    FY: Double;
    FIndexNo: Integer;
  end;

  TgtCustomGraphicsEngine = class(TgtCustomDocumentEngine)
  private
    FMetafileCanvas: TMetafileCanvas;
    FMonochrome: Boolean;
    FPixelFormat: TPixelFormat;
    FScaleY: Double;
    FScaleX: Double;
    procedure GetDefaultBrush(ABrush: TBrush);
    procedure SetCanvasTextRotation(Angle: Integer);
    procedure SetMonochrome(const Value: Boolean);
    procedure SetPixelFormat(const Value: TPixelFormat);
    procedure SetScaleX(const Value: Double);
    procedure SetScaleY(const Value: Double);
  protected
    FMetafile: TMetafile;
    procedure Start; override;
    procedure Finish; override;
    procedure EndPage; override;
    procedure BeginPage; override;

    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeLine(AX1, AY1, AX2, AY2: Double; APen: TPen); override;
    procedure EncodeRect(AX1, AY1, AX2, AY2: Double; APen: TPen;
      ABrush: TBrush); override;
    procedure EncodeRoundRect(AX1, AY1, AX2, AY2, AX3, AY3: Double; APen: TPen;
      ABrush: TBrush); override;
    procedure EncodeEllipse(AX1, AY1, AX2, AY2: Double; APen: TPen;
      ABrush: TBrush); override;
    procedure EncodePolyLine(APoints: TgtPoints; NoPoints: Integer;
      IsClosed: Boolean; APen: TPen; ABrush: TBrush); override;
    procedure EncodeArc(AX1, AY1, AX2, AY2, AX3, AY3, AX4, AY4: Double;
       APen: TPen); override;
    procedure EncodePie(AX1, AY1, AX2, AY2, AX3, AY3, AX4, AY4: Double;
       APen: TPen; ABrush: TBrush); override;
    procedure EncodeChord(AX1, AY1, AX2, AY2, AX3, AY3, AX4, AY4: Double;
       APen: TPen; ABrush: TBrush); override;
    procedure EncodePolyBezier(APoints: TgtPoints; NoPoints: Integer;
      APen: TPen); override;
    procedure EncodeCustomItem(AObject: TgtDocumentItem); override;


    property Monochrome: Boolean read FMonochrome write SetMonochrome
    	default False;
    property PixelFormat: TPixelFormat read FPixelFormat write SetPixelFormat
    	default pf24bit;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure NewPage; override;

    procedure TextOut(X, Y: Double; Text: WideString); override;
    procedure TextRect(Rect: TgtRect; X, Y: Double; Text: WideString); override;
    procedure TextOut(ColumnNo: Integer; Text: WideString); override;
    function TextOut(Text: WideString): Double; override;
    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment); override;
    procedure SetTextRotation(Angle: Integer); override;

    procedure DrawImage(X, Y: Double; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; AGraphic: TGraphic); override;
    procedure DrawImage(ImageRect: TgtRect; Index: Integer); override;
    procedure DrawImage(ColumnNo: Integer; Width, Height: Double;
      AGraphic: TGraphic); override;
    function AddImageAsResource(AGraphic: TGraphic): Integer; override;


    procedure Line(X1, Y1, X2, Y2: Double); override;
    procedure Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure RoundRect(X1, Y1, X2, y2, X3, Y3: Double; IsFill: Boolean);
       override;
    procedure Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean); override;
    procedure Polygon(Points: array of TgtPoint; IsFill: Boolean); override;
    procedure PolyLine(Points: array of TgtPoint); override;

    procedure Arc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double); override;
    procedure Pie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure Chord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); override;
    procedure PolyBezier(Points: array of TgtPoint); override;
    
    procedure BeginPara; override;
    procedure EndPara; override;

    function BeginTable(X, Y: Double; NoColumns: Integer): TList; override;
    function NewRow(Height: Double): Double; override;
    function NewRow: Double; override;
    procedure EndTable; override;

    procedure PlayMetafile(Metafile: TMetafile); override;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile); override;
    procedure PlayMetafile(DestRect: TgtRect; Metafile: TMetafile); override;

    procedure BeginHeader; override;
    procedure EndHeader; override;
    procedure ClearHeader; override;

    procedure BeginFooter; override;
    procedure EndFooter; override;
    procedure ClearFooter; override;

    procedure BeginWaterMark; override;
    procedure EndWaterMark; override;
    procedure ClearWaterMark; override;

    procedure BeginStamp; override;
    procedure EndStamp; override;
    procedure ClearStamp; override;

    function SaveEngineState: Integer; override;
    procedure RestoreEngineState(Index: Integer); override;
    procedure ClearEngineStates; override;

    procedure SetWorkingPage(PageNo: Integer); override;

    property TextFormatting;
    property TableSettings;
    property Frame;

  published
    property FileName;
    property Font;
    property Pen;
    property Brush;
    property ImageSettings;
    property Page;
    property PageBorder;
    property Preferences;

    property BackgroundColor;
    property BackgroundImage;
    property BackgroundImageDisplayType;
    property ScaleX: Double read FScaleX write SetScaleX;
    property ScaleY: Double read FScaleY write SetScaleY;
    property OnCellDraw;
    property OnNeedFileName;
  end;


implementation

{ TgtCustomGraphicsEngine }

procedure TgtCustomGraphicsEngine.Arc(X1, Y1, X2, y2, X3, Y3, X4,
  Y4: Double);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.BeginDoc;
begin
  inherited;
end;

procedure TgtCustomGraphicsEngine.BeginFooter;
begin
  inherited;
end;

procedure TgtCustomGraphicsEngine.BeginHeader;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.BeginPara;
begin
  inherited ;
end;

function TgtCustomGraphicsEngine.BeginTable(X, Y: Double;
  NoColumns: Integer): TList;
begin
  Result := inherited BeginTable(X, Y, NoColumns);
end;

procedure TgtCustomGraphicsEngine.BeginWaterMark;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.BeginStamp;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.Chord(X1, Y1, X2, y2, X3, Y3, X4,
  Y4: Double; IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.ClearEngineStates;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.DrawImage(ImageRect: TgtRect;
  AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.DrawImage(X, Y: Double;
  AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.DrawImage(ImageRect: TgtRect;
  Index: Integer);
begin
  inherited;

end;

constructor TgtCustomGraphicsEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScaleY := 1.0;
  FScaleX := 1.0;
end;

destructor TgtCustomGraphicsEngine.Destroy;
begin
  inherited;
end;

procedure TgtCustomGraphicsEngine.DrawImage(ColumnNo: Integer; Width,
  Height: Double; AGraphic: TGraphic);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.Ellipse(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.EncodeArc(AX1, AY1, AX2, AY2, AX3, AY3,
  AX4, AY4: Double; APen: TPen);
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    Arc(Round(AX1), Round(AY1), Round(AX2), Round(AY2), Round(AX3), Round(AY3),
     Round(AX4), Round(AY4));
  end;
end;

procedure TgtCustomGraphicsEngine.EncodeChord(AX1, AY1, AX2, AY2, AX3, AY3,
  AX4, AY4: Double; APen: TPen; ABrush: TBrush);
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    if ABrush <> nil then
      Brush.Assign(ABrush);
    Chord(Round(AX1), Round(AY1), Round(AX2), Round(AY2), Round(AX3), Round(AY3),
     Round(AX4), Round(AY4));
    if ABrush <> nil then
      GetDefaultBrush(Brush);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodeEllipse(AX1, AY1, AX2, AY2: Double;
  APen: TPen; ABrush: TBrush);
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    if ABrush <> nil then
      Brush.Assign(ABrush);
    Ellipse(Round(AX1), Round(AY1), Round(AX2), Round(AY2));
    if ABrush <> nil then
      GetDefaultBrush(Brush);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodeImage(AObject: TgtImageItem);
var
  LBitmap1, LBitmap2: TBitmap;
  LX, LY: Double;
  LHeight, LWidth, LOffsetX, LOffsetY: Integer;
begin
  inherited;
  with AObject do
  begin
    LBitmap2 := GetImageAsBitmap(AObject);

    if Settings.IsFrame then
    begin
      LX := X; LY := Y;
      LOffsetX := 0; LOffsetY := 0;
      LHeight := LBitmap2.Height;
      LWidth := LBitmap2.Width;
      LBitmap1 := TBitmap.Create;

      if Frame.IsLeft then
      begin
        LOffsetX := Pen.Width;
        LWidth := LWidth + Pen.Width;
      end;
      if Frame.IsTop then
      begin
        LOffsetY := Pen.Width;
        LHeight := LHeight + Pen.Width;
      end;
      if Frame.IsRight then
        LWidth := LWidth + Pen.Width;
      if Frame.IsBottom then
        LHeight := LHeight + Pen.Width;

      LBitmap1.Width := LWidth;
      LBitmap1.Height := LHeight;
      LBitmap1.Canvas.Pen.Assign(Pen);
      if Frame.IsLeft then
      begin
        LBitmap1.Canvas.MoveTo(Pen.Width div 2, Pen.Width div 2);
        LBitmap1.Canvas.LineTo(Pen.Width div 2, LHeight);
      end;

      if Frame.IsTop then
      begin
        LBitmap1.Canvas.MoveTo(Pen.Width div 2, Pen.Width div 2);
        LBitmap1.Canvas.LineTo(LWidth, Pen.Width div 2);
      end;

      if Frame.IsRight then
      begin
        LBitmap1.Canvas.MoveTo(LWidth - Pen.Width div 2, Pen.Width div 2);
        LBitmap1.Canvas.LineTo(LWidth - Pen.Width div 2, LHeight);
      end;

      if Frame.IsBottom then
      begin
        LBitmap1.Canvas.MoveTo(Pen.Width div 2, LHeight - Pen.Width div 2);
        LBitmap1.Canvas.LineTo(LWidth, LHeight - Pen.Width div 2);
      end;
      LBitmap1.Canvas.Draw(LOffsetX, LOffsetY, LBitmap2);
      LBitmap2.Free;
      LBitmap2 := LBitmap1;
      LX := LX - LOffsetX;
      LY := LY - LOffsetY;
    end;

    if (Settings.Inclination mod 360 <> 0) then
    begin
      LBitmap1 := GetRotatedBitmap(LBitmap2, LX, LY, Settings.Inclination,
        BackgroundColor);
      FMetafileCanvas.Draw(Round(LX), Round(LY), LBitmap1);
      LBitmap1.Free;
    end
    else
      FMetafileCanvas.Draw(Round(X), Round(Y), LBitmap2);
  end;
  LBitmap2.Free;
end;

procedure TgtCustomGraphicsEngine.EncodeLine(AX1, AY1, AX2, AY2: Double;
  APen: TPen);
begin
  inherited;
  with FMetafileCanvas do
  begin
    FMetafileCanvas.Pen.Assign(APen);
    MoveTo(Round(AX1), Round(AY1));
    LineTo(Round(AX2), Round(AY2));
  end;
end;

procedure TgtCustomGraphicsEngine.EncodePie(AX1, AY1, AX2, AY2, AX3, AY3,
  AX4, AY4: Double; APen: TPen; ABrush: TBrush);
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    if ABrush <> nil then
      Brush.Assign(ABrush);
    Pie(Round(AX1), Round(AY1), Round(AX2), Round(AY2), Round(AX3), Round(AY3),
     Round(AX4), Round(AY4));
    if ABrush <> nil then
      GetDefaultBrush(Brush);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodePolyBezier(APoints: TgtPoints;
   NoPoints: Integer; APen: TPen);
var
  TempArray: array of TPoint;
  I: Integer;
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    SetLength(TempArray, NoPoints);
    for I := 0 to NoPoints - 1 do
    begin
      TempArray[I].X := Round(APoints[I].X);
      TempArray[I].Y := Round(APoints[I].Y);
    end;
    PolyBezier(TempArray);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodePolyLine(APoints: TgtPoints;
   NoPoints: Integer; IsClosed: Boolean; APen: TPen; ABrush: TBrush);
var
  TempArray: array of TPoint;
  I: Integer;
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    if ABrush <> nil then
      Brush.Assign(ABrush);

    SetLength(TempArray, NoPoints);
    for I := 0 to NoPoints - 1 do
    begin
      TempArray[I].X := Round(APoints[I].X);
      TempArray[I].Y := Round(APoints[I].Y);
    end;
    if IsClosed then
      Polygon(TempArray)
    else
      Polyline(TempArray);

    if ABrush <> nil then
      GetDefaultBrush(Brush);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodeRect(AX1, AY1, AX2, AY2: Double;
  APen: TPen; ABrush: TBrush);
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    if ABrush <> nil then
      Brush.Assign(ABrush);
    Rectangle(Round(AX1), Round(AY1), Round(AX2), Round(AY2));
    if ABrush <> nil then
      GetDefaultBrush(Brush);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodeRoundRect(AX1, AY1, AX2, AY2, AX3,
  AY3: Double; APen: TPen; ABrush: TBrush);
begin
  inherited;
  with FMetafileCanvas do
  begin
    Pen.Assign(APen);
    if ABrush <> nil then
      Brush.Assign(ABrush);
    RoundRect(Round(AX1), Round(AY1), Round(AX2), Round(AY2),
      Round(AX3), Round(AY3));
    if ABrush <> nil then
      GetDefaultBrush(Brush);
  end;
end;

procedure TgtCustomGraphicsEngine.EncodeText(AObject: TgtTextItem);
var
  LSize: TSize;
  LPen: TPen;
  LS: WideString;
  LRect: TRect;
begin
  with FMetafileCanvas do
  begin
    LS := ReplacePlaceHolders(AObject.Lines[0], True);
    Font.Assign(AObject.Font);
    if (AObject.Brush.Style in [bsSolid, bsClear]) or
      (AObject.RotationAngle <> 0) then
    begin
      if  Abs(ColorToRGB(AObject.Brush.Color)) <> Abs(ColorToRGB(clWindow)) then
      begin
        SetBkMode(Handle, OPAQUE);
        SetBkColor(Handle, AObject.Brush.Color);
      end
      else
        SetBkMode(Handle, TRANSPARENT);
    end
    else
    with AObject do            
    begin
      LSize := TextSize(LS, Font);
      LPen := TPen.Create;
      LPen.Style := psClear;
      EncodeRect(X, Y, X + LSize.cx, Y + LSize.cy, LPen, Brush);
      LPen.Free;
      SetBkMode(Handle, TRANSPARENT);
    end;
    Brush.Assign(AObject.Brush); 
    if AObject.IsClipRect then
    begin
      LRect := Rect(Round(AObject.ClipRect.Left), Round(AObject.ClipRect.Top),
        Round(AObject.ClipRect.Right), Round(AObject.ClipRect.Bottom));
      ExtTextOutW(Handle, Round(AObject.X), Round(AObject.Y), ETO_CLIPPED,
        @LRect, PWideChar(LS), Length(LS), nil);
    end
    else
    begin
      SetCanvasTextRotation(AObject.RotationAngle);
      TextOutW(Handle, Round(AObject.X), Round(AObject.Y), PWideChar(LS), Length(LS));
    end;
  end;
end;

procedure TgtCustomGraphicsEngine.EndDoc;
begin
  inherited;
end;

procedure TgtCustomGraphicsEngine.EndFooter;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.EndHeader;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.EndPage;
begin
  FreeAndNil(FMetafileCanvas);
  inherited;
end;

procedure TgtCustomGraphicsEngine.EndPara;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.EndTable;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.EndWaterMark;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.EndStamp;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.Line(X1, Y1, X2, Y2: Double);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.NewPage;
begin
  inherited;
end;

function TgtCustomGraphicsEngine.NewRow: Double;
begin
  Result := inherited NewRow;
end;

function TgtCustomGraphicsEngine.NewRow(Height: Double): Double;
begin
  Result := inherited NewRow(Height);
end;

procedure TgtCustomGraphicsEngine.Pie(X1, Y1, X2, y2, X3, Y3, X4,
  Y4: Double; IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.PolyBezier(Points: array of TgtPoint);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.Polygon(Points: array of TgtPoint;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.PolyLine(Points: array of TgtPoint);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.Rectangle(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.RestoreEngineState(Index: Integer);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.RoundRect(X1, Y1, X2, y2, X3, Y3: Double;
  IsFill: Boolean);
begin
  inherited;

end;

function TgtCustomGraphicsEngine.SaveEngineState: Integer;
begin
  Result := inherited SaveEngineState;
end;

procedure TgtCustomGraphicsEngine.GetDefaultBrush(ABrush: TBrush);
begin
  ABrush.Color := clWhite;
  ABrush.Bitmap := nil;
  ABrush.Style := bsSolid;
end;

procedure TgtCustomGraphicsEngine.SetCanvasTextRotation(Angle: Integer);
var
	AFontLogRec: TLogFont;
begin
  With FMetafileCanvas do
  begin
    GetObject(Font.Handle, SizeOf(AFontLogRec), Addr(AFontLogRec));
    AFontLogRec.lfEscapement := (Angle * 10);
    AFontLogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;
    Font.Handle := CreateFontIndirect(AFontLogRec);
  end;
end;

procedure TgtCustomGraphicsEngine.SetTextRotation(Angle: Integer);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.SetWorkingPage(PageNo: Integer);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.TextBox(TextRect: TgtRect; Text: WideString;
  HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
begin
  inherited;

end;

function TgtCustomGraphicsEngine.TextOut(Text: WideString): Double;
begin
  Result := inherited TextOut(Text);
end;

procedure TgtCustomGraphicsEngine.TextOut(X, Y: Double; Text: WideString);
begin
  inherited TextOut(X, Y, Text);
end;

procedure TgtCustomGraphicsEngine.TextOut(ColumnNo: Integer; Text: WideString);
begin
  inherited;

end;


procedure TgtCustomGraphicsEngine.SetMonochrome(const Value: Boolean);
begin
  FMonochrome := Value;
end;

procedure TgtCustomGraphicsEngine.SetPixelFormat(
  const Value: TPixelFormat);
begin
  FPixelFormat := Value;
end;

function TgtCustomGraphicsEngine.AddImageAsResource(
  AGraphic: TGraphic): Integer;
begin
  Result := inherited AddImageAsResource(AGraphic);
end;

procedure TgtCustomGraphicsEngine.BeginPage;
var
  LX, LY, LWidth, LHeight : Integer;

	procedure CalcBackgroundImagePos(var ALeft, ATop: Integer; AGraphic: TGraphic);
	begin
		ALeft := 0;
		ATop := 0;
		if BackgroundImageDisplayType in [dtTopCenter, dtCenter,
				dtBottomCenter] then
			ALeft := (LWidth - AGraphic.Width) div 2
		else if BackgroundImageDisplayType in [dtTopRight, dtCenterRight,
				dtBottomRight] then
			ALeft := LWidth - AGraphic.Width;
		if BackgroundImageDisplayType in [dtCenterLeft, dtCenter,
			dtCenterRight] then
			ATop := (LHeight - AGraphic.Height) div 2
		else if BackgroundImageDisplayType in [dtBottomLeft, dtBottomCenter,
				dtBottomRight] then
			ATop := LHeight - AGraphic.Height;
	end;

begin
  inherited;

  LWidth := Round(Pages[CurrentPage - 1].Settings.Width);
  LHeight := Round(Pages[CurrentPage - 1].Settings.Height);
  FMetafile.Width := LWidth;
  FMetafile.Height := LHeight;

  FMetafileCanvas := TMetafileCanvas.Create(FMetafile, 0);

	FMetafileCanvas.Brush.Color := BackgroundColor;
	FMetafileCanvas.Brush.Style := bsSolid;
	FMetafileCanvas.FillRect(Rect(0, 0, LWidth, LHeight));

	if BackgroundImage.Graphic <> nil then
    if BackgroundImageDisplayType = dtTile then
    begin
      LY := 0;
      while LY < LHeight do
      begin
        LX := 0;
        while LX < LWidth do
        begin
          FMetafileCanvas.Draw(LX, LY, BackgroundImage.Graphic);
          LX := LX + BackgroundImage.Graphic.Width;
        end;
        LY := LY + BackgroundImage.Graphic.Height;
      end;
    end
    else
    begin
      CalcBackgroundImagePos(LX, LY, BackgroundImage.Graphic);
      FMetaFileCanvas.Draw(LX, LY, BackgroundImage.Graphic);
    end;
end;

procedure TgtCustomGraphicsEngine.SetScaleX(const Value: Double);
begin
  FScaleX := Value;
end;

procedure TgtCustomGraphicsEngine.SetScaleY(const Value: Double);
begin
  FScaleY := Value;
end;

procedure TgtCustomGraphicsEngine.Finish;
begin
  inherited;
  FMetafile.Free;
end;

procedure TgtCustomGraphicsEngine.Start;
begin
  inherited;
  FMetafile := TMetafile.Create;
  FMetafile.Enhanced := True;
end;

procedure TgtCustomGraphicsEngine.EncodeCustomItem(
  AObject: TgtDocumentItem);
begin
  inherited;
  if AObject is TgtGfxMetafileItem then
  with AObject as TgtGfxMetafileItem do
  begin
    FMetafileCanvas.Draw(Round(FX), Round(FY), GetGraphicResource(FIndexNo));
  end;
end;

procedure TgtCustomGraphicsEngine.PlayMetafile(Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.PlayMetafile(X, Y: Double;
  Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.TextRect(Rect: TgtRect; X, Y: Double;
  Text: WideString);
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.ClearFooter;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.ClearHeader;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.ClearStamp;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.ClearWaterMark;
begin
  inherited;

end;

procedure TgtCustomGraphicsEngine.PlayMetafile(DestRect: TgtRect;
  Metafile: TMetafile);
begin
  inherited;

end;

end.
