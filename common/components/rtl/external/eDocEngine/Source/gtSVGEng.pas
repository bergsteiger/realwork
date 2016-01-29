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

unit gtSVGEng;

interface

uses
  Windows, Classes, SysUtils, Graphics, gtConsts3, gtCstDocEng, gtCstPlnEng,
  gtDocConsts, gtDocUtils, gtUtils3, gtDocResStrs;

type
	TgtCurveType = (ctArc, ctChord, ctPie);

  (* For image reuse *)
  TgtSVGImageSettings = class(TgtImageSettings)
  private
    FFileName: String;
    FDispWidth, FDispHeight, FImageWidth, FImageHeight: Double;
    procedure SetFileName(const Value: String);
    procedure SetDispHeight(const Value: Double);
    procedure SetDispWidth(const Value: Double);
    procedure SetImageHeight(const Value: Double);
    procedure SetImageWidth(const Value: Double);
  public
    constructor Create; override;
    destructor Destroy; override;
    function IsEqual(AObject: TgtImageItem;
    	AOriginalWidth, AOriginalHeight: Double): Boolean;
  published
    property FileName: String read FFileName write SetFileName;
    property DispWidth: Double read FDispWidth write SetDispWidth;
    property DispHeight: Double read FDispHeight write SetDispHeight;
    property ImageWidth: Double read FImageWidth write SetImageWidth;
    property ImageHeight: Double read FImageHeight write SetImageHeight;
  end;

	TgtSVGEngine = class(TgtCustomPlainSheetEngine)
  private
  	FSVGStream: TStream;
    FImageCount: Integer;
    FPattern: String;
    FPatternPathList: TStringList;
    FCurInclination: Integer;
    FRotationPoint: TgtPoint;
    FImgSettingList: array of TList;
    FAttachmentList: TStringList;
    function GetRGBString(AColor: TColor): String;
    function GetSVGImage(AObject: TgtImageItem): String;
    function GetShapeStyle(APen: TPen; ABrush: TBrush): String;
    procedure EncodeCurve(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double; APen: TPen;
      ABrush: TBrush; AType: TgtCurveType);
    function NumToStr(AN: Extended): String;
    function SVGChars(AString: String; AToSVG: Boolean): String;
  protected
    {$IFDEF EMailSupport}
  	procedure CreateEMailSettingsObj; override;
    {$ENDIF}
    procedure Start; override;
    procedure Finish; override;
  	procedure EndPage; override;
    procedure BeginPage; override;
    function ShowSetupModal: Word; override;
    function CheckOutputImageFormat(Value: TgtOutputImageFormat;
      var S: String): Boolean; override;
		procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); override;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
    	Brush: TBrush); override;
    procedure EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
      IsClosed: Boolean; Pen: TPen; Brush: TBrush); override;
    procedure EncodeArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
       Pen: TPen); override;
    procedure EncodePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
       Pen: TPen; Brush: TBrush); override;
    procedure EncodeChord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       Pen: TPen; Brush: TBrush); override;
    procedure EncodePolyBezier(Points: TgtPoints; NoPoints: Integer;
      Pen: TPen); override;
    // If any more shapes are needed then override...
    procedure EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses gtSVGEngDlg, Math;

{ TgtSVGEngine }

procedure TgtSVGEngine.BeginPage;
var
	LS: String;
  LATemp : AnsiString;
begin
  inherited;

  if not Preferences.OutputToUserStream then
  begin
    FSVGStream := CreateFile(FileName + IntToStr(CurrentPage) + '.' +
      FileExtension);
    EngineFileNames.Add(FileName + IntToStr(CurrentPage) + '.' + FileExtension);
  end
  else
    FSVGStream := UserStream;
  (* Standard XML header *)
  LS := '<?xml version="1.0" encoding="iso-8859-1"?>' + CRLF +
  	'<svg xml:space="default' +
  	'" width="' + NumToStr(Pages[CurrentPage - 1].Settings.Width) +
    '" height="' + NumToStr(Pages[CurrentPage - 1].Settings.Height) +
    '">' + CRLF +
	  '<title> ' + DocInfo.Title + ' </title>' + CRLF +
  	'<desc> ' + DocInfo.Subject + ' </desc>' + CRLF;
  FPattern := '';
  FPatternPathList.Clear;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

(* Check if image format is supported by SVG *)
function TgtSVGEngine.CheckOutputImageFormat(Value: TgtOutputImageFormat;
  var S: String): Boolean;
begin
	Result := False;
  if (Value in [ifPNG, ifJPEG]) then
  	Result := True
  else S := SUnsupportedSVGImageFormat;
end;

constructor TgtSVGEngine.Create(AOwner: TComponent);
begin
  inherited;
	FImageCount := 1;
	FileExtension := 'svg';
  Capabilities := [ckText, ckImage, ckShape, ckImageStretch, ckImageFrame];
  FileDescription := SSVGDescription;
  Preferences.ActiveHyperlinks := True;
  ImageSettings.OutputImageFormat := ifJPEG;
  FAttachmentList := TStringList.Create;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 113);
{$ENDIF}
end;

destructor TgtSVGEngine.Destroy;
begin
  FAttachmentList.Free;
  inherited;
end;

procedure TgtSVGEngine.EncodeArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  Pen: TPen);
begin
	EncodeCurve(X1, Y1, X2, Y2, X3, Y3, X4, Y4, Pen, nil, ctArc);
end;

procedure TgtSVGEngine.EncodeChord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  Pen: TPen; Brush: TBrush);
begin
	EncodeCurve(X1, Y1, X2, Y2, X3, Y3, X4, Y4, Pen, Brush, ctChord);
end;

(*
	Encoding of Arc, Pie and Chord using SVG-Arc commands
  See SVG Specification on parameters required:
  From Start Point,
  Arc(Rx, Ry, X-Axis-Rotation, Large-Arc-Flag, Sweep-Flag, X, Y)
*)
procedure TgtSVGEngine.EncodeCurve(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  APen: TPen; ABrush: TBrush; AType: TgtCurveType);
var
	LRx, LRy, LAlpha, LBeta: Double;
  LLargeArcFlag: Integer;
  LS: String;
  LATemp : AnsiString;
  (* Center, Start and End Points *)
  LCenter, LSPoint, LEPoint: TgtPoint;

	function FindAngle(ACenter, APoint: TgtPoint): Double;
  begin
    if ((APoint.X > ACenter.X) and (APoint.Y <= ACenter.Y)) then
    begin
      (* First quadrant *)
      Result := ArcTan(Abs((ACenter.Y - APoint.Y) / (APoint.X - ACenter.X)));
    end
    else if ((APoint.X > ACenter.X) and (APoint.Y > ACenter.Y)) then
    begin
      (* Second quadrant *)
      Result := (2 * Pi) - ArcTan(Abs((ACenter.Y - APoint.Y) / (APoint.X - ACenter.X)));
    end
    else if ((APoint.X < ACenter.X) and (APoint.Y <= ACenter.Y)) then
    begin
      (* Third quadrant *)
      Result := Pi - ArcTan(Abs((ACenter.Y - APoint.Y) / (APoint.X - ACenter.X)));
    end
    else if ((APoint.X < ACenter.X) and (APoint.Y > ACenter.Y)) then
    begin
    	(* Fourth quadrant *)
      Result := Pi + ArcTan(Abs((ACenter.Y - APoint.Y) / (APoint.X - ACenter.X)));
    end
    else
    begin
    	(* 1st or 2nd quadrant *)
      if (APoint.Y <= ACenter.Y) then Result := Pi / 2
      (* 3rd or 4th quadrant *)
      else Result := Pi * 1.5;
    end;
  end;
begin
  LLargeArcFlag := 0;
  LCenter := gtPoint((X1 + X2) / 2, (Y1 + Y2) / 2);
  LRx := Abs(X1 - X2) / 2;
  LRy := Abs(Y1 - Y2) / 2;
  LAlpha := FindAngle(LCenter, gtPoint(X3, Y3));
  LBeta := FindAngle(LCenter, gtPoint(X4, Y4));
  if (((LBeta > LAlpha) and ((LBeta - LAlpha) >= Pi)) or
  	((LAlpha > LBeta) and ((LAlpha - LBeta) <= Pi))) then LLargeArcFlag := 1;
  LSPoint := gtPoint(LCenter.X + LRx*Cos(LAlpha), LCenter.Y - LRy * Sin(LAlpha));
  LEPoint := gtPoint(LCenter.X + LRx*Cos(LBeta), LCenter.Y - LRy * Sin(LBeta));
  LS := '<path d="M ' + NumToStr(LSPoint.X) + ' ' + NumToStr(LSPoint.Y) +
  	' A ' + NumToStr(LRx) + ' ' + NumToStr(LRy) + ' 0 ' + (* X-Axis-Rotation = 0 *)
    IntToStr(LLargeArcFlag) + ' 0 ' + (* Sweep-Flag = 0 *)
    NumToStr(LEPoint.X) + ' ' + NumToStr(LEPoint.Y);
  if (AType = ctPie) then
  	(* Draw line from EndPoint to Center *)
    LS := LS + ' L ' + NumToStr(LCenter.X) + ' ' + NumToStr(LCenter.Y);
  if ((AType = ctChord) or (AType = ctPie)) then
  	(* Draw line from current EndPoint to StartPoint *)
  	LS := LS + ' z';
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) +
      ' ' + NumToStr(FRotationPoint.X) +
      ' ' + NumToStr(FRotationPoint.Y) + ')';
	FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(APen, ABrush) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

(*
  See SVG Specification on parameters required:
  Ellipse(Cx, Cy, Rx, Ry)
*)
procedure TgtSVGEngine.EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
	LS: String;
  LATemp : AnsiString;
begin
  LS := '<ellipse cx="' + NumToStr(X1 + ((X2-X1)/2)) +
  	'" cy="' + NumToStr(Y1 + ((Y2-Y1)/2)) +
    '" rx="' + NumToStr(Abs(X1 - X2)/2) +
    '" ry="' + NumToStr(Abs(Y1 - Y2)/2);
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) +
      ' ' + NumToStr(FRotationPoint.X) +
      ' ' + NumToStr(FRotationPoint.Y) + ')';
  FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(Pen, Brush) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

function TgtSVGEngine.GetSVGImage(AObject: TgtImageItem): String;
var
	LFileName, LFileExt: String;
  LI: Integer;
  LReuseImageIndex: Integer;
  LSettings: TgtSVGImageSettings;
  LBitmap: TBitmap;
begin
  LReuseImageIndex := -1;
  LBitmap := nil;
  (* Reuse already created image *)
  if Length(FImgSettingList) >= (AObject.IndexNo + 1) then
  begin
    if (FImgSettingList[AObject.IndexNo] <> nil) then
    begin
      with FImgSettingList[AObject.IndexNo] do
        for LI := 0 to Count - 1 do
          if ((TgtSVGImageSettings(Items[LI])).IsEqual(
            AObject, GetGraphicResource(AObject.IndexNo).Width,
              GetGraphicResource(AObject.IndexNo).Height)) then
          begin
            LReuseImageIndex := LI;
            Break;
          end;
    end
    else FImgSettingList[AObject.IndexNo] := TList.Create;
  end
  else
  begin
    SetLength(FImgSettingList, (AObject.IndexNo + 1));
    FImgSettingList[AObject.IndexNo] := TList.Create;
  end;
  (* New image, store settigns *)
  if (LReuseImageIndex = -1) then
  begin
    LFileName := FileName + '_' + IntToStr(FImageCount) + '_I';
    Inc(FImageCount);
	  LSettings := TgtSVGImageSettings.Create;
    LSettings.Assign(AObject.Settings);
    LSettings.DispWidth := AObject.DisplayRect.Right - AObject.DisplayRect.Left;
    LSettings.DispHeight := AObject.DisplayRect.Bottom - AObject.DisplayRect.Top;
    LSettings.ImageWidth := AObject.Width;
    LSettings.ImageHeight := AObject.Height;
    case AObject.Settings.OutputImageFormat of
      ifPNG:
      begin
        LFileExt := '.png';
        LBitmap := GetImageAsBitmap(AObject);
        with TMemoryStream(GetBitmapAsPNGStream(LBitmap, clWhite)) do
        	try
          	SaveToFile(LFileName + LFileExt);
          finally
          	Free;
          end;
      end;
    else
    begin
      LFileExt := '.jpg';
      LBitmap := GetImageAsBitmap(AObject);
      with TMemoryStream(GetBitmapAsJPGGIFStream(
          LBitmap, True, AObject.Settings.JPEGQuality)) do
        try
          SaveToFile(LFileName + LFileExt);
        finally
          Free;
        end;
    end;
    end;
    FAttachmentList.Add(LFileName + LFileExt);
    LSettings.FFileName := GetFileNameFromPath(LFileName) + LFileExt;
    LReuseImageIndex := FImgSettingList[AObject.IndexNo].Add(LSettings);
  end;
  with AObject do
  begin
    (* Image Border with rotation *)
    if (Settings.IsFrame) then
    begin
      FCurInclination := Settings.Inclination;
      FRotationPoint := gtPoint(DisplayRect.Left - Pen.Width,
      	DisplayRect.Top - Pen.Width);
      if (Frame.IsLeft) then
      	EncodeLine(DisplayRect.Left - Pen.Width,
        	DisplayRect.Top - Pen.Width,
          DisplayRect.Left - Pen.Width,
        	DisplayRect.Bottom + Pen.Width,
          Pen);
      FCurInclination := Settings.Inclination;
      if (Frame.IsRight) then
      	EncodeLine(DisplayRect.Right + Pen.Width,
        	DisplayRect.Top - Pen.Width,
        	DisplayRect.Right + Pen.Width,
          DisplayRect.Bottom + Pen.Width,
          Pen);
      FCurInclination := Settings.Inclination;
      if (Frame.IsTop) then
      	EncodeLine(DisplayRect.Left - Pen.Width,
        	DisplayRect.Top - Pen.Width,
        	DisplayRect.Right + Pen.Width,
          DisplayRect.Top - Pen.Width,
          Pen);
      FCurInclination := Settings.Inclination;
      if (Frame.IsBottom) then
      	EncodeLine(DisplayRect.Left - Pen.Width,
        	DisplayRect.Bottom + Pen.Width,
          DisplayRect.Right + Pen.Width,
        	DisplayRect.Bottom + Pen.Width,
          Pen);
    end;
    if (Brush <> nil) then
    begin
	    (* Image Display area to be filled by brush *)
    	FCurInclination := Settings.Inclination;
    	EncodeRect(DisplayRect.Left - Pen.Width, DisplayRect.Top - Pen.Width,
        DisplayRect.Right + Pen.Width, DisplayRect.Bottom + Pen.Width,
        nil, Brush);
    end;
  end;
  (* Draw image with roation *)
  with FImgSettingList[AObject.IndexNo] do
  begin
    Result := '<image x="' + NumToStr(AObject.X) +
      '" y="' + NumToStr(AObject.Y);
  if (AObject.Settings.Inclination <> 0) then
    Result := Result + '" transform="rotate(' +
    	IntToStr(360 - AObject.Settings.Inclination) + ' ' +
      NumToStr(AObject.DisplayRect.Left - AObject.Pen.Width) + ' ' +
      NumToStr(AObject.DisplayRect.Top - AObject.Pen.Width) + ')';
  Result := Result + '" width="' + NumToStr(AObject.Width) +
    '" height="' + NumToStr(AObject.Height) +
    '" xlink:href="' +
    TgtSVGImageSettings(Items[LReuseImageIndex]).FFileName + '" />' + CRLF;
  end;
  if (LBitmap <> nil) then LBitmap.Free;
end;

procedure TgtSVGEngine.EncodeImage(AObject: TgtImageItem);
var
	LS: String;
  LATemp : AnsiString;
begin
  inherited;
  LS := GetSVGImage(AObject);
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSVGEngine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
	LS: String;
  LATemp : AnsiString;
begin
	LS := LS + '<line x1="' + NumToStr(X1) +
  	'" y1="' + NumToStr(Y1) +
    '" x2="' + NumToStr(X2) +
    '" y2="' + NumToStr(Y2);
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) +
      ' ' + NumToStr(FRotationPoint.X) +
      ' ' + NumToStr(FRotationPoint.Y) + ')';
  FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(Pen, nil) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSVGEngine.EncodePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  Pen: TPen; Brush: TBrush);
begin
	EncodeCurve(X1, Y1, X2, Y2, X3, Y3, X4, Y4, Pen, Brush, ctPie);
end;

procedure TgtSVGEngine.EncodePolyBezier(Points: TgtPoints;
  NoPoints: Integer; Pen: TPen);
var
	LMax, LI: Integer;
  LS: String;
  LATemp : AnsiString;
begin
  (* take only required no. of points (3n+1) and ignore if there are more *)
  LMax := ((High(Points) div 3) * 3);
  LS := '<path d="M ' + NumToStr(Points[Low(Points)].X) + ',' +
  	NumToStr(Points[Low(Points)].Y) + ' ';
  LI := Low(Points) + 1;
  while LI <= LMax do
  begin
    LS := LS + 'C ' +
    	NumToStr(Points[LI].X) + ',' + NumToStr(Points[LI].Y) + ' ' +
      NumToStr(Points[LI+1].X) + ',' + NumToStr(Points[LI+1].Y) + ' ' +
      NumToStr(Points[LI+2].X) + ',' + NumToStr(Points[LI+2].Y);
    Inc(LI, 3);
    if (LI <> LMax) then LS := LS + ' ';
  end;
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) + ' ' +
      NumToStr(FRotationPoint.X) + ' ' +
      NumToStr(FRotationPoint.Y) + ')';
  FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(Pen, nil) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

(* For both Polygon and Polyline use same points *)
procedure TgtSVGEngine.EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
  IsClosed: Boolean; Pen: TPen; Brush: TBrush);
var
	LS: String;
  LATemp : AnsiString;
  LI: Integer;
begin
  if (IsClosed) then LS := '<polygon '
  else LS := '<polyline ';
  LS := LS + 'points="';
  for LI := Low(Points) to High(Points) do
  begin
    LS := LS + NumToStr(Points[LI].X) + ',' +
      NumToStr(Points[LI].Y);
    if (LI <> High(Points)) then LS := LS + ' ';
  end;
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) + ' ' +
      NumToStr(FRotationPoint.X) + ' ' +
      NumToStr(FRotationPoint.Y) + ')';
  FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(Pen, Brush) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSVGEngine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
	LS: String;
  LATemp : AnsiString;
begin
  LS := '<rect x="' + NumToStr(X1) +
  	'" y="' + NumToStr(Y1) +
    '" width="' + NumToStr(Abs(X1 - X2)) +
    '" height="' + NumToStr(Abs(Y1 - Y2));
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) +
      ' ' + NumToStr(FRotationPoint.X) +
      ' ' + NumToStr(FRotationPoint.Y) + ')';
  FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(Pen, Brush) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSVGEngine.EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  Pen: TPen; Brush: TBrush);
var
	LS: String;
  LATemp : AnsiString;
begin
  LS := '<rect x="' + NumToStr(X1) +
  	'" y="' + NumToStr(Y1) +
    '" width="' + NumToStr(Abs(X1 - X2)) +
    '" height="' + NumToStr(Abs(Y1 - Y2)) +
    '" rx="' + NumToStr(X3) +
    '" ry="' + NumToStr(Y3);
  if (FCurInclination <> 0) then
    LS := LS + '" transform="rotate(' + IntToStr(360 - FCurInclination) +
      ' ' + NumToStr(FRotationPoint.X) +
      ' ' + NumToStr(FRotationPoint.Y) + ')';
  FCurInclination := 0;
  LS := LS + '" ' + GetShapeStyle(Pen, Brush) + ' />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSVGEngine.EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap);
var
	LS: String;
  LATemp : AnsiString;
begin
  LS := FileName + '_' + IntToStr(FImageCount) + '_S.jpg';
  with TMemoryStream(GetBitmapAsJPGGIFStream(Bitmap, True, 100)) do
  	try
    	SaveToFile(LS);
    finally
    	Free;
    end;
  FattachmentList.Add(LS);
  Inc(FImageCount);
  LS := '<image x="' + NumToStr(X) +
  	'" y="' + NumToStr(Y) +
    '" width="' + NumToStr(Bitmap.Width) +
    '" height="' + NumToStr(Bitmap.Height) +
    '" xlink:href="' + GetFileNameFromPath(LS) +
    '" />' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSVGEngine.EncodeText(AObject: TgtTextItem);
var
	LStyle, LS, LText, LLinkBuffer, LLinkText : String;
  LATemp : AnsiString;
  LOriginalText: WideString;
  LChar: Char;
  LStartPos: Integer;
  LSize: TSize;
begin
  inherited;
  LOriginalText := AObject.Lines.Strings[0];
  AObject.Lines.Strings[0] := ReplacePlaceHolders(AObject.Lines.Strings[0], True);
  LSize := TextSize(RemoveTerminalCRLF(AnsiString(AObject.Lines.Strings[0])), AObject.Font);
  if (Brush <> nil) then
  begin
    (* Text shading using Rectangle with no border *)
    FCurInclination := AObject.RotationAngle;
    FRotationPoint := gtPoint(AObject.X, AObject.Y);
    EncodeRect(AObject.X, AObject.Y, AObject.X + LSize.cx,
    	AObject.Y + LSize.cy, nil, AObject.Brush);
  end;
  (* Change Special Characters to SVG characters *)
  AObject.Lines.Strings[0] := SVGChars(AObject.Lines.Strings[0], True);

  (* Convert web addresses to hyperlinks *)
  if (Preferences.ActiveHyperlinks) then
  begin
    LText := Trim(AObject.Lines.Strings[0]);
    LLinkBuffer := '';
    LStartPos := 0;
    LLinkText := GetHyperLinkText(LText, LStartPos);
    if LLinkText <> '' then
    begin
      while (LLinkText <> '') and (LLinkText <> #$D#$A) do
      begin
        LLinkText := SVGChars(LLinkText, False);
        LChar := LLinkText[Length(LLinkText)];
        (* Special Character in the end due to SVGChars function *)
        {$IFDEF gtDelphi2009Up}
        if SysUtils.CharInSet(LChar,['&', '>', '<', '''']) then
        {$ELSE}
        if (LChar in ['&', '>', '<', '''']) then
        {$ENDIF}

					LLinkText := Copy(LLinkText, 0, Length(LLinkText) - 1);
        if (AnsiPos('http:', LLinkText) = 1) or
            (AnsiPos('ftp:', LLinkText) = 1) then
          LLinkBuffer := '<a xlink:href="' + LLinkText + '">' +
          	LLinkText + '</a>'
        else
          LLinkBuffer := '<a xlink:href="' + 'http://' + LLinkText + '">' +
          	LLinkText + '</a>';
        AObject.Lines.Strings[0] := StringReplace(AObject.Lines.Strings[0], LLinkText,
        	LLinkBuffer,[]);
        LLinkText := SVGChars(LLinkText + LChar, True);
        LStartPos := LStartPos + Length(LLinkText);
        LLinkText := GetHyperLinkText(LText, LStartPos);
      end;
    end;
  end;
  (* Encode Font Style *)
  LStyle := 'style="';
  if (fsItalic in AObject.Font.Style) then
  	LStyle := LStyle + 'font-style: italic; ';
  if (fsBold in AObject.Font.Style) then
  	LStyle := LStyle + 'font-weight: bold; ';
  LStyle := LStyle + 'font-family: ' + AObject.Font.Name +
    '; font-size: ' + IntToStr(AObject.Font.Size) +
    'pt';
  if ((fsUnderline in AObject.Font.Style) or
  	(fsStrikeOut in AObject.Font.Style)) then
    begin
  		LStyle := LStyle + '; text-decoration:';
      if (fsUnderline in AObject.Font.Style) then
        LStyle := LStyle + ' underline';
      if (fsStrikeOut in AObject.Font.Style) then
        LStyle := LStyle + ' line-through';
  end;
  LStyle := LStyle + '; fill: ' + GetRGBString(AObject.Font.Color);
	LStyle := LStyle + '"';

  (* SVG takes Left-Bottom corner as (X, Y) for text *)
  LS := '<text x="' + NumToStr(AObject.X) +
  	'" y="' + NumToStr(AObject.Y + AObject.Font.Size * AObject.Font.PixelsPerInch / 72.0);
    if (AObject.RotationAngle <> 0) then
	    LS := LS + '" transform="rotate(' + IntToStr(360 - AObject.RotationAngle) +
    		' ' + NumToStr(AObject.X) + ' ' + NumToStr(AObject.Y) + ')';
    LS := LS + '" ' + LStyle + '>' +
    AObject.Lines.Strings[0] + '</text>' + CRLF;
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
  AObject.Lines.Strings[0] := LOriginalText;
end;

procedure TgtSVGEngine.EndPage;
var
	LS: String;
  LATemp : AnsiString;
begin
  if (FPattern <> '') then
  	(* Encode Defs for Brush styles used *)
	  LS := LS + '<defs>' + CRLF + FPattern + CRLF + '</defs>'+ CRLF;
  LS := LS + '</svg>';
  LATemp := AnsiString(LS);
  FSVGStream.Write(LATemp[1], Length(LS));
  if (not Preferences.OutputToUserStream) then
	  FSVGStream.Free;
  inherited;
end;

function TgtSVGEngine.GetRGBString(AColor: TColor): String;
begin
CheckSysColor(AColor);
Result := '#' + IntToHex(GetRValue(AColor), 2) +
IntToHex(GetGValue(AColor), 2) + IntToHex(GetBValue(AColor), 2);
end;


(* Encode Brush and Pen styles *)
function TgtSVGEngine.GetShapeStyle(APen: TPen; ABrush: TBrush): String;
var
	LPath: String;
  LI: Integer;
begin
  if ((ABrush <> nil) and (ABrush.Style <> bsClear)) then
  begin
  	if (ABrush.Style <> bsSolid) then
    begin
      (*
      	Create a Pattern style needed for brush, reuse created Patterns
      *)
      LPath := '<path fill="none" stroke="' + GetRGBString(ABrush.Color) +
        '" d="';
      case ABrush.Style of
        bsHorizontal: LPath := LPath + 'M 0 2.5 L 5 2.5';
        bsVertical: LPath := LPath + 'M 2.5 0 L 2.5 5';
        bsFDiagonal: LPath := LPath + 'M 2.5 0 L 0 2.5 M 5 2.5 L 2.5 5';
        bsBDiagonal: LPath := LPath + 'M 2.5 0 L 5 2.5 M 0 2.5 L 2.5 5';
        bsCross: LPath := LPath + 'M 2.5 0 L 2.5 5 M 0 2.5 L 5 2.5';
        bsDiagCross: LPath := LPath + 'M 2.5 0 L 0 2.5 L 2.5 5 L 5 2.5 z';
      end;
      LPath := LPath + '" />';
      LI := FPatternPathList.IndexOf(LPath);
      if (LI = -1) then
      begin
        (* New Pattern, add to list*)
      	LI := FPatternPathList.Add(LPath);
        FPattern := FPattern +
          '<pattern id="gtPattern' + IntToStr(LI) +
          '" patternUnits="userSpaceOnUse"' + CRLF +
          'x="0" y="0" width="10" height="10" viewBox="0 0 5 5">' + CRLF +
          FPatternPathList.Strings[LI] + CRLF + '</pattern>' + CRLF;
      end;
      Result := 'fill="url(#gtPattern' + IntToStr(LI) + ')" ';
    end
    else Result := 'fill="' + GetRGBString(ABrush.Color) + '" '
  end
  else Result :='fill="none"';
  if ((APen <> nil) and (APen.Style <> psClear)) then
  begin
    Result := Result + ' style="stroke:' + GetRGBString(APen.Color) +
      '; stroke-width:' + IntToStr(APen.Width);
    (* Encode Pen style with dasharray -> (dash-length, space-length)... *)
    case APen.Style of
      psDash:
        Result := Result + '; stroke-dasharray: 3mm,1mm';
      psDot:
        Result := Result + '; stroke-dasharray: 1mm,1mm';
      psDashDot:
        Result := Result + '; stroke-dasharray: 3mm,1mm,1mm,1mm';
      psDashDotDot:
        Result := Result + '; stroke-dasharray: 3mm,1mm,1mm,1mm,1mm,1mm';
    end;
    Result := Result + ';"'
  end;
end;

function TgtSVGEngine.ShowSetupModal: Word;
begin
  with TgtSVGEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

{$IFDEF EMailSupport}
procedure TgtSVGEngine.CreateEMailSettingsObj;
begin
  inherited;
	EMailSettings.Attachments.AddStrings(FAttachmentList);
end;
{$ENDIF}

procedure TgtSVGEngine.Start;
begin
  inherited;
  FPatternPathList := TStringList.Create;
	SetLength(FImgSettingList, 0)
end;

procedure TgtSVGEngine.Finish;
var
	LI, LJ: Integer;
begin
  inherited;
  FPatternPathList.Free;
  (* Free Settings List used in image-reuse *)
  for LI := 0 to Length(FImgSettingList) - 1 do
  begin
    if FImgSettingList[LI] <> nil then
    with FImgSettingList[LI] do
      for LJ := 0 to Count - 1 do
        TgtSVGImageSettings(Items[LJ]).Free;
    FImgSettingList[LI].Free;
  end;
end;

(* Decimal Separator must be '.' for SVG tags *)
function TgtSVGEngine.NumToStr(AN: Extended): String;
begin
	// Convert to native String.
	Result := FloatToStrF(AN, ffFixed, 18, 4);
	// Regional settings! convert without changing DecimalSeparator.
	if {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator <> '.' then
		Result := ReplaceString(Result, {$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, '.');
end;

function TgtSVGEngine.SVGChars(AString: String; AToSVG: Boolean): String;
begin
  if (AToSVG) then
  begin
  	Result := ReplaceString(AString, '&', '&amp;');
		Result := ReplaceString(Result, '''', '&apos;');
	  Result := ReplaceString(Result, '>', '&gt;');
		Result := ReplaceString(Result, '<', '&lt;');
    // To Do: Remove/replace all special characters
    if (Pos(Chr(3), Result) > 0) then
      Result := ReplaceString(Result, Chr(3), '');
  end
  else
  begin
  	Result := ReplaceString(AString, '&amp', '&');
		Result := ReplaceString(Result, '&apos', '''');
	  Result := ReplaceString(Result, '&gt', '>');
		Result := ReplaceString(Result, '&lt', '<');
  end;
end;

{ TgtSVGImageSettings }

constructor TgtSVGImageSettings.Create;
begin
  inherited;
	FFileName := '';
end;

destructor TgtSVGImageSettings.Destroy;
begin

  inherited;
end;

(* Check if image can be reused, or a new image is needed *)
function TgtSVGImageSettings.IsEqual(AObject: TgtImageItem;
	AOriginalWidth, AOriginalHeight: Double): Boolean;
begin
  Result := False;
  with AObject do
  begin
    if OutputImageFormat = Settings.OutputImageFormat then
    begin
      if (OutputImageFormat = ifJPEG) and
        (JPEGQuality <> Settings.JPEGQuality) then Exit;
    end
    else Exit;
    if (ImagePixelFormat <> Settings.ImagePixelFormat) then Exit;
    if (SourceDPI <> Settings.SourceDPI) then Exit;
    if (AutoSize <> Settings.AutoSize) then Exit;
    if (Stretch <> Settings.Stretch) then
    begin
      if (Stretch) then
      begin
        if ((Width <> AOriginalWidth) or (Height <> AOriginalHeight)) then Exit
        else
        begin
          Result := True;
          Exit;
        end;
      end
      else
      begin
        if ((ImageWidth <> AOriginalWidth) or
        		(ImageHeight <> AOriginalHeight)) then
        	Exit
        else
        begin
          Result := True;
          Exit;
        end;
      end;
    end
    else if (Stretch) and (Settings.Stretch) then
    begin
      Result := True;
      Exit;
    end;
    if Center <> Settings.Center then
    begin
      if (ImageWidth <> Width) or (ImageHeight <> Height) or
          (ImageWidth <> AOriginalWidth) or
          (ImageHeight <> AOriginalHeight) then
        Exit;
    end
    else if (Center) and (Settings.Center) then
    begin
      if ((ImageWidth = AOriginalWidth) and
      	(ImageHeight = AOriginalHeight)) then
      begin
        if ((Width < AOriginalWidth) or (Height < AOriginalHeight)) then Exit;
      end
      else
      begin
        if ((ImageWidth <> Width) or (ImageHeight <> Height)) then Exit;
      end;
    end;
    if ((ImageWidth <> Width) or (ImageHeight <> Height)) then Exit;
    Result := True;
  end;
end;

procedure TgtSVGImageSettings.SetDispHeight(const Value: Double);
begin
  FDispHeight := Value;
end;

procedure TgtSVGImageSettings.SetDispWidth(const Value: Double);
begin
  FDispWidth := Value;
end;

procedure TgtSVGImageSettings.SetFileName(const Value: String);
begin
	FFileName := Value;
end;

procedure TgtSVGImageSettings.SetImageHeight(const Value: Double);
begin
  FImageHeight := Value;
end;

procedure TgtSVGImageSettings.SetImageWidth(const Value: Double);
begin
  FImageWidth := Value;
end;

end.
