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

{$I gtDefines.inc}
{$I gtDocDefines.inc}
{ .$DEFINE ONEView }

unit gtRTFEng;

interface

uses
  Classes, SysUtils, Windows, Graphics, Printers, Dialogs, Math, gtCstDocEng,
  gtCstPlnEng,
  gtUtils3, gtConsts3, gtDocConsts, gtDocResStrs, gtDocUtils, gtClasses3;

type

  TgtRTFEncodingType = (etPositionalAccuracy, etEaseOfEditing);

  { TgtRTFPreferences }

  TgtRTFPreferences = class(TgtPlainSheetPreferences)
  private
    FGraphicDataInBinary: Boolean;
    FMetafileAsImage: Boolean;
    procedure SetGraphicDataInBinary(const Value: Boolean);
    procedure SetMetafileAsImage(const Value: Boolean);
  published
    property GraphicDataInBinary: Boolean read FGraphicDataInBinary
      write SetGraphicDataInBinary;
    property MetafileAsImage: Boolean read FMetafileAsImage
      write SetMetafileAsImage default False;
  end;

  TgtTabItem = class(TgtDocumentItem)
  private
    FBeforeSpace: Double;
    FLineSpacing: Double;
    FDefaultTabStop: Double;
    FTextList: TStringList;
    FTabStopList: TList;
    FFont: TFont;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtBookmarkItem = class(TgtDocumentItem)
  private
    FName: String;
    FX: Double;
    FY: Double;
  end;

  TgtRTFEngine = class(TgtCustomPlainSheetEngine)
  private
    FRTFStream: TMemoryStream;
    FHeaderStream: TMemoryStream;
    FFooterStream: TMemoryStream;
    FOutputStream: TStream;
    FColorTable: TStrings;
    FFontTable: TStrings;
    FRTFFactor: Double;
    FTabItem: TgtTabItem;
    FIsTabStarted: Boolean;
    FDefaultTabStop: Double;
    FDocumentEncodingType: TgtRTFEncodingType;
    FCheckRepeatText: String;
    FRepeatTextX: Double;
    FRepeatTextY: Double;
    FRemoveDuplicates: Boolean;
    FCountTextItem: Integer;
    FRepeatedText: TList;

    { local functions }
    function AddFontInfoToFontTable(AFont: TFont): Integer;
    function AddColorInfoToColorTable(AColor: TColor): Integer;
    function NativeText(const Text: String): String;
    function GetLineAttrib(APen: TPen): String;
    function GetShapeFillAttrib(ABrush: TBrush): String;
    function GetCharacterShade(ABrush: TBrush): String;
    function GetShadeAttrib(ABrush: TBrush): String;
    function GetFrameAttrib(APen: TPen; AFrame: TgtFrame): String;
    function GetParaBrdrInfo(AWidth: Integer; AColor: TColor;
      AStyle: TPenStyle): String;
    function GetFontAttrib(AFont: TFont): String;
    function GetAlignment(HAlign: TgtHAlignment): String;
    function GetLinkTextAttrib(Text: String): String;
    function GetBmpHeader(AStream: TMemoryStream; ABitmap: TBitmap): String;
    function EncodeGraphic(AObject: TgtImageItem): String;
    procedure WriteToRTFStream(Text: String);
    procedure SetBackgroundDisplayType(const Value: TgtBackgroundDisplayType);
    procedure SetTabStop(const Value: Double);
    procedure SetDocumentEncodingType(const Value: TgtRTFEncodingType);
    function GetPreferences: TgtRTFPreferences;
    procedure SetPreferences(const Value: TgtRTFPreferences);
    function WriteBackgroundImage: String;
    function ConvertToMultibyte(pw: PWideChar): String;
    function GetRemoveDuplicates: Boolean;
    procedure SetRemoveDuplicates(const Value: Boolean);
    // function RTFUnicode(AParam: string): string;
  protected
    procedure Start; override;
    procedure BeginPage; override;
    procedure EndPage; override;
    procedure Finish; override;
    procedure AdjustTextItemList(AList: TList); override;

{$IFNDEF gtRegistered}
    procedure PutTrialNote; override;
{$ENDIF}
    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeTextBox(AObject: TgtTextBoxItem); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeParagraph(AObject: TgtParagraphItem); override;
    procedure EncodeTable(AObject: TgtTableItem); override;
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); override;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
      IsClosed: Boolean; Pen: TPen; Brush: TBrush); override;
    procedure EncodePolyBezier(Points: TgtPoints; NoPoints: Integer;
      Pen: TPen); override;
    procedure EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap); override;
    procedure EncodeCustomItem(AObject: TgtDocumentItem); override;
    procedure EncodePageBorder; override;

    procedure ProcessTextList(AList: TList); override;
    function CheckOutputImageFormat(Value: TgtOutputImageFormat; var S: String)
      : Boolean; override;
    function ShowSetupModal: Word; override;
    function GetPreferencesClassName: TgtPreferencesClass; override;
    procedure ProcessMetafile(AX, AY: Double; AMetafile: TMetafile); override;
    function ReplacePageInfo(AText: WideString): WideString; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginPara; override;

    procedure BeginTab;
    function TextOut(Text: WideString): Double; override;
    procedure EndTab;
    procedure InsertTabStop(Value: array of Double);
    procedure SetDefaultTabStop(Value: Double);
    procedure InsertBookmark(BookmarkName: String; X, Y: Double);

    property DefaultTabStop: Double read FDefaultTabStop write SetTabStop;

  published
    property FileExtension;
    Property FileDescription;
    property BackgroundImage;
    property BackgroundImageDisplayType write SetBackgroundDisplayType;
    property DocumentEncodingType: TgtRTFEncodingType read FDocumentEncodingType
      write SetDocumentEncodingType;

    property Preferences: TgtRTFPreferences read GetPreferences
      write SetPreferences;
    property RemoveDuplicates: Boolean read GetRemoveDuplicates
      write SetRemoveDuplicates default False;
  end;

implementation

uses gtRTFEngDlg;

const

  Bold: array [Boolean] of String = ('', ' \b');
  Italic: array [Boolean] of String = ('', ' \i');
  StrikeOut: array [Boolean] of String = ('', ' \strike');
  UnderLine: array [Boolean] of String = ('', ' \ul');

ANSIFontCharsetIDs:
array [0 .. 15] of record FontCharset: Integer;
WinCode:
Integer;
end
= ((FontCharset: 0; WinCode: 1252), { Latin 1 (US, Western Europe) }
  (FontCharset: 128; WinCode: 932), { Japanese }
  (FontCharset: 129; WinCode: 949), { Korean }
  (FontCharset: 130; WinCode: 1361), { DBCS,  Korean }
  (FontCharset: 134; WinCode: 936), { Chinese (PRC, Singapore) }
  (FontCharset: 136; WinCode: 950), { Chinese (Taiwan, Hong Kong) }
  (FontCharset: 161; WinCode: 1253), { Greek }
  (FontCharset: 162; WinCode: 1254), { Turkish }
  (FontCharset: 163; WinCode: 1258), { Vietnamese }
  (FontCharset: 177; WinCode: 1255), { Hebrew }
  (FontCharset: 178; WinCode: 1256), { Latin/Arabic }
  (FontCharset: 186; WinCode: 1257), { Baltic }
  (FontCharset: 204; WinCode: 1251), { Cyrillic(Slavic) }
  (FontCharset: 222; WinCode: 874), { Thai }
  (FontCharset: 238; WinCode: 1250), { Eastern European }
  (FontCharset: 0; WinCode: 1200) { Unicode (BMP of ISO 10646) }
  );
CANSIWinCode = 1252;

{ TgtRTFEngine }

function TgtRTFEngine.AddColorInfoToColorTable(AColor: TColor): Integer;
var
  S: String;
begin
  S := ColorToString(AColor);
  Result := FColorTable.IndexOf(S);
  if Result = -1 then
    Result := FColorTable.AddObject(S, TObject(AColor));
  Inc(Result);
end;

function TgtRTFEngine.AddFontInfoToFontTable(AFont: TFont): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FFontTable.Count - 1 do
  begin
    if (FFontTable[I] = AFont.Name) and
      (TFontCharset(FFontTable.Objects[I]) = AFont.Charset) then
    begin
      Result := I;
      Break;
    end;
  end;
  if Result = -1 then
    Result := FFontTable.AddObject(AFont.Name, TObject(AFont.Charset));
end;

constructor TgtRTFEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'rtf';
  FileDescription := SRTFDescription;
  Capabilities := [ckImage, ckText, ckShape, ckHeader, ckFooter, ckWatermark];
  FDocumentEncodingType := etPositionalAccuracy;
  ImageSettings.OutputImageFormat := ifJPEG;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 102);
{$ENDIF}
  FCheckRepeatText := '';
  FRepeatTextX := 0;
  FRepeatTextY := 0;
end;

destructor TgtRTFEngine.Destroy;
begin

  inherited;
end;

procedure TgtRTFEngine.EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  LS: String;
  LATemp: AnsiString;
begin
  LS := '{\*\do\dobxpage\dobypage\dpellipse' + '\dpx' +
    IntToStr(Round(X1 * FRTFFactor)) + '\dpy' + IntToStr(Round(Y1 * FRTFFactor))
    + '\dpxsize' + IntToStr(Round((X2 - X1) * FRTFFactor)) + '\dpysize' +
    IntToStr(Round((Y2 - Y1) * FRTFFactor));
  LS := LS + GetLineAttrib(Pen);
  if Brush <> nil then
    LS := LS + GetShapeFillAttrib(Brush);
  LS := '{\lang1024 ' + LS + '}}';
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
end;

function TgtRTFEngine.EncodeGraphic(AObject: TgtImageItem): String;
var
  LS2, LTemp, LBmpHeader: String;
  // Changes should be tested as per the request of the customer
  // LS2: AnsiString;
  // LTemp, LBmpHeader: String;
  LStream: TMemoryStream;
  LBitmap: TBitmap;
  LMetafile: TMetafile;
  LWidth, LHeight: Integer;
begin
  LBitmap := nil;
  LMetafile := nil;
  Result := '';
  with AObject do
  begin
    case Settings.OutputImageFormat of
      ifJPEG:
        begin
          Result := Result + '\jpegblip';
          LBitmap := GetImageAsBitmap(AObject);
          LStream := TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, True,
            Settings.JPEGQuality));
          LStream.Position := 0;
        end;
      ifMetafile:
        begin
          Result := Result + '\emfblip';
          LMetafile := GetImageAsMetafile(AObject);
          LStream := TMemoryStream.Create;
          LMetafile.SaveToStream(LStream);
          LStream.Position := 0;
        end;
      ifPNG:
        begin
          Result := Result + '\pngblip';
          LBitmap := GetImageAsBitmap(AObject);
          LStream := TMemoryStream(GetBitmapAsPNGStream(LBitmap, clWhite));
          LStream.Position := 0;
        end;
    else
      begin
        Result := Result + '\wmetafile8';
        LBitmap := GetImageAsBitmap(AObject);
        LStream := TMemoryStream.Create;
        LBmpHeader := GetBmpHeader(LStream, LBitmap);
      end;
    end;
    if Settings.OutputImageFormat = ifMetafile then
    begin
      LWidth := LMetafile.Width;
      LHeight := LMetafile.Height;
    end
    else
    begin
      // For handling images in different DPI
      if (Settings.SourceDPI <> -1) then
      begin
        LWidth := Round(LBitmap.Width * (CPixelsPerInch / Settings.SourceDPI));
        LHeight :=
          Round(LBitmap.Height * (CPixelsPerInch / Settings.SourceDPI));
      end
      else
      begin
        LWidth := LBitmap.Width;
        LHeight := LBitmap.Height;
      end;
    end;

    Result := Result + '\picw' + IntToStr(Round(LWidth * FRTFFactor)) + '\pich'
      + IntToStr(Round(LHeight * FRTFFactor)) +
    // '\picwgoal' + IntToStr(Round(Width * FRTFFactor)) +
    // '\pichgoal' + IntToStr(Round(Height * FRTFFactor)) +
      '\picscalex' + IntToStr(Round(Width / LWidth * 100)) + '\picscaley' +
      IntToStr(Round(Height / LHeight * 100));

    with LStream do
    begin
      SetLength(LS2, Size - Position);
      Read(LS2[1], Size - Position);
    end;

    Result := Result + '\picbmp\picbpp4 ';

    if (Preferences.GraphicDataInBinary) and
      (Settings.OutputImageFormat <> ifBMP) then
      Result := Result + '\bin' + IntToStr(Length(LS2)) + ' ' + LS2
    else
    begin
      SetLength(LTemp, 2 * Length(LS2));
      BinToHex(PChar(LS2), PChar(LTemp), Length(LS2));
      Result := Result + LBmpHeader + LTemp + '030000000000';
    end;
  end;
  FreeAndNil(LStream);
  if LBitmap <> nil then
    FreeAndNil(LBitmap);
  if LMetafile <> nil then
    FreeAndNil(LMetafile);
end;

procedure TgtRTFEngine.EncodeImage(AObject: TgtImageItem);
var
  LS, LS2: String;
begin
  with AObject do
  begin
    LS2 := EncodeGraphic(AObject);
    with AObject.DisplayRect do
      LS := '{\pard\pvpg\phpg' + '\absw' +
        IntToStr(Round((Right - Left) * FRTFFactor)) + '\absh' +
        IntToStr(Round((Bottom - Top) * FRTFFactor)) + '\posx' +
        IntToStr(Round(X * FRTFFactor)) + '\posy' +
        IntToStr(Round(Y * FRTFFactor)) + '\overlay';

    if Settings.IsFrame then
      LS := LS + GetFrameAttrib(Pen, Frame);
    LS := LS + GetShadeAttrib(Brush);
    LS := LS + '{\pict';
    LS := LS + LS2 + '}\par}';
    WriteToRTFStream(LS);
  end;
end;

procedure TgtRTFEngine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
  LS: String;
  LATemp: AnsiString;
{$IFDEF ONEView}
  LX, LY: Double;
{$ENDIF}
begin
{$IFDEF ONEView}
  if (X2 < X1) then
  begin
    LX := X2;
    LY := Y2;
    X2 := X1;
    Y2 := Y1;
    X1 := LX;
    Y1 := LY;
  end;
  if (X1 > (Page.Width - Page.LeftMargin)) then
    Exit;
  if (X2 > (Page.Width - Page.LeftMargin)) then
    X2 := (Page.Width - Page.LeftMargin);
{$ENDIF}
  LS := '{\*\do\dobxpage\dobypage\dpline';
  LS := LS + '\dpx' + IntToStr(Round(X1 * FRTFFactor)) + '\dpy' +
    IntToStr(Round(Y1 * FRTFFactor)) + '\dpxsize' +
    IntToStr(Round((X2 - X1) * FRTFFactor)) + '\dpysize' +
    IntToStr(Round((Y2 - Y1) * FRTFFactor));
  LS := LS + GetLineAttrib(Pen) + '}';
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
end;

procedure TgtRTFEngine.EncodeParagraph(AObject: TgtParagraphItem);
var
  LS, LSettings, LBorder: String;
  I: Integer;
begin
  with AObject do
  begin
    for I := 0 to Lines.Count - 1 do
    begin
      (* For unicode characters *)
      if not((Font.Charset = ANSI_CHARSET) or ((Font.Charset = DEFAULT_CHARSET)
        and (GetACP = CANSIWinCode))) then
        LS := LS + ConvertToMultibyte(PWideChar(Lines[I]))
      else
        LS := LS + NativeText(Lines[I]);
      LS := ReplacePlaceHolders(LS, True);
    end;
    if Lines.Count > 1 then
    begin
      if Copy(LS, Length(LS) - 1, 2) = CRLF then
        System.Delete(LS, Length(LS) - 1, 2);
      LS := ReplaceString(LS, CRLF, '\par ');
    end;

    with Settings do
    begin
      LSettings := '\fi' + IntToStr(Round(FirstLineIndent * FRTFFactor)) + '\li'
        + IntToStr(Round(LeftIndent * FRTFFactor)) + '\ri' +
        IntToStr(Round(RightIndent * FRTFFactor)) + '\sb' +
        IntToStr(Round(BeforeSpace * FRTFFactor)) + '\sl-' +
        IntToStr(Round(LineSpacing * TextSize('W', Font).cy * FRTFFactor)) +
        '\slmult0';
    end;

    (*
      with Settings do
      begin
      LSettings := '\pard\pvpg\phpg' +
      '\absw'+ IntToStr(Round(Width * FRTFFactor)) +
      '\posx'+ IntToStr(Round(LeftIndent * FRTFFactor)) +
      '\posy'+ IntToStr(Round(BeforeSpace * FRTFFactor)) + '\overlay';
      end;
    *)

    with Settings.Border do
    begin
      LBorder := GetParaBrdrInfo(Width, Color, Style) + '\brsp' +
        IntToStr(Round(SpaceFromText * FRTFFactor));
      if DrawLeft then
        LSettings := LSettings + '\brdrl' + LBorder;
      if DrawRight then
        LSettings := LSettings + '\brdrr' + LBorder;
      if DrawTop then
        LSettings := LSettings + '\brdrt' + LBorder;
      if DrawBottom then
        LSettings := LSettings + '\brdrb' + LBorder;
      if DrawTop or DrawBottom then
        LSettings := LSettings + '\brdrbtw' + LBorder;
    end;

    if LS <> '' then
    begin
      LS := '{' + '\pard' + GetAlignment(Settings.Alignment) + LSettings +
        GetCharacterShade(Brush) + GetFontAttrib(Font) + ' ' +
        GetLinkTextAttrib(LS) + '\par' + '}';
      WriteToRTFStream(LS);
    end;
  end;
end;

procedure TgtRTFEngine.EncodePolyBezier(Points: TgtPoints; NoPoints: Integer;
  Pen: TPen);
begin
  EncodePolyLine(Points, NoPoints, False, Pen, nil);
end;

procedure TgtRTFEngine.EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
  IsClosed: Boolean; Pen: TPen; Brush: TBrush);
var
  LS: String;
  I: Integer;
  X1, Y1, X2, Y2: Double;
  LATemp: AnsiString;
begin
  LS := '{\*\do\dobxpage\dobypage';
  if IsClosed then
    LS := LS + '\dppolygon'
  else
    LS := LS + '\dppolyline';
  LS := LS + '\dppolycount' + IntToStr(NoPoints);
  X1 := 0;
  Y1 := 0;
  X2 := 0;
  Y2 := 0;
  for I := 0 to NoPoints - 1 do
  begin
    if I = 0 then
    begin
      X1 := Points[I].X;
      Y1 := Points[I].Y;
    end;

    if X1 > Points[I].X then
      X1 := Points[I].X;
    if X2 < Points[I].X then
      X2 := Points[I].X;

    if Y1 > Points[I].Y then
      Y1 := Points[I].Y;
    if Y2 < Points[I].Y then
      Y2 := Points[I].Y;

  end;
  for I := 0 to NoPoints - 1 do
    LS := LS + '\dpptx' + IntToStr(Round((Points[I].X - X1) * FRTFFactor)) +
      '\dppty' + IntToStr(Round((Points[I].Y - Y1) * FRTFFactor));

  LS := LS + '\dpx' + IntToStr(Round(X1 * FRTFFactor)) + '\dpy' +
    IntToStr(Round(Y1 * FRTFFactor)) + '\dpxsize' +
    IntToStr(Round((X2 - X1) * FRTFFactor)) + '\dpysize' +
    IntToStr(Round((Y2 - Y1) * FRTFFactor));

  LS := LS + GetLineAttrib(Pen);
  if Brush <> nil then
    LS := LS + GetShapeFillAttrib(Brush);
  LS := '{\lang1024 ' + LS + '}}';
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
end;

procedure TgtRTFEngine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  LS: String;
begin
  LS := '{\*\do\dobxpage\dobypage\dprect' + '\dpx' +
    IntToStr(Round(X1 * FRTFFactor)) + '\dpy' + IntToStr(Round(Y1 * FRTFFactor))
    + '\dpxsize' + IntToStr(Round((X2 - X1) * FRTFFactor)) + '\dpysize' +
    IntToStr(Round((Y2 - Y1) * FRTFFactor));
  LS := LS + GetLineAttrib(Pen);

  if (Brush <> nil) then
    LS := LS + GetShapeFillAttrib(Brush);
  LS := '{\lang1024 ' + LS + '}}';
  WriteToRTFStream(LS);
end;

procedure TgtRTFEngine.EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  Pen: TPen; Brush: TBrush);
var
  LS: String;
  LATemp: AnsiString;
begin
  LS := '{\*\do\dobxpage\dobypage\dprect\dproundr' + '\dpx' +
    IntToStr(Round(X1 * FRTFFactor)) + '\dpy' + IntToStr(Round(Y1 * FRTFFactor))
    + '\dpxsize' + IntToStr(Round((X2 - X1) * FRTFFactor)) + '\dpysize' +
    IntToStr(Round((Y2 - Y1) * FRTFFactor));
  LS := LS + GetLineAttrib(Pen);
  if Brush <> nil then
    LS := LS + GetShapeFillAttrib(Brush);
  LS := '{\lang1024 ' + LS + '}}';
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
end;

procedure TgtRTFEngine.EncodeTable(AObject: TgtTableItem);

  function GetCellShading(ABrush: TBrush): String;
  const
    LBrushStyle: array [TBrushStyle] of String = ('\clshdng10000', '\clshdng0',
      '\clbghoriz', '\clbgvert', '\clbgfdiag', '\clbgbdiag', '\clbgcross',
      '\clbgdcross');
  begin
    Result := LBrushStyle[ABrush.Style] + '\clcfpat' +
      IntToStr(AddColorInfoToColorTable(ABrush.Color)) + '\clcbpat' +
      IntToStr(AddColorInfoToColorTable(clWhite));
  end;

var
  I, J, K, L: Integer;
  LS, LS1, LS2, LText, LIntital: String;
  LCellRight: Double;
  LDocItem: TgtDocumentItem;
  LPen: TPen;
  LBrush: TBrush;
  LFont: TFont;
  LFrame: TgtFrame;
  LI, SrtPa, SrtRn, CuRn: Integer;
  LAlign: TgtHAlignment;
begin
  { LS1 - Table formating informn, LS2 - Actual Data }
  LPen := TPen.Create;
  LBrush := TBrush.Create;
  LFont := TFont.Create;
  LFrame := TgtFrame.Create(Self);
  LI := 0;
  FTablenumber := LI;
  while (TableOnLastpage[LI] = True) do
  begin
    LI := LI + 1;
    FTablenumber := LI;
  end;
  SrtPa := RowsOnPage[FTablenumber][0]; // Starting page number
  SrtRn := 0;
  CuRn := RowsOnPage[FTablenumber][(CurrentPage - SrtPa) + 1];
  // Number of rows on current page
  LI := 1;
  while (LI < (CurrentPage - SrtPa) + 1) do
  begin
    SrtRn := SrtRn + RowsOnPage[FTablenumber][LI];
    LI := LI + 1;
  end;
  if (CurrentPage = SrtPa) then
  begin
    if (AObject.Settings.EnableTitle) then
    begin
      SrtRn := -1;
      CuRn := CuRn + 1;
    end;
  end;
  if (CurrentPage = SrtPa + 1) then
  begin
    AObject.Y := Page.TopMargin + Page.HeaderHeight;
  end;
  if (RowsOnPage[FTablenumber][(CurrentPage - SrtPa) + 1 + 1] = 0) then
    TableOnLastpage[FTablenumber] := True
  else
    TableOnLastpage[FTablenumber] := False;
  with AObject do
  begin

    LS := '{';
    I := SrtRn;
    while (I <= SrtRn + CuRn - 1) do
    begin
      LCellRight := 0;
      LS2 := '';

      LS1 := '\pard\trowd\trgaph50\trqc';
      if I = -1 then
        LS1 := LS1 + '\trrh' +
          IntToStr(Round(Settings.TitleHeight * FRTFFactor))
      else
        LS1 := LS1 + '\trrh' +
          IntToStr(Round(Int64(RowHeights[I]) * FRTFFactor));
      LS1 := LS1 + '\trql\trkeep';

      for J := 0 to ColCount - 1 do
      begin

        LPen.Assign(Pen);
        LBrush.Assign(Brush);
        LFont.Assign(Font);
        LFrame.IsLeft := True;
        LFrame.IsTop := True;
        LFrame.IsRight := True;
        LFrame.IsBottom := True;
{$IFDEF gtActiveX}
        if Assigned(OnCellDraw) then
          OnCellDraw(Self, I, J, LPen, LBrush, LFont, LFrame);
        if Assigned(OnCellDrawEx) then
          OnCellDrawEx(Self, I, J, LPen, LBrush, LFont, LFrame, LAlign);
{$ELSE}
        if Assigned(OnCellDraw) then
          OnCellDraw(Self, I, J, LPen, LBrush, LFont, LFrame, LAlign);
{$ENDIF}
        LCellRight := LCellRight + Columns[J].Width;
        if LFrame.IsLeft then
          LS1 := LS1 + '\clbrdrl' + GetFrameAttrib(LPen, nil);
        if LFrame.IsTop then
          LS1 := LS1 + '\clbrdrt' + GetFrameAttrib(LPen, nil);
        if LFrame.IsRight then
          LS1 := LS1 + '\clbrdrr' + GetFrameAttrib(LPen, nil);
        if LFrame.IsBottom then
          LS1 := LS1 + '\clbrdrb' + GetFrameAttrib(LPen, nil);
        LS1 := LS1 + GetCellShading(LBrush) + '\clvertalc\cellx' +
          IntToStr(Round(LCellRight * FRTFFactor)) + ' ';

        if J = 0 then
        begin
          LS2 := LS2 + '\pard\intbl\pvpg\phpg\posx' +
            IntToStr(Round(X * FRTFFactor)) + '\posy' +
            IntToStr(Round(Y * FRTFFactor));
          LIntital := '';
        end
        else
          LIntital := '\pard\intbl';
        // All columns inherit from previous columns

        if (I = -1) then
        begin
          if Settings.EnableTitle then
          begin
            LS2 := LS2 + LIntital + GetAlignment(Columns[J].Alignment) + '{' +
              GetFontAttrib(LFont) + ' ';
            (* For unicode characters *)
            if not((Font.Charset = ANSI_CHARSET) or
              ((Font.Charset = DEFAULT_CHARSET) and
              (GetACP = CANSIWinCode))) then
              LS2 := LS2 + GetLinkTextAttrib
                (ConvertToMultibyte(PWideChar(Columns[J].Title))) + '}\cell'
            else
              LS2 := LS2 + GetLinkTextAttrib(NativeText(Columns[J].Title))
                + '}\cell';
          end;
        end
        else
        begin
          K := 0;
          while K <= RowItemsList[I].Count - 1 do
          begin
            LDocItem := TgtDocumentItem(RowItemsList[I].Items[K]);
            if (LDocItem is TgtTextItem) and (TgtTextItem(LDocItem).X = J) then
            begin
              with LDocItem as TgtTextItem do
              begin
                LText := '';
                for L := 0 to Lines.Count - 1 do
                  (* For unicode characters *)
                  if not((Font.Charset = ANSI_CHARSET) or
                    ((Font.Charset = DEFAULT_CHARSET) and
                    (GetACP = CANSIWinCode))) then
                    LText := LText + ConvertToMultibyte(PWideChar(Lines[L]))
                  else
                    LText := LText + NativeText(Lines[L]);

                if Lines.Count > 1 then
                begin
                  if Copy(LText, Length(LText) - 1, 2) = CRLF then
                    System.Delete(LText, Length(LText) - 1, 2);
                  LText := ReplaceString(LText, CRLF, '\par ');
                end;
                LS2 := LS2 + LIntital + GetAlignment(Columns[J].Alignment) + '{'
                  + GetCharacterShade(Brush) + GetFontAttrib(LFont) + ' ' +
                  GetLinkTextAttrib(LText) + '}\cell';
              end;
              Break;
            end
            else if (LDocItem is TgtImageItem) and
              (TgtImageItem(LDocItem).X = J) then
            begin
              TgtImageItem(LDocItem).Pen := LPen;
              TgtImageItem(LDocItem).Brush := LBrush;
              LS2 := LS2 + LIntital + '{\pict' +
                EncodeGraphic(TgtImageItem(LDocItem)) + '}\cell ';
              Break;
            end;
            Inc(K);
          end;
          if K = RowItemsList[I].Count then
            LS2 := LS2 + ' \cell';
        end;
      end;
      LS := LS + LS1 + '{' + LS2 + '} \pard\intbl{\row}';
      Inc(I);
    end;
    LS := LS + '\pard}';
  end;
  WriteToRTFStream(LS);
  LFont.Free;
  LFrame.Free;
  LPen.Free;
  LBrush.Free;
end;

function TgtRTFEngine.ConvertToMultibyte(pw: PWideChar): String;
var
  p: PChar;
  iLen, LI, LCharCode: Integer;
  LStr: String;
  // LChar: AnsiChar;
  LChar: String;
const
  FMaxCharCode: Integer = 32767;
  FMaxvalue: Integer = 65536;
begin
  LStr := '';
  iLen := lstrlenw(pw) + 1;
  GetMem(p, iLen);
  for LI := 0 to lstrlenw(pw) - 1 do
    if (Ord(pw[LI]) >= 256) then
    begin
      LCharCode := Ord(pw[LI]);
      if LCharCode > FMaxCharCode then
        LCharCode := LCharCode - FMaxvalue;
      // LChar := AnsiChar(pw[LI]);
      // if (LChar = '<') or (LChar = '>') then
      LChar := '?';
      LStr := LStr + '\u' + IntToStr(LCharCode)
      // + '\''' + IntToStr(Length(InttoStr(LCharCode)))
        + LChar;
    end
    else
      // LStr := LStr + ReplacePlaceHolders(NativeText(AnsiChar(pw[LI])), True);
      LStr := LStr + ReplacePlaceHolders(NativeText(String(pw[LI])), True);
  FreeMem(p, iLen);
  Result := LStr;
end;

procedure TgtRTFEngine.EncodeText(AObject: TgtTextItem);
var
  LS, LOriginalText: String;
  LBitmap: TBitmap;
  LIndex: Integer;
  LTextItem: TgtTextItem;
  LUnique: Boolean;
{$IFDEF ONEView}
  LTextWidth: Double;

  function GetTextForWidth(AWidth: Double): String;
  var
    LI: Integer;
  begin
    Result := '';
    with AObject do
      for LI := 1 to Length(Lines[0]) do
      begin
        if TextSize(Result, Font).cx <= AWidth then
          Result := Result + Lines[0][LI]
        else
          Break;
      end;
  end;
{$ENDIF}
  function GetTextForWidth(Text: WideString; AWidth: Double): String;
  var
    LI: Integer;
  begin
    Result := '';
    for LI := 1 to Length(Text) do
    begin
      if TextSize(Result, Font).cx <= AWidth then
        Result := Result + Text[LI]
      else
        Break;
    end;
  end;

  function GetCharForWidth(Text: WideString; Width: Double): Integer;
  var
    I: Integer;
    LWidth: Double;
  begin
    LWidth := 0;
    Result := 0;
    for I := 1 to Length(String(Text)) do
    begin
      LWidth := LWidth + TextWidth(Text[I]);
      if (LWidth >= Width) then
      begin
        Result := I - 1;
        Exit;
      end;
    end;
  end;

begin
  if FRemoveDuplicates then
  begin
    LUnique := True;
    if FCountTextItem = 1 then
    begin
      FRepeatedText.Add(AObject);
    end
    else
    begin
      for LIndex := 0 to (FRepeatedText.Count - 1) do
      begin
        LTextItem := TgtTextItem(FRepeatedText.Items[LIndex]);
        if ((AObject.Lines[0] = LTextItem.Lines[0]) and
          (AObject.X = LTextItem.X) and (AObject.Y = LTextItem.Y)) then
          LUnique := False;
      end;
      if not LUnique then
      begin
        Inc(FCountTextItem);
        Exit;
      end
      else
        FRepeatedText.Add(AObject);
    end;
    Inc(FCountTextItem);
  end;

  inherited;

  LOriginalText := AObject.Lines[0];


  { Temporary fix for repeated overlapping of text }
  if (FCheckRepeatText = AObject.Lines[0]) and (FRepeatTextX = AObject.X) and
    (FRepeatTextY = AObject.Y) then
    Exit;

  AObject.Lines[0] := ReplacePlaceHolders(AObject.Lines[0], True);
  if AObject.RotationAngle <> 0 then
  begin
    LBitmap := GetRotatedTextBitmap(AObject);
    EncodeShapeBitmap(AObject.X, AObject.Y, LBitmap);
    LBitmap.Free;
  end
  else
    with AObject do
    begin
{$IFDEF ONEView}
      LTextWidth := (Page.Width - X - Page.LeftMargin);
      if LTextWidth < 0 then
      begin
        LTextWidth := 0;
        Lines[0] := '';
      end;

      if (((X + Page.LeftMargin + TextSize(Lines[0], Font).cx) > (Page.Width))
        and (LTextWidth > 0)) then
        Lines[0] := GetTextForWidth(LTextWidth);
{$ENDIF}

      LS := LS + '{\pard\pvpg\phpg' + '\posy' + FloatToStr(Round(Y * FRTFFactor)
        ) + '\posx' + FloatToStr(Round(X * FRTFFactor)) + '\overlay' +
        GetFontAttrib(Font) + GetCharacterShade(Brush) + ' ';

      (* For clipping the text if 'AutoSize' of the textbox is set to 'False' *)
      if IsClipRect then
        LS := LS + '\absh-' +
          FloatToStr(Round((ClipRect.Bottom - ClipRect.Top) * FRTFFactor)) +
          '\absw' + FloatToStr(Round((ClipRect.Right - ClipRect.Left + 10) *
          FRTFFactor)) + ' ';

      (* For unicode characters *)
      if not((Font.Charset = ANSI_CHARSET) or ((Font.Charset = DEFAULT_CHARSET)
        and (GetACP = CANSIWinCode))) then
        LS := LS + GetLinkTextAttrib(ConvertToMultibyte(PWideChar(Lines[0])))
          + '\par}'
        (* For clipping the text if 'AutoSize' of the textbox is set to 'False' *)
      else if IsClipRect then
        LS := LS + GetLinkTextAttrib
          (ReplacePlaceHolders(NativeText(GetTextForWidth(LOriginalText,
          (ClipRect.Right - ClipRect.Left))), True)) + '\par}'
      else
        LS := LS+GetLinkTextAttrib(ConvertToMultibyte(PWideChar(Lines[0])))
          + '\par}';

      WriteToRTFStream(LS);
    end;

  FCheckRepeatText := AObject.Lines[0];
  FRepeatTextX := AObject.X;
  FRepeatTextY := AObject.Y;
  AObject.Lines[0] := LOriginalText;
end;

procedure TgtRTFEngine.EncodeTextBox(AObject: TgtTextBoxItem);
var
  LS: String;
  LOffsetY: Double;
  I, LCount: Integer;
  LUnicode: Boolean;
  LATemp: AnsiString;
begin
  LUnicode := False;
  with AObject do
  begin
    for I := 0 to Lines.Count - 1 do
    begin
      (* For Unicode *)
      LUnicode := not((Font.Charset = ANSI_CHARSET) or
        ((Font.Charset = DEFAULT_CHARSET) and (GetACP = CANSIWinCode)));
      if LUnicode then
        LS := LS + GetLinkTextAttrib(ConvertToMultibyte(PWideChar(Lines[I])))
      else
        LS := LS + GetLinkTextAttrib(NativeText(Lines[I]));
    end;

    if Lines.Count > 1 then
    begin
      if Copy(LS, Length(LS) - 1, 2) = CRLF then
        System.Delete(LS, Length(LS) - 1, 2);
      LS := ReplaceString(LS, CRLF, CRLF + '\par ');
    end;
    LS := GetLinkTextAttrib(LS);

    { calculate vertical alignment }
    LOffsetY := 0;
    case VAlign of
      vaBottom:
        LOffsetY := BoxHeight - Lines.Count * TextSize('W', Font).cy;
      vaCenter:
        LOffsetY := (BoxHeight - Lines.Count * TextSize('W', Font).cy) / 2;
    end;

    LCount := Trunc(LOffsetY / TextSize('W', Font).cy);
    for I := 1 to LCount do
      LS := '\par ' + LS;

    if LUnicode then
      LS := '{\shp{\*\shpinst\shpleft' + IntToStr(Round(X * FRTFFactor)) +
        '\shptop' + IntToStr(Round(Y * FRTFFactor)) + '\shpright' +
        IntToStr(Round((X + BoxWidth) * FRTFFactor)) + '\shpbottom' +
        IntToStr(Round((Y + BoxHeight) * FRTFFactor)) +
        '\shpfhdr0\shpbxcolumn\shpbxignore\shpbypara' +
        '\shpwr3\shpwrk0\shpfblwtxt0' + '{\sp{\sn shapeType}{\sv 1}}' +
        '{\sp{\sn fLayoutInCell}{\sv 1}}' + '{\shptxt \ltrpar \pard\plain' +
        '{\pard\ql' + GetFontAttrib(Font) + ' ' + LS + '\par}' + '}}\par}'
    else
      LS := '{\*\do\dobxpage\dobypage\dptxbx' + '\dptxbxmar' +
        IntToStr(Round(Frame.InternalMargin.Left * FRTFFactor)) + '\dpx' +
        IntToStr(Round(X * FRTFFactor)) + '\dpy' +
        IntToStr(Round(Y * FRTFFactor)) + '\dpxsize' +
        IntToStr(Round(BoxWidth * FRTFFactor)) + '\dpysize' +
        IntToStr(Round(BoxHeight * FRTFFactor)) + '{\dptxbxtext\pard' +
        GetAlignment(HAlign) + GetFontAttrib(Font) + ' ' + LS + '\par}';

    LS := LS + GetLineAttrib(Pen);
    if Brush <> nil then
      LS := LS + GetShapeFillAttrib(Brush);
    LS := '{\lang1024 ' + LS + '}}';
    LATemp := AnsiString(LS);
    FRTFStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtRTFEngine.EndPage;
var
  LS: String;
  LATemp: AnsiString;
begin
  if Assigned(FRepeatedText) then
    FRepeatedText.Free;
  if FHeaderStream.Size <> 0 then
  begin
    LS := '{\header ';
    LATemp := AnsiString(LS);
    FRTFStream.Write(LATemp[1], Length(LS));
    FRTFStream.CopyFrom(FHeaderStream, 0);
    LS := '}';
    LATemp := AnsiString(LS);
    FRTFStream.Write(LATemp[1], Length(LS));
    FHeaderStream.Clear;
  end;
  if FFooterStream.Size <> 0 then
  begin
    LS := '{\footer ';
    LATemp := AnsiString(LS);
    FRTFStream.Write(LATemp[1], Length(LS));
    FRTFStream.CopyFrom(FFooterStream, 0);
    LS := '}';
    LATemp := AnsiString(LS);
    FRTFStream.Write(LATemp[1], Length(LS));
    FFooterStream.Clear;
  end;
  LS := '}\sect'; // End section
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
  inherited;
end;

function TgtRTFEngine.NativeText(const Text: String): String;
begin
  Result := ReplaceString(Text, '\', '\\');
  Result := ReplaceString(Result, '{', '\{');
  Result := ReplaceString(Result, '}', '\}');
end;

function TgtRTFEngine.GetLineAttrib(APen: TPen): String;
var
  LColor: LongInt;
begin
  Result := '';
  case APen.Style of
    psDash:
      Result := '\dplinedash';
    psDot:
      Result := '\dplinedot';
    psDashDot:
      Result := '\dplinedado';
    psDashDotDot:
      Result := '\dplinedadodo';
    psClear:
      Result := '\dplinehollow';
  else
    Result := '\dplinesolid';
  end;
  LColor := ColorToRGB(APen.Color);
  Result := Result + '\dplinecor' + IntToStr(Byte(LColor)) + '\dplinecog' +
    IntToStr(Byte(LColor shr 8)) + '\dplinecob' + IntToStr(Byte(LColor shr 16))
    + '\dplinew' + IntToStr(Round(APen.Width * FRTFFactor)) + ' ';
end;

function TgtRTFEngine.GetShapeFillAttrib(ABrush: TBrush): String;
var
  LColor: LongInt;
const
  BrushStyle: array [TBrushStyle] of String = ('1', '0', '14', '15', '16', '17',
    '18', '19');
begin
  LColor := ColorToRGB(ABrush.Color);

  Result := '\dpfillfgcr255' + '\dpfillfgcg255' + '\dpfillfgcb255' +
    '\dpfillbgcr' + IntToStr(Byte(LColor)) + '\dpfillbgcg' +
    IntToStr(Byte(LColor shr 8)) + '\dpfillbgcb' + IntToStr(Byte(LColor shr 16))
    + '\dpfillpat' + BrushStyle[ABrush.Style] + ' ';
end;

function TgtRTFEngine.GetAlignment(HAlign: TgtHAlignment): String;
begin
  case HAlign of
    haRight:
      Result := '\qr';
    haCenter:
      Result := '\qc';
    haJustify:
      Result := '\qj';
  else
    Result := '\ql';
  end;
end;

function TgtRTFEngine.GetFontAttrib(AFont: TFont): String;
begin
  Result := '\f' + IntToStr(AddFontInfoToFontTable(AFont)) + '\cf' +
    IntToStr(AddColorInfoToColorTable(AFont.Color)) + '\fs' +
    IntToStr(Abs(AFont.Size) * 2) + Bold[fsBold in AFont.Style] +
    Italic[fsItalic in AFont.Style] + StrikeOut[fsStrikeOut in AFont.Style] +
    UnderLine[fsUnderLine in AFont.Style];
end;

function TgtRTFEngine.GetLinkTextAttrib(Text: String): String;
var
  LinkText, HyperLinkText: String;
  StartPos: Integer;
begin
  StartPos := 0;
  Result := Text;
  if (not Preferences.ActiveHyperLinks) then
    Exit;
  LinkText := GetHyperLinkText(Text, StartPos);
  while (LinkText <> '') and (LinkText <> CRLF) do
  begin
    HyperLinkText := '{\field' + '{\*\fldinst {HYPERLINK "';
    if (AnsiPos('http:', LinkText) = 0) and (AnsiPos('ftp:', LinkText) = 0) and
      (AnsiPos('@', LinkText) = 0) and (AnsiPos(':\', LinkText) = 0) then
      HyperLinkText := HyperLinkText + 'http://'
    else if (AnsiPos('@', LinkText) > 0) then
      HyperLinkText := HyperLinkText + 'mailto:'
    else if (AnsiPos(':\', LinkText) > 0) then
    begin
      LinkText := StringReplace(LinkText, '\\', '\\\\', [rfReplaceAll]);
      Result := StringReplace(Result, '\\', '\\\\', [rfReplaceAll]);
    end;
    HyperLinkText := HyperLinkText + LinkText + '"}}' + '{\fldrslt {' + '\ul\cf'
      + IntToStr(AddColorInfoToColorTable(16711680)) + ' ' +
      StringReplace(LinkText, '\\\\', '\\', [rfReplaceAll]) + '}}}';
    Result := ReplaceString(Result, LinkText, HyperLinkText);
    StartPos := StartPos + Length(LinkText) + 1;
    LinkText := GetHyperLinkText(Text, StartPos);
  end;
end;

function TgtRTFEngine.GetShadeAttrib(ABrush: TBrush): String;
begin
  case ABrush.Style of
    bsHorizontal:
      Result := '\bghoriz';
    bsVertical:
      Result := '\bgvert';
    bsFDiagonal:
      Result := '\bgfdiag';
    bsBDiagonal:
      Result := '\bgbdiag';
    bsCross:
      Result := '\bgcross';
    bsDiagCross:
      Result := '\bgdcross';
    bsSolid:
      Result := '\shading10000';
  else
    Exit;
  end;
  Result := Result + '\cfpat' +
    IntToStr(AddColorInfoToColorTable(ABrush.Color));
end;

procedure TgtRTFEngine.BeginPage;
var
  LS, LBorder: String;
  LATemp: AnsiString;
begin
  FRepeatedText := TList.Create();
  FCountTextItem := 1;
  inherited;
  with Pages[CurrentPage - 1].Settings do
  begin
    LS := LS + ' \sectd';
    // add ctrl word for page orientation
    if Orientation = poLandscape then
      LS := LS + '\lndscpsxn';
    LS := LS + '\pgwsxn' + IntToStr(Round(Width * FRTFFactor)) + '\pghsxn' +
      IntToStr(Round(Height * FRTFFactor)) + '\marglsxn' +
      IntToStr(Round(LeftMargin * FRTFFactor)) + '\margrsxn' +
      IntToStr(Round(RightMargin * FRTFFactor)) + '\margtsxn' +
      IntToStr(Round(TopMargin * FRTFFactor)) + '\margbsxn' +
      IntToStr(Round(BottomMargin * FRTFFactor));
    if Page.BinNumber <> 0 then
      LS := LS + '\binfsxn' + IntToStr(Page.BinNumber) + '\binsxn' +
        IntToStr(Page.BinNumber);
    LS := LS + '\headery' + IntToStr(Round(HeaderHeight * FRTFFactor)) +
      '\footery' + IntToStr(Round(FooterHeight * FRTFFactor)) +
      '\sectdefaultcl';
    with PageBorder do
    begin
      LBorder := GetParaBrdrInfo(Width, Color, Style);
      LS := LS + '\pgbrdrhead\pgbrdrfoot';
      if DrawLeft then
        LS := LS + '\pgbrdrl' + LBorder;
      if DrawRight then
        LS := LS + '\pgbrdrr' + LBorder;
      if DrawTop then
        LS := LS + '\pgbrdrt' + LBorder;
      if DrawBottom then
        LS := LS + '\pgbrdrb' + LBorder;
    end;
    LS := LS + CRLF + '{'
  end;
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
end;

function TgtRTFEngine.GetFrameAttrib(APen: TPen; AFrame: TgtFrame): String;
begin
  if APen.Style = psClear then
    Exit;
  case APen.Style of
    psDash:
      Result := '\brdrdash';
    psDot:
      Result := '\brdrdot';
    psDashDot:
      Result := '\brdrdashd';
    psDashDotDot:
      Result := '\brdrdashdd';
  else
    Result := '\brdrs';
  end;
  Result := Result + '\brdrw' + IntToStr(Round(Pen.Width * FRTFFactor));
  Result := Result + '\brdrcf' + IntToStr(AddColorInfoToColorTable(Pen.Color));
  if AFrame <> nil then
  begin
    if not AFrame.IsTop then
      Result := Result + '\brdrt';
    if not AFrame.IsRight then
      Result := Result + '\brdrr';
    if not AFrame.IsBottom then
      Result := Result + '\brdrb';
    if not AFrame.IsLeft then
      Result := Result + '\brdrl';
  end;
end;

procedure TgtRTFEngine.WriteToRTFStream(Text: String);
var
  LATemp: AnsiString;
begin
  if Length(Text) = 0 then
    Exit;
  LATemp := AnsiString(Text);
  if (FBandType = btHeader) or (FBandType = btWatermark) then
    FHeaderStream.Write(LATemp[1], Length(Text))
  else if FBandType = btFooter then
    FFooterStream.Write(LATemp[1], Length(Text))
  else
    FRTFStream.Write(LATemp[1], Length(Text));
end;

procedure TgtRTFEngine.EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap);
var
  LS, LS2, LTemp, LBmpHeader: String;
  LStream: TMemoryStream;
  LMetafile: TMetafile;
begin
  LMetafile := nil;
  LStream := nil;
  LS := '{\pard\pvpg\phpg' + '\posx' + IntToStr(Round(X * FRTFFactor)) + '\posy'
    + IntToStr(Round(Y * FRTFFactor)) + '\overlay';
  LS := LS + '{\pict';

  case ImageSettings.OutputImageFormat of
    ifJPEG:
      begin
        LS := LS + '\jpegblip';
        LStream := TMemoryStream(GetBitmapAsJPGGIFStream(Bitmap, True,
          ImageSettings.JPEGQuality));
        LStream.Position := 0;
      end;
    ifMetafile:
      begin
        LS := LS + '\emfblip';
        LMetafile := TMetafile.Create;
        LMetafile.Assign(Bitmap);
        LStream := TMemoryStream.Create;
        LMetafile.SaveToStream(LStream);
        LStream.Position := 0;
      end;
    ifPNG:
      begin
        LS := LS + '\pngblip';
        LStream := TMemoryStream(GetBitmapAsPNGStream(Bitmap, clWhite));
        LStream.Position := 0;
      end;
  else
    begin
      LS := LS + '\wmetafile8';
      LStream := TMemoryStream.Create;
      LBmpHeader := GetBmpHeader(LStream, Bitmap);
    end;
  end;
  if ImageSettings.OutputImageFormat = ifMetafile then
    LS := LS + '\picw' + IntToStr(Round(LMetafile.Width * FRTFFactor)) + '\pich'
      + IntToStr(Round(LMetafile.Height * FRTFFactor))
  else
    LS := LS + '\picw' + IntToStr(Round(Bitmap.Width * FRTFFactor)) + '\pich' +
      IntToStr(Round(Bitmap.Height * FRTFFactor));

  with LStream do
  begin
    SetLength(LS2, Size - Position);
    Read(LS2[1], Size - Position);
  end;

  LS := LS + '\picbmp\picbpp4 ';

  if (Preferences.GraphicDataInBinary) and
    (ImageSettings.OutputImageFormat <> ifBMP) then
    LS := LS + '\bin' + IntToStr(Length(LS2)) + ' ' + LS2 + '}\par}'
  else
  begin
    SetLength(LTemp, 2 * Length(LS2));
    BinToHex(PChar(LS2), PChar(LTemp), Length(LS2));
    LS := LS + LBmpHeader + LTemp + '030000000000' + '}\par}';
  end;

  WriteToRTFStream(LS);
  FreeAndNil(LStream);
  if LMetafile <> nil then
    FreeAndNil(LMetafile);
end;

function TgtRTFEngine.GetBmpHeader(AStream: TMemoryStream;
  ABitmap: TBitmap): String;
var
  I: Integer;
begin
  ABitmap.SaveToStream(AStream);
  AStream.Position := 2;
  AStream.Read(I, 4);
  I := I div 2 + 7;
  Result := '010009000003' + RevHexBytes(IntToHex(I + $24, 8)) + '0000' +
    RevHexBytes(IntToHex(I, 8)) + '0000050000000b0200000000050000000c02' +
    RevHexBytes(IntToHex(ABitmap.Height, 4)) +
    RevHexBytes(IntToHex(ABitmap.Width, 4)) +
    '05000000090200000000050000000102ffffff000400000007010300' +
    RevHexBytes(IntToHex(I, 8)) + '430f2000cc000000' +
    RevHexBytes(IntToHex(ABitmap.Height, 4)) +
    RevHexBytes(IntToHex(ABitmap.Width, 4)) + '00000000' +
    RevHexBytes(IntToHex(ABitmap.Height, 4)) +
    RevHexBytes(IntToHex(ABitmap.Width, 4)) + '00000000' + CRLF;
  AStream.Position := AStream.Position + 8;
end;

procedure TgtRTFEngine.SetBackgroundDisplayType(const Value
  : TgtBackgroundDisplayType);
begin
  if Value <> dtTile then
    inherited BackgroundImageDisplayType := Value
  else
    // MessageDlg(SUnsupportedBackgroundDisplayType, mtError, [mbOK], 0)
    raise ExUnsupportedBackgroundDisplayType.Create
      (ErrUnsupportedBackgroundDisplayType);
end;

function TgtRTFEngine.CheckOutputImageFormat(Value: TgtOutputImageFormat;
  var S: String): Boolean;
begin
  Result := False;
  if (Value in [ifBMP, ifJPEG, ifPNG, ifMetafile]) then
    Result := True
  else
    S := SUnsupportedRTFImageFormat;
end;

procedure TgtRTFEngine.BeginTab;
var
  LMasterUnit: TgtUnitType;
begin
  if not FIsDocumentStarted or FIsParagraphStarted then
    Exit;
  FIsTabStarted := True;
  FTabItem := TgtTabItem.Create;
  FTabItem.FFont.Assign(Font);
  LMasterUnit := MeasurementUnit;
  MeasurementUnit := muPixels;
  FTabItem.FBeforeSpace := TextFormatting.BeforeSpace;
  FTabItem.FLineSpacing := TextFormatting.LineSpacing;
  MeasurementUnit := LMasterUnit;
end;

procedure TgtRTFEngine.EndTab;
begin
  if FIsTabStarted then
  begin
    FIsTabStarted := False;
    FTabItem.FDefaultTabStop := DefaultTabStop;
    AddDocumentItem(FTabItem);
  end;
end;

function TgtRTFEngine.TextOut(Text: WideString): Double;
begin
  Result := -1;
  if FIsTabStarted then
    FTabItem.FTextList.Add(Text)
  else
    Result := inherited TextOut(Text);
end;

procedure TgtRTFEngine.BeginPara;
begin
  if FIsTabStarted then
    Exit;
  inherited;
end;

procedure TgtRTFEngine.InsertTabStop(Value: array of Double);
var
  I, LCount: Integer;
begin
  if not FIsTabStarted then
    Exit;
  LCount := SizeOf(Value) div SizeOf(Double);
  for I := 0 to LCount - 1 do
    FTabItem.FTabStopList.Add(TObject(Round(NativeXPos(Value[I]))));
end;

procedure TgtRTFEngine.SetDefaultTabStop(Value: Double);
begin
  if not FIsTabStarted then
    Exit;
  FTabItem.FDefaultTabStop := NativeXPos(Value);
end;

procedure TgtRTFEngine.EncodeCustomItem(AObject: TgtDocumentItem);
var
  I, LastTabPosn: Integer;
  LS, LSettings: String;
  LWidth: Double;
  LATemp: AnsiString;
begin
  inherited;
  if AObject is TgtBookmarkItem then
  begin
    with AObject as TgtBookmarkItem do
      LS := '{\*\bkmkstart ' + FName + '}' + '\plain\pvpg\phpg' + '\posy' +
        FloatToStr(Round(FY * FRTFFactor)) + '\posx' +
        FloatToStr(Round(FX * FRTFFactor)) + '\absw0\absh0' + '{\*\bkmkend ' +
        FName + '}';
    WriteToRTFStream(LS);
  end
  else if AObject is TgtTabItem then
    with AObject as TgtTabItem do
    begin
      LastTabPosn := 0;
      LS := LS + '\tqr';
      for I := 0 to FTabStopList.Count - 1 do
      begin
        if Int64(FTabStopList.Items[I]) > LastTabPosn then
          LastTabPosn := Int64(FTabStopList.Items[I]);
        LS := LS + '\tx' +
          IntToStr(Round(Int64(FTabStopList.Items[I]) * FRTFFactor));
      end;

      with Pages[CurrentPage - 1].Settings do
        LWidth := Width - LeftMargin - RightMargin;

      LastTabPosn := Round(Ceil(LastTabPosn / FDefaultTabStop) *
        FDefaultTabStop);
      while LastTabPosn < (LWidth) do
      begin
        LS := LS + '\tx' + IntToStr(Round(LastTabPosn * FRTFFactor));
        LastTabPosn := LastTabPosn + Round(FDefaultTabStop);
      end;

      LS := LS + CRLF;
      for I := 0 to FTextList.Count - 1 do
      begin
        LS := LS + NativeText(FTextList[I]);
        if (I <> FTextList.Count - 1) then
          LS := LS + '\tab ';
      end;

      LSettings := '\sb' + IntToStr(Round(FBeforeSpace * FRTFFactor)) + '\sl' +
        IntToStr(Round(FLineSpacing * TextSize('W', Font).cy * FRTFFactor)) +
        '\slmult0';

      LS := '{' + '\pard\keep\keepn' + LSettings + GetFontAttrib(FFont) +
        GetShadeAttrib(Brush) + GetLinkTextAttrib(LS) + '\par' + '}';
      LATemp := AnsiString(LS);
      FRTFStream.Write(LATemp[1], Length(LS));
    end;
end;

procedure TgtRTFEngine.SetTabStop(const Value: Double);
begin
  FDefaultTabStop := NativeXPos(Value);
end;

procedure TgtRTFEngine.ProcessTextList(AList: TList);
var
  YDisplacement, RealDisp, LX: Double;
  I: Integer;
  LTextItem: TgtTextItem;
  LOffset, LastY, LPrevX, CRepX, CRepY: Double;
  LS, LS1, LS2, CRepStrOld, CRepStrNew, LTempString: String;
  LTextWidth: Integer;
  TallFont, PrevLinefont: Extended;
  IsFirstLine: Boolean;
const
  CDiff: Integer = 8;
begin
  RealDisp := 0;
  if not(FBandType = btContent) then
    inherited
  else
  begin
    if AList.Count = 0 then
      Exit;
    IsFirstLine := True;
    LOffset := 0;
    LastY := LOffset;
    LPrevX := 0;
    LTextWidth := 0; // Temp
    I := 0;
    CRepX := 0;
    CRepY := 0;
    PrevLinefont := 0;
    // YDisplacement := 0;
    TallFont := TextSize(TgtTextItem(AList.Items[0]).Lines[0],
      TgtTextItem(AList.Items[0]).Font).cy;
    while I < AList.Count do
    begin
      LTextItem := TgtTextItem(AList.Items[I]);
      LTempString := GetLinkTextAttrib
        (ConvertToMultibyte(PWideChar(NativeText(LTextItem.Lines[0]))));
      CRepStrNew := GetLinkTextAttrib(NativeText(LTextItem.Lines[0]));
      // Check for repeated texts
      if ((Abs(CRepX - LTextItem.X) < CDiff) and (CRepY = LTextItem.Y) and
        (CRepStrOld = CRepStrNew)) then
        Inc(I)
      else
      begin
        if (LTextItem.Y > (LOffset)) then
        begin
          if LOffset <> FYFactor then
          begin
            // add sl-? value for lines other than last line
            YDisplacement :=
              Abs(LTextItem.Y - (Page.TopMargin * NativeConversionFactor));
            if not IsFirstLine then
            begin
              YDisplacement := Abs(LTextItem.Y - LastY);
              if ((RealDisp - PrevLinefont) <> 0) then
                if Abs(Round((RealDisp - PrevLinefont) * FRTFFactor)) > 45 then
                  LS := LS + '{\pard \sl-' +
                    IntToStr(8 + Abs(Round((RealDisp - PrevLinefont) *
                    FRTFFactor))) + '\par}'; // space between lines
              PrevLinefont := TallFont;
              LS := LS + '{\pard \sl-0' + LS1 + LS2 + '\par}';
            end;
            RealDisp := Abs(YDisplacement);
            TallFont := TextSize(TgtTextItem(AList.Items[I]).Lines[0],
              TgtTextItem(AList.Items[I]).Font).cy;
            IsFirstLine := False;
          end;
          LS1 := '';
          LS2 := '';
          LPrevX := 0;
          LTextWidth := 0; // Temp
          LOffset := Ceil(LTextItem.Y / FYFactor) * FYFactor;
          LastY := LOffset;
        end;
        with LTextItem do
        begin
          if Y < LastY then
            LastY := Y;
          if ((TextSize(TgtTextItem(AList.Items[I]).Lines[0],
            TgtTextItem(AList.Items[I]).Font).cy) > TallFont) then
          begin
            TallFont := TextSize(TgtTextItem(AList.Items[I]).Lines[0],
              TgtTextItem(AList.Items[I]).Font).cy;
          end;
          LX := X;
          X := X - (Page.LeftMargin * NativeConversionFactor) + 1;
          if X <= LPrevX + LTextWidth then // Temp
            X := LPrevX + LTextWidth + 1;

          LS1 := LS1 + '\tx' + IntToStr(Round(X * FRTFFactor));
          if (LX <= Page.LeftMargin) then
            LS2 := LS2 + '{' + GetCharacterShade(Brush) + GetFontAttrib(Font) +
              ' ' + LTempString + '}'
          else
            LS2 := LS2 + '{' + '\tab' + GetCharacterShade(Brush) +
              GetFontAttrib(Font) + ' ' + LTempString + '}';
          // temporaray condition
          LPrevX := X;
          LTextWidth := TextSize(Lines[0], Font).cx;
        end;
        CRepX := LTextItem.X;
        CRepY := LTextItem.Y;
        CRepStrOld := GetLinkTextAttrib(NativeText(LTextItem.Lines[0]));
        Inc(I);
      end;
    end;
    if (LS1 <> '') and (LS2 <> '') then
    begin
      // add sl-? value for last line here
      if ((RealDisp - PrevLinefont) <> 0) then
        if Abs(Round((RealDisp - PrevLinefont) * FRTFFactor)) > 45 then
          LS := LS + '{\pard \sl-' +
            IntToStr(8 + Abs(Round((RealDisp - PrevLinefont) * FRTFFactor))) +
            '\par}'; // space between lines
      LS := LS + '{\pard \sl-0' + LS1 + LS2 + '\par }';
    end;
  end;
  // LS:=RTFUnicode(LS); // changes to be tested     //changed
  WriteToRTFStream(LS);
end;

procedure TgtRTFEngine.SetDocumentEncodingType(const Value: TgtRTFEncodingType);
begin
  FDocumentEncodingType := Value;
end;

function TgtRTFEngine.GetCharacterShade(ABrush: TBrush): String;
begin
  if ABrush.Color <> clWhite then { To prevent shading for default Brush }
  begin
    case ABrush.Style of
      bsHorizontal:
        Result := '\chbgdkhoriz';
      bsVertical:
        Result := '\chbgdkvert';
      bsBDiagonal:
        Result := '\chbgdkfdiag';
      bsFDiagonal:
        Result := '\chbgdkbdiag';
      bsCross:
        Result := '\chbgdkcross';
      bsDiagCross:
        Result := '\chbgdkdcross';
      bsSolid:
        Result := '\chshdng10000';
    else
      Exit;
    end;
    Result := Result + '\chcfpat' +
      IntToStr(AddColorInfoToColorTable(ABrush.Color));
  end;
end;

procedure TgtRTFEngine.InsertBookmark(BookmarkName: String; X, Y: Double);
var
  LBookmarkItem: TgtBookmarkItem;
begin
  if not FIsDocumentStarted then
    Exit;
  LBookmarkItem := TgtBookmarkItem.Create;
  LBookmarkItem.FName := BookmarkName;
  LBookmarkItem.FX := NativeXPos(X);
  LBookmarkItem.FY := NativeXPos(Y);
  AddDocumentItem(LBookmarkItem);
end;

procedure TgtRTFEngine.Finish;
var
  LS: String;
  LATemp: AnsiString;
  function MakeColorTable: String;
  var
    I: Integer;
    LColor: LongInt;
  begin
    Result := '';
    for I := 0 to FColorTable.Count - 1 do
    begin
      LColor := ColorToRGB(TColor(FColorTable.Objects[I]));
      Result := Result + '\red' + IntToStr(Byte(LColor)) + '\green' +
        IntToStr(Byte(LColor shr 8)) + '\blue' +
        IntToStr(Byte(LColor shr 16)) + ';';
    end;
  end;

// Read from FFontTbl list and construct RTF font table.
  function MakeFontTable: String;
  var
    I: Integer;
    CodePage: Integer;

    function GetCharSet(WinCP: Integer): Integer;
    var
      I: Integer;
    begin
      Result := 0;
      for I := Low(ANSIFontCharsetIDs) to High(ANSIFontCharsetIDs) do
        if ANSIFontCharsetIDs[I].WinCode = WinCP then
        begin
          Result := ANSIFontCharsetIDs[I].FontCharset;
          Break;
        end;
    end;

  begin
    Result := '';
    CodePage := GetACP;
    for I := 0 to FFontTable.Count - 1 do
    begin
      if ((TFontCharset(FFontTable.Objects[I]) = DEFAULT_CHARSET) and
        (CodePage = CANSIWinCode)) then
        Result := Result + '{\f' + IntToStr(I) + ' ' + FFontTable[I] + ';}'
      else
      begin
        if (CodePage <> CANSIWinCode) then
          Result := Result + '{\f' + IntToStr(I) + '\fcharset' +
            IntToStr(TFontCharset(GetCharSet(CodePage))) + ' ' + FFontTable
            [I] + ';}'
        else
          Result := Result + '{\f' + IntToStr(I) + '\fcharset' +
            IntToStr(TFontCharset(FFontTable.Objects[I])) + ' ' + FFontTable
            [I] + ';}';
      end;
    end;
  end;

begin
  inherited; { Process whole document }

  LS := '{\rtf1\ansi\ansicpg' + IntToStr(GetACP) + '\deff0\deftab' +
    FloatToStr(Round(FDefaultTabStop) * FRTFFactor) + '{\fonttbl' +
    MakeFontTable + '}' + '{\colortbl;' + MakeColorTable + '}';
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

  FOutputStream.CopyFrom(FRTFStream, 0);
  LS := '}';

  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));
  if not Preferences.OutputToUserStream then
    FreeAndNil(FOutputStream);

  FreeAndNil(FFontTable);
  FreeAndNil(FColorTable);
  FreeAndNil(FRTFStream);
  FreeAndNil(FHeaderStream);
  FreeAndNil(FFooterStream);
end;

procedure TgtRTFEngine.Start;
var
  LS: String;
  LATemp: AnsiString;
begin
  inherited;
  FDefaultTabStop := 0.5 * CPixelsPerInch;

  FYFactor := TextSize('W', DefaultFont).cy;

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;

  FRTFStream := TMemoryStream.Create;
  FFontTable := TStringList.Create;
  FColorTable := TStringList.Create;
  FRTFFactor := 1 / CalculateNativeUnitFactor(muTwips);

  // Write Document information and default page dimensions

  LS := LS + '{\info';
  if DocInfo.Title <> '' then
    LS := LS + '{\title ' + ConvertToMultibyte(PWideChar(DocInfo.Title)) + '}';
  if DocInfo.Subject <> '' then
    LS := LS + '{\subject ' + ConvertToMultibyte
      (PWideChar(DocInfo.Subject)) + '}';
  LS := LS + '{\author ' + ConvertToMultibyte(PWideChar(DocInfo.Author)) +
    '}{\keywords ' + ConvertToMultibyte(PWideChar(DocInfo.Keywords)) + '}' +
    '{\doccomm ' + NativeText('Gnostice eDocEngine V' + CVersion +
    ' (www.gnostice.com)') + '}{\creatim' +
    FormatDateTime('"\yr"yyyy"\mo"m"\dy"d"\hr"h"\min"n', Now) + '}}' +
    '\viewkind1';
  with Pages[0].Settings do
  begin
    LS := LS + '\paperw' + IntToStr(Round(Width * FRTFFactor)) + '\paperh' +
      IntToStr(Round(Height * FRTFFactor)) + '\margl' +
      IntToStr(Round(LeftMargin * FRTFFactor)) + '\margr' +
      IntToStr(Round(RightMargin * FRTFFactor)) + '\margt' +
      IntToStr(Round(TopMargin * FRTFFactor)) + '\margb' +
      IntToStr(Round(BottomMargin * FRTFFactor));
    LS := LS + '\headery' + IntToStr(Round(HeaderHeight * FRTFFactor)) +
      '\footery' + IntToStr(Round(FooterHeight * FRTFFactor));
  end;
  LATemp := AnsiString(LS);
  FRTFStream.Write(LATemp[1], Length(LS));
  FHeaderStream := TMemoryStream.Create;
  FFooterStream := TMemoryStream.Create;
  WriteBackgroundImage;
  if DocumentEncodingType = etEaseOfEditing then
    FSortTextItems := True
  else
    FSortTextItems := False;
end;

function TgtRTFEngine.ShowSetupModal: Word;
begin
  with TgtRTFEngineDlg.Create(nil) do
    try
      Engine := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function TgtRTFEngine.GetPreferences: TgtRTFPreferences;
begin
  Result := TgtRTFPreferences( inherited Preferences);
end;

procedure TgtRTFEngine.SetPreferences(const Value: TgtRTFPreferences);
begin
  inherited Preferences := Value;
end;

function TgtRTFEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtRTFPreferences;
end;

function TgtRTFEngine.WriteBackgroundImage: String;
var
  ALeft, ATop: Double;
  ABmp: TBitmap;
  LBandType: TgtBandType;
  LFactor: Double;
begin
  // Sets background image position and calls Encodegraphic to
  // encode background image.
  Result := '';
  ALeft := 0;
  ATop := 0;
  LFactor := NativeXPos(1);
  if BackgroundImage.Graphic <> nil then
    with Page do
    begin
      if BackgroundImageDisplayType in [dtTopCenter, dtCenter,
        dtBottomCenter] then
        ALeft := (LFactor * Width - BackgroundImage.Graphic.Width) / 2
      else if BackgroundImageDisplayType in [dtTopRight, dtCenterRight,
        dtBottomRight] then
        ALeft := LFactor * Width - BackgroundImage.Graphic.Width;
      if BackgroundImageDisplayType in [dtCenterLeft, dtCenter,
        dtCenterRight] then
        ATop := (LFactor * Height - BackgroundImage.Graphic.Height) / 2
      else if BackgroundImageDisplayType in [dtBottomLeft, dtBottomCenter,
        dtBottomRight] then
        ATop := LFactor * Height - BackgroundImage.Graphic.Height;

      ABmp := TBitmap.Create;
      try
        ABmp.Height := BackgroundImage.Height;
        ABmp.Width := BackgroundImage.Width;
        ABmp.Transparent := True;
        ABmp.Canvas.Draw(0, 0, BackgroundImage.Graphic);
        LBandType := FBandType;
        FBandType := btHeader;
        EncodeShapeBitmap(ALeft, ATop, ABmp);
        FBandType := LBandType;
      finally
        ABmp.Free;
      end;
    end;
end;

procedure TgtRTFEngine.ProcessMetafile(AX, AY: Double; AMetafile: TMetafile);
var
  LImageItem: TgtImageItem;
begin
  if Preferences.MetafileAsImage then
  begin
    LImageItem := TgtImageItem.Create;
    LImageItem.X := BandRect.Left + NativeXPos(AX);
    LImageItem.Y := BandRect.Top + NativeYPos(AY);
    LImageItem.Width := AMetafile.Width;
    LImageItem.Height := AMetafile.Height;
    with LImageItem do
      DisplayRect := gtRect(X, Y, X + Width, Y + Height);
    LImageItem.Settings.OutputImageFormat := ifMetafile;
    LImageItem.IndexNo := AddImageAsResource(AMetafile);
    AddDocumentItem(LImageItem);
  end
  else
    inherited;
end;

procedure TgtRTFEngine.EncodePageBorder;
begin
end;

function TgtRTFEngine.GetParaBrdrInfo(AWidth: Integer; AColor: TColor;
  AStyle: TPenStyle): String;
begin
  Result := '';
  if AStyle <> psClear then
    case AStyle of
      psSolid:
        Result := '\brdrs';
      psDash:
        Result := '\brdrdash';
      psDot:
        Result := '\brdrdot';
      psDashDot:
        Result := '\brdrdashd';
      psDashDotDot:
        Result := '\brdrdashdd';
      psInsideFrame:
        Result := '\brdrs';
    end;
  Result := Result + '\brdrw' + IntToStr(Round(AWidth * FRTFFactor)) + '\brdrcf'
    + IntToStr(AddColorInfoToColorTable(AColor));
end;

{$IFNDEF gtRegistered}

procedure TgtRTFEngine.PutTrialNote;
begin
  PutTrialNoteOnTop;
end;
{$ENDIF}

procedure TgtRTFEngine.AdjustTextItemList(AList: TList);
var
  I, J, K: Integer;
  CTextItem: TgtTextItem;
  E, YRef, TallFont, LineLimit, NextLine: Double;

  procedure UpdateAllVars(AIndex: Integer);
  begin
    YRef := TgtTextItem(AList.Items[AIndex]).Y;
    if YRef < NextLine then
      YRef := NextLine;
    TallFont := Abs(TgtTextItem(AList.Items[AIndex]).Font.Height);
    LineLimit := Abs(YRef + (TallFont * 0.70));
    NextLine := YRef + TallFont;
  end;

begin
  NextLine := 0;
  if (AList.Count = 0) then
    Exit;
  // sort according to y
  for I := 1 to AList.Count - 1 do
  begin
    CTextItem := TgtTextItem(AList.Items[I]);
    J := I;
    while ((J > 0) and (TgtTextItem(AList.Items[J - 1]).Y > CTextItem.Y)) do
    begin
      AList.Items[J] := AList.Items[J - 1];
      Dec(J);
    end;
    AList.Items[J] := CTextItem;
  end;

  // sort and according to font hieght in a line
  if (AList.Count > 0) then
    UpdateAllVars(0);
  for I := 1 to AList.Count - 1 do
  begin
    E := Abs(TgtTextItem(AList.Items[I]).Font.Height);
    if (TgtTextItem(AList.Items[I]).Y <= LineLimit) then
    begin
      TgtTextItem(AList.Items[I]).Y := YRef;
      if (E > TallFont) then
      begin
        TallFont := E;
        NextLine := YRef + TallFont;
      end;
    end
    else if (TgtTextItem(AList.Items[I]).Y < NextLine) then
    begin
      K := I;
      while (K < AList.Count) and (TgtTextItem(AList.Items[K]).Y < NextLine) do
      begin
        if (E > TallFont) then
        begin
          TallFont := E;
          NextLine := YRef + TallFont;
        end;
        Inc(K);
      end;
      TgtTextItem(AList.Items[I]).Y := NextLine;
      if (E > TallFont) then
        TallFont := E;
    end
    else if (TgtTextItem(AList.Items[I]).Y > NextLine) then
      UpdateAllVars(I);
  end;

  // sort according to x
  for I := 0 to AList.Count - 1 do
  begin
    CTextItem := TgtTextItem(AList.Items[I]);
    J := I;
    while (J > 0) and (TgtTextItem(AList.Items[J - 1]).Y = CTextItem.Y) and
      (TgtTextItem(AList.Items[J - 1]).X > CTextItem.X) do
    begin
      AList.Items[J] := AList.Items[J - 1];
      Dec(J);
    end;
    AList.Items[J] := CTextItem;
  end;
end;

function TgtRTFEngine.ReplacePageInfo(AText: WideString): WideString;
const
  CPage: WideString = '{\field{\*\fldinst { PAGE }}}';
  CNumPages: WideString = '{\field{\*\fldinst { NUMPAGES }}}';
begin
  Result := AText;
  if ((FBandType = btHeader) or (FBandType = btFooter) or
    (FBandType = btWatermark)) then
  begin
    Result := ReplaceString(Result, CphPageNo, CPage);
    Result := ReplaceString(Result, CphTotalPages, CNumPages);
  end
  else
    Result := inherited ReplacePageInfo(Result);
end;
// New fuction is added as per the request by the customer
// function TgtRTFEngine.RTFUnicode(AParam: string): string;
// var
// I: Integer;
// begin
// Result := '';
// for I := 1 to Length(AParam) do
// if Ord(AParam[I]) > $FF then
// Result := Result + '\u' + IntToStr(Ord(AParam[I])) + '?'
// else
// Result := Result + AParam[I];
// end;

function TgtRTFEngine.GetRemoveDuplicates: Boolean;
begin
  Result := FRemoveDuplicates;
end;

procedure TgtRTFEngine.SetRemoveDuplicates(const Value: Boolean);
begin
  FRemoveDuplicates := Value;
end;

{ TgtTabItem }

constructor TgtTabItem.Create;
begin
  FTabStopList := TList.Create;
  FTextList := TStringList.Create;
  FFont := TFont.Create;
end;

destructor TgtTabItem.Destroy;
begin
  FreeAndNil(FTextList);
  FreeAndNil(FTabStopList);
  FreeAndNil(FFont);
  inherited;
end;

{ TgtRTFPreferences }

procedure TgtRTFPreferences.SetGraphicDataInBinary(const Value: Boolean);
begin
  FGraphicDataInBinary := Value;
end;

procedure TgtRTFPreferences.SetMetafileAsImage(const Value: Boolean);
begin
  FMetafileAsImage := Value;
end;

end.
