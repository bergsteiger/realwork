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

{$I ..\gtDefines.inc}
{$I ..\gtDocDefines.inc}
{$I ..\gtExpIntf.inc}
// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- AceReporter Version Support ---
// Below Version 1.70 DISABLE Ace170up, Ace171up
// Version 1.70 & above, but below v1.71 ENABLE Ace170up, DISABLE Ace171up
// Version 1.71 & above ENABLE Ace171up and Ace170up

//{$DEFINE Ace170up}
//{$DEFINE Ace171up}

unit gtAceXportIntf;

interface
uses
  Windows, Classes, Graphics, SysUtils, Dialogs, Forms, AceFile, AceXport,
  AceTypes, AceUtil, AceImg, AceCtrl, AceSetup, SctRep, PSetup, gtCstDocEng,
  gtXportIntf, Printers, ComCtrls, RichEdit, Math, gtConsts3, gtUtils3,
  gtDocUtils ;

type
  TgtAceXport = class;

  TgtAceExportInterface = class(TgtExportInterface)
  private
    FAceXport: TgtAceXport;

    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AceFile: string); overload;
    procedure RenderDocument(AceReport: TSctReport); overload;

  published
    property Engine write SetEngine;
    property Visible write SetVisible;

  end;

  TgtAceXport = class(TAceExportFilter)
  private
    FParent: TObject;
    FEngine: TgtCustomDocumentEngine;
    FHandle: HDC;
    FAceFile: TAceAceFile;
    FCurrentX,FCurrentY: Integer;
    ARotation: Integer;
    FVAlignment: TgtVAlignment;
    CurPosUpdate: Boolean;
		procedure ExportDocument(ACurrentPage: Integer);
    function GetShadeRectMetafile(ARect: TRect;
	    Shade: TAceShadePercent): TMetafile;
    function Get3of9BarcodeBitmap(
	    ALeft, ATop, AWidth, AHeight, ANarrowWidth, AWideWidth: Integer;
	    AInches, AVertical: Boolean; ABarData: string): TBitmap;
    function Get2of5BarcodeBitmap(
	    ALeft, ATop, AWidth, AHeight, ANarrowWidth, AWideWidth: Integer;
	    AInches, AVertical: Boolean; ABarData: string): TBitmap;
    function GetRichTextAsMetafile(ARect: TRect;
	    AStream: TStream; AStartPos, AEndPos: LongInt): TMetaFile;
    function GetBitmapFromAceStream(AAceStream: TStream): TBitmap;
    function GetCheckBoxMetafile(ARect: TRect;
    	CheckStyle: TAceCheckStyle; Color: TColor; Thickness: Integer): TMetafile;
    function PixelsToTwips(X: Extended): Extended;
  public
    constructor Create(AParent: TgtExportInterface); reintroduce;

    procedure GenerateToFile(AceFileStream: TStream; FileName: string;
     CurrentPage: Integer); override;
    procedure GenerateToStream(AceFileStream: TStream; UserStream: TStream;
     CurrentPage: Integer); override;

    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure BeginPage; override;
    procedure EndPage; override;

    procedure SetFont(Font: TFont); override;
    procedure SetLogFont(Font: TFont; LogFont: TAceLogFont); override;
    procedure SetPen(Pen: TPen); override;
    procedure SetBrush(Brush: TBrush); override;
    procedure SetTextAlign(Flags: Word); override;
    procedure Textout(X, Y: Integer; const Text: string); override;
    procedure MoveTo(X, Y: Integer); override;
    procedure LineTo(X, Y: Integer); override;
    procedure PTextout(X, Y: Integer; Text: PChar;
     Count: LongInt); override;
    procedure ExtTextout(X, Y: Integer; Options: Word; Rect: TRect;
     Text: PChar; Count: Word); override;
    procedure TextRect(Rect: TRect; X, Y: Integer; const Text: string); override;
    procedure FillRect(Rect: TRect); override;
    procedure Rectangle(X1, Y1, X2, Y2: Integer); override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
    procedure StretchDraw(Rect: TRect; Graphic: TGraphic); override;
    procedure DrawBitmap(X, Y: Integer; Stream: TStream); override;
    procedure StretchDrawBitmap(Rect: TRect;
     Stream: TStream); override;
    procedure ShadeRect(Rect: TRect;
     Shade: TAceShadePercent); override;
    procedure SetBkColor(bkColor: LongInt); override;
    procedure TextJustify(Rect: TRect; X, Y: Integer; const Text: string;
     EndParagraph: Boolean; FullRect: TRect); override;
    procedure RtfDraw(Rect: TRect; Stream: TStream; StartPos, EndPos: LongInt;
     SetDefFont: Boolean); override;
    procedure DrawCheckBox(Rect: TRect; CheckStyle: TAceCheckStyle;
     Color: TColor; Thickness: Integer); override;
    procedure DrawShapeType(dt: TAceDrawType;
     X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure PolyDrawType(pt: TAcePolyType;
     const Points: array of TPoint; Count: Integer); override;
    procedure Print3of9Barcode(
     Left, Top, Width, Height, NarrowWidth, WideWidth: Integer;
     Inches, Vertical: Boolean; BarData: String); override;
    procedure Print2of5Barcode(
     Left, Top, Width, Height, NarrowWidth, WideWidth: Integer;
     Inches, Vertical: Boolean; BarData: String); override;
  end;


implementation

{ TgtAceExportInterface }

procedure TgtAceExportInterface.SetEngine(
  const Value: TgtCustomDocumentEngine);
begin
  inherited Engine := Value;
  FAceXport.Active := False;
  FAceXport.FEngine := Value;
  FAceXport.FileExtension := '*.' + IgtDocumentEngine(Engine).FileExtension;
  FAceXport.DisplayName := IgtDocumentEngine(Engine).FileDescription + ' (' +
    FAceXport.FileExtension + ')';
  FAceXport.Active := Visible;
end;

procedure TgtAceExportInterface.SetVisible(const Value: Boolean);
begin
  FAceXport.Active := Value;
  inherited Visible := Value;
end;

constructor TgtAceExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  FAceXport := TgtAceXport.Create(nil);
end;

destructor TgtAceExportInterface.Destroy;
begin
  FAceXport.Active := False;
  FreeAndNil(FAceXport);
  inherited;
end;

procedure TgtAceExportInterface.RenderDocument(AceFile: string);
var
  gtAceFilter: TgtAceXport;
  AceStream: TMemoryStream;
begin
  gtAceFilter := TgtAceXport.Create(Self);
  AceStream := TMemoryStream.Create;
  try
    AceStream.LoadFromFile(AceFile);
    gtAceFilter.FEngine := Engine;
    gtAceFilter.GenerateToFile(AceStream, IgtDocumentEngine(Engine).FileName, 0);
  finally
    FreeAndNil(gtAceFilter);
    FreeAndNil(AceStream);
  end;
end;

procedure TgtAceExportInterface.RenderDocument(AceReport: TSctReport);
var
  gtAceFilter: TgtAceXport;
  AceStream: TMemoryStream;
begin
  gtAceFilter := TgtAceXport.Create(Self);
  AceStream := TMemoryStream.Create;
  try
		AceReport.Prompt := False;
		AceReport.Page.PageSetup.Destination := destFile;
		AceReport.Page.AceFileName := AceGetTempFile('gtAce');
		AceReport.Run;
		AceStream.LoadFromFile(AceReport.Page.AceFileName);
    gtAceFilter.FEngine := Engine;
    gtAceFilter.GenerateToFile(AceStream, IgtDocumentEngine(Engine).FileName, 0);
  finally
    FreeAndNil(gtAceFilter);
    FreeAndNil(AceStream);
  end;
end;

{ TgtAceXport }

procedure TgtAceXport.BeginDoc;
begin
end;

procedure TgtAceXport.BeginPage;
begin
end;

constructor TgtAceXport.Create(AParent: TgtExportInterface);
begin
  inherited Create(nil);
  FParent := AParent;
end;

procedure TgtAceXport.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  if Graphic is TMetafile then
    IgtDocumentEngine(FEngine).PlayMetafile(X, Y, TMetafile(Graphic))
  else
    IgtDocumentEngine(FEngine).DrawImage(X, Y, Graphic);
end;

procedure TgtAceXport.DrawBitmap(X, Y: Integer; Stream: TStream);
var
  Bmp: TBitmap;
begin
  Bmp := GetBitmapFromAceStream(Stream);
  try
    IgtDocumentEngine(FEngine).DrawImage(X, Y, Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TgtAceXport.DrawCheckBox(Rect: TRect; CheckStyle: TAceCheckStyle;
  Color: TColor; Thickness: Integer);
var
	LMeta: TMetafile;
begin
  LMeta := GetCheckBoxMetafile(Rect, CheckStyle, Color, Thickness);
  try
    IgtDocumentEngine(FEngine).PlayMetafile(Rect.Left, Rect.Top, LMeta);
  finally
		LMeta.Free;
  end;
end;

procedure TgtAceXport.DrawShapeType(dt: TAceDrawType; X1, Y1, X2, Y2, X3,
  Y3, X4, Y4: Integer);
begin
  with IgtDocumentEngine(FEngine) do
  begin
    case dt of
      dtArc:
        Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
      dtChord:
        Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4, Brush.Style <> bsClear);
      dtPie:
        Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4, Brush.Style <> bsClear);
    end;
  end;
end;

procedure TgtAceXport.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  IgtDocumentEngine(FEngine).Ellipse(X1, Y1, X2, Y2,
    IgtDocumentEngine(FEngine).Brush.Style <> bsClear);
end;

procedure TgtAceXport.EndDoc;
begin
end;

procedure TgtAceXport.EndPage;
begin
end;

procedure TgtAceXport.ExportDocument(ACurrentPage: Integer);
  procedure SetDocumentPageInfo(APageNo: Integer);
  var
    LW, LH: Double;
    LUnits: TgtUnitType;
	begin
    TAceAceFile(FAceFile).IgnorePrinterSettings := True;
    with IgtDocumentEngine(FEngine).Page do
		begin
    	LUnits := FEngine.MeasurementUnit;
      PaperSize := Custom;
      FAceFile.GetPagePrinterInfo(FAceFile.AcePrinterSetup, APageNo);

      {$IFDEF Ace171up}
      FAceFile.AcePrinterSetup.SetDataReset;
      {$ELSE}
        {$IFDEF Ace170up}
        FAceFile.AcePrinterSetup.SetData(True);
        {$ELSE}
        FAceFile.AcePrinterSetup.SetData;
        {$ENDIF}
      {$ENDIF}

      FEngine.MeasurementUnit := muInches;
      if (DMORIENT_LANDSCAPE = FAceFile.AcePrinterSetup.Orientation) then
        Orientation := Printers.poLandscape
      else
        Orientation := Printers.poPortrait;

      if (FAceFile.AcePrinterSetup.PaperSize in
        [DMPAPER_LETTER..DMPAPER_PENV_10_ROTATED]) then
      begin
				AcePaperSizeInch(FAceFile.AcePrinterSetup.Orientation,
        	FAceFile.AcePrinterSetup.PaperSize, LW, LH);
				Width := LW;
				Height := LH;
      end
      else
      begin
        FEngine.MeasurementUnit := muPixels;
				Width := FAceFile.PageWidth;
				Height := FAceFile.PageHeight;
      end;
      FEngine.MeasurementUnit := LUnits;
    end;
  end;

var
	I: Integer;
begin
	try
    IgtDocumentEngine(FEngine).Page.PaperSize := Custom;
    for I := 1 to FAceFile.Pages.Count do
    begin
      FAceFile.Exporting := True;
      FAceFile.ExportFilter := Self;
      IsGraphicExport := False;
      FHandle := GetDC(0);
      SetDocumentPageInfo(I);
      if  I <> 1 then
        IgtDocumentEngine(FEngine).NewPage
      else
      begin
        if FParent is TgtAceExportInterface then
          TgtAceExportInterface(FParent).StartDocument
        else
          IgtDocumentEngine(FEngine).BeginDoc;
      end;
      try
        FAceFile.PlayPage(FHandle, I);
      finally
        ReleaseDC(0, FHandle);
      end;
    end;
    if FParent is TgtAceExportInterface then
      TgtAceExportInterface(FParent).EndDocument
    else
      IgtDocumentEngine(FEngine).EndDoc;
	finally
    FreeAndNil(FAceFile);
	end;
end;

procedure TgtAceXport.ExtTextout(X, Y: Integer; Options: Word; Rect: TRect;
  Text: PChar; Count: Word);
begin
  TextRect(Rect, X, Y, Text);
end;

procedure TgtAceXport.FillRect(Rect: TRect);
var
  TmpPenStyle: TPenStyle;
begin
  with IgtDocumentEngine(FEngine) do
  begin
    TmpPenStyle := Pen.Style;
//    if (Abs(Rect.Left - Rect.Right) = 1) then
//      Line(Rect.Right, Rect.Top, Rect.Right, Rect.Bottom)
//    else if (Abs(Rect.Top - Rect.Bottom) = 1) then
//      Line(Rect.Left, Rect.Top, Rect.Right, Rect.Top)
//    else
//    begin
      Pen.Style := psClear;
      Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom,
        Brush.Style <> bsClear);
//    end;
    Pen.Style := TmpPenStyle;
  end;
end;

procedure TgtAceXport.GenerateToFile(AceFileStream: TStream;
  FileName: string; CurrentPage: Integer);
var
  LUnits: TgtUnitType;
begin
  FAceFile := TAceAceFile.Create;
  AceFileStream.Position := 0;
  FAceFile.LoadFromStream(AceFileStream);
  LUnits := FEngine.MeasurementUnit;
  FEngine.MeasurementUnit := muPixels;
  IgtDocumentEngine(FEngine).FileName := FileName;
  ExportDocument(1);
  FEngine.MeasurementUnit := LUnits;
end;

procedure TgtAceXport.GenerateToStream(AceFileStream, UserStream: TStream;
  CurrentPage: Integer);
begin
end;



procedure TgtAceXport.LineTo(X, Y: Integer);
begin
  IgtDocumentEngine(FEngine).Line(FCurrentX, FCurrentY, X, Y);
end;

procedure TgtAceXport.MoveTo(X, Y: Integer);
begin
  FCurrentX := X;
  FCurrentY := Y;
end;

procedure TgtAceXport.PolyDrawType(pt: TAcePolyType;
  const Points: array of TPoint; Count: Integer);
var
  APts: TgtPoints;
  LI: Integer;
begin
  SetLength(APts, Count);
  for LI := 0 to Count - 1 do
    APts[LI] := gtPoint(Points[LI].X, Points[LI].Y);
  with IgtDocumentEngine(FEngine) do
  begin
    if pt = ptPolygon then
      Polygon(APts, Brush.Style <> bsClear)
    else
      Polyline(APts);
  end;
end;

procedure TgtAceXport.Print2of5Barcode(Left, Top, Width, Height,
  NarrowWidth, WideWidth: Integer; Inches, Vertical: Boolean;
  BarData: String);
var
  Bmp: TBitmap;
begin
  Bmp := Get2of5BarcodeBitmap(Left, Top, Width, Height,
    NarrowWidth, WideWidth, Inches, Vertical, BarData);
  try
    IgtDocumentEngine(FEngine).DrawImage(Left, Top, Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TgtAceXport.Print3of9Barcode(Left, Top, Width, Height,
  NarrowWidth, WideWidth: Integer; Inches, Vertical: Boolean;
  BarData: String);
var
  Bmp: TBitmap;
begin
  Bmp := Get3of9BarcodeBitmap(Left, Top, Width, Height,
    NarrowWidth, WideWidth, Inches, Vertical, BarData);
  try
    IgtDocumentEngine(FEngine).DrawImage(Left, Top, Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TgtAceXport.PTextout(X, Y: Integer; Text: PChar; Count: Integer);
begin
  TextOut(X, Y, Text);
end;

procedure TgtAceXport.Rectangle(X1, Y1, X2, Y2: Integer);
begin
  with IgtDocumentEngine(FEngine) do
  begin
    if (Abs(X1 - X2) = 1) then
      Line(X2, Y1, X2,Y2)
    else if (Abs(Y1 - Y2) = 1) then
      Line(X1,Y1,X2,Y1)
    else
      Rectangle(X1, Y1, X2, Y2, Brush.Style <> bsClear);
  end;
end;

procedure TgtAceXport.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  IgtDocumentEngine(FEngine).RoundRect(X1, Y1, X2, Y2, X3, Y3,
    IgtDocumentEngine(FEngine).Brush.Style <> bsClear);
end;

procedure TgtAceXport.RtfDraw(Rect: TRect; Stream: TStream; StartPos,
  EndPos: Integer; SetDefFont: Boolean);
var
  AMetafile: TMetafile;
begin
  AMetafile := GetRichTextAsMetafile(Rect, Stream, StartPos, EndPos);
  try
    IgtDocumentEngine(FEngine).PlayMetafile(Rect.Left, Rect.Top, AMetafile);
  finally
    AMetafile.Free;
  end;
end;

procedure TgtAceXport.SetBkColor(bkColor: Integer);
begin
  IgtDocumentEngine(FEngine).Brush.Color := bkColor;
end;

procedure TgtAceXport.SetBrush(Brush: TBrush);
begin
  if Brush <> nil then
    IgtDocumentEngine(FEngine).Brush.Assign(Brush)
  else
    IgtDocumentEngine(FEngine).Brush.Style := bsClear;
end;

procedure TgtAceXport.SetFont(Font: TFont);
begin
  if Font <> nil then
    IgtDocumentEngine(FEngine).Font.Assign(Font);
end;

procedure TgtAceXport.SetLogFont(Font: TFont; LogFont: TAceLogFont);
var
	AFontStyle: TFontStyles;
begin
	if Font <> nil then
		IgtDocumentEngine(FEngine).Font.Assign(Font);
	AFontStyle := [];
	if LogFont.Weight > FW_NORMAL then
		Include(AFontStyle, fsBold);
	if LogFont.Italic <> 0 then
		Include(AFontStyle, fsItalic);
	if LogFont.UnderLine <> 0 then
		Include(AFontStyle, fsUnderline);
	if LogFont.StrikeOut <> 0 then
		Include(AFontStyle, fsStrikeout);
	IgtDocumentEngine(FEngine).Font.Style := AFontStyle;
	// Font rotation is obtained in tenths of a degree.
  ARotation := (LogFont.Escapement div 10) mod 360;
  IgtDocumentEngine(FEngine).SetTextRotation(ARotation);
end;

procedure TgtAceXport.SetPen(Pen: TPen);
begin
  if Pen <> nil then
    IgtDocumentEngine(FEngine).Pen.Assign(Pen)
  else
    IgtDocumentEngine(FEngine).Pen.Style := psClear;
end;

procedure TgtAceXport.SetTextAlign(Flags: Word);
begin
  IgtDocumentEngine(FEngine).TextFormatting.Alignment := haLeft;
  if (Flags and TA_CENTER) = TA_CENTER then
    IgtDocumentEngine(FEngine).TextFormatting.Alignment := haCenter
  else if (Flags and TA_RIGHT) = TA_RIGHT then
    IgtDocumentEngine(FEngine).TextFormatting.Alignment := haRight;
  //Getting Alignments
  IgtDocumentEngine(FEngine).SetTextAlignment(
    IgtDocumentEngine(FEngine).TextFormatting.Alignment);
  FVAlignment := vaTop;
  if (Flags and TA_BOTTOM) = TA_BOTTOM then
    FVAlignment := vaBottom
  else if (Flags and TA_BASELINE) = TA_BASELINE then
    FVAlignment := vaCenter;
  if (Flags and TA_UPDATECP) = TA_UPDATECP then
    CurPosUpdate := True
  else if (Flags and TA_NOUPDATECP) = TA_NOUPDATECP then
    CurPosUpdate := False;
end;

procedure TgtAceXport.ShadeRect(Rect: TRect; Shade: TAceShadePercent);
var
	LMeta: TMetafile;
begin
  LMeta := GetShadeRectMetafile(Rect, Shade);
    try
      if not LMeta.Empty then
        IgtDocumentEngine(FEngine).PlayMetafile(Rect.Left, Rect.Top, LMeta);
    finally
      LMeta.Free;
    end;
end;

procedure TgtAceXport.StretchDraw(Rect: TRect; Graphic: TGraphic);
begin
  if Graphic is TMetafile then
    IgtDocumentEngine(FEngine).PlayMetafile(gtRect(Rect.Left, Rect.Top,
      Rect.Right, Rect.Bottom), TMetafile(Graphic))
  else
  begin
    IgtDocumentEngine(FEngine).ImageSettings.Stretch := True;
    IgtDocumentEngine(FEngine).DrawImage(gtRect(Rect.Left, Rect.Top,
      Rect.Right, Rect.Bottom), Graphic);
  end;
end;

procedure TgtAceXport.StretchDrawBitmap(Rect: TRect; Stream: TStream);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromStream(Stream);
    IgtDocumentEngine(FEngine).ImageSettings.Stretch := true;
    IgtDocumentEngine(FEngine).DrawImage(gtRect(Rect.Left, Rect.Top,
      Rect.Right, Rect.Bottom), ABitmap);
  finally
    ABitmap.Free;
  end;
end;

procedure TgtAceXport.TextJustify(Rect: TRect; X, Y: Integer;
  const Text: string; EndParagraph: Boolean; FullRect: TRect);
begin
  if not EndParagraph then
  begin
    TextOut(X, Y, GetJustifiedText(Text, IgtDocumentEngine(FEngine).Font,
      Rect.Right-Rect.Left));
  end
  else
    TextOut(X, Y, Text);
end;

procedure TgtAceXport.Textout(X, Y: Integer; const Text: string);
var
  ASize: TSize;
  ATextWidth: Extended;
  ATextHeight: Extended;
  FX, FY: Extended;
  Alpha, Len: Double;
  FfiDescent: Integer;
  TM: TTextMetric;
  DC: HDC;
begin
  with IgtDocumentEngine(FEngine) do
  begin
    if CurPosUpdate then
    begin
      X := FCurrentX + X;
      Y := FCurrentY + Y;
    end;
    FX := X;
    FY := Y;
    ASize := TextSize(Text,Font);
    ATextWidth := ASize.cx;
    ATextHeight := ASize.cy;
    if (ARotation = 0) then
    begin
      if TextFormatting.Alignment = haRight then
          FX := FX - ATextWidth
      else if TextFormatting.Alignment = haCenter then
          FX := FX - ATextWidth / 2;
      if FVAlignment = vaBottom then
          FY := FY - (ATextHeight) + Pen.Width
      else if FVAlignment = vaCenter then
          FY := FY - (ATextHeight / 2) + Pen.Width;
    end
    else
    begin
      SetTextRotation(ARotation);
      DC := GetDC(0);
      SelectObject(DC,Font.Handle);
      GetTextMetrics(DC, TM);
      FfiDescent := -Abs(TM.tmDescent) div CPixelsPerInch * CInchesToPoints;
      if (TextFormatting.Alignment = haLeft) and
          (FVAlignment = vaTop) then
      begin
        FY := FY;
        FX := FX;
      end
      else if (TextFormatting.Alignment = haLeft) and
        (FVAlignment = vaCenter) then
      begin
        FY := FY - (Cos(ARotation * PI / 180) * (Font.Size - FfiDescent));
        FX := FX - (Sin(ARotation * PI / 180.0) * (Font.Size - FfiDescent));
      end
      else if (TextFormatting.Alignment = haLeft) and
        (FVAlignment = vaBottom) then
      begin
        ASize := TextSize(Text, Font);
        FY := FY - Cos(ARotation * PI / 180.0) * ASize.cy;
        FX := FX- Sin(ARotation * PI / 180.0) * ASize.cy;
      end
      else if (TextFormatting.Alignment = haCenter) and
        (FVAlignment = vaTop) then
      begin
        ASize := TextSize(Text, Font);
        FY := FY + Sin(ARotation * PI / 180.0) * ASize.cx / 2;
        FX := FX - Cos(ARotation * PI / 180.0) * ASize.cx / 2;
      end
      else if (TextFormatting.Alignment = haCenter) and
        (FVAlignment = vaCenter) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - (ArcTan(
          (Font.Size - FfiDescent) / ASize.cx / 2));
        Len := Hypot((ASize.cx / 2), (Font.Size - FfiDescent));
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end
      else if (TextFormatting.Alignment = haCenter) and
        (FVAlignment = vaBottom) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - ArcTan(ASize.cy /(ASize.cx / 2));
        Len := Hypot((ASize.cx / 2), ASize.cy);
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end
      else if (TextFormatting.Alignment = haRight) and
        (FVAlignment = vaTop) then
      begin
        FY := FY + Sin(ARotation * PI / 180.0) *
        TextSize(Text, Font).cx;
        FX := FX - Cos(ARotation * PI / 180.0) *
        TextSize(Text, Font).cx;
      end
      else if (TextFormatting.Alignment = haRight) and
        (FVAlignment = vaCenter) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - (ArcTan(
          (Font.Size - FfiDescent) / ASize.cx));
        Len := Hypot(ASize.cx, (Font.Size) - FfiDescent);
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end
      else if (TextFormatting.Alignment = haRight) and
        (FVAlignment = vaBottom) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - (ArcTan(
          ASize.cy / ASize.cx));
        Len := Hypot(ASize.cx, ASize.cy);
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end;
    end;
    TextOut(FX,FY,Text);
    if CurPosUpdate then
      FCurrentX := X +  ASize.cx ;
  end;
end;

procedure TgtAceXport.TextRect(Rect: TRect; X, Y: Integer;
  const Text: string);
var
  FX, FY: Double;
  ASize: TSize;
  ATextWidth: Integer;
  Alpha, Len: Double;
  ATextHeight: Integer;
  FfiDescent: Integer;
  TM: TTextMetric;
  DC: HDC;
begin
  with IgtDocumentEngine(FEngine) do
  begin
    FX := X;
    FY := Y;
    ASize := Textsize(Text, Font);
    ATextWidth := ASize.cx;
    ATextHeight := ASize.cy;

    if (ARotation = 0) then
    begin
      if TextFormatting.Alignment = haRight then
        FX := FX - ATextWidth
      else if TextFormatting.Alignment = haCenter then
        FX := FX - ATextWidth / 2;
      if FVAlignment = vaBottom then
        FY := FY - ( ATextHeight) + Pen.Width
      else if FVAlignment = vaCenter then
        FY := FY - ( ATextHeight / 2) + Pen.Width;
      if ((Rect.Top > FY) and ((Rect.Top - FY) < 3)) then
        FY := Rect.Top;
      if ((Rect.Left > FX) and ((Rect.Left - FX) < 3)) then
        FX := Rect.Left;
    end
    else
    begin
      SetTextRotation(ARotation);
      DC := GetDC(0);
      SelectObject(DC,Font.Handle);
      GetTextMetrics(DC, TM);
      FfiDescent := -Abs(TM.tmDescent) div CPixelsPerInch * CInchesToPoints;
      if (TextFormatting.Alignment = haLeft) and
          (FVAlignment = vaTop) then
      begin
        FY := FY;
        FX := FX;
      end
      else if (TextFormatting.Alignment = haLeft) and
        (FVAlignment = vaCenter) then
      begin
        FY := FY - (Cos(ARotation * PI / 180) * (Font.Size - FfiDescent));
        FX := FX - (Sin(ARotation * PI / 180.0) * (Font.Size - FfiDescent));
      end
      else if (TextFormatting.Alignment = haLeft) and
        (FVAlignment = vaBottom) then
      begin
        ASize := TextSize(Text, Font);
        FY := FY - Cos(ARotation * PI / 180.0) * ASize.cy;
        FX := FX- Sin(ARotation * PI / 180.0) * ASize.cy;
      end
      else if (TextFormatting.Alignment = haCenter) and
        (FVAlignment = vaTop) then
      begin
        ASize := TextSize(Text, Font);
        FY := FY + Sin(ARotation * PI / 180.0) * ASize.cx / 2;
        FX := FX - Cos(ARotation * PI / 180.0) * ASize.cx / 2;
      end
      else if (TextFormatting.Alignment = haCenter) and
        (FVAlignment = vaCenter) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - (ArcTan(
          (Font.Size - FfiDescent) / ASize.cx / 2));
        Len := Hypot((ASize.cx / 2), (Font.Size - FfiDescent));
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end
      else if (TextFormatting.Alignment = haCenter) and
        (FVAlignment = vaBottom) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - ArcTan(ASize.cy /(ASize.cx / 2));
        Len := Hypot((ASize.cx / 2), ASize.cy);
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end
      else if (TextFormatting.Alignment = haRight) and
        (FVAlignment = vaTop) then
      begin
        FY := FY + Sin(ARotation * PI / 180.0) *
        TextSize(Text, Font).cx;
        FX := FX - Cos(ARotation * PI / 180.0) *
        TextSize(Text, Font).cx;
      end
      else if (TextFormatting.Alignment = haRight) and
        (FVAlignment = vaCenter) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - (ArcTan(
          (Font.Size - FfiDescent) / ASize.cx));
        Len := Hypot(ASize.cx, (Font.Size) - FfiDescent);
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end
      else if (TextFormatting.Alignment = haRight) and
        (FVAlignment = vaBottom) then
      begin
        ASize := TextSize(Text, Font);
        Alpha := (ARotation * PI / 180) - (ArcTan(
          ASize.cy / ASize.cx));
        Len := Hypot(ASize.cx, ASize.cy);
        FY := FY + Sin(Alpha) * Len;
        FX := FX - Cos(Alpha) * Len;
      end;
    end;
    TextRect(gtRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom),
      FX, FY, Text);
  end;
end;

function TgtAceXport.GetShadeRectMetafile(ARect: TRect;Shade: TAceShadePercent): TMetafile;
var
	LMetaCanvas: TMetafileCanvas;
begin
  Result := TMetafile.Create;
  LMetaCanvas := TMetafileCanvas.Create(Result, 0);
  try
    AceShadeRect(LMetaCanvas.Handle, Rect(0, 0, Round(ARect.Right - ARect.Left),
    	Round(ARect.Bottom - ARect.Top)), Shade);
  finally
  	LMetaCanvas.Free;
  end;
end;

function TgtAceXport.GetBitmapFromAceStream(AAceStream: TStream): TBitmap;
var
	AAceBitmap: TAceBitmap;
begin
	AAceBitmap := TAceBitmap.Create;
  try
		AAceBitmap.LoadFromStream(AAceStream);
		Result := TBitmap.Create;
		Result.Width := AAceBitmap.Width;
		Result.Height := AAceBitmap.Height;
    AAceBitmap.Draw(Result.Canvas.Handle, 0, 0);
	finally
		AAceBitmap.Free;
	end;
end;

function TgtAceXport.Get3of9BarcodeBitmap(ALeft, ATop, AWidth, AHeight,
  ANarrowWidth, AWideWidth: Integer; AInches, AVertical: Boolean;
  ABarData: string): TBitmap;
var
  AceBarCode: TAce3of9BarCode;
begin
  AceBarCode := TAce3of9BarCode.Create;
	with AceBarCode do
		try
			Width := AWidth;
			Height := AHeight;
			NarrowWidth := ANarrowWidth;
			WideWidth := AWideWidth;
			WidthInInches_1000 := AInches;
			Vertical := AVertical;

			Result := TBitmap.Create;
			Result.Width := AWidth;
			Result.Height := AHeight;
      if AWidth = 0 then
        Result.Width := BarCodeLength(Result.Canvas.Handle, ABarData);
      if AHeight = 0 then
        Result.Height := BarCodeLength(Result.Canvas.Handle, ABarData);
      PrintDC(Result.Canvas.Handle,IgtDocumentEngine(FEngine).Brush.Handle,
        0, 0, ABarData);
    finally
			Free;
		end;
end;

function TgtAceXport.Get2of5BarcodeBitmap(ALeft, ATop, AWidth, AHeight,
  ANarrowWidth, AWideWidth: Integer; AInches, AVertical: Boolean;
  ABarData: string): TBitmap;
begin
  with TAce2of5BarCode.Create do
		try
			Width := AWidth;
			Height := AHeight;
			NarrowWidth := ANarrowWidth;
			WideWidth := AWideWidth;
			WidthInInches_1000 := AInches;
			Vertical := AVertical;

			Result := TBitmap.Create;
			Result.Width := AWidth;
			Result.Height := AHeight;
      if AWidth = 0 then
        Result.Width := BarCodeLength(Result.Canvas.Handle, ABarData);
      if AHeight = 0 then
        Result.Height := BarCodeLength(Result.Canvas.Handle, ABarData);

      PrintDC(Result.Canvas.Handle, IgtDocumentEngine(FEngine).Brush.Handle,
        0, 0, ABarData);
		finally
			Free;
		end;
end;

function TgtAceXport.GetRichTextAsMetafile(ARect: TRect; AStream: TStream;
  AStartPos, AEndPos: Integer): TMetaFile;
var
	ARichEdit: TRichEdit;
	FmtRange: TFormatRange;
	ACharRange: TCharRange;
	AParentWnd: TForm;
	AMetafileCanvas: TMetafileCanvas;
begin
  AParentWnd := TForm.Create(nil);
	ARichEdit := TRichEdit.Create(AParentWnd);
	try
		ARichEdit.Parent := AParentWnd;
		AStream.Position := 0;
		ARichEdit.Lines.LoadFromStream(AStream);
		ACharRange.cpMin := AStartPos;
		ACharRange.cpMax := AEndPos;
		with FmtRange do
		begin
			Result := TMetafile.Create;
			rc := Rect(0, 0,Round(PixelsToTwips(ARect.Right - ARect.Left)),
				Round(PixelsToTwips(ARect.Bottom - ARect.Top)));

			AMetafileCanvas := TMetafileCanvas.Create(Result, 0);

			chrg := ACharRange;
			hdc := AMetafileCanvas.Handle;
			hdcTarget := Result.Handle;
      rc.Bottom := rc.Bottom + (AEndPos - AStartPos);
			rcPage := rc;
			SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 1, Longint(@FmtRange));
			AMetafileCanvas.Free;
		end;
	finally
		ARichEdit.Free;
		AParentWnd.Free;
	end;
end;

function TgtAceXport.GetCheckBoxMetafile(ARect: TRect;
  CheckStyle: TAceCheckStyle; Color: TColor; Thickness: Integer): TMetafile;
var
	LMetaCanvas: TMetafileCanvas;
begin
  Result := TMetafile.Create;
  LMetaCanvas := TMetafileCanvas.Create(Result, 0);
  try
    AceDrawCheckBox(LMetaCanvas.Handle, Rect(0, 0,
    	Round(ARect.Right - ARect.Left), Round(ARect.Right - ARect.Left)),
    	CheckStyle, Color, Thickness);
  finally
    LMetaCanvas.Free
	end;
end;

function TgtAceXport.PixelsToTwips(X: Extended):Extended;
begin
  Result := X / CPixelsPerInch * CInchesToPoints / CTwipsToPoints;
end;

end.
