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
{$I gtDocDefines.inc}
{$I gtDefines.inc}
unit gtCstHTMLEng;

interface

uses
  Classes, Windows, Graphics, SysUtils,
  gtCstDocEng, gtCstPlnEng, gtDocConsts, gtUtils3, gtDocUtils, gtConsts3,
  gtDocResStrs;

type
  (* For storing image properties while reusing created images *)
  TgtHTMLImageSettings = class(TgtImageSettings)
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

  TgtHTMLPreferences = class(TgtPlainSheetPreferences)
  private
    FOptimizeForIE: Boolean;
    FSingleFile: Boolean;
    FAutoScroll: Boolean;
    FPageEndLines: Boolean;
    procedure SetAutoScroll(const Value: Boolean);
    procedure SetOptimizeForIE(const Value: Boolean);
    procedure SetSingleFile(const Value: Boolean);
    procedure SetPageEndLines(const Value: Boolean);
  published
    property SingleFile: Boolean read FSingleFile write SetSingleFile
      default True;
    property AutoScroll: Boolean read FAutoScroll write SetAutoScroll
      default True;
    property OptimizeForIE: Boolean read FOptimizeForIE write SetOptimizeForIE
      default True;
    property PageEndLines: Boolean read FPageEndLines write SetPageEndLines
      default True;
  end;

  TgtHTMLNavigatorOrientation = (noHorizontal, noVertical);

  TgtHTMLNavigatorPosition = (npTopLeft, npTopCenter, npTopRight, npCenterLeft,
    npCenter, npCenterRight, npBottomLeft, npBottomCenter, npBottomRight);

  TgtHTMLNavigatorType = (ntFixedToScreen, ntFixedToPage);

  TgtHTMLNavBtn = (hnbTOC, hnbFirst, hnbPrev, hnbNext, hnbLast);
  TgtHTMLNavBtns = set of TgtHTMLNavBtn;

  (* If SingleFile = False, page navigator can be created *)
  TgtHTMLNavigator = class(TPersistent)
  private
    FLinkBackColor: TColor;
    FLinkHoverBackColor: TColor;
    FLinkHoverForeColor: TColor;
    FLinkImageTOC: String;
    FLinkImageFirst: String;
    FLinkImageLast: String;
    FLinkImageNext: String;
    FLinkImagePrev: String;
    FLinkFont: TFont;
    FLinkTextTOC: String;
    FLinkTextFirst: String;
    FLinkTextLast: String;
    FLinkTextNext: String;
    FLinkTextPrev: String;
    FNavigatorOrientation: TgtHTMLNavigatorOrientation;
    FNavigatorPosition: TgtHTMLNavigatorPosition;
    FNavigatorType: TgtHTMLNavigatorType;
    FUseTextLinks: Boolean;
    FEnabled: Boolean;

    function IsLinkTextTOCStored: Boolean;
    function IsLinkTextFirstStored: Boolean;
    function IsLinkTextNextStored: Boolean;
    function IsLinkTextPrevStored: Boolean;
    function IsLinkTextLastStored: Boolean;

    procedure SetLinkFont(Value: TFont);
    procedure SetLinkBackColor(const Value: TColor);
    procedure SetLinkHoverBackColor(const Value: TColor);
    procedure SetLinkHoverForeColor(const Value: TColor);
    procedure SetLinkTextTOC(const Value: String);
    procedure SetLinkTextFirst(const Value: String);
    procedure SetLinkTextLast(const Value: String);
    procedure SetLinkTextNext(const Value: String);
    procedure SetLinkTextPrev(const Value: String);
    function SetNavigatorOrientation: TgtHTMLNavigatorOrientation;
    procedure SetNavigatorPosition(const Value: TgtHTMLNavigatorPosition);
    procedure SetNavigatorType(const Value: TgtHTMLNavigatorType);
    procedure SetUseTextLinks(const Value: Boolean);
    procedure SetLinkImageFirst(const Value: String);
    procedure SetLinkImageLast(const Value: String);
    procedure SetLinkImageNext(const Value: String);
    procedure SetLinkImagePrev(const Value: String);
    procedure SetLinkImageTOC(const Value: String);
    procedure SetEnabled(const Value: Boolean);
  protected
  public
    constructor Create;
    destructor Destroy; override;

  published
    property LinkBackColor: TColor read FLinkBackColor write SetLinkBackColor
      default CLinkBackColor;
    property LinkHoverForeColor: TColor read FLinkHoverForeColor
      write SetLinkHoverForeColor default CLinkHoverForeColor;
    property LinkHoverBackColor: TColor read FLinkHoverBackColor
      write SetLinkHoverBackColor default CLinkHoverBackColor;
    property LinkImageTOC: String read FLinkImageTOC write SetLinkImageTOC;
    property LinkImageFirst: String read FLinkImageFirst
      write SetLinkImageFirst;
    property LinkImageNext: String read FLinkImageNext write SetLinkImageNext;
    property LinkImagePrev: String read FLinkImagePrev write SetLinkImagePrev;
    property LinkImageLast: String read FLinkImageLast write SetLinkImageLast;
    property LinkFont: TFont read FLinkFont write SetLinkFont;
    property LinkTextTOC: String read FLinkTextTOC write SetLinkTextTOC
      stored IsLinkTextTOCStored;
    property LinkTextFirst: String read FLinkTextFirst write SetLinkTextFirst
      stored IsLinkTextFirstStored;
    property LinkTextNext: String read FLinkTextNext write SetLinkTextNext
      stored IsLinkTextNextStored;
    property LinkTextPrev: String read FLinkTextPrev write SetLinkTextPrev
      stored IsLinkTextPrevStored;
    property LinkTextLast: String read FLinkTextLast write SetLinkTextLast
      stored IsLinkTextLastStored;
    property NavigatorOrientation: TgtHTMLNavigatorOrientation
      read SetNavigatorOrientation write FNavigatorOrientation
      default noHorizontal;
    property NavigatorPosition: TgtHTMLNavigatorPosition read FNavigatorPosition
      write SetNavigatorPosition default npBottomRight;
    property NavigatorType: TgtHTMLNavigatorType read FNavigatorType
      write SetNavigatorType default ntFixedToScreen;
    (* If UseTextLinks = False, image links are used instead of text links *)
    property UseTextLinks: Boolean read FUseTextLinks write SetUseTextLinks
      default True;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
  end;

  // Addition of Meta-Data to a HTML file
  TgtHTMLCustomMetaInfo = class(TPersistent)
  private
    FNames: TStringList;
    FValues: TStringList;
    procedure SetNames(const Value: TStringList);
    procedure SetValues(const Value: TStringList);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Names: TStringList read FNames write SetNames;
    property Values: TStringList read FValues write SetValues;
  end;

  // Creation of image file
  TgtOnNeedImageFileNameEvent = procedure(Sender: TgtCustomDocumentEngine;
    ImageWidthPixels, ImageHeightPixels: Integer;
    ImageFormat: TgtOutputImageFormat; var FileName: String;
    var CreateNewImage: Boolean) of object;

  TgtCustomHTMLEngine = class(TgtCustomPlainSheetEngine)
  private

    FPositionAbsolute: String;
    FNavBtnChars: array [TgtHTMLNavBtn] of String;
    FNavFontName: String;
    FNavigatorWidth: Double;
    FNavigatorHeight: Double;
    FImageCount: Integer;
    FCSSClasses: TStringList;
    FImgSettingList: array of TList;
    FHTMLStream, FBodyStream, FFooterStream, FHeaderStream: TStream;

    FOutputStylesToCSSFile: Boolean;
    FOutputScriptsToJSFile: Boolean;
    FCSSFileName: String;
    FJSFileName: String;
    FNavigator: TgtHTMLNavigator;
    FCustomMetaInfo: TgtHTMLCustomMetaInfo;
    FTransparentBackground: Boolean;
    FOnNeedImageFileName: TgtOnNeedImageFileNameEvent;
    procedure WriteHeader;
    procedure WriteFooter;
    function ConstructStyleStrings: String;
    procedure CalculateNavigatorDimensions;
    function GetNavigatorStyle: String;
    function GetBackground: String;
    function GetNavigatorJS: String;
    function SpacesToNBSP(AString: String): String;
    function GetFontInfo(AFont: TFont): String;
    function GetHTMLImage(AObject: TgtImageItem; AIsTableItem: Boolean): String;
    function ConvertHyperLinks(AString: String; AFont: TFont): String;

    procedure SetNavigator(const Value: TgtHTMLNavigator);
    procedure SetOutputStylesToCSSFile(const Value: Boolean);
    procedure SetOutputScriptsToJSFile(const Value: Boolean);
    procedure SetCSSFileName(const Value: String);
    procedure SetJSFileName(const Value: String);
    function GetPreferences: TgtHTMLPreferences;
    procedure SetPreferences(const Value: TgtHTMLPreferences);
    procedure SetCustomMetaInfo(const Value: TgtHTMLCustomMetaInfo);
    function GetHTMLFileNames: TStringList;
    procedure SetTransparentBackground(const Value: Boolean);
    procedure SetOnNeedImageFileName(const Value: TgtOnNeedImageFileNameEvent);
  protected

    FAttachmentList: TStringList;
    (* Implementation only in Pro version of the product *)
    procedure InsertAnchors(AStream: TStream); virtual;
    procedure EncodeTOC; virtual;

    (* Used by Pro version of the product also *)
    function GetFontCSS(AFont: TFont): String;
    function GetISOCharSet(WinCP: Integer): String;
    function GetOffsetFromTop: Integer;

    (* The only diffence between HTML and XHTML *)
    function AddXHTMLHeader: String; virtual;
    function AddXHTMLHeader2: String; virtual;
    function AddBR: String; virtual;
    function AddMetaClose: String; virtual;
    function AddHRClose: String; virtual;
    function AddImgClose: String; virtual;
    function AddShapeImgSrc(ImgWidth, ImgHeight: Integer): String; virtual;

    procedure BeginPage; override;
    procedure EndPage; override;
    function CheckOutputImageFormat(Value: TgtOutputImageFormat; var S: String)
      : Boolean; override;
    function ShowSetupModal: Word; override;
    function GetPreferencesClassName: TgtPreferencesClass; override;
{$IFDEF EMailSupport}
    procedure CreateEMailSettingsObj; override;
{$ENDIF}
{$IFNDEF gtRegistered}
    procedure PutTrialNote; override;
{$ENDIF}
    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeParagraph(AObject: TgtParagraphItem); override;
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); override;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeShapeBitmap(X, Y: Double; Bitmap: TbitMap); override;
    procedure EncodeTable(AObject: TgtTableItem); override;
    procedure Start; override;
    procedure Finish; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NewPage; override; // New code
    property RelatedFileNames: TStringList read FAttachmentList;
    property HTMLFileNames: TStringList read GetHTMLFileNames;

  published
    property OutputStylesToCSSFile: Boolean read FOutputStylesToCSSFile
      write SetOutputStylesToCSSFile default False;
    property OutputScriptsToJSFile: Boolean read FOutputScriptsToJSFile
      write SetOutputScriptsToJSFile default False;
    property Navigator: TgtHTMLNavigator read FNavigator write SetNavigator;
    property CSSFileName: String read FCSSFileName write SetCSSFileName;
    property JSFileName: String read FJSFileName write SetJSFileName;
    property TransparentBackground: Boolean read FTransparentBackground
      write SetTransparentBackground;
    property BackgroundImage;
    property BackgroundImageDisplayType;
    property BackgroundColor;

    property Preferences: TgtHTMLPreferences read GetPreferences
      write SetPreferences;
    property CustomMetaInfo: TgtHTMLCustomMetaInfo read FCustomMetaInfo
      write SetCustomMetaInfo;
    property OnNeedImageFileName: TgtOnNeedImageFileNameEvent
      read FOnNeedImageFileName write SetOnNeedImageFileName;
    property OnNeedFileName;
  end;

const
  (*
    HTML Navigator characters, when graphic navigator is chosen.
    '¯', '&' or ']' can be used for TOC.
  *)
  CNavWingdingsChars: array [TgtHTMLNavBtn] of String = (']', 'Ù', '×',
    'Ø', 'Ú');

implementation

uses Math, gtHTMLEngDlg;

const
  CHTMLAlignText: array [TgtHAlignment] of String = ('left', 'right', 'center',
    'justify', 'general');
  (* Background image display *)
  CHTMLBgRepeat: array [Boolean] of String = ('repeat', 'no-repeat');
  CHTMLBgPosition: array [TgtBackgroundDisplayType] of String = ('center',
    'top left', 'top center', 'top right', 'center left', 'center',
    'center right', 'bottom left', 'bottom center', 'bottom right');

  { TgtCustomHTMLEngine }

procedure TgtCustomHTMLEngine.Start;
begin
  inherited;

  if Navigator.UseTextLinks then
  begin
    FNavBtnChars[hnbTOC] := Navigator.LinkTextTOC;
    FNavBtnChars[hnbFirst] := Navigator.LinkTextFirst;
    FNavBtnChars[hnbPrev] := Navigator.LinkTextPrev;
    FNavBtnChars[hnbNext] := Navigator.LinkTextNext;
    FNavBtnChars[hnbLast] := Navigator.LinkTextLast;
    FNavFontName := 'Arial';
  end
  else
  begin
    FNavBtnChars[hnbTOC] := CNavWingdingsChars[hnbTOC];
    FNavBtnChars[hnbFirst] := CNavWingdingsChars[hnbFirst];
    FNavBtnChars[hnbPrev] := CNavWingdingsChars[hnbPrev];
    FNavBtnChars[hnbNext] := CNavWingdingsChars[hnbNext];
    FNavBtnChars[hnbLast] := CNavWingdingsChars[hnbLast];
    FNavFontName := 'Wingdings';
  end;

  FHeaderStream := TMemoryStream.Create;
  if (Preferences.SingleFile) then
    FBodyStream := TMemoryStream.Create;
  FFooterStream := TMemoryStream.Create;
  FImageCount := 1;
  FAttachmentList.Clear;
  FCSSClasses := TStringList.Create;
  FPositionAbsolute := '';
  if (not Preferences.OptimizeForIE) then
    FPositionAbsolute := 'position: absolute; ';
  CalculateNavigatorDimensions;
  SetLength(FImgSettingList, 0);
end;

constructor TgtCustomHTMLEngine.Create(AOwner: TComponent);
begin
  inherited;

  Preferences.SingleFile := True;
  Preferences.AutoScroll := False;
  Preferences.OptimizeForIE := False;
  Preferences.ActiveHyperLinks := True;
  Preferences.PageEndLines := True;
  OutputStylesToCSSFile := False;
  OutputScriptsToJSFile := False;
  TransparentBackground := True;
  BackgroundColor := clWhite;
  BackgroundImage.Graphic := nil;
  FNavigator := TgtHTMLNavigator.Create;
  FCustomMetaInfo := TgtHTMLCustomMetaInfo.Create;
  FImageCount := 1;
  Capabilities := [ckText, ckImage, ckShape, ckImageStretch, ckImageFrame,
    ckImageReusable];
  FileExtension := 'htm';
  FileDescription := SHTMLDescription;
  FAttachmentList := TStringList.Create;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 103);
{$ENDIF}
end;

procedure TgtCustomHTMLEngine.Finish;
var
  LCSSStyles, LJavaScript: String;
  LI, LJ: Integer;
begin
  if (FTOCItemList.Count > 0) then
    EncodeTOC;
  if Preferences.OptimizeForIE then
  begin
    if OutputStylesToCSSFile then
    begin
      LCSSStyles := '';
      if ((not Preferences.SingleFile) and Navigator.Enabled) then
        LCSSStyles := GetNavigatorStyle;
      // Encode Background.
      LCSSStyles := LCSSStyles + CRLF + GetBackground;
      // Encode DIV Styles.
      LCSSStyles := LCSSStyles + CRLF + 'div {position:absolute; font: ' +
        GetFontCSS(Font) + '; text-align: left}';
      // Encode CSS classes.
      LCSSStyles := LCSSStyles + ConstructStyleStrings + CRLF +
        'span {position: absolute; visibility: hidden}';
      try
        if (CSSFileName = '') then
          CSSFileName := FileName + '_CSS.css';
        FAttachmentList.Add(CSSFileName);
        with TFileStream.Create(CSSFileName, fmCreate) do
          try
            Write(LCSSStyles[1], Length(LCSSStyles));
          finally
            Free;
          end;
      except
        raise EFileCreateError.Create(SCSSFileCreationError);
      end;
    end;
  end;
  if (OutputScriptsToJSFile) then
    if (((Navigator.NavigatorType = ntFixedToScreen) and
      (not Preferences.SingleFile) and Navigator.Enabled and (PageCount <> 1))
      or Preferences.AutoScroll) then
    begin
      LJavaScript := GetNavigatorJS;
      try
        if (JSFileName = '') then
          JSFileName := FileName + '_JS.js';
        FAttachmentList.Add(JSFileName);
        with TFileStream.Create(JSFileName, fmCreate) do
          try
            Write(LJavaScript[1], Length(LJavaScript));
          finally
            Free;
          end;
      except
        raise EFileCreateError.Create(SJSFileCreationError);
      end;
    end;
  if (Preferences.SingleFile) then
  begin

    if not Preferences.OutputToUserStream then
      FHTMLStream := CreateFile(EngineFileNames[0])
    else
      FHTMLStream := UserStream;

    WriteHeader;
    FHTMLStream.CopyFrom(FHeaderStream, 0);
    TMemoryStream(FHeaderStream).Clear;

    FHTMLStream.CopyFrom(FBodyStream, 0);
    TMemoryStream(FBodyStream).Clear;

    WriteFooter;
    FHTMLStream.CopyFrom(FFooterStream, 0);
    TMemoryStream(FFooterStream).Clear;

    if (not Preferences.OutputToUserStream) then
      FHTMLStream.Free;
  end;
  (* Free the memory used for image-reuse settings *)
  for LI := 0 to Length(FImgSettingList) - 1 do
  begin
    if FImgSettingList[LI] <> nil then
      with FImgSettingList[LI] do
      begin
        for LJ := 0 to Count - 1 do
          TgtHTMLImageSettings(Items[LJ]).Free;
        Free;
      end;
  end;
  FHeaderStream.Free;
  if (Preferences.SingleFile) then
    FBodyStream.Free;
  FFooterStream.Free;
  FCSSClasses.Free;
end;

procedure TgtCustomHTMLEngine.EndPage;
var
  LS: String;
  LATemp: AnsiString;
begin
  if (Preferences.SingleFile and Preferences.PageEndLines) then
  begin
    LS := '<div style="' + FPositionAbsolute + 'top: ' +
      IntToStr(CurrentPage * Round(Pages[CurrentPage - 1].Settings.Height -
      CPageEndLineWidth)) + 'px">' +

      '<hr style="height:' + IntToStr(CPageEndLineWidth) + 'px;border-width:' +
      IntToStr(Round(Pages[CurrentPage - 1].Settings.Width) - 10) +
      ';color:gray;background-color:gray" ' + AddHRClose +
    // '<hr size= ' + IntToStr(CPageEndLineWidth) + ' ' +
    // 'width= ' + IntToStr(Round(Pages[CurrentPage-1].Settings.Width) - 10) + ' ' +
    // 'noshade></hr>
      '</div>' + CRLF;

    // LS := '<div style="' + FPositionAbsolute + 'top: ' +
    // IntToStr(CurrentPage * Round(Pages[CurrentPage - 1].Settings.Height -
    // CPageEndLineWidth)) + 'px">' + '<hr size= ' + IntToStr(CPageEndLineWidth)
    // + ' ' + 'width= ' + IntToStr(Round(Pages[CurrentPage - 1].Settings.Width)
    // - 10) + ' ' + 'noshade></hr></div>' + CRLF;
    LATemp := AnsiString(LS);
    FBodyStream.Write(LATemp[1], Length(LS));
  end;
  (* Insert anchors onto this page *)
  if (FTOCItemList.Count > 0) then
    InsertAnchors(FBodyStream);
  if (not Preferences.SingleFile) then
  begin
    if not Preferences.OutputToUserStream then
      FHTMLStream := CreateFile(EngineFileNames[CurrentPage - 1])
    else
      FHTMLStream := UserStream;

    WriteHeader;
    FHTMLStream.CopyFrom(FHeaderStream, 0);
    TMemoryStream(FHeaderStream).Clear;

    FHTMLStream.CopyFrom(FBodyStream, 0);
    TMemoryStream(FBodyStream).Free;

    WriteFooter;
    FHTMLStream.CopyFrom(FFooterStream, 0);
    TMemoryStream(FFooterStream).Clear;

    if (not Preferences.OutputToUserStream) then
      FHTMLStream.Free;
  end;
  inherited;
end;

function TgtCustomHTMLEngine.GetBackground: String;
var
  LFileName, LFileExt: String;
  LBmp: TbitMap;
begin
  Result := '';
  if (BackgroundImage.Graphic <> nil) then
  begin
    LBmp := TbitMap.Create;
    try
      LFileName := FileName + '_BG';
      LBmp.Width := BackgroundImage.Width;
      LBmp.Height := BackgroundImage.Height;
      LBmp.Transparent := True;
      LBmp.Canvas.Draw(0, 0, BackgroundImage.Graphic);
      case ImageSettings.OutputImageFormat of
        ifBMP:
          begin
            LFileExt := '.bmp';
            LBmp.SaveToFile(LFileName + '.bmp');
          end;
        ifGIF:
          begin
            LFileExt := '.gif';
            with TMemoryStream(GetBitmapAsJPGGIFStream(LBmp, False, 100)) do
              try
                SaveToFile(LFileName + '.gif');
              finally
                Free;
              end;
          end;
        ifPNG:
          begin
            LFileExt := '.png';
            with TMemoryStream(GetBitmapAsPNGStream(LBmp, BackgroundColor)) do
              try
                SaveToFile(LFileName + '.png');
              finally
                Free;
              end;
          end;
      else
        begin
          LFileExt := '.jpg';
          with TMemoryStream(GetBitmapAsJPGGIFStream(LBmp, True, 100)) do
            try
              SaveToFile(LFileName + '.jpg');
            finally
              Free;
            end;
        end;
      end;
    finally
      LBmp.Free;
    end;
    if LFileName <> '' then
      Result := 'url(' + GetFileNameFromPath(LFileName) + LFileExt + ') ';
    FAttachmentList.Add(LFileName + LFileExt);
  end;
  Result := 'body {background: ' + Result;
  if (not TransparentBackground) then
    Result := Result + '#' + ColorBGRToRGB(BackgroundColor) + ' ';
  Result := Result + CHTMLBgRepeat[BackgroundImageDisplayType <> dtTile] + ' ' +
    CHTMLBgPosition[BackgroundImageDisplayType] + ' fixed}';
end;

(* Font information for navigator *)
function TgtCustomHTMLEngine.GetNavigatorStyle: String;
begin
  Result := 'a:link {font: ' + IntToStr(Round(Navigator.LinkFont.Size)) + 'pt '
    + Navigator.LinkFont.Name + '; text-decoration: none; color: #' +
    ColorBGRToRGB(Navigator.LinkFont.Color) + '; background-color: #' +
    ColorBGRToRGB(Navigator.LinkBackColor) + '}' + CRLF + 'a:visited {font: ' +
    IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' + Navigator.LinkFont.Name +
    '; text-decoration: none; color: #' +
    ColorBGRToRGB(Navigator.LinkFont.Color) + '; background-color: #' +
    ColorBGRToRGB(Navigator.LinkBackColor) + '}' + CRLF + 'a:hover {font: ' +
    IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' + Navigator.LinkFont.Name +
    '; text-decoration: none; color: #' +
    ColorBGRToRGB(Navigator.LinkHoverForeColor) + '; background-color: #' +
    ColorBGRToRGB(Navigator.LinkHoverBackColor) + '}';
end;

procedure TgtCustomHTMLEngine.SetNavigator(const Value: TgtHTMLNavigator);
begin
  if (Value <> nil) then
    with FNavigator do
    begin
      Enabled := Value.Enabled;
      LinkTextTOC := Value.LinkTextTOC;
      LinkTextFirst := Value.LinkTextFirst;
      LinkTextPrev := Value.LinkTextPrev;
      LinkTextNext := Value.LinkTextNext;
      LinkTextLast := Value.LinkTextLast;
      LinkFont.Assign(Value.LinkFont);
      LinkBackColor := Value.LinkBackColor;
      LinkHoverForeColor := Value.LinkHoverForeColor;
      LinkHoverBackColor := Value.LinkHoverBackColor;
      LinkImageTOC := Value.LinkImageTOC;
      LinkImageFirst := Value.LinkImageFirst;
      LinkImageNext := Value.LinkImageNext;
      LinkImagePrev := Value.LinkImagePrev;
      LinkImageLast := Value.LinkImageLast;
      NavigatorOrientation := Value.NavigatorOrientation;
      NavigatorPosition := Value.NavigatorPosition;
      NavigatorType := Value.NavigatorType;
      UseTextLinks := Value.UseTextLinks;
    end;
end;

procedure TgtCustomHTMLEngine.SetOutputStylesToCSSFile(const Value: Boolean);
begin
  FOutputStylesToCSSFile := Value;
end;

(* Write the navigator and end the HTML tag *)
procedure TgtCustomHTMLEngine.WriteFooter;
var
  LS: String;
  LATemp: AnsiString;
  LNavLeft, LNavTop: Double;

  function GetNavHTML: String;
  const
    CTextFormat = '<a %stitle="%s" class="A1" ' +
      'style="text-decoration: none">%s</a>';
    CImageFormat = '<a %stitle="%s"><img src="%s" alt="%s" %s </a>';
  var
    LFirstPage, LLastPage: Boolean;
    LFirstLnk, LPrevLnk, LNextLnk, LLastLnk, LNavSeparator: String;
{$IFDEF gtPro}
    LTOCLnk: String;
{$ENDIF}
  begin
    if Navigator.NavigatorOrientation = noHorizontal then
      LNavSeparator := '&nbsp;'
    else
      // LNavSeparator := '<br/>';
      LNavSeparator := AddBR;
    (* Navigator Links *)
{$IFDEF gtPro}
    LTOCLnk := '';
{$ENDIF}
    LFirstLnk := '';
    LPrevLnk := '';
    LNextLnk := '';
    LLastLnk := '';
    Result := '';
    LFirstPage := (CurrentPage = 1);
    LLastPage := (CurrentPage = PageCount);
    if not LFirstPage then
    begin
      LFirstLnk := 'href="' + GetFileNameFromPath(EngineFileNames[0]) + '" ';
      LPrevLnk := 'href="' + GetFileNameFromPath
        (EngineFileNames[CurrentPage - 2]) + '" ';
    end;
    if not LLastPage then
    begin
      LLastLnk := 'href="' + GetFileNameFromPath
        (EngineFileNames[PageCount - 1]) + '" ';
      LNextLnk := 'href="' + GetFileNameFromPath
        (EngineFileNames[CurrentPage]) + '" ';
    end;
{$IFDEF gtPro}
    if (FTOCItemList.Count > 0) then
      LTOCLnk := 'href="' + GetFileNameFromPath(FileName) + '_TOC.htm" ';
{$ENDIF}
    if Navigator.UseTextLinks then
    begin
{$IFDEF gtPro}
      if (FTOCItemList.Count > 0) then
        Result := Format(CTextFormat, [LTOCLnk, STitleTextTOC,
          Navigator.LinkTextTOC]) + LNavSeparator;
{$ENDIF}
      Result := Result + Format(CTextFormat, [LFirstLnk, STitleTextFirst,
        Navigator.LinkTextFirst]) + LNavSeparator +
        Format(CTextFormat, [LPrevLnk, STitleTextPrev, Navigator.LinkTextPrev])
        + LNavSeparator + Format(CTextFormat, [LNextLnk, STitleTextNext,
        Navigator.LinkTextNext]) + LNavSeparator + Format(CTextFormat,
        [LLastLnk, STitleTextLast, Navigator.LinkTextLast]);
    end
    else
    begin
{$IFDEF gtPro}
      if (FTOCItemList.Count > 0) then
        Result := Format(CImageFormat, [LTOCLnk, STitleTextTOC,
          Navigator.LinkImageTOC, STitleTextTOC, AddImgClose]) + LNavSeparator;
      // if (FTOCItemList.Count > 0) then
      // Result := Format(CImageFormat, [LTOCLnk, STitleTextTOC,
      // Navigator.LinkImageTOC, STitleTextTOC]) + LNavSeparator;
{$ENDIF}
      // Result := Result + Format(CImageFormat, [LFirstLnk, STitleTextFirst,
      // Navigator.LinkImageFirst, STitleTextFirst]) + LNavSeparator +
      // Format(CImageFormat, [LPrevLnk, STitleTextPrev, Navigator.LinkImagePrev,
      // STitleTextPrev]) + LNavSeparator + Format(CImageFormat,
      // [LNextLnk, STitleTextNext, Navigator.LinkImageNext, STitleTextNext]) +
      // LNavSeparator + Format(CImageFormat, [LLastLnk, STitleTextLast,
      // Navigator.LinkImageLast, STitleTextLast]);
      Result := Result + Format(CImageFormat, [LFirstLnk, STitleTextFirst,
        Navigator.LinkImageFirst, STitleTextFirst, AddImgClose]) + LNavSeparator
        + Format(CImageFormat, [LPrevLnk, STitleTextPrev,
        Navigator.LinkImagePrev, STitleTextPrev, AddImgClose]) + LNavSeparator +
        Format(CImageFormat, [LNextLnk, STitleTextNext, Navigator.LinkImageNext,
        STitleTextNext, AddImgClose]) + LNavSeparator +
        Format(CImageFormat, [LLastLnk, STitleTextLast, Navigator.LinkImageLast,
        STitleTextLast, AddImgClose]);
    end;
  end;

begin
  LS := '';
  if ((not Preferences.SingleFile) and (Navigator.Enabled) and
    (not Preferences.ProcessAfterEachPage) and (PageCount > 1)) then
  begin
    if (Navigator.NavigatorType = ntFixedToScreen) then
    begin
      (* Use Java Script *)
      LS := '<div style="' + FPositionAbsolute + 'font: ' +
        IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' +
        Navigator.LinkFont.Name + '; color: #' +
        ColorBGRToRGB(Navigator.LinkFont.Color) + '">' +
        '<span id="gtNavigator">' + GetNavHTML + CRLF + '</span>' + '</div>';
    end
    else
    begin
      LNavLeft := 0;
      LNavTop := 0;
      if Navigator.NavigatorPosition in [npTopRight, npCenterRight,
        npBottomRight] then
        LNavLeft := Pages[CurrentPage - 1].Settings.Width - FNavigatorWidth
      else if Navigator.NavigatorPosition in [npTopCenter, npCenter,
        npBottomCenter] then
        LNavLeft := (Pages[CurrentPage - 1].Settings.Width -
          FNavigatorWidth) / 2;

      if Navigator.NavigatorPosition in [npCenterLeft, npCenter,
        npCenterRight] then
        LNavTop := (Pages[CurrentPage - 1].Settings.Height -
          FNavigatorHeight) / 2
      else if Navigator.NavigatorPosition in [npBottomLeft, npBottomCenter,
        npBottomRight] then
        LNavTop := Pages[CurrentPage - 1].Settings.Height - FNavigatorHeight;

      (* Display navigator buttons *)
      LS := '<div style="' + FPositionAbsolute + 'top: ' +
        IntToStr(Round(LNavTop)) + 'px; ' + 'left: ' + IntToStr(Round(LNavLeft)
        ) + 'px; ';
      if Navigator.NavigatorOrientation = noVertical then
        LS := LS + 'width: 1px; ';
      LS := LS + 'font: ' + IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' +
        Navigator.LinkFont.Name + '; color: #' +
        ColorBGRToRGB(Navigator.LinkFont.Color) + '">' + GetNavHTML +
        '</div>' + CRLF;
    end;
    LATemp := AnsiString(LS);
    FFooterStream.Write(LATemp[1], Length(LS));
  end;
  (* Append closing HTML Tags *)
  if ((not Preferences.SingleFile) or (CurrentPage = PageCount)) then
  begin
    LS := '</body>' + CRLF + '</html>' + CRLF;
    LATemp := AnsiString(LS);
    FFooterStream.Write(LATemp[1], Length(LS))
  end;
end;

(* Encode Font Details including Styles, Size, Name and Color *)
function TgtCustomHTMLEngine.GetFontCSS(AFont: TFont): String;
begin
  Result := '';
  with AFont do
  begin
    if (fsItalic in Style) then
      Result := Result + ' italic';
    if (fsBold in Style) then
      Result := Result + ' bold';
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + IntToStr(Abs(Size)) + 'pt ' + AFont.Name;
    if ((Style - [fsBold, fsItalic]) <> []) then
    begin
      Result := Result + '; text-decoration:';
      if fsUnderline in Style then
        Result := Result + ' underline';
      if fsStrikeOut in Style then
        Result := Result + ' line-through';
    end;
    Result := Trim(Result) + '; color: #' + ColorBGRToRGB(Color)
  end;
end;

(*
  If font of a text object it is not already present as a CSS class,
  then create one and return class name
*)
function TgtCustomHTMLEngine.GetFontInfo(AFont: TFont): String;
var
  LI: Integer;

  function IsFontMatching: Boolean;
  begin
    with AFont do
      Result := (Size = Font.Size) and (Name = Font.Name) and
        (Style = Font.Style) and (Color = Font.Color);
  end;

begin
  Result := '';
  if Preferences.OptimizeForIE then
  begin
    if (not IsFontMatching) then
    begin
      Result := 'font:' + GetFontCSS(AFont);
      LI := FCSSClasses.IndexOf(Result);
      if LI = -1 then
        LI := FCSSClasses.Add(Result);
      Result := '" class="S' + IntToStr(LI);
    end;
  end
  else
    Result := 'font:' + GetFontCSS(AFont);
end;

(* Support for NON-ANSI Charsets *)
function TgtCustomHTMLEngine.GetISOCharSet(WinCP: Integer): String;
var
  LK: Integer;
begin
  Result := '';
  for LK := Low(CANSICodePageIDs) to High(CANSICodePageIDs) do
    if CANSICodePageIDs[LK].WinCode = WinCP then
    begin
      Result := CANSICodePageIDs[LK].ISOCode;
      Break;
    end;
end;

procedure TgtCustomHTMLEngine.WriteHeader;
var
  LI: Integer;
  LS: String;
  LATemp: AnsiString;
begin
  LS := AddXHTMLHeader + CRLF + AddXHTMLHeader2 + CRLF + '<head>' + CRLF +
    '<title>' + DocInfo.Title + '</title>' + CRLF +
    '<meta http-equiv="Content-Type" content="text/html;charset=' +
    GetISOCharSet(GetACP) + '" ' + AddMetaClose + CRLF +

    '<meta http-equiv="Content-Style-Type" content="text/css;charset=' +
  // LS := AddXHTMLHeader + CRLF + '<html> <head>' + CRLF + '<title>' +
  // DocInfo.Title + '</title>' + CRLF +
  // '<meta HTTP-EQUIV="Content-Style-Type" CONTENT="text/css" CHARSET="' +
  (*
    Get active chatacter code page and encode so that non English characters
    such as Eastern European & Asian characters show up properly
  *)
    GetISOCharSet(GetACP) + '" ' + AddMetaClose + CRLF +
    '<meta name="Subject" content="' + DocInfo.Subject + '" ' + AddMetaClose +
    CRLF + '<meta name="Keywords" content="' + DocInfo.Keywords + '" ' +
    AddMetaClose + CRLF + '<meta name="Author" content="' + DocInfo.Author +
    '" ' + AddMetaClose + CRLF + '<meta name="Creator" content="' +
    DocInfo.Creator + '" ' + AddMetaClose + CRLF +
    '<meta name="Producer" content="Gnostice eDocEngine v' + CVersion + '" ' +
    AddMetaClose + CRLF;
  // GetISOCharSet(GetACP) + '"></meta>' + CRLF +
  // '<meta NAME="Subject" CONTENT="' + DocInfo.Subject + '"></meta>' + CRLF +
  // '<meta NAME="Keywords" CONTENT="' + DocInfo.Keywords + '"></meta>' + CRLF +
  // '<meta NAME="Author" CONTENT="' + DocInfo.Author + '"></meta>' + CRLF +
  // '<meta NAME="Creator" CONTENT="' + DocInfo.Creator + '"></meta>' + CRLF +
  // '<meta NAME="Producer" CONTENT="Gnostice eDocEngine v' + CVersion +
  // '">' + CRLF;
  for LI := 0 to CustomMetaInfo.Names.Count - 1 do
  begin
    LS := LS + '<meta name="' + CustomMetaInfo.Names.Strings[LI] + '" content="'
      + CustomMetaInfo.Values.Strings[LI] + '" ' + AddMetaClose + CRLF;
    // LS := LS + '<meta NAME="' + CustomMetaInfo.Names.Strings[LI] + '" CONTENT="'
    // + CustomMetaInfo.Values.Strings[LI] + '"></meta>' + CRLF;
  end;
  // LS := LS + '</meta>';
  (* Encode style sheet location *)
  if Preferences.OptimizeForIE and OutputStylesToCSSFile then
  begin
    if (CSSFileName = '') then
      CSSFileName := FileName + '_CSS.css';
    LS := LS + CRLF + '<link rel="stylesheet" href="' +
      GetFileNameFromPath(CSSFileName) + '" type="text/css"></link>';
  end;
  LS := LS + CRLF + '<style type="text/css">' + CRLF + '<!--' + CRLF +
    GetBackground;
  // LS := LS + CRLF + '<style>' + CRLF + '<!--' + CRLF + GetBackground;
  (* Encode default style - positioning & report font properties *)
  if Preferences.OptimizeForIE then
  begin
    LS := LS + CRLF + 'div {position:absolute; font:' + GetFontCSS(Font) + '}';
    if (not OutputStylesToCSSFile) then
      LS := LS + ConstructStyleStrings;
  end;

  (* Encode navigator anchor style, if not SingleFile and ShowNavigator on *)
  if ((not Preferences.SingleFile) and Navigator.Enabled) then
    LS := LS + CRLF + 'SN:link {font:18pt ' + FNavFontName +
      '; text-decoration:none; color:' + CNavNormalColor + '; background-color:'
      + CNavNormalBackground + '}' + CRLF + 'SN:visited {font:18pt ' +
      FNavFontName + '; text-decoration:none; color:' + CNavNormalColor +
      '; background-color:' + CNavNormalBackground + '}' + CRLF +
      'SN:hover {font:18pt ' + FNavFontName + '; text-decoration:none; color:' +
      CNavHoverColor + ';background-color:' + CNavHoverBackground + '}';
  LS := LS + CRLF + 'span {position: absolute; visibility: hidden}';
  LS := LS + CRLF + '-->' + CRLF + '</style>';

  (* Encode Java Script for Floating Navigator *)
  if (Preferences.AutoScroll or (not Preferences.SingleFile) and
    Navigator.Enabled and (Navigator.NavigatorType = ntFixedToScreen) and
    (PageCount <> 1)) then
  begin
    // LS := LS + CRLF + '<script language="JavaScript "';
    // LS := LS + CRLF + '<script language="JavaScript';
    LS := LS + CRLF + '<script type="text/javascript"';
    if OutputScriptsToJSFile then
    begin
      if (JSFileName = '') then
        JSFileName := FileName + '_JS.js';
      LS := LS + ' src="' + GetFileNameFromPath(JSFileName) + '">';
    end
    else (* Encode JavaScripts *)
      LS := LS + '>' + CRLF + '<!--' + CRLF + GetNavigatorJS + CRLF + '-->';
    LS := LS + CRLF + '</script>';
  end;
  LS := LS + CRLF + '</head>' + CRLF + '<body';
  if (not TransparentBackground) then
    LS := LS + ' bgcolor = "#FFFFFF"';
  if ((Navigator.NavigatorType = ntFixedToScreen) and
    (not Preferences.SingleFile) and Navigator.Enabled and (PageCount <> 1)) or
    Preferences.AutoScroll then
    LS := LS + ' onLoad="doAll()"';
  LS := LS + '>' + CRLF;
  LATemp := AnsiString(LS);
  FHeaderStream.Write(LATemp[1], Length(LS));
end;

(* Create CSS strings *)
function TgtCustomHTMLEngine.ConstructStyleStrings: String;
var
  LI: Integer;
begin
  Result := '';
  for LI := 0 to FCSSClasses.Count - 1 do
    Result := Result + CRLF + '.S' + IntToStr(LI) + ' {' + FCSSClasses
      [LI] + '}';
  Result := Result + CRLF + '.A1:link {font: ' +
    IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' + Navigator.LinkFont.Name +
    '; text-decoration: none; color: #' +
    ColorBGRToRGB(Navigator.LinkFont.Color) + '; background-color: #' +
    ColorBGRToRGB(Navigator.LinkBackColor) + '}' + CRLF + '.A1:visited {font: '
    + IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' + Navigator.LinkFont.Name
    + '; text-decoration: none; color: #' +
    ColorBGRToRGB(Navigator.LinkFont.Color) + '; background-color: #' +
    ColorBGRToRGB(Navigator.LinkBackColor) + '}' + CRLF + '.A1:hover {font: ' +
    IntToStr(Round(Navigator.LinkFont.Size)) + 'pt ' + Navigator.LinkFont.Name +
    '; text-decoration: none; color: #' +
    ColorBGRToRGB(Navigator.LinkHoverForeColor) + '; background-color: #' +
    ColorBGRToRGB(Navigator.LinkHoverBackColor) + '}';
end;

procedure TgtCustomHTMLEngine.EncodeText(AObject: TgtTextItem);
var
  LS, LOriginalString: String;
  LBmp: TbitMap;
  LI: Integer;
  LATemp: AnsiString;

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

begin
  inherited;
  with AObject do
  begin
    LOriginalString := Lines.Strings[0];
    Lines.Strings[0] := ReplacePlaceHolders(Lines.Strings[0], True);
    (* Support only unrotated text *)
    if ((RotationAngle mod 360) = 0) then
    begin
      (* for unicode characters *)
      if (Font.Charset <> ANSI_CHARSET) and
        ((Font.Charset <> DEFAULT_CHARSET) or (GetACP <> CANSIWinCode)) then
      begin
        LS := '';
        for LI := 1 to Length(Lines.Strings[0]) do
          LS := LS + '&#' + IntToStr(Ord(Lines.Strings[0][LI])) + ';';
        Lines.Strings[0] := LS;
      end;
      Lines.Strings[0] := ConvertHyperLinks
        (SpacesToNBSP(Lines.Strings[0]), Font);
      LS := '<div style="' + FPositionAbsolute + 'top: ' +
        IntToStr(Round(Y + GetOffsetFromTop)) + 'px; ' + 'left: ' +
        IntToStr(Round(X)) + 'px; ';

      (* For clipping the text if 'AutoSize' of the textbox is set to 'False' *)
      if IsClipRect then
        LS := LS + 'width:' + FloatToStr((ClipRect.Right - ClipRect.Left)
          ) + 'px; '
      else
        (* width for hyphenated words; "2.5" for printing error *)
        // LS := LS + 'width:' + IntToStr(Round(TextSize(Lines.Strings[0], Font).cx * 2.5)) + 'px; ';
        (* multiplying by 2.5 is not necessary, since nbsp is used *)
        // LS := LS + 'width:' + IntToStr(Round(TextSize(LOriginalString, Font).cx)
        // ) + 'px; ';
        LS := LS + 'width:' +
          IntToStr(Round(TextSize(LOriginalString, Font).cx *
          1.09 { need about 1-2 more pixel width for IE vs other browser } )
          ) + 'px; ';

      if (Brush.Style = bsSolid) then
        LS := LS + 'background-color: #' + ColorBGRToRGB(Brush.Color) + '; ';
      LS := LS + GetFontInfo(Font) + '">';

      (* For clipping the text if 'AutoSize' of the textbox is set to 'False' *)
      if IsClipRect then
        LS := LS + SpacesToNBSP(ReplacePlaceHolders(GetTextForWidth(LOriginalString,
          (ClipRect.Right - ClipRect.Left)), True)) + '</div>' + CRLF
                 else
        LS := LS + Lines.Strings[0] + '</div>' + CRLF;
      LATemp := AnsiString(LS);
      FBodyStream.Write(LATemp[1], Length(LS));
    end
    else (* Encode Rotated Text as Bitmap *)
    begin
      LBmp := GetRotatedTextBitmap(AObject);
      if (LBmp <> nil) then
        try
          EncodeShapeBitmap(X, Y, LBmp);
        finally
          LBmp.Free;
        end;
    end;
    Lines.Strings[0] := LOriginalString;
  end;
end;

function TgtCustomHTMLEngine.ConvertHyperLinks(AString: String;
  AFont: TFont): String;
var
  LS, LLinkBuffer, LLinkText: String;
  LStartPos: Integer;
begin
  LS := Trim(AString);
  Result := LS;
  if Preferences.ActiveHyperLinks then
  begin
    LLinkBuffer := '';
    LStartPos := 0;
    LS := ReplaceString(LS, '&nbsp;', ' ');
    LLinkText := GetHyperLinkText(LS, LStartPos);
    if LLinkText <> '' then
    begin
      while (LLinkText <> '') and (LLinkText <> #$D#$A) do
      begin
        (* If spaces have been replaced by '&nbsp', then remove them *)
        LLinkText := Trim(ReplaceString(LLinkText, '&nbsp', ' '));
        if (AnsiPos('http:', LLinkText) = 1) or
          (AnsiPos('ftp:', LLinkText) = 1) then
          LLinkBuffer := '<a href="' + LLinkText + '" style="font: ' +
            GetFontCSS(AFont) + '">' + SpacesToNBSP(Trim(LLinkText)) + '</a>'
        else if (AnsiPos('@', LLinkText) > 1) then
          LLinkBuffer := '<a href="mailto:' + LLinkText + '" style="font: ' +
            GetFontCSS(AFont) + '">' + SpacesToNBSP(Trim(LLinkText)) + '</a>'
        else if (AnsiPos(':\', LLinkText) > 1) then
          LLinkBuffer := '<a href="' + LLinkText + '" style="font: ' +
            GetFontCSS(AFont) + '">' + { SpacesToNBSP } (Trim(LLinkText)
            ) + '</a>'
        else
          LLinkBuffer := '<a href="' + 'http://' + LLinkText + '" style="font: '
            + GetFontCSS(AFont) + '">' + SpacesToNBSP(Trim(LLinkText)) + '</a>';
        Result := ReplaceString(Result, LLinkText, LLinkBuffer);
        LStartPos := LStartPos + Length(LLinkText);
        LLinkText := GetHyperLinkText(LS, LStartPos);
      end;
    end;
  end;
end;

function TgtCustomHTMLEngine.SpacesToNBSP(AString: String): String;
begin
  if Copy(AString, 1, Length(CHTMLNoTranslateText)) = CHTMLNoTranslateText then
    Result := Copy(AString, Length(CHTMLNoTranslateText) + 1, MaxInt)
  else
  begin
    Result := ReplaceString(AString, #38, '&amp;');
    Result := ReplaceString(Result, ' ', '&nbsp;');
    Result := ReplaceString(Result, CRLF, AddBR + CRLF);
    Result := ReplaceString(Result, #9, '&#9;');
    if (pos(#60, Result) + 1) <> (pos('br', Result)) then
      Result := ReplaceString(Result, #60, '&lt;');
    if ((pos(#62, Result)) <> (pos('br', Result) + 2)) then
      Result := ReplaceString(Result, #62, '&gt;');
    if (pos('&gt;', Result)) = (pos('br/', Result) + 3) then
      Result := ReplaceString(Result, '&gt;', #62);

    Result := ReplaceString(Result, #162, '&cent;');
    Result := ReplaceString(Result, #163, '&pound;');
    Result := ReplaceString(Result, #165, '&yen;');
    Result := ReplaceString(Result, #167, '&sect;');
    Result := ReplaceString(Result, #169, '&copy;');
    Result := ReplaceString(Result, #174, '&reg;');
    Result := ReplaceString(Result, #8482, '&trade;');
    Result := ReplaceString(Result, #8364, '&euro;');
    Result := ReplaceString(Result, #8220, '&ldquo;');
    Result := ReplaceString(Result, #8221, '&rdquo;');
    Result := ReplaceString(Result, #8230, '&hellip;');
    Result := ReplaceString(Result, #8230, '&hellip;');
    Result := ReplaceString(Result, #8211, '&ndash;');
  end;

end;

(*
  SingleFile: Offset = (Paperheight + PageEndLine width) * (PagesDone - 1)
  MultiFile: Offset = 0
  To Do: page height different for different pages
*)
function TgtCustomHTMLEngine.GetOffsetFromTop: Integer;
begin
  Result := (Round(Pages[CurrentPage - 1].Settings.Height) * (CurrentPage - 1) +
    CPageEndLineWidth) * Ord(Preferences.SingleFile);
end;

procedure TgtCustomHTMLEngine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
  LLeft, LTop, LWidth, LHeight: Double;
  LS: String;
  LATemp: AnsiString;
begin
  if ((X1 = X2) or (Y1 = Y2)) then
  begin
    LLeft := Min(X1, X2);
    LTop := Min(Y1, Y2);
    LWidth := Abs(X1 - X2);
    LHeight := Abs(Y1 - Y2);
    if LWidth = 0 then
    begin
      LWidth := Pen.Width;
      LS := '; border-left: '; (* Vertical line *)
    end
    else
    begin
      LHeight := Pen.Width;
      LS := '; border-top: '; (* Horizontal line *)
    end;
    LTop := LTop + GetOffsetFromTop + Pen.Width - 1;
    LS := LS + IntToStr(Round(Pen.Width)) + 'px ' + CLineStyle[Pen.Style] + ' #'
      + ColorBGRToRGB(Pen.Color);
    LS := '<div style="font: 0pt; ' + FPositionAbsolute + 'top: ' +
      IntToStr(Round(LTop)) + 'px; ' + 'left: ' + IntToStr(Round(LLeft)) +
      'px; ' + 'width: ' + IntToStr(Round(LWidth)) + 'px; ' + 'height: ' +
      IntToStr(Round(LHeight)) + 'px' + LS + '"></div>' + CRLF;
    LATemp := AnsiString(LS);
    FBodyStream.Write(LATemp[1], Length(LS));
  end
  else
    inherited;
end;

procedure TgtCustomHTMLEngine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  LPosX, LPosY, LRectWidth, LRectHeight: Double;
  LS: String;
  LATemp: AnsiString;

  function GetRectDetails: String;
  var
    LI: Integer;
    LStr: String;
  begin
    Result := '';
    LStr := 'border: ' + IntToStr(Round(Pen.Width)) + 'px ' + CLineStyle
      [Pen.Style] + ' #' + ColorBGRToRGB(Pen.Color);

    if (not Preferences.OptimizeForIE) then
      Result := '; ' + LStr
    else
    begin
      LI := FCSSClasses.IndexOf(LStr);
      if LI = -1 then
        Result := 'S' + IntToStr(Round(FCSSClasses.Add(LStr)))
      else
        Result := 'S' + IntToStr(Round(LI));
      Result := '" class="' + Result;
    end;
  end;

begin
  LPosX := X1 - Pen.Width / 2;
  LPosY := Y1 - Pen.Width / 2;
  LRectWidth := X2 - X1 - Pen.Width;
  LRectHeight := Y2 - Y1 - Pen.Width;
  (* Calculate Left/Top positions when Width/Height is negative *)
  if LRectWidth < 0 then
  begin
    LRectWidth := Abs(LRectWidth);
    LPosX := LPosX - LRectWidth;
  end;
  if LRectHeight < 0 then
  begin
    LRectHeight := Abs(LRectHeight);
    LPosY := LPosY - LRectHeight;
  end;
  if LRectWidth = 0 then
  begin
    LRectWidth := 1;
  end;
   if LRectHeight = 0 then
  begin
   LRectHeight := 1;
  end;
  LS := '<div style="' + FPositionAbsolute + 'font: 0pt; top: ' +
    IntToStr(Round(LPosY + GetOffsetFromTop + Pen.Width - 1)) + 'px; ' +
    'left: ' + IntToStr(Round(LPosX)) + 'px; ' + 'width: ' +
    IntToStr(Round(LRectWidth)) + 'px; ' + 'height: ' +
    IntToStr(Round(LRectHeight)) + 'px; ';
  if ((Brush <> nil) and (Brush.Style = bsSolid)) then
    LS := LS + 'background-color: #' + ColorBGRToRGB(Brush.Color);
  if ((X2 - X1) = 1) or ((Y2 - Y1) = 1) then
    Pen.Width := Pen.Width - 1;
  if Pen.Style <> psClear then
    LS := LS + GetRectDetails;
  LS := LS + '"></div>' + CRLF;
  LATemp := AnsiString(LS);
  FBodyStream.Write(LATemp[1], Length(LS));
  if ((X2 - X1) = 1) or ((Y2 - Y1) = 1) then
    Pen.Width := Pen.Width + 1;
end;

procedure TgtCustomHTMLEngine.EncodeShapeBitmap(X, Y: Double; Bitmap: TbitMap);
var
  LS: String;
  LATemp: AnsiString;
  LWidth, LHeight: Integer;
begin
  inherited;
  LS := FileName + '_' + IntToStr(FImageCount) + '_S.jpg';
  with TMemoryStream(GetBitmapAsJPGGIFStream(Bitmap, True, 100)) do
    try
      SaveToFile(LS);
    finally
      Free;
    end;
  FAttachmentList.Add(LS);
  Inc(FImageCount);
  LWidth := Bitmap.Width;
  LHeight := Bitmap.Height;
  LS := '<div style="' + FPositionAbsolute + 'top: ' +
    IntToStr(Round(Y + GetOffsetFromTop)) + 'px; ' + 'left: ' +
    IntToStr(Round(X)) + 'px; ' + 'width: ' + IntToStr(Round(Bitmap.Width)) +
    'px; ' + 'height: ' + IntToStr(Round(Bitmap.Height)) + 'px' + ';">' +
    '<img src="' + GetFileNameFromPath(LS) + AddShapeImgSrc(LWidth, LHeight);

  LATemp := AnsiString(LS);
  FBodyStream.Write(LATemp[1], Length(LS));
end;

procedure TgtCustomHTMLEngine.EncodeImage(AObject: TgtImageItem);
var
  LS: String;
  LATemp: AnsiString;
begin
  LS := GetHTMLImage(AObject, False);
  LATemp := AnsiString(LS);
  FBodyStream.Write(LATemp[1], Length(LS));
end;

(*
  Return JavaScript for page Navigator. JavaScript will be embedded in
  HEAD of the HTML Document
*)
function TgtCustomHTMLEngine.GetNavigatorJS: String;
const
  CTab = #09;
var
  LWindowPixelLeft, LWindowPixelTop: String;
begin
  LWindowPixelLeft := 'document.body.scrollLeft';
  if Navigator.NavigatorPosition in [npTopRight, npCenterRight,
    npBottomRight] then
    LWindowPixelLeft := LWindowPixelLeft + ' + ' +
      'document.body.clientWidth - ' + IntToStr(Round(FNavigatorWidth))
  else if Navigator.NavigatorPosition in [npTopCenter, npCenter,
    npBottomCenter] then
    LWindowPixelLeft := LWindowPixelLeft + ' + ' +
      '(document.body.clientWidth / 2) - ' +
      IntToStr(Round(FNavigatorWidth / 2));
  LWindowPixelTop := 'document.body.scrollTop';
  if Navigator.NavigatorPosition in [npCenterLeft, npCenter, npCenterRight] then
    LWindowPixelTop := LWindowPixelTop + ' + ' +
      '(document.body.clientHeight / 2) - ' +
      IntToStr(Round(FNavigatorHeight / 2))
  else if Navigator.NavigatorPosition in [npBottomLeft, npBottomCenter,
    npBottomRight] then
    LWindowPixelTop := LWindowPixelTop + ' + ' + 'document.body.clientHeight - '
      + IntToStr(Round(FNavigatorHeight));

  Result := '';
  if (Navigator.Enabled) then
    Result := Result + 'function floatNavigator() {' + CRLF + CTab +
      'if(document.all) {' + CRLF + CTab + CTab +
      'document.all.gtNavigator.style.pixelTop = ' + LWindowPixelTop + ';' +
      CRLF + CTab + CTab + 'document.all.gtNavigator.style.pixelLeft = ' +
      LWindowPixelLeft + ';' + CRLF + CTab + '}' + CRLF + CTab +
      'else if(document.getElementById){' + CRLF + CTab + CTab +
      'document.getElementById(''gtNavigator'').style.top = window.pageYOffset + ''px'';'
      + CRLF + CTab + CTab +
      'document.getElementById(''gtNavigator'').style.left = window.pageXOffset + ''px'';'
      + CRLF + CTab + '}' + CRLF + '}' + CRLF + 'if(document.all) {' + CRLF +
      CTab + 'window.onresize = SetResizeLeft;' + CRLF + CTab +
      'window.onscroll = floatNavigator;' + CRLF + '}' + CRLF +
      'else setInterval (''floatNavigator()'', 100);' + CRLF +
      'function initNavigator() {' + CRLF + CTab + 'if(document.all) {' + CRLF +
      CTab + CTab + 'document.all.gtNavigator.style.pixelTop = ' +
      LWindowPixelTop + ';' + CRLF + CTab + CTab +
      'document.all.gtNavigator.style.pixelLeft = ' + LWindowPixelLeft + ';' +
      CRLF + CTab + CTab +
      'document.all.gtNavigator.style.visibility = ''visible'';' + CRLF + CTab +
      '}' + CRLF + CTab + 'else if(document.getElementById) {' + CRLF + CTab +
      CTab + 'document.getElementById(''gtNavigator'').style.top = window.pageYOffset + ''px'';'
      + CRLF + CTab + CTab +
      'document.getElementById(''gtNavigator'').style.left = window.pageYOffset + ''px'';'
      + CRLF + CTab + CTab +
      'document.getElementById(''gtNavigator'').style.visibility = ''visible'';'
      + CRLF + CTab + '}' + CRLF + '}' + CRLF + 'function SetResizeLeft() {' +
      CRLF + CTab + 'if(document.all) {' + CRLF + CTab + CTab +
      'document.all.gtNavigator.style.pixelTop = ' + LWindowPixelTop + ';' +
      CRLF + CTab + CTab + 'document.all.gtNavigator.style.pixelLeft = ' +
      LWindowPixelLeft + ';' + CRLF + CTab + '}' + CRLF + CTab +
      'else if(document.getElementById) {' + CRLF + CTab + CTab +
      'document.getElementById(''gtNavigator'').style.top = window.pageYOffset + ''px'';'
      + CRLF + CTab + CTab +
      'document.getElementById(''gtNavigator'').style.left = window.pageYOffset + ''px'';'
      + CRLF + CTab + '}' + CRLF + '}';

  if Preferences.AutoScroll then
    Result := Result + CRLF + 'var speed = 1;' + CRLF +
      'var currentpos = 0, alt = 1, curpos1 = 0, curpos2 = -1;' + CRLF +
      'function initialize() {' + CRLF + CTab + 'startit();' + CRLF + '}' + CRLF
      + 'function scrollwindow() {' + CRLF + CTab +
      'if(document.all) temp=document.body.scrollTop;' + CRLF + CTab +
      'else temp=window.pageYOffset;' + CRLF + CTab + 'if(alt==0) alt = 1;' +
      CRLF + CTab + 'else alt = 0;' + CRLF + CTab + 'if(alt==0) curpos1 = temp;'
      + CRLF + CTab + 'else curpos2 = temp;' + CRLF + 'if(curpos1!=curpos2) {' +
      CRLF + CTab + CTab +
      'if (document.all) currentpos = document.body.scrollTop + speed;' + CRLF +
      CTab + CTab + 'else currentpos = window.pageYOffset + speed;' + CRLF +
      CTab + CTab + 'window.scroll(0, currentpos);' + CRLF + CTab + '}' + CRLF +
      'else{' + CRLF + CTab + CTab + 'currentpos = 0;' + CRLF + CTab + CTab +
      'window.scroll(0, currentpos);' + CRLF + CTab + '}' + CRLF + '}' + CRLF +
      'function startit(){' + CRLF + CTab + 'setInterval("scrollwindow()", 25);'
      + CRLF + '}' + CRLF;
  Result := Result + CRLF + 'function doAll(){' + CRLF;
  if Navigator.Enabled then
    Result := Result + 'initNavigator();' + CRLF;
  if Preferences.AutoScroll then
    Result := Result + 'initialize();' + CRLF;
  Result := Result + '}';
end;

procedure TgtCustomHTMLEngine.SetOutputScriptsToJSFile(const Value: Boolean);
begin
  FOutputScriptsToJSFile := Value;
end;

destructor TgtCustomHTMLEngine.Destroy;
begin
  FAttachmentList.Free;
  FNavigator.Free;
  FCustomMetaInfo.Free;
  inherited;
end;

procedure TgtCustomHTMLEngine.CalculateNavigatorDimensions;
var
  LPicture: TPicture;
  LNavWidth, LNavHeight: Double;
  LSize: TSize;
begin
  if Navigator.UseTextLinks then
  begin
    LSize := TextSize(Navigator.LinkTextFirst + ' ', Navigator.LinkFont);
    LNavWidth := LSize.cx;
    LNavHeight := LSize.cy;
  end
  else
  begin
    LPicture := TPicture.Create;
    try
      LPicture.LoadFromFile(Navigator.LinkImageFirst);
      LNavWidth := LPicture.Graphic.Width * 1.5;
      LNavHeight := LPicture.Graphic.Height * 1.5;
    finally
      LPicture.Free;
    end;
  end;
  case Navigator.NavigatorOrientation of
    noHorizontal:
      begin
        FNavigatorWidth := LNavWidth * 4.5;
        FNavigatorHeight := LNavHeight;
      end;
    noVertical:
      begin
        FNavigatorWidth := LNavWidth;
        FNavigatorHeight := LNavHeight * 4.5;
      end;
  end;
end;

procedure TgtCustomHTMLEngine.BeginPage;
begin
  inherited;
  if (not Preferences.SingleFile) then
  begin
    FBodyStream := TMemoryStream.Create;
    if (not OutputStylesToCSSFile) then
      FCSSClasses.Clear;
  end;

end;

function TgtCustomHTMLEngine.GetHTMLImage(AObject: TgtImageItem;
  AIsTableItem: Boolean): String;
var
  LFileName, LFileExt, LPrevFileName: String;
  LI: Integer;
  LReuseImageIndex: Integer;
  LSettings: TgtHTMLImageSettings;
  LBitmap: TbitMap;
  LCreateImg: Boolean;
begin
  LCreateImg := True;
  LReuseImageIndex := -1;
  LBitmap := nil;
  (* Reuse image with Settings list *)
  if Length(FImgSettingList) >= (AObject.IndexNo + 1) then
  begin
    if (FImgSettingList[AObject.IndexNo] <> nil) then
    begin
      with FImgSettingList[AObject.IndexNo] do
        for LI := 0 to Count - 1 do
          if ((TgtHTMLImageSettings(Items[LI])).IsEqual(AObject,
            GetGraphicResource(AObject.IndexNo).Width,
            GetGraphicResource(AObject.IndexNo).Height)) then
          begin
            LReuseImageIndex := LI;
            Break;
          end;
    end
    else
      FImgSettingList[AObject.IndexNo] := TList.Create;
  end
  else
  begin
    SetLength(FImgSettingList, (AObject.IndexNo + 1));
    FImgSettingList[AObject.IndexNo] := TList.Create;
  end;
  (* New image, add it to the list *)
  if (LReuseImageIndex = -1) then
  begin
    LFileName := FileName + '_' + IntToStr(FImageCount) + '_I';
    LPrevFileName := LFileName;
    Inc(FImageCount);
    LSettings := TgtHTMLImageSettings.Create;
    LSettings.Assign(AObject.Settings);
    LSettings.DispWidth := AObject.DisplayRect.Right - AObject.DisplayRect.Left;
    LSettings.DispHeight := AObject.DisplayRect.Bottom -
      AObject.DisplayRect.Top;
    LSettings.ImageWidth := AObject.Width;
    LSettings.ImageHeight := AObject.Height;

    if Assigned(OnNeedImageFileName) then
      OnNeedImageFileName(Self, Round(AObject.Width), Round(AObject.Height),
        AObject.Settings.OutputImageFormat, LFileName, LCreateImg);

    if LPrevFileName = LFileName then
    begin
      case AObject.Settings.OutputImageFormat of
        ifBMP:
          LFileExt := '.bmp';
        ifPNG:
          LFileExt := '.png';
        ifGIF:
          LFileExt := '.gif';
      else
        LFileExt := '.jpg';
      end;

      if (LCreateImg) then
      begin
        case AObject.Settings.OutputImageFormat of
          ifBMP:
            begin
              LBitmap := GetImageAsBitmap(AObject);
              LBitmap.SaveToFile(LFileName + LFileExt);
            end;
          ifPNG:
            begin
              LBitmap := GetImageAsBitmap(AObject);
              with TMemoryStream(GetBitmapAsPNGStream(LBitmap, clWhite)) do
                try
                  SaveToFile(LFileName + LFileExt);
                finally
                  Free;
                end;
            end;
          ifGIF:
            begin
              LBitmap := GetImageAsBitmap(AObject);
              with TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, False,
                AObject.Settings.JPEGQuality)) do
                try
                  SaveToFile(LFileName + LFileExt);
                finally
                  Free;
                end;
            end;
        else
          begin
            LBitmap := GetImageAsBitmap(AObject);
            with TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, True,
              AObject.Settings.JPEGQuality)) do
              try
                SaveToFile(LFileName + LFileExt);
              finally
                Free;
              end;
          end;
        end;
      end;
      FAttachmentList.Add(LFileName + LFileExt);
      LSettings.FFileName := 'file://' + LFileName + LFileExt;
    end
    else
    begin
      FAttachmentList.Add(LFileName);
      LSettings.FFileName := LFileName;
    end;
    LReuseImageIndex := FImgSettingList[AObject.IndexNo].Add(LSettings);
  end;
  (* Encode image with border into HTML document *)
  Result := '<div style="';
  if (not AIsTableItem) then
  begin
    Result := Result + FPositionAbsolute + 'top: ' +
      IntToStr((Round(AObject.DisplayRect.Top) + GetOffsetFromTop +
      AObject.Pen.Width - 1)) + 'px; ' + 'left: ' +
      IntToStr(Round(AObject.DisplayRect.Left)) + 'px; ';
  end;
  Result := Result + 'width: ' +
    IntToStr(Round(AObject.DisplayRect.Right - AObject.DisplayRect.Left + 2 *
    AObject.Pen.Width)) + 'px; ' + 'height: ' +
    IntToStr(Round(AObject.DisplayRect.Bottom - AObject.DisplayRect.Top + 2 *
    AObject.Pen.Width)) + 'px';
  if (AObject.Settings.IsFrame) then
  begin
    with AObject do
    begin
      if (Frame.IsLeft) then
        Result := Result + '; border-left: ' + IntToStr(Round(Pen.Width)) +
          'px ' + CLineStyle[Pen.Style] + ' #' + ColorBGRToRGB(Pen.Color);
      if (Frame.IsTop) then
        Result := Result + '; border-top: ' + IntToStr(Round(Pen.Width)) + 'px '
          + CLineStyle[Pen.Style] + ' #' + ColorBGRToRGB(Pen.Color);
      if (Frame.IsRight) then
        Result := Result + '; border-right: ' + IntToStr(Round(Pen.Width)) +
          'px ' + CLineStyle[Pen.Style] + ' #' + ColorBGRToRGB(Pen.Color);
      if (Frame.IsBottom) then
        Result := Result + '; border-bottom: ' + IntToStr(Round(Pen.Width)) +
          'px ' + CLineStyle[Pen.Style] + ' #' + ColorBGRToRGB(Pen.Color);
    end;
  end;
  Result := Result + ';">' + '<img style="';
  if (not AIsTableItem) then
    Result := Result + FPositionAbsolute + 'top: ' +
      IntToStr(Round(AObject.Y - AObject.DisplayRect.Top)) + 'px; ' + 'left: ' +
      IntToStr(Round(AObject.X - AObject.DisplayRect.Left)) + 'px; ';
  Result := Result + 'width: ' + IntToStr(Round(AObject.Width)) + 'px; height: '
    + IntToStr(Round(AObject.Height));
  with FImgSettingList[AObject.IndexNo] do
    // Result := Result + 'px;" src="' + 'file://' +
    // TgtHTMLImageSettings(Items[LReuseImageIndex]).FFileName +
    // '"></img></div>' + CRLF

    Result := Result + 'px;" src="' + TgtHTMLImageSettings
      (Items[LReuseImageIndex]).FFileName + '" alt="" ' + AddImgClose +
      '</div>' + CRLF;
  if (LBitmap <> nil) then
    LBitmap.Free;
end;

(* Check if the image format is supported by HTML *)
function TgtCustomHTMLEngine.CheckOutputImageFormat(Value: TgtOutputImageFormat;
  var S: String): Boolean;
begin
  Result := False;
  if (Value in [ifBMP, ifPNG, ifJPEG, ifGIF]) then
    Result := True
  else
    S := SUnsupportedHTMLImageFormat;
end;

(* This changes for XHTML document *)
function TgtCustomHTMLEngine.AddBR: String;
begin
  Result := '<br>';
end;

function TgtCustomHTMLEngine.AddHRClose: String;
begin
  Result := '>';
end;

function TgtCustomHTMLEngine.AddImgClose: String;
begin
  Result := '>';
end;

function TgtCustomHTMLEngine.AddMetaClose: String;
begin
  Result := '>';
end;

function TgtCustomHTMLEngine.AddShapeImgSrc(ImgWidth,
  ImgHeight: Integer): String;
begin
  Result := '" Width="' + IntToStr(Round(ImgWidth)) + '" Height="' +
    IntToStr(Round(ImgHeight)) + '" alt="" ' + AddImgClose + '</div>' + CRLF;
end;

function TgtCustomHTMLEngine.AddXHTMLHeader: String;
begin
  Result := '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">';
  // Result := '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 transitional//EN">';
end;

function TgtCustomHTMLEngine.AddXHTMLHeader2: String;
begin
  Result := '<html>'; // LR HTML
end;

(* Encode table as HTML tables *)
procedure TgtCustomHTMLEngine.EncodeTable(AObject: TgtTableItem);
var
  LI, LJ, LK, LL, LM: Integer;
  LTableWidth, LTmpHt: Double;
  LS, LS1, LS2, LS3: String;
  LText: WideString;
  LDocItem: TgtDocumentItem;
  LPen: TPen;
  LBrush: TBrush;
  LFont: TFont;
  LFrame: TgtFrame;
  LItemFound: Boolean;
  LTextItem: TgtTextItem;
  L, SrtPa, SrtRn, CuRn: Integer;
  LAlign: TgtHAlignment;
  LATemp: AnsiString;
begin
  LPen := TPen.Create;
  LBrush := TBrush.Create;
  LFont := TFont.Create;
  LFrame := TgtFrame.Create(Self);
  LTableWidth := 0;
  LTextItem := nil;
  if AObject.Settings.EnableTitle then
  begin
    LTextItem := TgtTextItem.Create;
    LTextItem.Font := AObject.Font;
    LTextItem.TextEffects := AObject.TextEffects;
  end;
  for LJ := 0 to (AObject.ColCount - 1) do
    LTableWidth := LTableWidth + AObject.Columns[LJ].Width;
  LS := '<table style="border-collapse: collapse; ' + FPositionAbsolute +
    'top: ' + IntToStr(Round(AObject.Y + GetOffsetFromTop + AObject.Pen.Width -
    1)) + 'px; ' + 'left: ' + IntToStr(Round(AObject.X)) + 'px; ' + 'width: ' +
    IntToStr(Round(LTableWidth)) + 'px; ';
  if AObject.Pen.Style = psClear then
    LS := LS + 'border: 0px'
  else
    LS := LS + 'border: ' + IntToStr(Round(AObject.Pen.Width)) + 'px ' +
      CLineStyle[AObject.Pen.Style] + ' #' + ColorBGRToRGB(AObject.Pen.Color);
  LS := LS + '">' + CRLF;
  L := 0;
  FTablenumber := L;
  while (TableOnLastpage[L] = True) do
  begin
    L := L + 1;
    FTablenumber := L;
  end;
  SrtPa := RowsOnPage[FTablenumber][0]; // Starting page number
  SrtRn := 0;
  CuRn := RowsOnPage[FTablenumber][(CurrentPage - SrtPa) + 1];
  // Number of rows on current page
  L := 1;
  while (L < (CurrentPage - SrtPa) + 1) do
  begin
    SrtRn := SrtRn + RowsOnPage[FTablenumber][L];
    L := L + 1;
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
  LI := SrtRn;
  while (LI <= SrtRn + CuRn - 1) do
  begin
    LS := LS + '<tr>' + CRLF;
    if (LI = -1) then
    begin
      (* Encode Column titles *)
      for LJ := 0 to (AObject.ColCount - 1) do
      begin
        LPen.Assign(AObject.Pen);
        LBrush.Assign(AObject.Brush);
        LFont.Assign(AObject.Font);
        LFrame.IsLeft := True;
        LFrame.IsTop := True;
        LFrame.IsRight := True;
        LFrame.IsBottom := True;
{$IFDEF gtActiveX}
        if Assigned(OnCellDraw) then
          OnCellDraw(Self, LI, LJ, LPen, LBrush, LFont, LFrame);
        if (Assigned(OnCellDrawEx)) then
          OnCellDrawEx(Self, LI, LJ, LPen, LBrush, LFont, LFrame, LAlign);
{$ELSE}
        if (Assigned(OnCellDraw)) then
          OnCellDraw(Self, LI, LJ, LPen, LBrush, LFont, LFrame, LAlign);
{$ENDIF}
        LS := LS + '<th style="text-align: ' + CHTMLAlignText
          [AObject.Columns[LJ].Alignment];
        if LPen.Style = psClear then
          LS := LS + '; border: 0px'
        else
          LS := LS + '; border: ' + IntToStr(Round(LPen.Width)) + 'px ' +
            CLineStyle[LPen.Style] + ' #' + ColorBGRToRGB(LPen.Color);
        LS := LS + '; width: ' + IntToStr(Round(AObject.Columns[LJ].Width)) +
          '; height: ' + IntToStr(Round(AObject.Settings.TitleHeight)) +
          '; padding: ' + IntToStr(Round(AObject.Settings.InternalMargin.Top)) +
          'px ' + IntToStr(Round(AObject.Settings.InternalMargin.Right)) + 'px '
          + IntToStr(Round(AObject.Settings.InternalMargin.Bottom)) + 'px ' +
          IntToStr(Round(AObject.Settings.InternalMargin.Left)) + 'px; ' +
          GetFontInfo(LFont);
        if (LBrush.Style = bsSolid) then
          LS := LS + '" bgcolor="' + ColorBGRToRGB(LBrush.Color);
        LS := LS + '">';
        LTextItem.Lines.Clear;
        with AObject.Settings.InternalMargin do
          WrapTextIntoLines(ReplacePlaceHolders(AObject.Columns[LJ].Title,
            True), AObject.Columns[LJ].Width - Left - Right, 0, LTextItem.Lines,
            AObject.Settings.AutoAdjustColumnWidth, LFont);
        if LTextItem.Lines[0] = '' then
          LTextItem.Lines.Delete(0);
        with AObject.Settings.InternalMargin do
          LTmpHt := LTextItem.Lines.Count * TextSize('W', LFont).cy +
            Top + Bottom;
        if (AObject.Settings.TitleHeight < LTmpHt) then
          AObject.Settings.TitleHeight := LTmpHt;
        (* for unicode *)
        if (Font.Charset <> ANSI_CHARSET) and
          ((Font.Charset <> DEFAULT_CHARSET) or (GetACP <> CANSIWinCode)) then
        begin
          LS3 := '';
          for LL := 0 to (LTextItem.Lines.Count) - 1 do
            for LM := 1 to Length(LTextItem.Lines.Strings[LL]) do
              if (Ord(LTextItem.Lines.Strings[LL][LM]) > 256) then
                LS3 := LS3 + '&#' +
                  IntToStr(Ord(LTextItem.Lines.Strings[LL][LM])) + ';'
              else
                LS3 := LS3 + LTextItem.Lines.Strings[LL][LM];
          LS3 := LS3 + AddBR;
        end
        else
        begin
          LS3 := '';
          for LL := 0 to (LTextItem.Lines.Count) - 1 do
            LS3 := LS3 + LTextItem.Lines[LL] + AddBR;
        end;

        if (AObject.Columns[LJ].Title <> '') then
          LS := LS + ConvertHyperLinks(SpacesToNBSP(LS3), LFont)

        else
          LS := LS + '&nbsp;';
        LS := LS + '</th>' + CRLF;
      end;
    end
    else
    begin
      for LJ := 0 to (AObject.ColCount - 1) do
      begin
        LPen.Assign(AObject.Pen);
        LBrush.Assign(AObject.Brush);
        LFont.Assign(AObject.Font);
        LFrame.IsLeft := True;
        LFrame.IsTop := True;
        LFrame.IsRight := True;
        LFrame.IsBottom := True;
{$IFDEF gtActiveX}
        if Assigned(OnCellDraw) then
          OnCellDraw(Self, LI, LJ, LPen, LBrush, LFont, LFrame);
        if (Assigned(OnCellDrawEx)) then
          OnCellDrawEx(Self, LI, LJ, LPen, LBrush, LFont, LFrame, LAlign);
{$ELSE}
        if (Assigned(OnCellDraw)) then
          OnCellDraw(Self, LI, LJ, LPen, LBrush, LFont, LFrame, LAlign);
{$ENDIF}
        LItemFound := False;
        LS1 := '<td';
        if (LBrush.Style = bsSolid) then
          LS1 := LS1 + ' bgcolor="' + ColorBGRToRGB(LBrush.Color) + '"';
        LS1 := LS1 + ' style="text-align: ' + CHTMLAlignText
          [AObject.Columns[LJ].Alignment];
        if LPen.Style = psClear then
          LS1 := LS1 + '; border: 0px'
        else
          LS1 := LS1 + '; border: ' + IntToStr(Round(LPen.Width)) + 'px ' +
            CLineStyle[LPen.Style] + ' #' + ColorBGRToRGB(LPen.Color);
        LS1 := LS1 + '; width: ' + IntToStr(Round(AObject.Columns[LJ].Width)) +
          '; height: ' + IntToStr(Round(Integer(AObject.RowHeights.Items[LI])))
          + '; padding: ' + IntToStr(Round(AObject.Settings.InternalMargin.Top))
          + 'px ' + IntToStr(Round(AObject.Settings.InternalMargin.Right)) +
          'px ' + IntToStr(Round(AObject.Settings.InternalMargin.Bottom)) +
          'px ' + IntToStr(Round(AObject.Settings.InternalMargin.Left)) + 'px';
        LS2 := '; ' + GetFontInfo(LFont) + '">';
        for LK := 0 to (AObject.RowItemsList[LI].Count - 1) do
        begin
          LDocItem := TgtDocumentItem(AObject.RowItemsList[LI].Items[LK]);
          if (LDocItem is TgtTextItem) then
          begin
            TgtTextItem(LDocItem).Font := LFont;
            TgtTextItem(LDocItem).Brush := LBrush;
            if (TgtTextItem(LDocItem).X = LJ) then
            begin
              with LDocItem as TgtTextItem do
              begin
                LS2 := '; ' + GetFontInfo(Font) + '">';

                LText := '';

                (* for unicode *)
                if (Font.Charset <> ANSI_CHARSET) and
                  ((Font.Charset <> DEFAULT_CHARSET) or
                  (GetACP <> CANSIWinCode)) then
                begin
                  LS3 := '';
                  for LL := 0 to Lines.Count - 1 do
                    for LM := 1 to Length(Lines.Strings[LL]) do
                      if (Ord(Lines[LL][LM]) > 256) then
                        LS3 := LS3 + '&#' + IntToStr(Ord(Lines[LL][LM])) + ';'
                      else
                        LS3 := LS3 + Lines[LL][LM];
                  LText := LS3;
                end
                else
                  for LL := 0 to Lines.Count - 1 do
                    LText := LText + ConvertHyperLinks
                      (SpacesToNBSP
                      (String(RemoveTerminalCRLF(AnsiString(Trim(Lines[LL]))))),
                      Font) + CRLF;

                LText := ReplacePlaceHolders(LText, True);
                if (LText <> '') then
                  LS1 := LS1 + LS2 + ReplaceString(LText, CRLF, AddBR + CRLF)
                else
                  LS1 := LS1 + LS2 + '&nbsp;';
                LItemFound := True;
                Break;
              end;
            end;
          end
          else if (LDocItem is TgtImageItem) then
          begin
            TgtImageItem(LDocItem).Pen := LPen;
            TgtImageItem(LDocItem).Brush := LBrush;
            if (TgtImageItem(LDocItem).X = LJ) then
            begin
              LS1 := LS1 + LS2 + GetHTMLImage(TgtImageItem(LDocItem), True);
              LItemFound := True;
              Break;
            end;
          end
        end;
        if (not LItemFound) then
          LS1 := LS1 + LS2;
        LS := LS + LS1 + '</td>' + CRLF;
      end;
    end;
    LS := LS + '</tr>' + CRLF;
    Inc(LI);
  end;
  LS := LS + '</table>' + CRLF;
  LATemp := AnsiString(LS);
  FBodyStream.Write(LATemp[1], Length(LS));
  if (LBrush <> nil) then
    LBrush.Free;
  if (LPen <> nil) then
    LPen.Free;
  if (LFont <> nil) then
    LFont.Free;
  if (LFrame <> nil) then
    LFrame.Free;
  if (LTextItem <> nil) then
    LTextItem.Free;
end;

procedure TgtCustomHTMLEngine.EncodeParagraph(AObject: TgtParagraphItem);
var
  LText: WideString;
  LS: String;
  LATemp: AnsiString;
  LI: Integer;
begin
  with AObject do
  begin
    LText := '';
    for LI := 0 to Lines.Count - 1 do
      LText := LText + Lines[LI];
    LText := ReplacePlaceHolders(LText, True);

    (* for unicode *)
    if (Font.Charset <> ANSI_CHARSET) and
      ((Font.Charset <> DEFAULT_CHARSET) or (GetACP <> CANSIWinCode)) then
    begin
      LS := '';
      for LI := 1 to Length(LText) do

        case Ord(LText[LI]) of
          38:
            LS := LS + '&amp;';
          60:
            LS := LS + '&lt;';
          62:
            LS := LS + '&gt;';
          162:
            LS := LS + '&cent;';
          163:
            LS := LS + '&pound;';
          165:
            LS := LS + '&yen;';
          167:
            LS := LS + '&sect;';
          169:
            LS := LS + '&copy;';
          174:
            LS := LS + '&reg;';
          8364:
            LS := LS + '&euro;';
          8482:
            LS := LS + '&trade;';
          8220:
            LS := LS + '&ldquo;';
          8221:
            LS := LS + '&rdquo';

        else
          if Ord(LText[LI]) > 256 then
            LS := LS + '&#' + IntToStr(Ord(LText[LI])) + ';'
          else
            LS := LS + LText[LI];
        end;
      LText := LS;
    end;
    LText := ReplaceString(LText, #8482, '&trade;');
    LText := ReplaceString(LText, #34, '&quot;');

    LS := Copy(LText, Length(LText) - 1, 2);
    if LS = CRLF then
      System.Delete(LText, Length(LText) - 1, 2)
    else
      LS := '';
    LText := ConvertHyperLinks(LText, Font) + LS;

    (* HTML does not recognize CRLF as newline, hence use <br/> *)
    LText := ReplaceString(LText, CRLF, AddBR + CRLF);
    LS := '<div style="' + FPositionAbsolute + 'top: ' +
      IntToStr(Round(Y + GetOffsetFromTop)) + 'px; ' + 'left: ' +
      IntToStr(Round(X)) + 'px; ' + 'margin-left: ' +
      IntToStr(Round(Settings.LeftIndent)) + 'px; ' + 'margin-right: ' +
      IntToStr(Round(Settings.RightIndent)) + 'px; ' + 'width: ' +
      IntToStr(Round(Width *
      1.09 { need about 1-2 more pixel width for IE vs other browser } ) + 1) +
      'px; ' + 'height: ' + IntToStr(Round(Height)) + 'px">' + CRLF +
      '<p style="position: relative; ' + 'text-indent: ' +
      IntToStr(Round(Settings.FirstLineIndent)) + 'px; ' + 'line-height: ' +
      IntToStr(Round(Settings.LineSpacing * TextSize('W', Font).cy)) + 'px; ';
    // LText := ReplaceString(LText, CRLF, '<br/>' + CRLF);
    // LS := '<div style="' + FPositionAbsolute + 'top: ' +
    // IntToStr(Round(Y + GetOffsetFromTop)) + 'px; ' + 'left: ' +
    // IntToStr(Round(X)) + 'px; ' + 'margin-left: ' +
    // IntToStr(Round(Settings.LeftIndent)) + 'px; ' + 'margin-right: ' +
    // IntToStr(Round(Settings.RightIndent)) + 'px; ' + 'width: ' +
    // IntToStr(Round(Width)) + 'px; ' + 'height: ' + IntToStr(Round(Height)) +
    // 'px">' + CRLF + '<p style="position: relative; ' + 'text-indent: ' +
    // IntToStr(Round(Settings.FirstLineIndent)) + 'px; ' + 'line-height: ' +
    // IntToStr(Round(Settings.LineSpacing * TextSize('W', Font).cy)) + 'px; ';

    if (Brush.Style = bsSolid) then
      LS := LS + 'background-color: #' + ColorBGRToRGB(Brush.Color) + '; ';
    LS := LS + 'text-align: ' + CHTMLAlignText[Settings.Alignment] + '; ' +
      GetFontInfo(AObject.Font) + '">' + Trim(LText) + '</p>' + CRLF +
      '</div>' + CRLF;
    LATemp := AnsiString(LS);
    FBodyStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomHTMLEngine.SetCSSFileName(const Value: String);
begin
  FCSSFileName := Value;
end;

procedure TgtCustomHTMLEngine.SetJSFileName(const Value: String);
begin
  FJSFileName := Value;
end;

procedure TgtCustomHTMLEngine.EncodeTOC;
begin
  (* Pro Version contains the implementation for this procedure *)
end;

procedure TgtCustomHTMLEngine.InsertAnchors(AStream: TStream);
begin
  (* Pro Version contains the implementation for this procedure *)
end;

function TgtCustomHTMLEngine.ShowSetupModal: Word;
begin
  with TgtHTMLEngineDlg.Create(nil) do
    try
      Engine := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function TgtCustomHTMLEngine.GetPreferences: TgtHTMLPreferences;
begin
  Result := TgtHTMLPreferences( inherited Preferences);
end;

procedure TgtCustomHTMLEngine.SetPreferences(const Value: TgtHTMLPreferences);
begin
  inherited Preferences := Value;
  with Preferences do
  begin
    SingleFile := Value.SingleFile;
    AutoScroll := Value.AutoScroll;
    OptimizeForIE := Value.OptimizeForIE;
    PageEndLines := Value.PageEndLines;
  end;
end;

function TgtCustomHTMLEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtHTMLPreferences;
end;

{$IFDEF EMailSupport}

procedure TgtCustomHTMLEngine.CreateEMailSettingsObj;
begin
  inherited;
  EMailSettings.Attachments.AddStrings(FAttachmentList);
end;
{$ENDIF}

procedure TgtCustomHTMLEngine.NewPage;
var
  LFileName: String;
begin
  inherited;
  if (not FIsDocumentStarted) then
    Exit;
  with Preferences do
  begin
    LFileName := FileName;
    if (not SingleFile) then
      LFileName := LFileName + IntToStr(CurrentPage);
    if ((not(SingleFile or OutputToUserStream or ProcessAfterEachPage)) and
      (Assigned(OnNeedFileName))) then
      OnNeedFileName(Self, LFileName, CurrentPage);
    EngineFileNames.Add(LFileName + '.' + FileExtension);
  end;
end;
{$IFNDEF gtRegistered}

procedure TgtCustomHTMLEngine.PutTrialNote;
begin
  PutTrialNoteOnTop;
end;
{$ENDIF}

procedure TgtCustomHTMLEngine.SetCustomMetaInfo(const Value
  : TgtHTMLCustomMetaInfo);
begin
  FCustomMetaInfo := Value;
end;

function TgtCustomHTMLEngine.GetHTMLFileNames: TStringList;
begin
  Result := EngineFileNames;
end;

procedure TgtCustomHTMLEngine.SetTransparentBackground(const Value: Boolean);
begin
  FTransparentBackground := Value;
end;

procedure TgtCustomHTMLEngine.SetOnNeedImageFileName
  (const Value: TgtOnNeedImageFileNameEvent);
begin
  FOnNeedImageFileName := Value;
end;

{ TgtHTMLNavigator }

constructor TgtHTMLNavigator.Create;
begin
  FEnabled := True;
  FLinkTextTOC := SLinkTextTOC;
  FLinkTextFirst := SLinkTextFirst;
  FLinkTextPrev := SLinkTextPrev;
  FLinkTextNext := SLinkTextNext;
  FLinkTextLast := SLinkTextLast;
  FLinkFont := TFont.Create;
  FLinkFont.Name := 'Wingdings';
  FLinkFont.Size := 20;
  FLinkFont.Color := CLinkForeColor;
  FLinkBackColor := CLinkBackColor;
  FLinkHoverForeColor := CLinkHoverForeColor;
  FLinkHoverBackColor := CLinkHoverBackColor;
  FLinkImageFirst := '';
  FLinkImageNext := '';
  FLinkImagePrev := '';
  FLinkImageLast := '';
  FNavigatorOrientation := noHorizontal;
  FNavigatorPosition := npBottomRight;
  FNavigatorType := ntFixedToScreen;
  FUseTextLinks := True;
end;

destructor TgtHTMLNavigator.Destroy;
begin
  FLinkFont.Free;
  inherited;
end;

function TgtHTMLNavigator.IsLinkTextFirstStored: Boolean;
begin
  Result := FLinkTextFirst <> SLinkTextFirst;
end;

function TgtHTMLNavigator.IsLinkTextLastStored: Boolean;
begin
  Result := FLinkTextLast <> SLinkTextLast;
end;

function TgtHTMLNavigator.IsLinkTextNextStored: Boolean;
begin
  Result := FLinkTextNext <> SLinkTextNext;
end;

function TgtHTMLNavigator.IsLinkTextPrevStored: Boolean;
begin
  Result := FLinkTextPrev <> SLinkTextPrev;
end;

function TgtHTMLNavigator.IsLinkTextTOCStored: Boolean;
begin
  Result := FLinkTextTOC <> SLinkTextTOC;
end;

procedure TgtHTMLNavigator.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TgtHTMLNavigator.SetLinkBackColor(const Value: TColor);
begin
  FLinkBackColor := Value;
end;

procedure TgtHTMLNavigator.SetLinkFont(Value: TFont);
begin
  FLinkFont.Assign(Value);
end;

procedure TgtHTMLNavigator.SetLinkHoverBackColor(const Value: TColor);
begin
  FLinkHoverBackColor := Value;
end;

procedure TgtHTMLNavigator.SetLinkHoverForeColor(const Value: TColor);
begin
  FLinkHoverForeColor := Value;
end;

procedure TgtHTMLNavigator.SetLinkImageFirst(const Value: String);
begin
  FLinkImageFirst := Value;
end;

procedure TgtHTMLNavigator.SetLinkImageLast(const Value: String);
begin
  FLinkImageLast := Value;
end;

procedure TgtHTMLNavigator.SetLinkImageNext(const Value: String);
begin
  FLinkImageNext := Value;
end;

procedure TgtHTMLNavigator.SetLinkImagePrev(const Value: String);
begin
  FLinkImagePrev := Value;
end;

procedure TgtHTMLNavigator.SetLinkImageTOC(const Value: String);
begin
  FLinkImageTOC := Value;
end;

procedure TgtHTMLNavigator.SetLinkTextFirst(const Value: String);
begin
  FLinkTextFirst := Value;
end;

procedure TgtHTMLNavigator.SetLinkTextLast(const Value: String);
begin
  FLinkTextLast := Value;
end;

procedure TgtHTMLNavigator.SetLinkTextNext(const Value: String);
begin
  FLinkTextNext := Value;
end;

procedure TgtHTMLNavigator.SetLinkTextPrev(const Value: String);
begin
  FLinkTextPrev := Value;
end;

procedure TgtHTMLNavigator.SetLinkTextTOC(const Value: String);
begin
  FLinkTextTOC := Value;
end;

function TgtHTMLNavigator.SetNavigatorOrientation: TgtHTMLNavigatorOrientation;
begin
  Result := FNavigatorOrientation;
end;

procedure TgtHTMLNavigator.SetNavigatorPosition(const Value
  : TgtHTMLNavigatorPosition);
begin
  FNavigatorPosition := Value;
end;

procedure TgtHTMLNavigator.SetNavigatorType(const Value: TgtHTMLNavigatorType);
begin
  FNavigatorType := Value;
end;

procedure TgtHTMLNavigator.SetUseTextLinks(const Value: Boolean);
begin
  FUseTextLinks := Value;
end;

{ TgtHTMLImageSettings }

constructor TgtHTMLImageSettings.Create;
begin
  inherited;
  FFileName := '';

end;

destructor TgtHTMLImageSettings.Destroy;
begin

  inherited;
end;

(* Check if image can be reused, or a new image needs to be created *)
function TgtHTMLImageSettings.IsEqual(AObject: TgtImageItem;
  AOriginalWidth, AOriginalHeight: Double): Boolean;
begin
  Result := False;
  with AObject do
  begin
    if OutputImageFormat = Settings.OutputImageFormat then
    begin
      if (OutputImageFormat = ifJPEG) and
        (JPEGQuality <> Settings.JPEGQuality) then
        Exit;
    end
    else
      Exit;
    if (ImagePixelFormat <> Settings.ImagePixelFormat) then
      Exit;
    if (SourceDPI <> Settings.SourceDPI) then
      Exit;
    if (AutoSize <> Settings.AutoSize) then
      Exit;
    if (Stretch <> Settings.Stretch) then
    begin
      if (Stretch) then
      begin
        if ((Width <> AOriginalWidth) or (Height <> AOriginalHeight)) then
          Exit
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
        (ImageWidth <> AOriginalWidth) or (ImageHeight <> AOriginalHeight) then
        Exit;
    end
    else if (Center) and (Settings.Center) then
    begin
      if ((ImageWidth = AOriginalWidth) and
        (ImageHeight = AOriginalHeight)) then
      begin
        if ((Width < AOriginalWidth) or (Height < AOriginalHeight)) then
          Exit;
      end
      else
      begin
        if ((ImageWidth <> Width) or (ImageHeight <> Height)) then
          Exit;
      end;
    end;
    if ((ImageWidth <> Width) or (ImageHeight <> Height)) then
      Exit;
    Result := True;
  end;
end;

procedure TgtHTMLImageSettings.SetDispHeight(const Value: Double);
begin
  FDispHeight := Value;
end;

procedure TgtHTMLImageSettings.SetDispWidth(const Value: Double);
begin
  FDispWidth := Value;
end;

procedure TgtHTMLImageSettings.SetFileName(const Value: String);
begin
  FFileName := Value;
end;

procedure TgtHTMLImageSettings.SetImageHeight(const Value: Double);
begin
  FImageHeight := Value;
end;

procedure TgtHTMLImageSettings.SetImageWidth(const Value: Double);
begin
  FImageWidth := Value;
end;

{ TgtHTMLPreferences }

procedure TgtHTMLPreferences.SetAutoScroll(const Value: Boolean);
begin
  FAutoScroll := Value;
end;

procedure TgtHTMLPreferences.SetOptimizeForIE(const Value: Boolean);
begin
  FOptimizeForIE := Value;
end;

procedure TgtHTMLPreferences.SetPageEndLines(const Value: Boolean);
begin
  FPageEndLines := Value;
end;

procedure TgtHTMLPreferences.SetSingleFile(const Value: Boolean);
begin
  FSingleFile := Value;
end;

{ TgtHTMLCustomMetaInfo }
constructor TgtHTMLCustomMetaInfo.Create;
begin
  inherited;
  FNames := TStringList.Create;
  FValues := TStringList.Create;
end;

destructor TgtHTMLCustomMetaInfo.Destroy;
begin
  FNames.Free;
  FValues.Free;
  inherited;
end;

procedure TgtHTMLCustomMetaInfo.SetNames(const Value: TStringList);
begin
  FNames.Assign(Value);
end;

procedure TgtHTMLCustomMetaInfo.SetValues(const Value: TStringList);
begin
  FValues.Assign(Value);
end;

end.
