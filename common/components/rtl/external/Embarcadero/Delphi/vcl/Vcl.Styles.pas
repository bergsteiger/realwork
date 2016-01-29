{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Styles;

interface

{$HPPEMIT '#pragma link "Vcl.Styles"'}
{$WARN UNSUPPORTED_CONSTRUCT OFF}

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Winapi.CommCtrl,
  System.Generics.Collections, System.ZLib, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Themes;

type
  TCustomStyle = class(TCustomStyleServices)
  private
    FCustomElements: array[TThemedElement] of TCustomElementServicesClass;
    FSource: TObject; { TseSkin }
    function InternalDrawText(DC: HDC; Details: TThemedElementDetails;
      const S: string; const R: TRect; Flags: TTextFormat; Color: TColor): Boolean;
    function SourceLoaded: Boolean;
  protected
    // Implementation for TCustomStyleServices.ColorToRGB
    function DoColorToRGB(Color: TColor; Details: PThemedElementDetails): TColorRef; override;
    // Implementation for TCustomStyleServices.DrawEdge
    function DoDrawEdge(DC: HDC; Details: TThemedElementDetails; const R: TRect;
      Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawElement
    function DoDrawElement(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; ClipRect: PRect): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawIcon
    function DoDrawIcon(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawParentBackground
    function DoDrawParentBackground(Window: HWND; Target: HDC; Details: PThemedElementDetails;
      OnlyIfTransparent: Boolean; Bounds: PRect): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawText
    function DoDrawText(DC: HDC; Details: TThemedElementDetails; const S: string;
      var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; overload; override;
    // Implementation for TCustomStyleServices.GetElementContentRect
    function DoGetElementContentRect(DC: HDC; Details: TThemedElementDetails;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementColor
    function DoGetElementColor(Details: TThemedElementDetails;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementMargins
    function DoGetElementMargins(DC: HDC; Details: TThemedElementDetails; Rect: PRect;
      ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementRegion
    function DoGetElementRegion(DC: HDC; Details: TThemedElementDetails;
      const Rect: TRect; out Region: HRGN): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementSize
    function DoGetElementSize(DC: HDC; Details: TThemedElementDetails; Rect: PRect;
      ElementSize: TElementSize; out Size: TSize): Boolean; override;
    // Implementation for TCustomStyleServices.GetStyleColor
    function DoGetStyleColor(Color: TStyleColor): TColor; override;
    // Implementation for TCustomStyleServices.GetStyleFontColor
    function DoGetStyleFontColor(Font: TStyleFont): TColor; override;
    // Implementation for TCustomStyleServices.GetSystemColor
    function DoGetSystemColor(Color: TColor): TColor; override;
    // Implementation for TCustomStyleServices.GetTextExtent
    function DoGetTextExtent(DC: HDC; Details: TThemedElementDetails; const Text: string;
      Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean; override;
    // Implementation for TCustomStyleServices.HasTransparentParts
    function DoHasTransparentParts(Details: TThemedElementDetails): Boolean; override;
    // Implementation for TCustomStyleServices.HasFixedPosition
    function DoHasElementFixedPosition(Details: TThemedElementDetails): Boolean; override;
    // Implementation for TCustomStyleServices.ValidateStyle
    class function DoIsValidStyle(Stream: TStream; StyleInfo: PStyleInfo): Boolean; override;

    function GetAvailable: Boolean; override;
    function GetEnabled: Boolean; override;
    function GetName: string; override;
    function GetTheme(Element: TThemedElement): THandle; override;
    function GetFlags: TCustomStyleServices.TStyleFlags; override;
    procedure UnloadThemeData; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure UpdateThemes; override;

    function GetElementDetails(Detail: TThemedButton): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedCategoryButtons): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedCategoryPanelGroup): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedCheckListBox): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedClock): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedComboBox): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedControlBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedDataNavButtons): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedDatePicker): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedEdit): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedFlyOut): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedExplorerBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedHeader): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedHint): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedGrid): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedLink): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedListView): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedMenu): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedMenuBand): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedMonthCal): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedNavigation): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedPage): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedPanel): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedProgress): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedRebar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedScrollBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedSpin): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedStartPanel): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedStatus): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTab): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTabSet): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTaskBand): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTaskBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTaskDialog): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTextLabel): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTextStyle): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedToolBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedToolTip): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTrackBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTrayNotify): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTreeview): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedWindow): TThemedElementDetails; override;

    class function LoadFromStream(Stream: TStream): TCustomStyleServices; override;
    procedure PaintBorder(Control: TWinControl; EraseLRCorner: Boolean); override;
    procedure SaveToStream(Stream: TStream); override;
  end;

  TStyleEngine = class(TCustomStyleEngine)
  public const
    ResourceTypeName = 'VCLSTYLE';
    FileExtension = '.vsf';
  strict private type
    TControlList = TDictionary<TComponent, TStyleHook>;
  strict private
    class var FControls: TControlList;
    class procedure DoRemoveControl(Control: TWinControl); virtual;
    class procedure DoUnregisterStyleHook(ControlClass: TClass; StyleHookClass: TStyleHookClass); virtual;
    class procedure FreeControlHooks;
  public
    class constructor Create;
    class destructor Destroy;
    class function HandleMessage(Control: TWinControl; var Message: TMessage;
      DefWndProc: TWndMethod): Boolean; override;
    class procedure Notification(Operation: TCustomStyleEngine.TStyleEngineNotification; Data: Pointer); override;
  end;

  TUxThemeStyleElements = class(TCustomElementServices)
  strict protected
    class function GetThemedElement: TThemedElement; virtual; abstract;
  public
    class function DrawEdge(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; override;
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function DrawIcon(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean; override;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementContentRect(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    class function GetElementMargins(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; Margin: TElementMargin; out ElementMargins: TElementMargins): Boolean; override;
    class function GetElementRegion(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const Rect: TRect; out Region: HRGN): Boolean; override;
    class function GetElementSize(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean; override;
    class function GetTextExtent(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const Text: string; Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean; override;
    class function HasTransparentParts(Style: TCustomStyleServices; Part, State: Integer): Boolean; override;
  end;

  // Implements specifics for teCategoryButtons elements
  TCustomStyleCategoryButtonElements = class(TUxThemeCategoryButtonElements)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teCategoryPanelGroup elements
  TCustomStyleCategoryPanelGroupElements = class(TUxThemeCategoryPanelGroupElements)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    class function GetElementSize(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean; override;
  end;

  // Implements specifics for teControlBar elements
  TCustomStyleControlBarElements = class(TUxThemeControlBarElements)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teDataNavButtons elements
  TCustomStyleDataNavButtonElements = class(TCustomElementServices)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function GetElementContentRect(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; override;
  end;

  // Implements specifics for teGrid elements
  TCustomStyleGridElements = class(TUxThemeGridElements)
  public
    class function DrawEdge(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; override;
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teHint elements
  TCustomStyleHintElements = class(TUxThemeHintElements)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teListView elements
  TCustomStyleListViewElements = class(TUxThemeStyleElements)
  strict protected
    class function GetThemedElement: TThemedElement; override;
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teMenu elements
  TCustomStyleMenuElements = class(TCustomElementServices)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    class function GetElementMargins(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; Margin: TElementMargin; out ElementMargins: TElementMargins): Boolean; override;
    class function GetElementSize(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean; override;
  end;

  // Implements specifics for tePanel elements
  TCustomStylePanelElements = class(TUxThemePanelElements)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teTabSet elements
  TCustomStyleTabSetElements = class(TUxThemeTabSetElements)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teTextLabel elements
  TCustomStyleTextLabelElements = class(TUxThemeTextLabelElements)
  public
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teToolBar elements
  TCustomStyleToolBarElements = class(TCustomElementServices)
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    class function GetElementContentRect(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; override;
    class function HasTransparentParts(Style: TCustomStyleServices; Part, State: Integer): Boolean; override;
    class function DrawEdge(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; override;
  end;

  // Implements specifics for teTreeView elements
  TCustomStyleTreeViewElements = class(TUxThemeStyleElements)
  strict protected
    class function GetThemedElement: TThemedElement; override;
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

implementation

uses
  System.Types, System.UITypes, System.SysUtils, Winapi.UxTheme, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Mask, Vcl.GraphUtil, Vcl.ImgList, Vcl.Menus, Vcl.Grids, Vcl.CategoryButtons,
  Vcl.ButtonGroup, Vcl.ExtCtrls, Vcl.Consts;

{$I StyleUtils.inc}
{$I StyleAPI.inc}

const
  THEME_BP_PUSHBUTTON = 1;
  THEME_BP_RADIOBUTTON = 2;
  THEME_BP_CHECKBOX = 3;
  THEME_BP_GROUPBOX = 4;

  THEME_TP_DROPDOWNBUTTON = 5;
  THEME_TP_BUTTON = 6;

  THEME_EP_EDITTEXT = 11;
  THEME_EP_CARET = 12;

  THEME_HP_HEADERITEM = 13;
  THEME_HP_HEADERITEMLEFT = 14;
  THEME_HP_HEADERITEMRIGHT = 15;
  THEME_HP_HEADERSORTARROW = 16;

  THEME_RP_GRIPPER = 17;
  THEME_RP_GRIPPERVERT = 18;
  THEME_RP_BAND = 19;
  THEME_RP_CHEVRON = 20;
  THEME_RP_CHEVRONVERT = 21;
  THEME_SP_PANE = 22;
  THEME_SP_GRIPPERPANE = 23;
  THEME_SP_GRIPPER = 24;

  THEME_SPNP_UP = 25;
  THEME_SPNP_DOWN = 26;
  THEME_SPNP_UPHORZ = 27;
  THEME_SPNP_DOWNHORZ = 28;

  THEME_SBP_ARROWBTN = 29;
  THEME_SBP_THUMBBTNHORZ = 30;
  THEME_SBP_THUMBBTNVERT = 31;
  THEME_SBP_LOWERTRACKHORZ = 32;
  THEME_SBP_UPPERTRACKHORZ = 33;
  THEME_SBP_LOWERTRACKVERT = 34;
  THEME_SBP_UPPERTRACKVERT = 35;
  THEME_SBP_GRIPPERHORZ = 36;
  THEME_SBP_GRIPPERVERT = 37;
  THEME_SBP_SIZEBOX = 38;

  THEME_TABP_TABITEM = 39;
  THEME_TABP_TABITEMLEFTEDGE = 40;
  THEME_TABP_TABITEMRIGHTEDGE = 41;
  THEME_TABP_TABITEMBOTHEDGE = 42;
  THEME_TABP_TOPTABITEM = 43;
  THEME_TABP_TOPTABITEMLEFTEDGE = 44;
  THEME_TABP_TOPTABITEMRIGHTEDGE = 45;
  THEME_TABP_TOPTABITEMBOTHEDGE = 46;
  THEME_TABP_PANE = 47;
  THEME_TABP_BODY = 48;

  THEME_PP_BAR = 49;
  THEME_PP_BARVERT = 50;
  THEME_PP_CHUNK = 51;
  THEME_PP_CHUNKVERT = 52;

  THEME_TKP_TRACK = 53;
  THEME_TKP_TRACKVERT = 54;
  THEME_TKP_THUMB = 55;
  THEME_TKP_THUMBBOTTOM = 56;
  THEME_TKP_THUMBTOP = 57;
  THEME_TKP_THUMBVERT = 58;
  THEME_TKP_THUMBLEFT = 59;
  THEME_TKP_THUMBRIGHT = 60;
  THEME_TKP_TICS = 61;
  THEME_TKP_TICSVERT = 62;

  THEME_WP_CAPTION = 77;
  THEME_WP_SMALLCAPTION = 78;
  THEME_WP_MINCAPTION = 79;
  THEME_WP_SMALLMINCAPTION = 80;
  THEME_WP_MAXCAPTION = 81;
  THEME_WP_SMALLMAXCAPTION = 82;
  THEME_WP_FRAMELEFT = 83;
  THEME_WP_FRAMERIGHT = 84;
  THEME_WP_FRAMEBOTTOM = 85;
  THEME_WP_SMALLFRAMELEFT = 86;
  THEME_WP_SMALLFRAMERIGHT = 87;
  THEME_WP_SMALLFRAMEBOTTOM = 88;
  
  THEME_WP_SYSBUTTON = 89;
  THEME_WP_MDISYSBUTTON = 90;
  THEME_WP_MINBUTTON = 91;
  THEME_WP_MDIMINBUTTON = 92;
  THEME_WP_MAXBUTTON = 93;
  THEME_WP_CLOSEBUTTON = 94;
  THEME_WP_SMALLCLOSEBUTTON = 95;
  THEME_WP_MDICLOSEBUTTON = 96;
  THEME_WP_RESTOREBUTTON = 97;
  THEME_WP_MDIRESTOREBUTTON = 98;
  THEME_WP_HELPBUTTON = 99;
  THEME_WP_MDIHELPBUTTON = 100;
  THEME_WP_HORZSCROLL = 101;
  THEME_WP_HORZTHUMB = 102;
  THEME_WP_VERTSCROLL = 103;
  THEME_WP_VERTTHUMB = 104;
  THEME_WP_DIALOG = 105;
  THEME_WP_CAPTIONSIZINGTEMPLATE = 106;
  THEME_WP_SMALLCAPTIONSIZINGTEMPLATE = 107;
  THEME_WP_FRAMELEFTSIZINGTEMPLATE = 108;
  THEME_WP_SMALLFRAMELEFTSIZINGTEMPLATE = 109;
  THEME_WP_FRAMERIGHTSIZINGTEMPLATE = 110;
  THEME_WP_SMALLFRAMERIGHTSIZINGTEMPLATE = 111;
  THEME_WP_FRAMEBOTTOMSIZINGTEMPLATE = 112;
  THEME_WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE = 113;
  THEME_WP_FRAME = 114;

  THEME_ABS_UPNORMAL = 201;
  THEME_ABS_UPHOT = 202;
  THEME_ABS_UPPRESSED = 203;
  THEME_ABS_UPDISABLED = 204;
  THEME_ABS_DOWNNORMAL = 205;
  THEME_ABS_DOWNHOT = 206;
  THEME_ABS_DOWNPRESSED = 207;
  THEME_ABS_DOWNDISABLED = 208;
  THEME_ABS_LEFTNORMAL = 209;
  THEME_ABS_LEFTHOT = 210;
  THEME_ABS_LEFTPRESSED = 211;
  THEME_ABS_LEFTDISABLED = 212;
  THEME_ABS_RIGHTNORMAL = 213;
  THEME_ABS_RIGHTHOT = 214;
  THEME_ABS_RIGHTPRESSED = 215;
  THEME_ABS_RIGHTDISABLED = 216;

  THEME_BP_COMMANDLINK = 217;
  THEME_BP_COMMANDLINKGLYPH = 218;

  THEME_EP_BORDER = 219;

  THEME_FS_ACTIVE = 1;
  THEME_FS_INACTIVE = 2;

  var
    THEME_WP_BUTTONS: TseWindowButtons = [];

// Get font from DC to Canvas method
function GetFontFromDC(ADC: HDC): TGDIHandleRecall;
var
  OldFontHandle: HFont;
  LogFont: TLogFont;
begin
  Result := TGDIHandleRecall.Create(ADC, OBJ_FONT);
  OldFontHandle := SelectObject(ADC, Result.Canvas.Font.Handle);
  FillChar(LogFont, SizeOf(LogFont), 0);
  GetObject(OldFontHandle, SizeOf(LogFont), @LogFont);
  Result.Canvas.Font.Handle := CreateFontIndirect(LogFont);
end;


// Helper functions for TCustomElementServices descendants

function GetElementObject(Style: TCustomStyle; const ControlName, ElementName: string): TseStyleObject;
var
  LSource: TseStyle;
begin
  Result := nil;
  LSource := TseStyle(Style.FSource);
  if (LSource <> nil) and (LSource.StyleSource <> nil) then
  begin
    Result := LSource.StyleSource.GetObjectByName(ControlName);
    if Result <> nil then
      Result := Result.FindObjectByName(ElementName);
  end;
end;

function DrawButtonElement(Style: TCustomStyle; DC: HDC; const R: TRect; ClipRect: PRect;
  const ControlName, ElementName: string; State: TSeState): Boolean;
var
  LObject: TseStyleObject;
begin
  Result := False;
  LObject := GetElementObject(TCustomStyle(Style), ControlName, ElementName);
  if LObject <> nil then
  begin
    LObject.BoundsRect := R;
    TseButtonObject(LObject).State := State;
    with TGDIHandleRecall.Create(DC, OBJ_FONT) do
    try
      if ClipRect <> nil then
        LObject.Draw(Canvas, ClipRect^)
      else
        LObject.Draw(Canvas, NullRect);
    finally
      Free;
    end;
    Result := True;
  end;
end;

function DrawBitmapElement(Style: TCustomStyle; DC: HDC; const R: TRect; ClipRect: PRect;
  const ControlName, ElementName: string): Boolean;
var
  LObject: TseStyleObject;
begin
  Result := False;
  LObject := GetElementObject(TCustomStyle(Style), ControlName, ElementName);
  if LObject <> nil then
  begin
    LObject.BoundsRect := R;
    with TGDIHandleRecall.Create(DC, OBJ_FONT) do
    try
      if ClipRect <> nil then
        LObject.Draw(Canvas, ClipRect^)
      else
        LObject.Draw(Canvas, NullRect);
    finally
      Free;
    end;
    Result := True;
  end;
end;

{ TCustomStyle }

constructor TCustomStyle.Create;
begin
  inherited Create;
  FSource := TObject(TseStyle.Create);
  // Windows elements
  FCustomElements[teListView] := TCustomStyleListViewElements;
  FCustomElements[teMenu] := TCustomStyleMenuElements;
  FCustomElements[teToolBar] := TCustomStyleToolBarElements;
  FCustomElements[teTreeview] := TCustomStyleTreeViewElements;
  // VCL elements
  FCustomElements[teCategoryButtons] := TCustomStyleCategoryButtonElements;
  FCustomElements[teCategoryPanelGroup] := TCustomStyleCategoryPanelGroupElements;
  FCustomElements[teControlBar] := TCustomStyleControlBarElements;
  FCustomElements[teCheckListBox] := TUxThemeCheckListBoxElements;
  FCustomElements[teDataNavButtons] := TCustomStyleDataNavButtonElements;
  FCustomElements[teGrid] := TCustomStyleGridElements;
  FCustomElements[teHint] := TCustomStyleHintElements;
  FCustomElements[tePanel] := TCustomStylePanelElements;
  FCustomElements[teTabSet] := TCustomStyleTabSetElements;
  FCustomElements[teTextLabel] := TCustomStyleTextLabelElements;
end;

destructor TCustomStyle.Destroy;
begin
  FSource.Free;
  inherited;
end;

procedure TCustomStyle.UpdateThemes;
begin
end;

procedure TCustomStyle.UnloadThemeData;
begin
end;

function TCustomStyle.GetTheme(Element: TThemedElement): THandle;
begin
  Result := 0;
end;

function TCustomStyle.GetFlags: TCustomStyleServices.TStyleFlags;
begin
  Result := [sfHandleMessages];
end;

function TCustomStyle.DoHasTransparentParts(Details: TThemedElementDetails): Boolean;
begin
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].HasTransparentParts(Self, Details.Part, Details.State)
  else
    case Details.Element of
      teButton,
      teProgress,
      teScrollbar:
        Result := True;
    else
      Result := False;
    end;
end;

class function TCustomStyle.DoIsValidStyle(Stream: TStream; StyleInfo: PStyleInfo): Boolean;
var
  DStream: TDecompressionStream;
  S: array [0..12] of AnsiChar;
begin
  // Read Filter Sign
  Stream.Read(S, SizeOf(S));
  Result := (S = StyleFileSign) or (S = StyleFileSign_1_0);
  if Result and (StyleInfo <> nil) then
  begin
    DStream := TDecompressionStream.Create(Stream);
    try
      // Read te SkinName property
      StyleInfo.Name := ReadString(DStream);
      StyleInfo.Version := ReadString(DStream);
      StyleInfo.Author := ReadString(DStream);
      StyleInfo.AuthorEMail := ReadString(DStream);
      StyleInfo.AuthorURL := ReadString(DStream);
    finally
      DStream.Free;
    end;
  end;
end;

function TCustomStyle.DoGetElementSize(DC: HDC; Details: TThemedElementDetails;
 Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean;
var
  LStyleObject: TSeStyleObject;
  LBitmapLink: TseBitmapLink;
  R, LRect: TRect;
begin
  Size := TSize.Create(0, 0);
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].GetElementSize(Self, DC, Details.Part,
      Details.State, Rect, ElementSize, Size)
  else
  begin
    Result := False;

    if Rect <> nil then
      LRect := Rect^
    else
      LRect := TRect.Empty;

    if (Details.Part >= THEME_WP_CAPTION) and
       (Details.Part <= THEME_WP_SMALLFRAMEBOTTOM) then
      LRect := System.Classes.Rect(0, 0, 100, 100);

    if SourceLoaded then
      case Details.Part of
        THEME_BP_CHECKBOX:
          begin
            LBitmapLink := nil;
            case TSeCheckDrawState(Details.State) of
              kcdsUncheckedNormal..kcdsUncheckedDisabled:
                begin
                  LStyleObject := GetElementObject(Self, 'CheckBox', 'Unchecked'); // do not localize
                  if LStyleObject is TSeButtonObject then
                    case TSeCheckDrawState(Details.State) of
                      kcdsUncheckedNormal: LBitmapLink := TSeButtonObject(LStyleObject).Bitmap;
                      kcdsUncheckedHot: LBitmapLink := TSeButtonObject(LStyleObject).BitmapHot;
                      kcdsUncheckedPressed: LBitmapLink := TSeButtonObject(LStyleObject).BitmapPressed;
                      kcdsUncheckedDisabled: LBitmapLink := TSeButtonObject(LStyleObject).BitmapDisabled;
                    end;
                end;
              kcdsCheckedNormal..kcdsCheckedDisabled:
                begin
                  LStyleObject := GetElementObject(Self, 'CheckBox', 'Checked'); // do not localize
                  if LStyleObject is TSeButtonObject then
                    case TSeCheckDrawState(Details.State) of
                      kcdsCheckedNormal: LBitmapLink := TSeButtonObject(LStyleObject).Bitmap;
                      kcdsCheckedHot: LBitmapLink := TSeButtonObject(LStyleObject).BitmapHot;
                      kcdsCheckedPressed: LBitmapLink := TSeButtonObject(LStyleObject).BitmapPressed;
                      kcdsCheckedDisabled: LBitmapLink := TSeButtonObject(LStyleObject).BitmapDisabled;
                    end;
                end;
              kcdsMixedNormal..kcdsMixedDisabled:
                begin
                  LStyleObject := GetElementObject(Self, 'CheckBox', 'Mixed'); // do not localize
                  if LStyleObject is TSeButtonObject then
                    case TSeCheckDrawState(Details.State) of
                      kcdsMixedNormal: LBitmapLink := TSeButtonObject(LStyleObject).Bitmap;
                      kcdsMixedHot: LBitmapLink := TSeButtonObject(LStyleObject).BitmapHot;
                      kcdsMixedPressed: LBitmapLink := TSeButtonObject(LStyleObject).BitmapPressed;
                      kcdsMixedDisabled: LBitmapLink := TSeButtonObject(LStyleObject).BitmapDisabled;
                    end;
                end;
            end;

            if LBitmapLink <> nil then
              Size := LBitmapLink.Rect.Size
            else
              with TStyleManager.SystemStyle do
                if not GetElementSize(DC, GetElementDetails(tbCheckBoxCheckedNormal),
                   LRect, ElementSize, Size) then
                begin
                  Size.cx := 13;
                  Size.cy := 13;
                end;
            Result := True;
          end;
        THEME_WP_CAPTION:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscStandard, LRect);
          Size.cx := 0;
          Size.cy := R.Top;
          Result := True;
        end;
        THEME_WP_FRAMELEFT:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscStandard, LRect);
          Size.cx := R.Left;
          Size.cy := 0;
          Result := True;
        end;
        THEME_WP_FRAMERIGHT:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscStandard, LRect);
          Size.cx := LRect.Right - R.Right;
          Size.cy := 0;
          Result := True;
        end;
        THEME_WP_FRAMEBOTTOM:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscStandard, LRect);
          Size.cx := 0;
          Size.cy := LRect.Bottom - R.Bottom;
          Result := True;
        end;

       THEME_WP_SMALLCAPTION:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscToolWindow, LRect);
          Size.cx := 0;
          Size.cy := R.Top;
          Result := True;
        end;
        THEME_WP_SMALLFRAMELEFT:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscToolWindow, LRect);
          Size.cx := R.Left;
          Size.cy := 0;
          Result := True;
        end;
        THEME_WP_SMALLFRAMERIGHT:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscToolWindow, LRect);
          Size.cx := LRect.Right - R.Right;
          Size.cy := 0;
          Result := True;
        end;
        THEME_WP_SMALLFRAMEBOTTOM:
        begin
          R := TseStyle(FSource).WindowGetClientRect(kwscToolWindow, LRect);
          Size.cx := 0;
          Size.cy := LRect.Bottom - R.Bottom;
          Result := True;
        end;
      end;
  end;
end;

function TCustomStyle.DoGetStyleColor(Color: TStyleColor): TColor;
begin
  case Color of
    scBorder: Result := TSeStyle(FSource).Colors[ktcBorder];
    scButtonDisabled: Result := TSeStyle(FSource).Colors[ktcButtonDisabled];
    scButtonFocused: Result := TSeStyle(FSource).Colors[ktcButtonFocused];
    scButtonHot: Result := TSeStyle(FSource).Colors[ktcButtonHot];
    scButtonNormal: Result := TSeStyle(FSource).Colors[ktcButton];
    scButtonPressed: Result := TSeStyle(FSource).Colors[ktcButtonPressed];
    scCategoryButtons: Result := TSeStyle(FSource).Colors[ktcCategoryButtons];
    scCategoryButtonsGradientBase: Result := TSeStyle(FSource).Colors[ktcCategoryButtonsGradientBase];
    scCategoryButtonsGradientEnd: Result := TSeStyle(FSource).Colors[ktcCategoryButtonsGradientEnd];
    scCategoryPanelGroup: Result := TSeStyle(FSource).Colors[ktcCategoryPanelGroup];
    scComboBox: Result := TSeStyle(FSource).Colors[ktcComboBox];
    scComboBoxDisabled: Result := TSeStyle(FSource).Colors[ktcComboBoxDisabled];
    scEdit: Result := TSeStyle(FSource).Colors[ktcEdit];
    scEditDisabled: Result := TSeStyle(FSource).Colors[ktcEditDisabled];
    scGrid: Result := TSeStyle(FSource).Colors[ktcGrid];
    scGenericBackground: Result := TSeStyle(FSource).Colors[ktcGenericBackground];
    scGenericGradientEnd: Result := TSeStyle(FSource).Colors[ktcGenericGradientEnd];
    scGenericGradientBase: Result := TSeStyle(FSource).Colors[ktcGenericGradientBase];
    scHintGradientBase: Result := TSeStyle(FSource).Colors[ktcHintGradientBase];
    scHintGradientEnd: Result := TSeStyle(FSource).Colors[ktcHintGradientEnd];
    scListBox: Result := TSeStyle(FSource).Colors[ktcListBox];
    scListBoxDisabled: Result := TSeStyle(FSource).Colors[ktcListBoxDisabled];
    scListView: Result := TSeStyle(FSource).Colors[ktcListView];
    scPanel: Result := TSeStyle(FSource).Colors[ktcPanel];
    scPanelDisabled: Result := TSeStyle(FSource).Colors[ktcPanelDisabled];
    scSplitter: Result := TSeStyle(FSource).Colors[ktcSplitter];
    scToolBarGradientBase: Result := TSeStyle(FSource).Colors[ktcToolBarGradientBase];
    scToolBarGradientEnd: Result := TSeStyle(FSource).Colors[ktcToolBarGradientEnd];
    scTreeView: Result := TSeStyle(FSource).Colors[ktcTreeView];
    scWindow: Result := TSeStyle(FSource).Colors[ktcWindow];
  else
    Result := clNone;
  end;
end;

function TCustomStyle.DoGetStyleFontColor(Font: TStyleFont): TColor;
begin
  case Font of
    sfButtonTextDisabled: Result := TSeStyle(FSource).Fonts[ktfButtonTextDisabled].Color;
    sfButtonTextFocused: Result := TSeStyle(FSource).Fonts[ktfButtonTextFocused].Color;
    sfButtonTextHot: Result := TseStyle(FSource).Fonts[ktfButtonTextHot].Color;
    sfButtonTextNormal: Result := TseStyle(FSource).Fonts[ktfButtonTextNormal].Color;
    sfButtonTextPressed: Result := TseStyle(FSource).Fonts[ktfButtonTextPressed].Color;
    sfCaptionTextInactive: Result := TseStyle(FSource).Fonts[ktfCaptionTextInactive].Color;
    sfCaptionTextNormal: Result := TseStyle(FSource).Fonts[ktfCaptionTextNormal].Color;
    sfCategoryPanelGroupHeaderHot: Result := TseStyle(FSource).Fonts[ktfCategoryPanelGroupHeaderHot].Color;
    sfCategoryPanelGroupHeaderNormal: Result := TseStyle(FSource).Fonts[ktfCategoryPanelGroupHeaderNormal].Color;
    sfCatgeoryButtonsCategoryNormal: Result := TseStyle(FSource).Fonts[ktfCatgeoryButtonsCategoryNormal].Color;
    sfCatgeoryButtonsCategorySelected: Result := TseStyle(FSource).Fonts[ktfCatgeoryButtonsCategorySelected].Color;
    sfCatgeoryButtonsHot: Result := TseStyle(FSource).Fonts[ktfCatgeoryButtonsHot].Color;
    sfCatgeoryButtonsNormal: Result := TseStyle(FSource).Fonts[ktfCatgeoryButtonsNormal].Color;
    sfCatgeoryButtonsSelected: Result := TseStyle(FSource).Fonts[ktfCatgeoryButtonsSelected].Color;
    sfCheckBoxTextDisabled: Result := TseStyle(FSource).Fonts[ktfCheckBoxTextDisabled].Color;
    sfCheckBoxTextFocused: Result := TseStyle(FSource).Fonts[ktfCheckBoxTextFocused].Color;
    sfCheckBoxTextHot: Result := TseStyle(FSource).Fonts[ktfCheckBoxTextHot].Color;
    sfCheckBoxTextNormal: Result := TseStyle(FSource).Fonts[ktfCheckBoxTextNormal].Color;
    sfCheckBoxTextPressed: Result := TseStyle(FSource).Fonts[ktfCheckBoxTextPressed].Color;
    sfComboBoxItemDisabled: Result := TseStyle(FSource).Fonts[ktfComboBoxItemDisabled].Color;
    sfComboBoxItemFocused: Result := TseStyle(FSource).Fonts[ktfComboBoxItemFocused].Color;
    sfComboBoxItemHot: Result := TseStyle(FSource).Fonts[ktfComboBoxItemHot].Color;
    sfComboBoxItemNormal: Result := TseStyle(FSource).Fonts[ktfComboBoxItemNormal].Color;
    sfComboBoxItemSelected: Result := TseStyle(FSource).Fonts[ktfComboBoxItemSelected].Color;
    sfEditBoxTextDisabled: Result := TseStyle(FSource).Fonts[ktfEditBoxTextDisabled].Color;
    sfEditBoxTextFocused: Result := TseStyle(FSource).Fonts[ktfEditBoxTextFocused].Color;
    sfEditBoxTextHot: Result := TseStyle(FSource).Fonts[ktfEditBoxTextHot].Color;
    sfEditBoxTextNormal: Result := TseStyle(FSource).Fonts[ktfEditBoxTextNormal].Color;
    sfEditBoxTextSelected: Result := TseStyle(FSource).Fonts[ktfEditBoxTextSelected].Color;
    sfGridItemFixedHot: Result := TseStyle(FSource).Fonts[ktfGridItemFixedHot].Color;
    sfGridItemFixedNormal: Result := TseStyle(FSource).Fonts[ktfGridItemFixedNormal].Color;
    sfGridItemFixedPressed: Result := TseStyle(FSource).Fonts[ktfGridItemFixedPressed].Color;
    sfGridItemNormal: Result := TseStyle(FSource).Fonts[ktfGridItemNormal].Color;
    sfGridItemSelected: Result := TseStyle(FSource).Fonts[ktfGridItemSelected].Color;
    sfGroupBoxTextDisabled: Result := TseStyle(FSource).Fonts[ktfGroupBoxTextDisabled].Color;
    sfGroupBoxTextNormal: Result := TseStyle(FSource).Fonts[ktfGroupBoxTextNormal].Color;
    sfHeaderSectionTextDisabled: Result := TseStyle(FSource).Fonts[ktfHeaderSectionTextDisabled].Color;
    sfHeaderSectionTextHot: Result := TseStyle(FSource).Fonts[ktfHeaderSectionTextHot].Color;
    sfHeaderSectionTextNormal: Result := TseStyle(FSource).Fonts[ktfHeaderSectionTextNormal].Color;
    sfHeaderSectionTextPressed: Result := TseStyle(FSource).Fonts[ktfHeaderSectionTextPressed].Color;
    sfListItemTextDisabled: Result := TseStyle(FSource).Fonts[ktfListItemTextDisabled].Color;
    sfListItemTextFocused: Result := TseStyle(FSource).Fonts[ktfListItemTextFocused].Color;
    sfListItemTextHot: Result := TseStyle(FSource).Fonts[ktfListItemTextHot].Color;
    sfListItemTextNormal: Result := TseStyle(FSource).Fonts[ktfListItemTextNormal].Color;
    sfListItemTextSelected: Result := TseStyle(FSource).Fonts[ktfListItemTextSelected].Color;
    sfMenuItemTextDisabled: Result := TseStyle(FSource).Fonts[ktfMenuItemTextDisabled].Color;
    sfMenuItemTextHot: Result := TseStyle(FSource).Fonts[ktfMenuItemTextHot].Color;
    sfMenuItemTextNormal: Result := TseStyle(FSource).Fonts[ktfMenuItemTextNormal].Color;
    sfMenuItemTextSelected: Result := TseStyle(FSource).Fonts[ktfMenuItemTextSelected].Color;
    sfPanelTextDisabled: Result := TseStyle(FSource).Fonts[ktfPanelTextDisabled].Color;
    sfPanelTextNormal: Result := TseStyle(FSource).Fonts[ktfPanelTextNormal].Color;
    sfPopupMenuItemTextDisabled: Result := TseStyle(FSource).Fonts[ktfPopupMenuItemTextDisabled].Color;
    sfPopupMenuItemTextHot: Result := TseStyle(FSource).Fonts[ktfPopupMenuItemTextHot].Color;
    sfPopupMenuItemTextNormal: Result := TseStyle(FSource).Fonts[ktfPopupMenuItemTextNormal].Color;
    sfPopupMenuItemTextSelected: Result := TseStyle(FSource).Fonts[ktfPopupMenuItemTextSelected].Color;
    sfRadioButtonTextDisabled: Result := TseStyle(FSource).Fonts[ktfRadioButtonTextDisabled].Color;
    sfRadioButtonTextFocused: Result := TseStyle(FSource).Fonts[ktfRadioButtonTextFocused].Color;
    sfRadioButtonTextHot: Result := TseStyle(FSource).Fonts[ktfRadioButtonTextHot].Color;
    sfRadioButtonTextNormal: Result := TseStyle(FSource).Fonts[ktfRadioButtonTextNormal].Color;
    sfRadioButtonTextPressed: Result := TseStyle(FSource).Fonts[ktfRadioButtonTextPressed].Color;
    sfSmCaptionTextInactive: Result := TseStyle(FSource).Fonts[ktfSmCaptionTextInactive].Color;
    sfSmCaptionTextNormal: Result := TseStyle(FSource).Fonts[ktfSmCaptionTextNormal].Color;
    sfStatusPanelTextDisabled: Result := TseStyle(FSource).Fonts[ktfStatusPanelTextDisabled].Color;
    sfStatusPanelTextNormal: Result := TseStyle(FSource).Fonts[ktfStatusPanelTextNormal].Color;
    sfTabTextActiveDisabled: Result := TseStyle(FSource).Fonts[ktfTabTextActiveDisabled].Color;
    sfTabTextActiveHot: Result := TseStyle(FSource).Fonts[ktfTabTextActiveHot].Color;
    sfTabTextActiveNormal: Result := TseStyle(FSource).Fonts[ktfTabTextActiveNormal].Color;
    sfTabTextInactiveDisabled: Result := TseStyle(FSource).Fonts[ktfTabTextInactiveDisabled].Color;
    sfTabTextInactiveHot: Result := TseStyle(FSource).Fonts[ktfTabTextInactiveHot].Color;
    sfTabTextInactiveNormal: Result := TseStyle(FSource).Fonts[ktfTabTextInactiveNormal].Color;
    sfTextLabelDisabled: Result := TseStyle(FSource).Fonts[ktfStaticTextDisabled].Color;
    sfTextLabelFocused: Result := TseStyle(FSource).Fonts[ktfStaticTextFocused].Color;
    sfTextLabelHot: Result := TseStyle(FSource).Fonts[ktfStaticTextHot].Color;
    sfTextLabelNormal: Result := TseStyle(FSource).Fonts[ktfStaticTextNormal].Color;
    sfToolItemTextDisabled: Result := TseStyle(FSource).Fonts[ktfToolItemTextDisabled].Color;
    sfToolItemTextHot: Result := TseStyle(FSource).Fonts[ktfToolItemTextHot].Color;
    sfToolItemTextNormal: Result := TseStyle(FSource).Fonts[ktfToolItemTextNormal].Color;
    sfToolItemTextSelected: Result := TseStyle(FSource).Fonts[ktfToolItemTextSelected].Color;
    sfTreeItemTextDisabled: Result := TseStyle(FSource).Fonts[ktfTreeItemTextDisabled].Color;
    sfTreeItemTextFocused: Result := TseStyle(FSource).Fonts[ktfTreeItemTextFocused].Color;
    sfTreeItemTextHot: Result := TseStyle(FSource).Fonts[ktfTreeItemTextHot].Color;
    sfTreeItemTextNormal: Result := TseStyle(FSource).Fonts[ktfTreeItemTextNormal].Color;
    sfTreeItemTextSelected: Result := TseStyle(FSource).Fonts[ktfTreeItemTextSelected].Color;
    sfWindowTextDisabled: Result := TseStyle(FSource).Fonts[ktfWindowTextDisabled].Color;
    sfWindowTextNormal: Result := TseStyle(FSource).Fonts[ktfWindowTextNormal].Color;
  else
    Result := clNone;
  end;
end;

function TCustomStyle.DoGetSystemColor(Color: TColor): TColor;
begin
  Result := TseStyle(FSource).SysColors[Color];
  if Result = TColor(clNone) then
    Result := Color;
end;

function TCustomStyle.DoGetElementMargins(DC: HDC; Details: TThemedElementDetails;
  Rect: PRect; ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean;
begin
  FillChar(Margins, SizeOf(Margins), 0);
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].GetElementMargins(Self, DC, Details.Part,
      Details.State, Rect, ElementMargin, Margins)
  else
    Result := False;
end;

function TCustomStyle.DoGetElementRegion(DC: HDC; Details: TThemedElementDetails;
  const Rect: TRect; out Region: HRGN): Boolean;
begin
  Result := False;
  if Details.Element = teWindow
  then
    begin
      case Details.Part of
        THEME_WP_CAPTION:
          begin
            Region := TseStyle(FSource).WindowGetRegion(kwscStandard, Rect);
            if Region = 0
            then
              Region := CreateRectRgn(Rect.Left, Rect.Top,
                Rect.Right, Rect.Bottom);
            Result := True;
          end;
        THEME_WP_SMALLCAPTION:
          begin
            Region := TseStyle(FSource).WindowGetRegion(kwscToolWindow, Rect);
            if Region = 0
            then
               Region := CreateRectRgn(Rect.Left, Rect.Top,
                Rect.Right, Rect.Bottom);
             Result := True;
          end;
      end;

    end;
end;

function TCustomStyle.DoColorToRGB(Color: TColor; Details: PThemedElementDetails): TColorRef;
begin
  if SourceLoaded then
    Result := TseStyle(FSource).SysColors.Colors[Color]
  else
    Result := Color;
end;

function TCustomStyle.DoDrawEdge(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean;
var
  DrawRect: TRect;
begin
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].DrawEdge(Self, DC, Details.Part,
      Details.State, R, Edges, Flags, ContentRect)
  else
  begin
    Result := True;
    DrawRect := R;
    if ContentRect <> nil then
      DrawStyleEdge(DC, ContentRect^, Edges, Flags)
    else
      DrawStyleEdge(DC, DrawRect, Edges, Flags)
  end;
end;

function TCustomStyle.DoDrawElement(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; ClipRect: PRect): Boolean;
var
  WI: TseWindowInfo;
  CR, MR: TRect;
  Buffer: TBitmap;
  WC: TseWindowSubclass;
  LCanvas: TCanvas;
  LFontRecall: TGDIHandleRecall;
begin
  Result := False;
  if not SourceLoaded then
    Exit;

  if FCustomElements[Details.Element] <> nil then
  begin
    Result := FCustomElements[Details.Element].DrawElement(Self, DC,
      Details.Part, Details.State, R, ClipRect);
    Exit;
  end;

  LFontRecall := TGDIHandleRecall.Create(DC, OBJ_FONT);
  try
    LCanvas := LFontRecall.Canvas;

    with Details, TseStyle(FSource) do
      case Element of
        teButton:
          begin
            Result := True;
            if Part = THEME_BP_PUSHBUTTON then
              ButtonDraw(kbscButton, LCanvas, ButtonInfo(R, TseButtonDrawState(State)))
            else
            if Part = THEME_BP_CHECKBOX then
              CheckDraw(kcscCheckBox, LCanvas, CheckInfo(R, TSeCheckDrawState(State)))
            else
            if Part = THEME_BP_RADIOBUTTON then
              CheckDraw(kcscRadioButton, LCanvas, CheckInfo(R, TSeCheckDrawState(State)))
            else
            if Part = THEME_BP_GROUPBOX then
              GroupDraw(kgscGroupBox, LCanvas, GroupInfo(R, NullRect, TSeGroupDrawState(State)))
            else
            if Part = THEME_BP_COMMANDLINKGLYPH then
            begin
              DrawButtonElement(Self, LCanvas.Handle, R, ClipRect,
                'Button', 'CommandLinkGlyph', TseState(State));
            end
            else
              Result := False;
          end;
        teEdit:
          begin
            Result := True;
            if Part = THEME_EP_EDITTEXT then
              EditDraw(kescEdit, LCanvas, EditInfo(R, TSeEditDrawState(State)))
            else if Part = THEME_EP_CARET then
              EditDraw(kescEdit, LCanvas, EditInfo(R, kedsNormal))
            else if Part = THEME_EP_BORDER then
              EditDraw(kescEdit, LCanvas, EditInfo(R, TSeEditDrawState(State)))
            else
              Result := False;
          end;
        teComboBox:
          begin
            Result := True;
            if Part = THEME_TP_DROPDOWNBUTTON then
            begin
              Buffer := TBitmap.Create;
              try
                Buffer.SetSize(R.Right - R.Left, R.Bottom - R.Top);
                with Buffer.Canvas do
                begin
                  Brush.Color := ColorToRGB(clWindow);
                  FillRect(Rect(0, 0, Buffer.Width, Buffer.Height));
                end;
                EditDrawButton(kescEdit, Buffer.Canvas,
                  EditButtonInfo(Rect(0, 0, Buffer.Width, Buffer.Height),
                    TSeEditButtonDrawState(State), kebcDropDown));
                LCanvas.Draw(R.Left, R.Top, Buffer);
              finally
                Buffer.Free;
              end;
            end
            else if Part = THEME_EP_BORDER then
            begin
              EditDraw(kescEdit, LCanvas, EditInfo(R, TSeEditDrawState(State)))
            end
            else
              Result := False;
          end;
        teHeader:
          begin
            Result := True;
            if Part = 0 then
            begin
              HeaderDraw(khscHeader, LCanvas, HeaderInfo(R));
            end;
            if (Part = THEME_HP_HEADERITEM) then
              HeaderDrawSection(khscHeader, LCanvas,
                 HeaderSectionInfo(R, khssMiddle, TSeSectionDrawState(State)))
            else
            if (Part = THEME_HP_HEADERITEMLEFT) then
              HeaderDrawSection(khscHeader, LCanvas,
                 HeaderSectionInfo(R, khssFirst, TSeSectionDrawState(State)))
            else
            if (Part = THEME_HP_HEADERITEMRIGHT) then
              HeaderDrawSection(khscHeader, LCanvas,
                 HeaderSectionInfo(R, khssLast, TSeSectionDrawState(State)))
            else
              Result := False;
          end;
        teTab:
          begin
            Result := True;
            case Part of
              THEME_TABP_PANE: TabDraw(ktscTab, LCanvas, TabInfo(R));
              THEME_TABP_BODY: TabDraw(ktscTab, LCanvas, TabInfo(R));

              THEME_TABP_TABITEMLEFTEDGE:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisLeftMiddle, TSeTabItemDrawState(State)));

              THEME_TABP_TOPTABITEMLEFTEDGE:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisLeftFirst, TSeTabItemDrawState(State)));

              THEME_TABP_TABITEMRIGHTEDGE:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisRightMiddle, TSeTabItemDrawState(State)));

              THEME_TABP_TOPTABITEMRIGHTEDGE:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisRightFirst, TSeTabItemDrawState(State)));

              THEME_TABP_TABITEM:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisTopMiddle, TSeTabItemDrawState(State)));

              THEME_TABP_TOPTABITEM:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisTopFirst, TSeTabItemDrawState(State)));

              THEME_TABP_TABITEMBOTHEDGE:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisBottomMiddle, TSeTabItemDrawState(State)));

              THEME_TABP_TOPTABITEMBOTHEDGE:
                TabDrawItem(ktscTab, LCanvas,
                  TabItemInfo(R, ktisBottomFirst, TSeTabItemDrawState(State)));

              else
                Result := False;
            end;
          end;

        tePage:
          begin
            TabDraw(ktscTab, LCanvas, TabInfo(R));
            Result := True;
          end;

        teTrackBar:
          begin
            Result := True;
            if Part = THEME_TKP_TRACK then
              TrackBarDraw(ktscTrackBar, LCanvas, TrackBarInfo(R, ktbcHorizontal, ktrbdsNormal))
            else
            if Part = THEME_TKP_TRACKVERT then
              TrackBarDraw(ktscTrackBar, LCanvas, TrackBarInfo(R, ktbcVertical, ktrbdsNormal))
            else
            if (Part = THEME_TKP_THUMB) then
              TrackDrawThumb(ktscTrackBar, LCanvas, TrackThumbInfo(R, ktbmHorzBoth, TSeTrackThumbDrawState(State)))
            else
            if Part = THEME_TKP_THUMBVERT then
              TrackDrawThumb(ktscTrackBar, LCanvas, TrackThumbInfo(R, ktbmVertBoth, TSeTrackThumbDrawState(State)))
            else
            if Part = THEME_TKP_THUMBBOTTOM then
              TrackDrawThumb(ktscTrackBar, LCanvas, TrackThumbInfo(R, ktbmHorzBottom, TSeTrackThumbDrawState(State)))
            else
            if Part = THEME_TKP_THUMBTOP then
              TrackDrawThumb(ktscTrackBar, LCanvas, TrackThumbInfo(R, ktbmHorzTop, TSeTrackThumbDrawState(State)))
            else
            if Part = THEME_TKP_THUMBLEFT then
              TrackDrawThumb(ktscTrackBar, LCanvas, TrackThumbInfo(R, ktbmVertLeft, TSeTrackThumbDrawState(State)))
            else
            if Part = THEME_TKP_THUMBRIGHT then
              TrackDrawThumb(ktscTrackBar, LCanvas, TrackThumbInfo(R, ktbmVertRight, TSeTrackThumbDrawState(State)))
            else
            if Part = THEME_TKP_TICS then
            begin
            end
            else
            if Part = THEME_TKP_TICSVERT then
            begin
            end
            else
              Result := False;
          end;

        teProgress:
          begin
            Result := True;
            if Part = THEME_PP_BAR then
              ProgressDraw(kpscProgressBar, LCanvas, ProgressInfo(R, kppBarHorz, kpdsNormal))
            else
            if Part = THEME_PP_BARVERT then
              ProgressDraw(kpscProgressBar, LCanvas, ProgressInfo(R, kppBarVert, kpdsNormal))
            else
            if Part = THEME_PP_CHUNK then
              ProgressDraw(kpscProgressBar, LCanvas, ProgressInfo(R, kppChunkHorz, kpdsNormal))
            else
            if Part = THEME_PP_CHUNKVERT then
              ProgressDraw(kpscProgressBar, LCanvas, ProgressInfo(R, kppChunkVert, kpdsNormal))
            else
              Result := False;
          end;
        teStatus:
          begin
            Result := True;
            if Part = 0 then
            begin
              StatusDraw(ksscStatusBar, LCanvas, StatusInfo(R));
            end;
            if Part = THEME_SP_PANE then
            begin
              StatusDrawPanel(ksscStatusBar, LCanvas,
                StatusPanelInfo(R, kspcNormal));
            end;
            if Part = THEME_SP_GRIPPERPANE then
            begin
              StatusDrawPanel(ksscStatusBar, LCanvas,
                StatusPanelInfo(R, kspcGripperPanel));
            end;
            if Part = THEME_SP_GRIPPER then
            begin
              StatusDrawPanel(ksscStatusBar, LCanvas,
                StatusPanelInfo(R, kspcGripper));
            end
            else
              Result := False;
          end;
        teScrollBar:
          begin
            Result := True;
            if Part = 0 then
            begin
            end;
            if Part = THEME_SBP_ARROWBTN then
            begin
              case State of
                THEME_ABS_UPNORMAL: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsNormal, ksbcUp));
                THEME_ABS_UPHOT: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsHot, ksbcUp));
                THEME_ABS_UPPRESSED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsPressed, ksbcUp));
                THEME_ABS_UPDISABLED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsDisabled, ksbcUp));
                THEME_ABS_DOWNNORMAL: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsNormal, ksbcDown));
                THEME_ABS_DOWNHOT: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsHot, ksbcDown));
                THEME_ABS_DOWNPRESSED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsPressed, ksbcDown));
                THEME_ABS_DOWNDISABLED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsDisabled, ksbcDown));
                THEME_ABS_LEFTNORMAL: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsNormal, ksbcLeft));
                THEME_ABS_LEFTHOT: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsHot, ksbcLeft));
                THEME_ABS_LEFTPRESSED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsPressed, ksbcLeft));
                THEME_ABS_LEFTDISABLED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsDisabled, ksbcLeft));
                THEME_ABS_RIGHTNORMAL: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsNormal, ksbcRight));
                THEME_ABS_RIGHTHOT: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsHot, ksbcRight));
                THEME_ABS_RIGHTPRESSED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsPressed, ksbcRight));
                THEME_ABS_RIGHTDISABLED: ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, ksbdsDisabled, ksbcRight));
              end;
            end;
            if Part = THEME_SBP_THUMBBTNHORZ then
              ScrollDrawButton(ksscScrollBar, LCanvas,
                ScrollButtonInfo(R, TSeScrollButtonDrawState(State), ksbcHorzSlider))
            else
            if Part = THEME_SBP_THUMBBTNVERT then
              ScrollDrawButton(ksscScrollBar, LCanvas,
                  ScrollButtonInfo(R, TSeScrollButtonDrawState(State), ksbcVertSlider))
            else
            if Part = THEME_SBP_LOWERTRACKHORZ then
              ScrollDrawArea(ksscScrollBar, LCanvas,
                ScrollAreaInfo(R, TSeScrollAreaDrawState(State), ksacHorizontal))
            else
            if Part = THEME_SBP_UPPERTRACKHORZ then
              ScrollDrawArea(ksscScrollBar, LCanvas,
                ScrollAreaInfo(R, TSeScrollAreaDrawState(State), ksacHorizontal))
            else
            if Part = THEME_SBP_LOWERTRACKVERT then
              ScrollDrawArea(ksscScrollBar, LCanvas,
                ScrollAreaInfo(R, TSeScrollAreaDrawState(State), ksacVertical))
            else
            if Part = THEME_SBP_UPPERTRACKVERT then
              ScrollDrawArea(ksscScrollBar, LCanvas,
                ScrollAreaInfo(R, TSeScrollAreaDrawState(State), ksacVertical))
            else
            if Part = THEME_SBP_SIZEBOX then
            begin
              WindowDrawGripper(kwscStandard, LCanvas, WindowGripperInfo(R, true));
            end;
          end;
        teSpin:
          begin
            Result := True;
            if Part = THEME_SPNP_UP then
              ButtonDraw(kbscSpinUp, LCanvas, ButtonInfo(R, TSeButtonDrawState(State)))
            else
            if Part = THEME_SPNP_DOWN then
              ButtonDraw(kbscSpinDown, LCanvas, ButtonInfo(R, TSeButtonDrawState(State)))
            else
            if Part = THEME_SPNP_DOWNHORZ then
              ButtonDraw(kbscSpinLeft, LCanvas, ButtonInfo(R, TSeButtonDrawState(State)))
            else
            if Part = THEME_SPNP_UPHORZ then
              ButtonDraw(kbscSpinRight, LCanvas, ButtonInfo(R,TSeButtonDrawState(State)))
            else
              Result := False;
          end;
        teRebar:
          begin
            Result := True;
            if Part = 0 then
              DockDraw(kdscDock, LCanvas, DockInfo(R))
            else
            if Part = THEME_RP_GRIPPER then
              ToolDrawItem(ktscToolbar, LCanvas,
                ToolItemInfo(R, kticGripper, mtidsNormal))
            else
            if Part = THEME_RP_GRIPPERVERT then
              ToolDrawItem(ktscToolbar, LCanvas,
                ToolItemInfo(R, kticGripperVert, mtidsNormal))
            else
            if Part = THEME_RP_BAND then
              ToolDraw(ktscToolbar, LCanvas, ToolInfo(R))
            else
            if Part = THEME_RP_CHEVRONVERT then
              ToolDrawItem(ktscToolbar, LCanvas,
                      ToolItemInfo(R, kticExpandButton, TSeToolItemDrawState(State)))
            else
            if Part = THEME_RP_CHEVRON then
            begin
            end
            else
              Result := False;
          end;
         teWindow:
          begin
            Result := True;

            WI.State := [kwdsActive];
            WI.Rect := R;
            WI.ClipRect := NullRect;
            WI.Buttons := [];
            WI.Title := '';

            if Part = 0 then
            begin
              WindowDrawClient(kwscStandard, LCanvas, R);
            end
            else
            begin
              if (Part = THEME_WP_MDIMINBUTTON) then
              begin
                MenuDrawItem(kmscMenuBar, LCanvas, MenuItemInfo(R, kmicMin, TSeMenuItemDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_MDIRESTOREBUTTON) then
              begin
                MenuDrawItem(kmscMenuBar, LCanvas, MenuItemInfo(R, kmicRestore, TSeMenuItemDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_MDICLOSEBUTTON) then
              begin
                MenuDrawItem(kmscMenuBar, LCanvas, MenuItemInfo(R, kmicClose, TSeMenuItemDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_SYSBUTTON) or (Part = THEME_WP_MDISYSBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbSysMenu];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscStandard, LCanvas, WindowButtonInfo(WI.Rect, kwbSysMenu, TSeWindowButtonDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_MINBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbMin];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscStandard, LCanvas, WindowButtonInfo(WI.Rect, kwbMin, TSeWindowButtonDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_MAXBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbMax];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscStandard, LCanvas, WindowButtonInfo(WI.Rect, kwbMax, TSeWindowButtonDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_CLOSEBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbClose];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscStandard, LCanvas, WindowButtonInfo(WI.Rect, kwbClose, TSeWindowButtonDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_RESTOREBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbMaxRestore];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscStandard, LCanvas, WindowButtonInfo(WI.Rect, kwbMaxRestore, TSeWindowButtonDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_HELPBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbHelp];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscStandard, LCanvas, WindowButtonInfo(WI.Rect, kwbHelp, TSeWindowButtonDrawState(State)));
                Exit;
              end
              else
              if (Part = THEME_WP_SMALLCLOSEBUTTON) then
              begin
                WI.Buttons := WI.Buttons + [kwbClose];
                WI.Rect := R;
                WI.ClipRect := Rect(0, 0, 0, 0);
                WindowDrawButton(kwscToolWindow, LCanvas, WindowButtonInfo(WI.Rect, kwbClose, TSeWindowButtonDrawState(State)));
                Exit;
              end;

              Buffer := TBitmap.Create;
              try
                Buffer.SetSize(R.Width, R.Height);

                if State = THEME_FS_ACTIVE then WI.State := WI.State + [kwdsActive];
                if State = THEME_FS_INACTIVE then WI.State := WI.State - [kwdsActive];

                {  Standard Window Border }
                WC := kwscStandard;

                WI.Rect := Rect(0, 0, 200, 200);
                CR := WindowGetClientRect(WC, WI.Rect);
                MR := Rect(CR.Left, CR.Top, WI.Rect.Right - CR.Right, WI.Rect.Bottom - CR.Bottom);

                if (Part = THEME_WP_CAPTION) or (Part = THEME_WP_MINCAPTION) or (Part = THEME_WP_MAXCAPTION) then
                begin
                  WI.Rect := Rect(0, 0, R.Width, MR.Top + MR.Bottom);
                  WI.ClipRect := Rect(0, 0, R.Width, MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                end
                else
                if Part = THEME_WP_FRAMELEFT then
                begin
                  WI.Rect := Rect(0, 0, MR.Left + MR.Right, R.Height + MR.Bottom + MR.Top);
                  WI.ClipRect := Rect(0, MR.Top, MR.Left, R.Height);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, -MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, MR.Top);
                end
                else
                if Part = THEME_WP_FRAMERIGHT then
                begin
                  WI.Rect := Rect(0, 0, MR.Left + MR.Right, R.Height + MR.Bottom + MR.Top);
                  WI.ClipRect := Rect(MR.Left, MR.Top, MR.Left + MR.Right, R.Height);
                  MoveWindowOrg(Buffer.Canvas.Handle, -MR.Left, -MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                  MoveWindowOrg(Buffer.Canvas.Handle, MR.Left, MR.Top);
                end
                else
                if Part = THEME_WP_FRAMEBOTTOM then
                begin
                  WI.Rect := Rect(0, 0, R.Width, MR.Top + MR.Bottom);
                  WI.ClipRect := Rect(0, MR.Top, R.Width, MR.Bottom);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, -MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, MR.Top);
                end;

                { Tool Window Border }

                if IsObjectDefined(kwscToolWindow) then WC := kwscToolWindow;

                WI.Rect := Rect(0, 0, 200, 200);
                CR := WindowGetClientRect(WC, WI.Rect);
                MR := Rect(CR.Left, CR.Top, WI.Rect.Right - CR.Right, WI.Rect.Bottom - CR.Bottom);

                if (Part = THEME_WP_SMALLCAPTION) or (Part = THEME_WP_SMALLMINCAPTION) or (Part = THEME_WP_SMALLMAXCAPTION) then
                begin
                  WI.Rect := Rect(0, 0, R.Width, MR.Top + MR.Bottom);
                  WI.ClipRect := Rect(0, 0, R.Width, MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                end
                else
                if Part = THEME_WP_SMALLFRAMELEFT then
                begin
                  WI.Rect := Rect(0, 0, MR.Left + MR.Right, R.Height + MR.Bottom + MR.Top);
                  WI.ClipRect := Rect(0, MR.Top, MR.Left, R.Height);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, -MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, MR.Top);
                end
                else
                if Part = THEME_WP_SMALLFRAMERIGHT then
                begin
                  WI.Rect := Rect(0, 0, MR.Left + MR.Right, R.Height + MR.Bottom + MR.Top);
                  WI.ClipRect := Rect(MR.Left, MR.Top, MR.Left + MR.Right, R.Height);
                  Buffer.Canvas.Handle := Buffer.Canvas.Handle;
                  MoveWindowOrg(Buffer.Canvas.Handle, -MR.Left, -MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                  MoveWindowOrg(Buffer.Canvas.Handle, MR.Left, MR.Top);
                end
                else
                if Part = THEME_WP_SMALLFRAMEBOTTOM then
                begin
                  WI.Rect := Rect(0, 0, R.Width, MR.Top + MR.Bottom);
                  WI.ClipRect := Rect(0, MR.Top, R.Width, MR.Bottom);
                  Buffer.Canvas.Handle := Buffer.Canvas.Handle;
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, -MR.Top);
                  WindowDraw(WC, Buffer.Canvas, WI);
                  MoveWindowOrg(Buffer.Canvas.Handle, 0, MR.Top);
                end;

                LCanvas.Draw(R.Left, R.Top, Buffer);
              finally
                Buffer.Free;
              end;
            end;
        end;
    end;
  finally
    LFontRecall.Free;
  end;
end;

function TCustomStyle.DoDrawIcon(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean;
var
  Icon: HICON;
  IW, IH: Integer;
begin
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].DrawIcon(Self, DC,
      Details.Part, Details.State, R, himl, Index)
  else
  begin
    if not ImageList_GetIconSize(himl, IW, IH) then
      Exit(False);
    Icon := ImageList_GetIcon(himl, Index, LR_DEFAULTCOLOR);
    Result := DrawIconEx(DC, R.Left, R.Top, Icon, IW, IH, 0, 0, DI_NORMAL);
    DestroyIcon(Icon);
  end;
end;

function TCustomStyle.DoDrawParentBackground(Window: HWND; Target: HDC;
  Details: PThemedElementDetails; OnlyIfTransparent: Boolean; Bounds: PRect): Boolean;
var
  P: TPoint;
  OldP: TPoint;
  ParentWnd: HWND;
  C: TWinControl;
begin
  Result := True;
  C := FindControl(Window);
  if C <> nil then
    DrawControlBackground(C, Target)
  else
  begin
    if Bounds = nil then
      P := Point(0, 0)
    else
      P := Bounds^.TopLeft;

    ParentWnd := GetParent(Window);
    ClientToScreen(Window, P);
    ScreenToClient(ParentWnd, P);
    GetViewportOrgEx(Target, OldP);
    P.X := -P.X + OldP.X;
    P.Y := -P.Y + OldP.Y;
    SetViewportOrgEx(Target, P.X, P.Y, nil);
    SendMessage(ParentWnd, WM_ERASEBKGND, WPARAM(Target), 0);
    SetViewportOrgEx(Target, OldP.X, OldP.X, nil);
  end;
end;

function TCustomStyle.DoDrawText(DC: HDC; Details: TThemedElementDetails;
  const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
var
  TextFlags: Cardinal;
  LFontRecall: TGDIHandleRecall;
begin
  TextFlags := TTextFormatFlags(Flags);
  if TextFlags and DT_CALCRECT <> 0 then
  begin
    LFontRecall := GetFontFromDC(DC);
    try
      Winapi.Windows.DrawText(LFontRecall.Canvas.Handle, PChar(S), Length(S), R, TextFlags);
    finally
      LFontRecall.Free;
      Result := True;
    end;
  end
 else
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].DrawText(Self, DC,
      Details.Part, Details.State, S, R, Flags, Options)
  else
    Result := InternalDrawText(DC, Details, S, R, Flags, Options.TextColor);
end;

function TCustomStyle.InternalDrawText(DC: HDC; Details: TThemedElementDetails;
  const S: string; const R: TRect; Flags: TTextFormat; Color: TColor): Boolean;
var
  WI: TseWindowInfo;
  R1: TRect;
  WC: TseWindowSubClass;
  TextFlags: Cardinal;
  LCanvas: TCanvas;
  LFontRecall: TGDIHandleRecall;
begin
  if not SourceLoaded then Exit(False);

  Result := False;
  TextFlags := TTextFormatFlags(Flags);
  LFontRecall := GetFontFromDC(DC);

  try
    LCanvas := LFontRecall.Canvas;
    LCanvas.Font.Color := Color;

    with Details, TseStyle(FSource) do
    case Element of
      teButton:
        begin
          Result := True;
          if Part = THEME_BP_PUSHBUTTON then
            ButtonDrawText(kbscButton, LCanvas, ButtonInfo(R, TseButtonDrawState(State)),
            TextInfo(R, S, TextFlags))
          else
          if Part = THEME_BP_CHECKBOX then
            CheckDrawText(kcscCheckBox, LCanvas, CheckInfo(R, TSeCheckDrawState(State)),
            TextInfo(R, S, TextFlags))
          else
          if Part = THEME_BP_RADIOBUTTON then
            CheckDrawText(kcscRadioButton, LCanvas, CheckInfo(R, TSeCheckDrawState(State)),
            TextInfo(R, S, TextFlags))
          else
          if Part = THEME_BP_GROUPBOX then
            GroupDrawText(kgscGroupBox, LCanvas, GroupInfo(R, NullRect, TSeGroupDrawState(State)),
            TextInfo(R, S, TextFlags))
          else
            Result := False;
        end;
      teHeader:
        begin
          Result := True;
          if (Part = THEME_HP_HEADERITEM) then
            HeaderDrawText(khscHeader, LCanvas,
               HeaderSectionInfo(R, khssMiddle, TSeSectionDrawState(State)),
               TextInfo(R, S, TextFlags))
          else
          if (Part = THEME_HP_HEADERITEMLEFT) then
            HeaderDrawText(khscHeader, LCanvas,
               HeaderSectionInfo(R, khssFirst, TSeSectionDrawState(State)),
               TextInfo(R, S, TextFlags))
          else
          if (Part = THEME_HP_HEADERITEMRIGHT) then
            HeaderDrawText(khscHeader, LCanvas,
               HeaderSectionInfo(R, khssLast, TSeSectionDrawState(State)),
               TextInfo(R, S, TextFlags))
          else
            Result := False;
        end;
      teTab:
        begin
          Result := True;
          case Part of
            THEME_TABP_TABITEMLEFTEDGE:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisLeftMiddle, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TOPTABITEMLEFTEDGE:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisLeftFirst, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TABITEMRIGHTEDGE:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisRightMiddle, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TOPTABITEMRIGHTEDGE:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisRightFirst, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TABITEM:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisTopMiddle, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TOPTABITEM:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisTopFirst, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TABITEMBOTHEDGE:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisBottomMiddle, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));

            THEME_TABP_TOPTABITEMBOTHEDGE:
              TabDrawText(ktscTab, LCanvas,
                TabItemInfo(R, ktisBottomFirst, TSeTabItemDrawState(State)),
                TextInfo(R, S, TextFlags));
             else
               Result := False;
          end;
        end;
      teStatus:
        begin
          if Part = THEME_SP_PANE then
          begin
            StatusDrawText(ksscStatusBar, LCanvas,
              StatusPanelInfo(R, kspcNormal), TextInfo(R, S, TextFlags));
            Result := True;
          end;
        end;
      teWindow:
        begin
          Result := True;

          if  Details.Part = THEME_WP_SMALLCAPTION then
            WC := kwscToolWindow
          else
            WC := kwscStandard;

          if State = THEME_FS_ACTIVE then
            WI := WindowInfo(R, [kwdsActive], NullRect, [], S)
          else
            WI := WindowInfo(R, [], NullRect, [], S);

          R1 := WindowGetTitleRect(WC, WI);
          R1.Left := R.Left;
          R1.Right := R.Right;
          WindowDrawText(WC, LCanvas, WI, R1, tfRtlReading in Flags);
        end
      else
        begin
          DrawStyleText(LCanvas, TextInfo(R, S, TextFlags));
          Result := True;
        end;
    end;
  finally
    LFontRecall.Free;
  end;
end;

function TCustomStyle.DoGetElementColor(Details: TThemedElementDetails;
  ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := False;

  if not SourceLoaded then Exit;
  if FCustomElements[Details.Element] <> nil then
  begin
    Result := FCustomElements[Details.Element].GetElementColor(Self, Details.Part,
      Details.State, ElementColor, Color);
    Exit;
  end;

  if ElementColor = ecTextColor then
  begin
    with Details, TseStyle(FSource) do
    case Element of
      teEdit:
        if Details.Part = THEME_EP_EDITTEXT then
        begin
          Result := True;
          case TSeEditDrawState(State) of
            kedsNormal: Color := Fonts[ktfEditBoxTextNormal].Color;
            kedsHot: Color := Fonts[ktfEditBoxTextHot].Color;
            kedsFocused: Color := Fonts[ktfEditBoxTextFocused].Color;
            kedsFocusedHot: Color := Fonts[ktfEditBoxTextFocused].Color;
            kedsDisabled: Color := Fonts[ktfEditBoxTextDisabled].Color;
            kedsReadOnly: Color := Fonts[ktfEditBoxTextDisabled].Color;
            kedsSelection: Color := Fonts[ktfEditBoxTextSelected].Color;
          else
            Result := False;
          end;
        end;
      teButton:
        begin
          if Part = THEME_BP_PUSHBUTTON then
          begin
            case TseButtonDrawState(State) of
              kbdsNormal: Color := Fonts[ktfButtonTextNormal].Color;
              kbdsHot: Color := Fonts[ktfButtonTextHot].Color;
              kbdsPressed: Color := Fonts[ktfButtonTextPressed].Color;
              kbdsDisabled:  Color := Fonts[ktfButtonTextDisabled].Color;
              kbdsDefault: Color := Fonts[ktfButtonTextFocused].Color;
            end;
           Result := True;
          end
          else
          if Part = THEME_BP_CHECKBOX then
          begin
            case TseCheckDrawState(State) of
              kcdsUncheckedNormal,
              kcdsCheckedNormal,
              kcdsMixedNormal: Color := Fonts[ktfCheckBoxTextNormal].Color;

              kcdsUncheckedHot,
              kcdsCheckedHot,
              kcdsMixedHot: Color := Fonts[ktfCheckBoxTextHot].Color;

              kcdsUncheckedPressed,
              kcdsCheckedPressed,
              kcdsMixedPressed: Color := Fonts[ktfCheckBoxTextPressed].Color;

              kcdsUncheckedDisabled,
              kcdsCheckedDisabled,
              kcdsMixedDisabled: Color := Fonts[ktfCheckBoxTextDisabled].Color;
            end;
            Result := True;
          end
          else
          if Part = THEME_BP_RADIOBUTTON then
          begin
            case TseCheckDrawState(State) of
              kcdsUncheckedNormal,
              kcdsCheckedNormal,
              kcdsMixedNormal: Color := Fonts[ktfRadioButtonTextNormal].Color;

              kcdsUncheckedHot,
              kcdsCheckedHot,
              kcdsMixedHot: Color := Fonts[ktfRadioButtonTextHot].Color;

              kcdsUncheckedPressed,
              kcdsCheckedPressed,
              kcdsMixedPressed: Color := Fonts[ktfRadioButtonTextPressed].Color;

              kcdsUncheckedDisabled,
              kcdsCheckedDisabled,
              kcdsMixedDisabled: Color := Fonts[ktfRadioButtonTextDisabled].Color;
            end;
            Result := True;
          end
          else
          if Part = THEME_BP_GROUPBOX then
          begin
            case TSeGroupDrawState(State) of
              kgdsNormal: Color := Fonts[ktfGroupBoxTextNormal].Color;
              kgdsDisabled: Color := Fonts[ktfGroupBoxTextDisabled].Color;
            end;
            Result := True;
          end;
        end;
      teReBar:
        begin
          if Part = THEME_RP_BAND then
           Color := Fonts[ktfStaticTextNormal].Color;
          Result := True;
        end;
      teHeader:
        begin
          if (Part = THEME_HP_HEADERITEM) or (Part = THEME_HP_HEADERITEM) or
             (Part = THEME_HP_HEADERITEMLEFT)
           then
          begin
            case TSeSectionDrawState(State) of
              khdsNormal: Color := Fonts[ktfHeaderSectionTextNormal].Color;
              khdsHot: Color := Fonts[ktfHeaderSectionTextHot].Color;
              khdsPressed: Color := Fonts[ktfHeaderSectionTextPressed].Color;
            end;
            Result := True;
          end;
        end;
      teTab:
        begin
          if (Part >= THEME_TABP_TABITEM) and (Part <= THEME_TABP_TOPTABITEMBOTHEDGE) then
          begin
            case TSeTabItemDrawState(State) of
              ktidsNormal: Color := Fonts[ktfTabTextInactiveNormal].Color;
              ktidsHot: Color := Fonts[ktfTabTextInactiveHot].Color;
              ktidsActive: Color := Fonts[ktfTabTextActiveNormal].Color;
              ktidsDisabled: Color := Fonts[ktfTabTextInactiveDisabled].Color;
            end;
            Result := True;
          end;
        end;
      teStatus:
        begin
          if Part = THEME_SP_PANE then
          begin
            Color := Fonts[ktfStatusPanelTextNormal].Color;
            Result := True;
          end;
        end;
      teWindow:
        begin
          case Details.Part of
            THEME_WP_CAPTION:
            begin
              if State = THEME_FS_ACTIVE then
                Color := Fonts[ktfCaptionTextNormal].Color
              else
                Color := Fonts[ktfCaptionTextInactive].Color;
              Result := True;
            end;
            THEME_WP_SMALLCAPTION:
            begin
              if State = THEME_FS_ACTIVE then
                Color := Fonts[ktfSmCaptionTextNormal].Color
              else
                Color := Fonts[ktfSmCaptionTextInactive].Color;
              Result := True;
            end;
          end;
       end;
    end;
  end;
end;

function TCustomStyle.DoGetTextExtent(DC: HDC; Details: TThemedElementDetails;
  const Text: string; Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean;
begin
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].GetTextExtent(Self,
      DC, Details.Part, Details.State, Text, Flags, BoundingRect, ExtentRect)
  else
  begin
    if BoundingRect <> nil then
      ExtentRect := BoundingRect^
    else
      ExtentRect := TRect.Empty;
    Result := False;
  end;
end;

function TCustomStyle.DoHasElementFixedPosition(Details: TThemedElementDetails): Boolean;
begin
  Result := False;
  if Details.Element <> teWindow then Exit;
  case Details.Part of
    THEME_WP_SMALLCLOSEBUTTON, THEME_WP_SMALLCAPTION:
      Result := TseStyle(FSource).WindowGetFixPosition(kwscToolWindow, kwbClose);
    THEME_WP_CLOSEBUTTON:
      Result := TseStyle(FSource).WindowGetFixPosition(kwscStandard, kwbClose);
    THEME_WP_HELPBUTTON:
      Result := TseStyle(FSource).WindowGetFixPosition(kwscStandard, kwbHelp);
    THEME_WP_MAXBUTTON, THEME_WP_RESTOREBUTTON:
      Result := TseStyle(FSource).WindowGetFixPosition(kwscStandard, kwbMax);
    THEME_WP_MINBUTTON:
      Result := TseStyle(FSource).WindowGetFixPosition(kwscStandard, kwbMin);
    THEME_WP_SYSBUTTON, THEME_WP_CAPTION:
      Result := TseStyle(FSource).WindowGetFixPosition(kwscStandard, kwbSysMenu);
  end;
end;

function TCustomStyle.DoGetElementContentRect(DC: HDC; Details: TThemedElementDetails;
  const BoundingRect: TRect; out ContentRect: TRect): Boolean;
var
  WI: TseWindowInfo;
begin
  if FCustomElements[Details.Element] <> nil then
    Result := FCustomElements[Details.Element].GetElementContentRect(Self, DC,
      Details.Part, Details.State, BoundingRect, ContentRect)
  else
  begin
    Result := False;
    if SourceLoaded then
    begin
      Result := True;
      case Details.Element of
        teButton:
          ContentRect := BoundingRect;
        teWindow:
          case Details.Part of
            THEME_WP_SMALLCLOSEBUTTON:
              begin
                THEME_WP_BUTTONS := [kwbClose];
                WI.Buttons := THEME_WP_BUTTONS;
                WI.Rect := BoundingRect;
                ContentRect := TseStyle(FSource).WindowGetButtonRect(kwscToolWindow, WI, kwbClose);
              end;
            THEME_WP_CLOSEBUTTON:
              begin
                THEME_WP_BUTTONS := [kwbClose];
                WI.Buttons := THEME_WP_BUTTONS;
                WI.Rect := BoundingRect;
                ContentRect := TseStyle(FSource).WindowGetButtonRect(kwscStandard, WI, kwbClose);
              end;
            THEME_WP_HELPBUTTON:
              begin
                THEME_WP_BUTTONS := THEME_WP_BUTTONS + [kwbHelp];
                WI.Buttons := THEME_WP_BUTTONS;
                WI.Rect := BoundingRect;
                ContentRect := TseStyle(FSource).WindowGetButtonRect(kwscStandard, WI, kwbHelp);
              end;
            THEME_WP_MAXBUTTON, THEME_WP_RESTOREBUTTON:
              begin
                THEME_WP_BUTTONS := THEME_WP_BUTTONS + [kwbMax];
                WI.Buttons := THEME_WP_BUTTONS;
                WI.Rect := BoundingRect;
                ContentRect := TseStyle(FSource).WindowGetButtonRect(kwscStandard, WI, kwbMax);
              end;
            THEME_WP_MINBUTTON:
              begin
                THEME_WP_BUTTONS := THEME_WP_BUTTONS + [kwbMin];
                WI.Buttons := THEME_WP_BUTTONS;
                WI.Rect := BoundingRect;
                ContentRect := TseStyle(FSource).WindowGetButtonRect(kwscStandard, WI, kwbMin);
              end;
            THEME_WP_SYSBUTTON:
              begin
                THEME_WP_BUTTONS := THEME_WP_BUTTONS + [kwbSysMenu];
                WI.Buttons := THEME_WP_BUTTONS;
                WI.Rect := BoundingRect;
                ContentRect := TseStyle(FSource).WindowGetButtonRect(kwscStandard, WI, kwbSysMenu);
              end;
          else
            Result := False;
          end;
      else
        Result := False;
      end;
    end;
  end;
  if not Result then
    ContentRect := TRect.Empty;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTreeview): TThemedElementDetails;
begin
  Result := TStyleManager.SystemStyle.GetElementDetails(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedListView): TThemedElementDetails;
begin
  Result := TStyleManager.SystemStyle.GetElementDetails(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedHeader): TThemedElementDetails;
begin
  Result.Element := teHeader;
  with Result do
  begin
    case Detail of
      thHeaderItemNormal..thHeaderItemPressed:
        begin
          Part := THEME_HP_HEADERITEM;
          case Detail of
            thHeaderItemNormal: State := Ord(khdsNormal);
            thHeaderItemHot: State := Ord(khdsHot);
            thHeaderItemPressed: State := Ord(khdsPressed);
          end;
        end;
      thHeaderItemLeftNormal..thHeaderItemLeftPressed:
        begin
          Part := THEME_HP_HEADERITEMLEFT;
          case Detail of
            thHeaderItemLeftNormal: State := Ord(khdsNormal);
            thHeaderItemLeftHot: State := Ord(khdsHot);
            thHeaderItemLeftPressed: State := Ord(khdsPressed);
          end;
        end;
      thHeaderItemRightNormal..thHeaderItemRightPressed:
        begin
          Part := THEME_HP_HEADERITEMRIGHT;
          case Detail of
            thHeaderItemRightNormal: State := Ord(khdsNormal);
            thHeaderItemRightHot: State := Ord(khdsHot);
            thHeaderItemRightPressed: State := Ord(khdsPressed);
          end;
        end;
      thHeaderSortArrowSortedUp..thHeaderSortArrowSortedDown:
        begin
          Part := THEME_HP_HEADERSORTARROW;
          case Detail of
            thHeaderSortArrowSortedUp: State := 0;
            thHeaderSortArrowSortedDown: State := 1;
          end;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedMenu): TThemedElementDetails;
begin
  Result.Element := teMenu;
  Result.Part := 0;
  Result.State := Integer(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedProgress): TThemedElementDetails;
begin
  Result.Element := teProgress;
  with Result do
  begin
    case Detail of
      tpBar:
        begin
          Part := THEME_PP_BAR;
          State := 0;
        end;
      tpBarVert:
        begin
          Part := THEME_PP_BARVERT;
          State := 0;
        end;
      tpChunk:
        begin
          Part := THEME_PP_CHUNK;
          State := 0;
        end;
      tpChunkVert:
        begin
          Part := THEME_PP_CHUNKVERT;
         State := 0;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedPage): TThemedElementDetails;
begin
  Result.Element := tePage;
  Result.Part := 0;
  Result.State := 0;
end;


function TCustomStyle.GetElementDetails(Detail: TThemedButton): TThemedElementDetails;
begin
  Result.Element := teButton;
  with Result do
  begin
    case Detail of
      tbCommandLinkGlyphNormal..tbCommandLinkGlyphDisabled:
      begin
        Part := THEME_BP_COMMANDLINKGLYPH;
        case Detail of
          tbCommandLinkGlyphNormal: State := Ord(ssNormal);
          tbCommandLinkGlyphHot: State := Ord(ssHot);
          tbCommandLinkGlyphPressed: State := Ord(ssPressed);
          tbCommandLinkGlyphDisabled: State := Ord(ssDisabled);
        end;
      end;
      tbPushButtonNormal..tbPushButtonDefaultedAnimating:
        begin
          Part := THEME_BP_PUSHBUTTON;
          case Detail of
            tbPushButtonNormal: State := Ord(kbdsNormal);
            tbPushButtonHot: State := Ord(kbdsHot);
            tbPushButtonPressed: State := Ord(kbdsPressed);
            tbPushButtonDisabled: State := Ord(kbdsDisabled);
            tbPushButtonDefaulted,
            tbPushButtonDefaultedAnimating: State := Ord(kbdsDefault);
          end;
        end;
      tbRadioButtonUncheckedNormal..tbRadioButtonCheckedDisabled:
        begin
          Part := THEME_BP_RADIOBUTTON;
          case Detail of
            tbRadioButtonUncheckedNormal: State := Ord(kcdsUncheckedNormal);
            tbRadioButtonUncheckedHot: State := Ord(kcdsUncheckedHot);
            tbRadioButtonUncheckedPressed: State := Ord(kcdsUncheckedPressed);
            tbRadioButtonUncheckedDisabled: State := Ord(kcdsUncheckedDisabled);
            tbRadioButtonCheckedNormal: State := Ord(kcdsCheckedNormal);
            tbRadioButtonCheckedHot: State := Ord(kcdsCheckedHot);
            tbRadioButtonCheckedPressed: State := Ord(kcdsCheckedPressed);
            tbRadioButtonCheckedDisabled: State := Ord(kcdsCheckedDisabled);
          end;
        end;
      tbCheckBoxUncheckedNormal..tbCheckBoxExcludedDisabled:
        begin
          Part := THEME_BP_CHECKBOX;
          case Detail of
            tbCheckBoxUncheckedNormal: State := Ord(kcdsUncheckedNormal);
            tbCheckBoxUncheckedHot: State := Ord(kcdsUncheckedHot);
            tbCheckBoxUncheckedPressed: State := Ord(kcdsUncheckedPressed);
            tbCheckBoxUncheckedDisabled: State := Ord(kcdsUncheckedDisabled);
            tbCheckBoxCheckedNormal: State := Ord(kcdsCheckedNormal);
            tbCheckBoxCheckedHot: State := Ord(kcdsCheckedHot);
            tbCheckBoxCheckedPressed: State := Ord(kcdsCheckedPressed);
            tbCheckBoxCheckedDisabled: State := Ord(kcdsCheckedDisabled);
            tbCheckBoxMixedNormal: State := Ord(kcdsMixedNormal);
            tbCheckBoxMixedHot: State := Ord(kcdsMixedHot);
            tbCheckBoxMixedPressed: State := Ord(kcdsMixedPressed);
            tbCheckBoxMixedDisabled: State := Ord(kcdsMixedDisabled);
            tbCheckBoxImplicitNormal,
            tbCheckBoxImplicitHot,
            tbCheckBoxImplicitPressed,
            tbCheckBoxImplicitDisabled: State := Ord(kcdsCheckedDisabled);
            tbCheckBoxExcludedNormal,
            tbCheckBoxExcludedHot,
            tbCheckBoxExcludedPressed,
            tbCheckBoxExcludedDisabled: State := Ord(kcdsUnCheckedDisabled);
          end;
        end;
      tbGroupBoxNormal..tbGroupBoxDisabled:
        begin
          Part := THEME_BP_GROUPBOX;
          case Detail of
            tbGroupBoxNormal: State := Ord(kgdsNormal);
            tbGroupBoxDisabled:  State := Ord(kgdsDisabled);
          end;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;


function TCustomStyle.GetElementDetails(Detail: TThemedComboBox): TThemedElementDetails;
begin
  Result.Element := teComboBox;
  with Result do
  begin
    case Detail of
      tcDropDownButtonNormal..tcDropDownButtonDisabled,
      tcDropDownButtonRightNormal..tcDropDownButtonRightDisabled,
      tcDropDownButtonLeftNormal..tcDropDownButtonLeftDisabled:
        begin
          Part := THEME_TP_DROPDOWNBUTTON;
          case Detail of
            tcDropDownButtonNormal,
            tcDropDownButtonLeftNormal,
            tcDropDownButtonRightNormal: State := Ord(kebdsNormal);
            tcDropDownButtonHot,
            tcDropDownButtonLeftHot,
            tcDropDownButtonRightHot: State := Ord(kebdsHot);
            tcDropDownButtonPressed,
            tcDropDownButtonLeftPressed,
            tcDropDownButtonRightPressed: State := Ord(kebdsPressed);
            tcDropDownButtonDisabled,
            tcDropDownButtonLeftDisabled,
            tcDropDownButtonRightDisabled: State := Ord(kebdsDisabled);
          end;
        end;
    else
      Part := THEME_EP_BORDER;
      case Detail of
        tcBorderNormal: State := Ord(kedsNormal);
        tcBorderHot: State := Ord(kedsHot);
        tcBorderFocused: State := Ord(kedsHot);
        tcBackground,
        tcReadOnlyNormal,
        tcReadOnlyHot,
        tcReadOnlyPressed,
        tcCueBannerNormal,
        tcCueBannerHot,
        tcCueBannerPressed: State := Ord(kedsNormal);
        tcBorderDisabled,
        tcReadOnlyDisabled,
        tcCueBannerDisabled: State := Ord(kedsDisabled);
      else
        Part := 0;
        State := 0;
      end;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedEdit): TThemedElementDetails;
begin
  Result.Element := teEdit;
  with Result do
  begin
    case Detail of
      teEditTextNormal..teEditTextAssist:
        begin
          Part := THEME_EP_EDITTEXT;
          case Detail of
            teEditTextNormal: State := Ord(kedsNormal);
            teEditTextHot: State := Ord(kebdsNormal);
            teEditTextSelected: State := Ord(kebdsNormal);
            teEditTextDisabled:State := Ord(kedsDisabled);
            teEditTextFocused: State := Ord(kedsFocused);
            teEditTextReadOnly: State := Ord(kedsNormal);
            teEditTextAssist: State := Ord(kedsNormal);
          end;
        end;
      teEditCaret:
        begin
          Part := THEME_EP_CARET;
          State := 0;
        end;
     teEditBorderNoScrollNormal..teEditBorderNoScrollDisabled:
       begin
         Part := THEME_EP_BORDER;
         case Detail of
           teEditBorderNoScrollNormal: State := Ord(kedsNormal);
           teEditBorderNoScrollHot: State := Ord(kedsHot);
           teEditBorderNoScrollFocused: State := Ord(kedsHot);
           teEditBorderNoScrollDisabled: State := Ord(kedsNormal);
         end;
       end;
     else
       Part := 0;
       State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedRebar): TThemedElementDetails;
begin
  Result.Element := teRebar;
  with Result do
  begin
    case Detail of
      trGripper:
        begin
          Part := THEME_RP_GRIPPER;
          State := 0;
        end;
      trGripperVert:
        begin
          Part := THEME_RP_GRIPPERVERT;
          State := 0;
        end;
      trBand:
        begin
          Part := THEME_RP_BAND;
          State := 0;
        end;
      trChevronNormal..trChevronPressed:
        begin
          Part := THEME_RP_CHEVRON;
          case Detail of
            trChevronNormal: State := Ord(mtidsNormal);
            trChevronHot: State := Ord(mtidsHot);
            trChevronPressed: State := Ord(mtidsHot);
          end;
        end;
      trChevronVertNormal..trChevronVertPressed:
        begin
          Part := THEME_RP_CHEVRONVERT;
          case Detail of
            trChevronVertNormal: State := Ord(mtidsNormal);
            trChevronVertHot: State := Ord(mtidsHot);
            trChevronVertPressed: State := Ord(mtidsHot);
          end;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTrackBar): TThemedElementDetails;
begin
  Result.Element := teTrackBar;
  with Result do
  begin
    case Detail of
      ttbTrack:
        begin
          Part := THEME_TKP_TRACK;
          State := 0;
        end;
      ttbTrackVert:
        begin
          Part := THEME_TKP_TRACKVERT;
          State := 0;
        end;
      ttbThumbNormal..ttbThumbDisabled:
        begin
          Part := THEME_TKP_THUMB;
          case Detail of
            ttbThumbNormal: State := Ord(kttdsNormal);
            ttbThumbHot: State := Ord(kttdsHot);
            ttbThumbPressed: State := Ord(kttdsPressed);
            ttbThumbFocused: State := Ord(kttdsFocused);
            ttbThumbDisabled: State := Ord(kttdsDisabled);
          end;
        end;
      ttbThumbBottomNormal..ttbThumbBottomDisabled:
        begin
          Part := THEME_TKP_THUMBBOTTOM;
          case Detail of
            ttbThumbBottomNormal: State := Ord(kttdsNormal);
            ttbThumbBottomHot: State := Ord(kttdsHot);
            ttbThumbBottomPressed: State := Ord(kttdsPressed);
            ttbThumbBottomFocused: State := Ord(kttdsFocused);
            ttbThumbBottomDisabled: State := Ord(kttdsDisabled);
          end;
        end;
      ttbThumbTopNormal..ttbThumbTopDisabled:
        begin
          Part := THEME_TKP_THUMBTOP;
          case Detail of
            ttbThumbTopNormal: State := Ord(kttdsNormal);
            ttbThumbTopHot: State := Ord(kttdsHot);
            ttbThumbTopPressed: State := Ord(kttdsPressed);
            ttbThumbTopFocused: State := Ord(kttdsFocused);
            ttbThumbTopDisabled: State := Ord(kttdsDisabled);
          end;
        end;
      ttbThumbVertNormal..ttbThumbVertDisabled:
        begin
          Part := THEME_TKP_THUMBVERT;
          case Detail of
            ttbThumbVertNormal: State := Ord(kttdsNormal);
            ttbThumbVertHot: State := Ord(kttdsHot);
            ttbThumbVertPressed: State := Ord(kttdsPressed);
            ttbThumbVertFocused: State := Ord(kttdsFocused);
            ttbThumbVertDisabled: State := Ord(kttdsDisabled);
          end;
        end;
      ttbThumbLeftNormal..ttbThumbLeftDisabled:
        begin
         Part := THEME_TKP_THUMBLEFT;
         case Detail of
            ttbThumbLeftNormal: State := Ord(kttdsNormal);
            ttbThumbLeftHot: State := Ord(kttdsHot);
            ttbThumbLeftPressed: State := Ord(kttdsPressed);
            ttbThumbLeftFocused: State := Ord(kttdsFocused);
            ttbThumbLeftDisabled: State := Ord(kttdsDisabled);
          end;
        end;
      ttbThumbRightNormal..ttbThumbRightDisabled:
        begin
          Part := THEME_TKP_THUMBRIGHT;
          case Detail of
            ttbThumbRightNormal: State := Ord(kttdsNormal);
            ttbThumbRightHot: State := Ord(kttdsHot);
            ttbThumbRightPressed: State := Ord(kttdsPressed);
            ttbThumbRightFocused: State := Ord(kttdsFocused);
            ttbThumbRightDisabled: State := Ord(kttdsDisabled);
          end;
        end;
      ttbThumbTics:
        begin
          Part := THEME_TKP_TICS;
          State := 0;
        end;
      ttbThumbTicsVert:
        begin
          Part := THEME_TKP_TICSVERT;
          State := 0;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;


function TCustomStyle.GetElementDetails(Detail: TThemedToolBar): TThemedElementDetails;
begin
  Result.Element := teToolBar;
  Result.Part := 0;
  Result.State := Integer(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedWindow): TThemedElementDetails;
begin
  Result.Element := teWindow;
  with Result do
  begin
    case Detail of
      twCaptionActive..twCaptionDisabled:
        begin
          Part := THEME_WP_CAPTION;
          case Detail of
            twCaptionActive, twCaptionDisabled: State := THEME_FS_ACTIVE;
            twCaptionInActive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSmallCaptionActive..twSmallCaptionDisabled:
        begin
          Part := THEME_WP_SMALLCAPTION;
          case Detail of
            twSmallCaptionActive, twSmallCaptionDisabled: State := THEME_FS_ACTIVE;
            twSmallCaptionInActive: State := THEME_FS_INACTIVE;
          end;
        end;
      twMinCaptionActive..twMinCaptionDisabled:
        begin
          Part := THEME_WP_MINCAPTION;
          case Detail of
            twMinCaptionActive, twMinCaptionDisabled: State := THEME_FS_ACTIVE;
            twMinCaptionInActive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSmallMinCaptionActive..twSmallMinCaptionDisabled:
        begin
          Part := THEME_WP_SMALLMINCAPTION;
          case Detail of
            twSmallMinCaptionActive, twSmallMinCaptionDisabled: State := THEME_FS_ACTIVE;
            twSmallMinCaptionInActive: State := THEME_FS_INACTIVE;
          end;
        end;
      twMaxCaptionActive..twMaxCaptionDisabled:
        begin
          Part := THEME_WP_MAXCAPTION;
           case Detail of
            twMaxCaptionActive, twMaxCaptionDisabled: State := THEME_FS_ACTIVE;
            twMaxCaptionInActive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSmallMaxCaptionActive..twSmallMaxCaptionDisabled:
        begin
          Part := THEME_WP_SMALLMAXCAPTION;
          case Detail of
            twSmallMaxCaptionActive, twSmallMaxCaptionDisabled: State := THEME_FS_ACTIVE;
            twSmallMaxCaptionInActive: State := THEME_FS_INACTIVE;
          end;
        end;
      twFrameLeftActive..twFrameLeftInactive:
        begin
          Part := THEME_WP_FRAMELEFT;
          case Detail of
            twFrameLeftActive: State := THEME_FS_ACTIVE;
            twFrameLeftInactive: State := THEME_FS_INACTIVE;
          end;
        end;
      twFrameRightActive..twFrameRightInactive:
        begin
          Part := THEME_WP_FRAMERIGHT;
          case Detail of
            twFrameRightActive: State := THEME_FS_ACTIVE;
            twFrameRightInactive: State := THEME_FS_INACTIVE;
          end;
        end;
      twFrameBottomActive..twFrameBottomInactive:
        begin
          Part := THEME_WP_FRAMEBOTTOM;
          case Detail of
            twFrameBottomActive: State := THEME_FS_ACTIVE;
            twFrameBottomInactive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSmallFrameLeftActive..twSmallFrameLeftInactive:
        begin
          Part := THEME_WP_SMALLFRAMELEFT;
          case Detail of
            twSmallFrameLeftActive: State := THEME_FS_ACTIVE;
            twSmallFrameLeftInactive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSmallFrameRightActive..twSmallFrameRightInactive:
        begin
          Part := THEME_WP_SMALLFRAMERIGHT;
          case Detail of
            twSmallFrameRightActive: State := THEME_FS_ACTIVE;
            twSmallFrameRightInactive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSmallFrameBottomActive..twSmallFrameBottomInactive:
        begin
          Part := THEME_WP_SMALLFRAMEBOTTOM;
          case Detail of
            twSmallFrameBottomActive: State := THEME_FS_ACTIVE;
            twSmallFrameBottomInactive: State := THEME_FS_INACTIVE;
          end;
        end;
      twSysButtonNormal..twSysButtonDisabled:
        begin
          Part := THEME_WP_SYSBUTTON;
          case Detail of
            twSysButtonNormal: State := Ord(kwbdsNormal);
            twSysButtonHot: State := Ord(kwbdsHot);
            twSysButtonPushed: State := Ord(kwbdsPressed);
            twSysButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twMDISysButtonNormal..twMDISysButtonDisabled:
        begin
          Part := THEME_WP_MDISYSBUTTON;
          case Detail of
            twMDISysButtonNormal: State := Ord(kmidsNormal);
            twMDISysButtonHot: State := Ord(kmidsHot);
            twMDISysButtonPushed: State := Ord(kmidsSelected);
            twMDISysButtonDisabled: State := Ord(kmidsDisabled);
          end;
        end;
      twMinButtonNormal..twMinButtonDisabled:
        begin
          Part := THEME_WP_MINBUTTON;
          case Detail of
            twMinButtonNormal: State := Ord(kwbdsNormal);
            twMinButtonHot: State := Ord(kwbdsHot);
            twMinButtonPushed: State := Ord(kwbdsPressed);
            twMinButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twMDIMinButtonNormal..twMDIMinButtonDisabled:
        begin
          Part := THEME_WP_MDIMINBUTTON;
            case Detail of
            twMDIMinButtonNormal: State := Ord(kmidsNormal);
            twMDIMinButtonHot: State := Ord(kmidsHot);
            twMDIMinButtonPushed: State := Ord(kmidsSelected);
            twMDIMinButtonDisabled: State := Ord(kmidsDisabled);
          end;
        end;
      twMaxButtonNormal..twMaxButtonDisabled:
        begin
          Part := THEME_WP_MAXBUTTON;
          case Detail of
            twMaxButtonNormal: State := Ord(kwbdsNormal);
            twMaxButtonHot: State := Ord(kwbdsHot);
            twMaxButtonPushed: State := Ord(kwbdsPressed);
            twMaxButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twCloseButtonNormal..twCloseButtonDisabled:
        begin
          Part := THEME_WP_CLOSEBUTTON;
          case Detail of
            twCloseButtonNormal: State := Ord(kwbdsNormal);
            twCloseButtonHot: State := Ord(kwbdsHot);
            twCloseButtonPushed: State := Ord(kwbdsPressed);
            twCloseButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twSmallCloseButtonNormal..twSmallCloseButtonDisabled:
        begin
          Part := THEME_WP_SMALLCLOSEBUTTON;
          case Detail of
            twSmallCloseButtonNormal: State := Ord(kwbdsNormal);
            twSmallCloseButtonHot: State := Ord(kwbdsHot);
            twSmallCloseButtonPushed: State := Ord(kwbdsPressed);
            twSmallCloseButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twMDICloseButtonNormal..twMDICloseButtonDisabled:
        begin
          Part := THEME_WP_MDICLOSEBUTTON;
          case Detail of
            twMDICloseButtonNormal: State := Ord(kmidsNormal);
            twMDICloseButtonHot: State := Ord(kmidsHot);
            twMDICloseButtonPushed: State := Ord(kmidsSelected);
            twMDICloseButtonDisabled: State := Ord(kmidsDisabled);
          end;
        end;
      twRestoreButtonNormal..twRestoreButtonDisabled:
        begin
          Part := THEME_WP_RESTOREBUTTON;
          case Detail of
            twRestoreButtonNormal: State := Ord(kwbdsNormal);
            twRestoreButtonHot: State := Ord(kwbdsHot);
            twRestoreButtonPushed: State := Ord(kwbdsPressed);
            twRestoreButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twMDIRestoreButtonNormal..twMDIRestoreButtonDisabled:
        begin
          Part := THEME_WP_MDIRESTOREBUTTON;
          case Detail of
            twMDIRestoreButtonNormal: State := Ord(kmidsNormal);
            twMDIRestoreButtonHot: State := Ord(kmidsHot);
            twMDIRestoreButtonPushed: State := Ord(kmidsSelected);
            twMDIRestoreButtonDisabled: State := Ord(kmidsDisabled);
          end;
        end;
      twHelpButtonNormal..twHelpButtonDisabled:
        begin
          Part := THEME_WP_HELPBUTTON;
          case Detail of
            twHelpButtonNormal: State := Ord(kwbdsNormal);
            twHelpButtonHot: State := Ord(kwbdsHot);
            twHelpButtonPushed: State := Ord(kwbdsPressed);
            twHelpButtonDisabled: State := Ord(kwbdsInactive);
          end;
        end;
      twMDIHelpButtonNormal..twMDIHelpButtonDisabled:
        begin
          Part := THEME_WP_MDIHELPBUTTON;
          case Detail of
            twMDIHelpButtonNormal: State := Ord(kmidsNormal);
            twMDIHelpButtonHot: State := Ord(kmidsHot);
            twMDIHelpButtonPushed: State := Ord(kmidsSelected);
            twMDIHelpButtonDisabled: State := Ord(kmidsDisabled);
          end;
        end;
      twHorzScrollNormal..twHorzScrollDisabled:
        begin
          Part := THEME_WP_HORZSCROLL;
          State := 0;
        end;
      twHorzThumbNormal..twHorzThumbDisabled:
        begin
          Part := THEME_WP_HORZTHUMB;
          State := 0;
        end;
      twVertScrollNormal..twVertScrollDisabled:
        begin
          Part := THEME_WP_VERTSCROLL;
          State := 0;
        end;
      twVertThumbNormal..twVertThumbDisabled:
        begin
          Part := THEME_WP_VERTTHUMB;
          State := 0;
        end;
      twDialog:
        begin
          Part := THEME_WP_DIALOG;
          State := 0;
        end;
      twCaptionSizingTemplate:
        begin
          Part := THEME_WP_CAPTIONSIZINGTEMPLATE;
          State := 0;
        end;
      twSmallCaptionSizingTemplate:
        begin
          Part := THEME_WP_SMALLCAPTIONSIZINGTEMPLATE;
          State := 0;
        end;
      twFrameLeftSizingTemplate:
        begin
          Part := THEME_WP_FRAMELEFTSIZINGTEMPLATE;
          State := 0;
        end;
      twSmallFrameLeftSizingTemplate:
        begin
          Part := THEME_WP_SMALLFRAMELEFTSIZINGTEMPLATE;
          State := 0;
        end;
      twFrameRightSizingTemplate:
        begin
          Part := THEME_WP_FRAMERIGHTSIZINGTEMPLATE;
          State := 0;
        end;
      twSmallFrameRightSizingTemplate:
        begin
          Part := THEME_WP_SMALLFRAMERIGHTSIZINGTEMPLATE;
          State := 0;
        end;
      twFrameBottomSizingTemplate:
        begin
          Part := THEME_WP_FRAMEBOTTOMSIZINGTEMPLATE;
          State := 0;
        end;
      twSmallFrameBottomSizingTemplate:
        begin
          Part := THEME_WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE;
          State := 0;
        end;
      twFrame:
        begin
          Part := THEME_WP_FRAME;
          State := 0;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedDataNavButtons): TThemedElementDetails;
begin
  Result.Element := teDataNavButtons;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedHint): TThemedElementDetails;
begin
  Result.Element := teHint;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedControlBar): TThemedElementDetails;
begin
  Result.Element := teControlBar;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTabSet): TThemedElementDetails;
begin
  Result.Element := teTabSet;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedCheckListBox): TThemedElementDetails;
begin
  Result.Element := teCheckListBox;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedCategoryPanelGroup): TThemedElementDetails;
begin
  Result.Element := teCategoryPanelGroup;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedCategoryButtons): TThemedElementDetails;
begin
  Result.Element := teCategoryButtons;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedPanel): TThemedElementDetails;
begin
  Result.Element := tePanel;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedGrid): TThemedElementDetails;
begin
  Result.Element := teGrid;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetName: string;
begin
  Result := TseStyle(FSource).Name;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedSpin): TThemedElementDetails;
begin
  Result.Element := teSpin;
  with Result do
  begin
    case Detail of
      tsUpNormal..tsUpDisabled:
        begin
          Part := THEME_SPNP_UP;
          case Detail of
            tsUpNormal: State := Ord(kbdsNormal);
            tsUpHot: State := Ord(kbdsHot);
            tsUpPressed: State := Ord(kbdsHot);
            tsUpDisabled: State := Ord(kbdsDisabled);
          end;
        end;
      tsDownNormal..tsDownDisabled:
        begin
          Part := THEME_SPNP_DOWN;
          case Detail of
            tsDownNormal: State := Ord(kbdsNormal);
            tsDownHot: State := Ord(kbdsHot);
            tsDownPressed: State := Ord(kbdsHot);
            tsDownDisabled: State := Ord(kbdsDisabled);
          end;
        end;
      tsUpHorzNormal..tsUpHorzDisabled:
        begin
          Part := THEME_SPNP_UPHORZ;
          case Detail of
            tsUpHorzNormal: State := Ord(kbdsNormal);
            tsUpHorzHot: State := Ord(kbdsHot);
            tsUpHorzPressed: State := Ord(kbdsHot);
            tsUpHorzDisabled: State := Ord(kbdsDisabled);
          end;
        end;
      tsDownHorzNormal..tsDownHorzDisabled:
        begin
          Part := THEME_SPNP_DOWNHORZ;
          case Detail of
            tsDownHorzNormal: State := Ord(kbdsNormal);
            tsDownHorzHot: State := Ord(kbdsHot);
            tsDownHorzPressed: State := Ord(kbdsHot);
            tsDownHorzDisabled: State := Ord(kbdsDisabled);
          end;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedScrollBar): TThemedElementDetails;
begin
  Result.Element := teScrollBar;
  with Result do
  begin
    case Detail of
      tsArrowBtnUpNormal..tsArrowBtnRightDisabled:
        begin
          Part := THEME_SBP_ARROWBTN;
          case Detail of
            tsArrowBtnUpNormal: State := THEME_ABS_UPNORMAL;
            tsArrowBtnUpHot: State := THEME_ABS_UPHOT;
            tsArrowBtnUpPressed: State := THEME_ABS_UPPRESSED;
            tsArrowBtnUpDisabled: State := THEME_ABS_UPDISABLED;
            tsArrowBtnDownNormal: State := THEME_ABS_DOWNNORMAL;
            tsArrowBtnDownHot: State := THEME_ABS_DOWNHOT;
            tsArrowBtnDownPressed: State := THEME_ABS_DOWNPRESSED;
            tsArrowBtnDownDisabled: State := THEME_ABS_DOWNDISABLED;
            tsArrowBtnLeftNormal: State := THEME_ABS_LEFTNORMAL;
            tsArrowBtnLeftHot: State := THEME_ABS_LEFTHOT;
            tsArrowBtnLeftPressed: State := THEME_ABS_LEFTPRESSED;
            tsArrowBtnLeftDisabled: State := THEME_ABS_LEFTDISABLED;
            tsArrowBtnRightNormal: State := THEME_ABS_RIGHTNORMAL;
            tsArrowBtnRightHot: State := THEME_ABS_RIGHTHOT;
            tsArrowBtnRightPressed: State := THEME_ABS_RIGHTPRESSED;
            tsArrowBtnRightDisabled: State := THEME_ABS_RIGHTDISABLED;
          end;
        end;
      tsThumbBtnHorzNormal..tsThumbBtnHorzDisabled:
        begin
          Part := THEME_SBP_THUMBBTNHORZ;
          case Detail of
            tsThumbBtnHorzNormal: State := Ord(ksbdsNormal);
            tsThumbBtnHorzHot: State := Ord(ksbdsHot);
            tsThumbBtnHorzPressed: State := Ord(ksbdsPressed);
            tsThumbBtnHorzDisabled: State := Ord(ksbdsDisabled);
          end;
        end;
      tsThumbBtnVertNormal..tsThumbBtnVertDisabled:
        begin
          Part := THEME_SBP_THUMBBTNVERT;
           case Detail of
            tsThumbBtnVertNormal: State := Ord(ksbdsNormal);
            tsThumbBtnVertHot: State := Ord(ksbdsHot);
            tsThumbBtnVertPressed: State := Ord(ksbdsPressed);
            tsThumbBtnVertDisabled: State := Ord(ksbdsDisabled);
          end;
        end;
      tsLowerTrackHorzNormal..tsLowerTrackHorzDisabled:
        begin
          Part := THEME_SBP_LOWERTRACKHORZ;
          case Detail of
            tsLowerTrackHorzNormal: State := Ord(ksadsNormal);
            tsLowerTrackHorzHot: State := Ord(ksadsHot);
            tsLowerTrackHorzPressed: State := Ord(ksadsPressed);
            tsLowerTrackHorzDisabled: State := Ord(ksadsDisabled);
          end;
        end;
      tsUpperTrackHorzNormal..tsUpperTrackHorzDisabled:
        begin
          Part := THEME_SBP_UPPERTRACKHORZ;
           case Detail of
            tsUpperTrackHorzNormal: State := Ord(ksadsNormal);
            tsUpperTrackHorzHot: State := Ord(ksadsHot);
            tsUpperTrackHorzPressed: State := Ord(ksadsPressed);
            tsUpperTrackHorzDisabled: State := Ord(ksadsDisabled);
          end;
        end;
      tsLowerTrackVertNormal..tsLowerTrackVertDisabled:
        begin
          Part := THEME_SBP_LOWERTRACKVERT;
          case Detail of
            tsLowerTrackVertNormal: State := Ord(ksadsNormal);
            tsLowerTrackVertHot: State := Ord(ksadsHot);
            tsLowerTrackVertPressed: State := Ord(ksadsPressed);
            tsLowerTrackVertDisabled: State := Ord(ksadsDisabled);
          end;
        end;
      tsUpperTrackVertNormal..tsUpperTrackVertDisabled:
        begin
          Part := THEME_SBP_UPPERTRACKVERT;
          case Detail of
            tsUpperTrackVertNormal: State := Ord(ksadsNormal);
            tsUpperTrackVertHot: State := Ord(ksadsHot);
            tsUpperTrackVertPressed: State := Ord(ksadsPressed);
            tsUpperTrackVertDisabled: State := Ord(ksadsDisabled);
          end;
        end;
      tsGripperHorzNormal..tsGripperHorzDisabled:
        begin
          Part := THEME_SBP_GRIPPERHORZ;
          case Detail of
            tsGripperHorzNormal: State := Ord(ksbdsNormal);
            tsGripperHorzHot: State := Ord(ksbdsHot);
            tsGripperHorzPressed: State := Ord(ksbdsPressed);
            tsGripperHorzDisabled: State := Ord(ksbdsDisabled);
          end;
        end;
      tsGripperVertNormal..tsGripperVertDisabled:
        begin
          Part := THEME_SBP_GRIPPERVERT;
           case Detail of
            tsGripperVertNormal: State := Ord(ksbdsNormal);
            tsGripperVertHot: State := Ord(ksbdsHot);
            tsGripperVertPressed: State := Ord(ksbdsPressed);
            tsGripperVertDisabled: State := Ord(ksbdsDisabled);
          end;
        end;
      tsSizeBoxRightAlign..tsSizeBoxLeftAlign:
        begin
          Part := THEME_SBP_SIZEBOX;
          case  Detail of
            tsSizeBoxRightAlign: State := 0;
            tsSizeBoxLeftAlign: State := 1;
          end;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTab): TThemedElementDetails;
begin
  Result.Element := teTab;
  with Result do
  begin
    case Detail of
      ttTabItemNormal..ttTabItemFocused:
        begin
          Part := THEME_TABP_TABITEM;
          case Detail of
            ttTabItemNormal: State := Ord(ktidsNormal);
            ttTabItemHot: State := Ord(ktidsHot);
            ttTabItemSelected: State := Ord(ktidsActive);
            ttTabItemDisabled: State := Ord(ktidsDisabled);
            ttTabItemFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTabItemLeftEdgeNormal..ttTabItemLeftEdgeFocused:
        begin
          Part := THEME_TABP_TABITEMLEFTEDGE;
          case Detail of
            ttTabItemLeftEdgeNormal: State := Ord(ktidsNormal);
            ttTabItemLeftEdgeHot: State := Ord(ktidsHot);
            ttTabItemLeftEdgeSelected: State := Ord(ktidsActive);
            ttTabItemLeftEdgeDisabled: State := Ord(ktidsDisabled);
            ttTabItemLeftEdgeFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTabItemRightEdgeNormal..ttTabItemRightEdgeFocused:
        begin
          Part := THEME_TABP_TABITEMRIGHTEDGE;
          case Detail of
            ttTabItemRightEdgeNormal: State := Ord(ktidsNormal);
            ttTabItemRightEdgeHot: State := Ord(ktidsHot);
            ttTabItemRightEdgeSelected: State := Ord(ktidsActive);
            ttTabItemRightEdgeDisabled: State := Ord(ktidsDisabled);
            ttTabItemRightEdgeFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTabItemBothEdgeNormal..ttTabItemBothEdgeFocused:
        begin
          Part := THEME_TABP_TABITEMBOTHEDGE;
          case Detail of
            ttTabItemBothEdgeNormal: State := Ord(ktidsNormal);
            ttTabItemBothEdgeHot: State := Ord(ktidsHot);
            ttTabItemBothEdgeSelected: State := Ord(ktidsActive);
            ttTabItemBothEdgeDisabled: State := Ord(ktidsDisabled);
            ttTabItemBothEdgeFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTopTabItemNormal..ttTopTabItemFocused:
        begin
          Part := THEME_TABP_TOPTABITEM;
          case Detail of
            ttTopTabItemNormal: State := Ord(ktidsNormal);
            ttTopTabItemHot: State := Ord(ktidsHot);
            ttTopTabItemSelected: State := Ord(ktidsActive);
            ttTopTabItemDisabled: State := Ord(ktidsDisabled);
            ttTopTabItemFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTopTabItemLeftEdgeNormal..ttTopTabItemLeftEdgeFocused:
        begin
          Part := THEME_TABP_TOPTABITEMLEFTEDGE;
          case Detail of
            ttTopTabItemLeftEdgeNormal: State := Ord(ktidsNormal);
            ttTopTabItemLeftEdgeHot: State := Ord(ktidsHot);
            ttTopTabItemLeftEdgeSelected: State := Ord(ktidsActive);
            ttTopTabItemLeftEdgeDisabled: State := Ord(ktidsDisabled);
            ttTopTabItemLeftEdgeFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTopTabItemRightEdgeNormal..ttTopTabItemRightEdgeFocused:
        begin
          Part := THEME_TABP_TOPTABITEMRIGHTEDGE;
          case Detail of
            ttTopTabItemRightEdgeNormal: State := Ord(ktidsNormal);
            ttTopTabItemRightEdgeHot: State := Ord(ktidsHot);
            ttTopTabItemRightEdgeSelected: State := Ord(ktidsActive);
            ttTopTabItemRightEdgeDisabled: State := Ord(ktidsDisabled);
            ttTopTabItemRightEdgeFocused: State := Ord(ktidsActive);
          end;
        end;
      ttTopTabItemBothEdgeNormal..ttTopTabItemBothEdgeFocused:
        begin
          Part := THEME_TABP_TOPTABITEMBOTHEDGE;
           case Detail of
            ttTopTabItemBothEdgeNormal: State := Ord(ktidsNormal);
            ttTopTabItemBothEdgeHot: State := Ord(ktidsHot);
            ttTopTabItemBothEdgeSelected: State := Ord(ktidsActive);
            ttTopTabItemBothEdgeDisabled: State := Ord(ktidsDisabled);
            ttTopTabItemBothEdgeFocused: State := Ord(ktidsActive);
          end;
        end;
      ttPane:
        begin
          Part := THEME_TABP_PANE;
          State := Ord(ttPane);
        end;
      ttBody:
        begin
          Part := THEME_TABP_BODY;
          State := Ord(ttBody);
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;


function TCustomStyle.GetElementDetails(Detail: TThemedStatus): TThemedElementDetails;
begin
  Result.Element := teStatus;
  with Result do
  begin
    case Detail of
      tsPane:
        begin
          Part := THEME_SP_PANE;
          State := 0;
        end;
      tsGripperPane:
        begin
          Part := THEME_SP_GRIPPERPANE;
          State := 0;
        end;
      tsGripper:
        begin
          Part := THEME_SP_GRIPPER;
          State := 0;
        end;
    else
      Part := 0;
      State := 0;
    end;
  end;
end;

function TCustomStyle.GetAvailable: Boolean;
begin
   Result := SourceLoaded;
end;

function TCustomStyle.GetEnabled: Boolean;
begin
  Result := SourceLoaded;
end;

class function TCustomStyle.LoadFromStream(Stream: TStream): TCustomStyleServices;
var
  LResult: TCustomStyle;
begin
  LResult := TCustomStyle.Create;
  if not TseStyle(LResult.FSource).LoadFromStream(Stream) then
    FreeAndNil(LResult);
  Result := LResult
end;

procedure TCustomStyle.SaveToStream(Stream: TStream);
begin
  if TseStyle(FSource).GetStyleConfig.CanStore then
    TseStyle(FSource).SaveToStream(Stream);
end;
function TCustomStyle.SourceLoaded: Boolean;
begin
  Result := (TseStyle(FSource).StyleSource <> nil) and (TseStyle(FSource).StyleSource.Count > 0);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedMenuBand): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedLink): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedNavigation): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedMonthCal): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedDatePicker): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedClock): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedExplorerBar): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedFlyOut): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTextStyle): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTextLabel): TThemedElementDetails;
begin
  Result.Element := teTextLabel;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTrayNotify): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedToolTip): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTaskBand): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedStartPanel): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTaskDialog): TThemedElementDetails;
begin
                   
end;

function TCustomStyle.GetElementDetails(Detail: TThemedTaskBar): TThemedElementDetails;
begin
                   
end;

procedure TCustomStyle.PaintBorder(Control: TWinControl; EraseLRCorner: Boolean);
var
  EmptyRect,
  DrawRect: TRect;
  DC: HDC;
  H, W: Integer;
  AStyle,
  ExStyle, Style: Integer;
  Details: TThemedElementDetails;
  C: TCanvas;
  LFontRecall: TGDIHandleRecall;
begin
  with Control do
  begin
    ExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    Style := GetWindowLong(Handle, GWL_STYLE);
    if ((ExStyle and WS_EX_CLIENTEDGE) <> 0) or ((Style and WS_BORDER) <> 0) then
    begin
      GetWindowRect(Handle, DrawRect);
      OffsetRect(DrawRect, -DrawRect.Left, -DrawRect.Top);
      DC := GetWindowDC(Handle);
      try
        EmptyRect := DrawRect;
        if EraseLRCorner then
        begin
          AStyle := GetWindowLong(Handle, GWL_STYLE);
          if ((AStyle and WS_HSCROLL) <> 0) and ((AStyle and WS_VSCROLL) <> 0) then
          begin
            W := GetSystemMetrics(SM_CXVSCROLL);
            H := GetSystemMetrics(SM_CYHSCROLL);
            if ExStyle and WS_EX_CLIENTEDGE <> 0 then
              InflateRect(EmptyRect, -2, -2)
            else
              InflateRect(EmptyRect, -1, -1);
            with EmptyRect do
              if UseRightToLeftScrollBar then
                EmptyRect := Rect(Left, Bottom - H, Left + W, Bottom)
              else
                EmptyRect := Rect(Right - W, Bottom - H, Right, Bottom);
            LFontRecall := TGDIHandleRecall.Create(DC, OBJ_FONT);
            try
              C := LFontRecall.Canvas;
              C.Brush.Color := GetSystemColor(clBtnFace);
              C.FillRect(EmptyRect);
            finally
              LFontRecall.Free;
            end;
          end;
        end;
        if ExStyle and WS_EX_CLIENTEDGE <> 0 then
        begin
          with DrawRect do
          ExcludeClipRect(DC, Left + 2, Top + 2, Right - 2, Bottom - 2);
          Details := GetElementDetails(teEditTextNormal);
          DrawElement(DC, Details, DrawRect);
        end
        else
        begin
          LFontRecall := TGDIHandleRecall.Create(DC, OBJ_FONT);
          try
            C := LFontRecall.Canvas;
            C.Brush.Style := bsSolid;
            C.Brush.Color := GetSystemColor(clWindowFrame);
            with DrawRect do
              ExcludeClipRect(C.Handle, Left + 1, Top + 1, Right - 1, Bottom - 1);
            C.FillRect(DrawRect);
          finally
            LFontRecall.Free;
          end;
        end;
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
  end;
end;

{ TStyleEngine }

class constructor TStyleEngine.Create;
begin
  inherited;
  FControls := TControlList.Create;
end;

class destructor TStyleEngine.Destroy;
begin
  FreeControlHooks;
  FreeAndNil(FControls);
  inherited;
end;

class procedure TStyleEngine.DoRemoveControl(Control: TWinControl);
var
  I: Integer;
  LControl: TControl;
begin
  if (FControls <> nil) and FControls.ContainsKey(Control) then
  begin
    for I := 0 to Control.ControlCount - 1 do
    begin
      LControl := Control.Controls[I];
      if LControl is TWinControl then
        DoRemoveControl(TWinControl(LControl));
    end;
    FControls.Items[Control].Free;
    FControls.Remove(Control);
  end;
end;

class procedure TStyleEngine.DoUnregisterStyleHook(ControlClass: TClass;
  StyleHookClass: TStyleHookClass);
var
  LItem: TPair<TComponent, TStyleHook>;
begin
  for LItem in FControls do
    if (LItem.Key is ControlClass) and (LItem.Value is StyleHookClass) then
    begin
      TStyleManager.SetStyle(TStyleManager.SystemStyle);
      Exit;
    end;
end;

class procedure TStyleEngine.FreeControlHooks;
var
  LItem: TPair<TComponent, TStyleHook>;
begin
  for LItem in FControls do
    LItem.Value.Free;
  FControls.Clear;
end;

class function TStyleEngine.HandleMessage(Control: TWinControl; var Message: TMessage;
  DefWndProc: TWndMethod): Boolean;

  function CreateStyleHook(List: TStyleHookList): TStyleHook;
  begin
    if List.Count > 0 then
      Result := List[List.Count - 1].Create(TWinControl(Control))
    else
      raise EStyleEngineException.CreateResFmt(@SStyleHookClassNotFound, [Control.ClassName]);
  end;

var
  LStyleHook: TStyleHook;
  LItem: TPair<TClass, TStyleHookList>;
begin
  Result := False;
  LStyleHook := nil;

  if not FControls.ContainsKey(Control) then
  begin
    if RegisteredStyleHooks.ContainsKey(Control.ClassType) then
      // The easy way: The class is registered
      LStyleHook := CreateStyleHook(RegisteredStyleHooks[Control.ClassType])
    else
    begin
      // The hard way: An ancestor is registered
      for LItem in RegisteredStyleHooks do
        if Control.InheritsFrom(LItem.Key) then
        begin
          LStyleHook := CreateStyleHook(Litem.Value);
          Break;
        end;
    end;
    if LStyleHook <> nil then
      FControls.Add(Control, LStyleHook);
  end
  else
    LStyleHook := FControls[Control];

  if LStyleHook <> nil then
    Result := LStyleHook.HandleMessage(Message);
end;

class procedure TStyleEngine.Notification(Operation: TCustomStyleEngine.TStyleEngineNotification; Data: Pointer);
begin
  case Operation of
    snControlDestroyed:
      DoRemoveControl(TWinControl(Data));
    snStyleHookUnregistered:
      DoUnregisterStyleHook(PStyleHookRegistrationData(Data).Key,
        PStyleHookRegistrationData(Data).Value);
  end;
end;

{ TCustomStyleTabSetElements }

class function TCustomStyleTabSetElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedTabSet(State) of
    tbsBackground:
      case ElementColor of
        ecFillColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcWindow];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tbsTabNormal:
      case ElementColor of
        ecFillColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecEdgeFillColor: Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecEdgeShadowColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecEdgeDkShadowColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecTextColor: Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfTabTextInactiveNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tbsTabSelected:
      case ElementColor of
        ecFillColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecEdgeShadowColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecEdgeDkShadowColor: Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecEdgeHighLightColor: Color := GetHighlightColor(TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase]);
        ecTextColor: Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfTabTextActiveNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleGridElements }

class function TCustomStyleGridElements.DrawEdge(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; Edges: TElementEdges;
  Flags: TElementEdgeFlags; ContentRect: PRect): Boolean;
var
  LRect: TRect;
begin
  Result := True;
  LRect := R;
  if ContentRect <> nil then
    DrawStyleEdge(DC, ContentRect^, Edges, Flags)
  else
    DrawStyleEdge(DC, LRect, Edges, Flags);
end;

class function TCustomStyleGridElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
const
  ControlName = 'DBGrid';
begin
  case TThemedGrid(State) of
    tgIndicatorArrow:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, ControlName, 'curArrow');
    tgIndicatorEdit:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, ControlName, 'curEdit');
    tgIndicatorInsert:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, ControlName, 'curInsert');
    tgIndicatorMultiDot:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, ControlName, 'curMultiDot');
    tgIndicatorMultiArrow:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, ControlName, 'curMultiArrow');
  else
    Result := inherited DrawElement(Style, DC, Part, State, R, ClipRect);
  end;
end;

class function TCustomStyleGridElements.GetElementColor(Style: TCustomStyleServices; Part,
  State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedGrid(State) of
    // gdsThemed style
    tgCellNormal:
      case ElementColor of
        ecBorderColor:
          if TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace] <>
             TseStyle(TCustomStyle(Style).FSource).SysColors[clWindow]
          then
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace]
          else
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGrid];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgCellSelected..tgCellRowSelectedRight:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemSelected].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgFixedCellNormal:
      case ElementColor of
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGrid];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgFixedCellHot:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedHot].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgFixedCellPressed:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedPressed].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;

    // gdsGradient style
    tgGradientCellNormal:
      case ElementColor of
        ecBorderColor:
          if TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace] <>
             TseStyle(TCustomStyle(Style).FSource).SysColors[clWindow]
          then
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace]
          else
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGrid];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgGradientCellSelected..tgGradientCellRowSelectedRight:
      case ElementColor of
        ecGradientColor1:
          Color := GetHighLightColor(TseStyle(TCustomStyle(Style).FSource).SysColors[clHighlight], 10);
        ecGradientColor2:
          Color := GetShadowColor(TseStyle(TCustomStyle(Style).FSource).SysColors[clHighlight], -20);
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemSelected].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgGradientFixedCellNormal:
      case ElementColor of
        ecBorderColor:
          if TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace] <>
             TseStyle(TCustomStyle(Style).FSource).SysColors[clWindow]
          then
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace]
          else
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgGradientFixedCellHot:
      case ElementColor of
        ecGradientColor1:
          Color := GetHighLightColor(TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase]);
        ecGradientColor2:
          Color := GetHighLightColor(TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd]);
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedHot].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgGradientFixedCellPressed:
      case ElementColor of
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedPressed].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;

    // gdsClassic style
    tgClassicCellNormal:
      case ElementColor of
        ecBorderColor:
          if TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace] <>
             TseStyle(TCustomStyle(Style).FSource).SysColors[clWindow]
          then
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace]
          else
            Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGrid];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgClassicCellSelected..tgClassicCellRowSelectedRight:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clHighlight];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemSelected].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgClassicFixedCellNormal:
      case ElementColor of
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgClassicFixedCellHot:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedHot].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tgClassicFixedCellPressed:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfGridItemFixedPressed].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleCategoryPanelGroupElements }

class function TCustomStyleCategoryPanelGroupElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
const
  CControlName = 'CategoryPanelGroup';
  CHeaderElement = 'Header';
  CChevronOpenedElement = 'ChevronOpened';
  CChevronClosedElement = 'ChevronClosed';
begin
  case TThemedCategoryPanelGroup(State) of
    tcpThemedHeader:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CHeaderElement);
    tcpThemedChevronOpenedNormal:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronOpenedElement, ssNormal);
    tcpThemedChevronOpenedHot:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronOpenedElement, ssHot);
    tcpThemedChevronOpenedPressed:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronOpenedElement, ssPressed);
    tcpThemedChevronClosedNormal:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronClosedElement, ssNormal);
    tcpThemedChevronClosedHot:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronClosedElement, ssHot);
    tcpThemedChevronClosedPressed:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronClosedElement, ssPressed);
  else
    Result := inherited DrawElement(Style, DC, Part, State, R, ClipRect);
  end;
end;

class function TCustomStyleCategoryPanelGroupElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
var
  LColor, LTextColor: TColor;
begin
  Result := True;
  LColor := GetTextColor(DC);
  try
    if GetElementColor(Style, Part, State, ecTextColor, LTextColor) and (LTextColor <> clNone) then
      SetTextColor(DC, ColorToRGB(LTextColor));
    Winapi.Windows.DrawText(DC, S, Length(S), R, TTextFormatFlags(Flags));
  finally
    SetTextColor(DC, ColorToRGB(LColor));
  end;
end;

class function TCustomStyleCategoryPanelGroupElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedCategoryPanelGroup(State) of
    tcpBackground:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcCategoryPanelGroup];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcpGradientHeader:
      case ElementColor of
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCategoryPanelGroupHeaderNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcpThemedHeader:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCategoryPanelGroupHeaderNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcpChevronOpenedNormal, tcpChevronClosedNormal:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCategoryPanelGroupHeaderNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcpChevronOpenedHot, tcpChevronOpenedPressed,
    tcpChevronClosedHot, tcpChevronClosedPressed:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCategoryPanelGroupHeaderHot].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

class function TCustomStyleCategoryPanelGroupElements.GetElementSize(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean;
begin
  Result := True;
  Size := TSize.Create(16, 16)
end;

{ TCustomStylePanelElements }

class function TCustomStylePanelElements.GetElementColor(Style: TCustomStyleServices; Part,
  State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedPanel(State) of
    tpPanelBackground:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcPanel];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfPanelTextNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tpPanelBevel:
      case ElementColor of
        ecEdgeHighLightColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
        ecEdgeShadowColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tpDockPanelHorzNormal, tpDockPanelVertNormal:
      case ElementColor of
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clWindowFrame];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnFace];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfPanelTextNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tpDockPanelHorzSelected, tpDockPanelVertSelected:
      case ElementColor of
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clWindowFrame];
        ecFillColor:
          Color := GetHighlightColor(TseStyle(TCustomStyle(Style).FSource).Colors[ktcPanel], 50);
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfPanelTextNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tpDockPanelPinNormal, tpDockPanelCloseNormal:
      case ElementColor of
        ecEdgeFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfButtonTextDisabled].Color;
        ecEdgeHighLightColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[cl3DLight];
        ecEdgeShadowColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnShadow];
        ecEdgeDkShadowColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcWindow];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleCategoryButtonElements }

class function TCustomStyleCategoryButtonElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
const
  CControlName = 'CategoryButtons';
  CChevronOpenedElement = 'ChevronOpened';
  CChevronClosedElement = 'ChevronClosed';
  CButtonFace = 'Face';
begin
  case TThemedCategoryButtons(State) of
    tcbButtonNormal:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CButtonFace, ssNormal);
    tcbButtonHot:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CButtonFace, ssHot);
    tcbButtonSelected:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CButtonFace, ssPressed);
    tcbCategoryGlyphOpened:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronOpenedElement);
    tcbCategoryGlyphClosed:
      Result := DrawBitmapElement(TCustomStyle(Style), DC, R, ClipRect, CControlName, CChevronClosedElement);
  else
    Result := inherited DrawElement(Style, DC, Part, State, R, ClipRect);
  end;
end;

class function TCustomStyleCategoryButtonElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;

  case TThemedCategoryButtons(State) of
    tcbBackground:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcCategoryButtons];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;

    tcbCategoryNormal:
      case ElementColor of
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcCategoryButtonsGradientBase];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcCategoryButtonsGradientEnd];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsCategoryNormal].Color;
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
        ecEdgeShadowColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcCategoryButtonsGradientEnd];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcbCategorySelected:
      case ElementColor of
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientBase];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsCategorySelected].Color;
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
        ecEdgeShadowColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcGenericGradientEnd];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;

    tcbButtonNormal:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsNormal].Color;
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcbButtonHot:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsHot].Color;
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcbButtonSelected:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsSelected].Color;
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clBtnHighlight];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;

    tcbCategoryChevronOpened:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsNormal].Color
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    tcbCategoryChevronClosed:
      case ElementColor of
        ecFillColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfCatgeoryButtonsNormal].Color
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleTextLabelElements }

class function TCustomStyleTextLabelElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect; Flags: TTextFormat;
  Options: TStyleTextOptions): Boolean;
var
  LRect: TRect;
  LFlags: Cardinal;
  LColor: TColor;
  LSaveColor: TColorRef;
  SaveIndex: Integer;
begin
  Result := True;
  LRect := R;
  LFlags := TTextFormatFlags(Flags);

  case TThemedTextLabel(State) of
    ttlTextLabelNormal, ttlTextLabelDisabled:
      begin
        LSaveColor := TColorRef(clNone);
        LColor := clNone;
        if not GetElementColor(Style, Part, State, ecTextColor, LColor) and
           (stfTextColor in Options.Flags) then
          LColor := Options.TextColor;
        if LColor <> clNone then
          LSaveColor := SetTextColor(DC, ColorToRGB(LColor));
        SaveIndex := SaveDC(DC);
        try
          SetBkMode(DC, WinAPI.Windows.Transparent);
          Winapi.Windows.DrawText(DC, PChar(S), Length(S), LRect, LFlags);
        finally
          RestoreDC(DC, SaveIndex);
          if LSaveColor <> TColorRef(clNone) then
            SetTextColor(DC, LSaveColor);
        end;
      end;
  else
    Result := inherited DrawText(Style, DC, Part, State, S, R, Flags, Options);
  end;
end;

class function TCustomStyleTextLabelElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedTextLabel(State) of
    ttlTextLabelNormal:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfStaticTextNormal].Color;
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    ttlTextLabelDisabled:
      case ElementColor of
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfStaticTextDisabled].Color;
        ecShadowColor:
          Color := GetShadowColor(TseStyle(TCustomStyle(Style).FSource).Fonts[ktfStaticTextDisabled].Color);
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleControlBarElements }

class function TCustomStyleControlBarElements.GetElementColor(
  Style: TCustomStyleServices; Part, State: Integer;
  ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedControlBar(State) of
    tcbGradientItemFrame:
      case ElementColor of
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[cl3DLight];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[cl3DDkShadow];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleHintElements }

class function TCustomStyleHintElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedHint(State) of
    thHintNormal:
      case ElementColor of
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcHintGradientBase];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcHintGradientEnd];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clWindowText];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
    thHintBalloon:
      case ElementColor of
        ecBorderColor:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcBorder];
        ecGradientColor1:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcHintGradientBase];
        ecGradientColor2:
          Color := TseStyle(TCustomStyle(Style).FSource).Colors[ktcHintGradientEnd];
        ecTextColor:
          Color := TseStyle(TCustomStyle(Style).FSource).SysColors[clWindowText];
      else
        Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
      end;
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
  end;
end;

{ TCustomStyleToolBarElements }

class function TCustomStyleToolBarElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
var
  LSource: TseStyle;
  LFontRecall: TGDIHandleRecall;

  procedure DrawToolItem(APart: TseToolItemClass; AState: TSeToolItemDrawState);
  begin
    LSource.ToolDrawItem(ktscToolbar, LFontRecall.Canvas, ToolItemInfo(R, APart, AState));
  end;
begin
  Result := True;
  LSource := TseStyle(TCustomStyle(Style).FSource);
  LFontRecall := TGDIHandleRecall.Create(DC, OBJ_FONT);
  try
    case TThemedToolBar(State) of
      // Normal toolbar button
      ttbButtonNormal: DrawToolItem(kticNormal, mtidsNormal);
      ttbButtonHot: DrawToolItem(kticNormal, mtidsHot);
      ttbButtonPressed: DrawToolItem(kticNormal, mtidsPressed);
      ttbButtonDisabled: DrawToolItem(kticNormal, mtidsDisabled);
      ttbButtonChecked:  DrawToolItem(kticNormal, mtidsChecked);
      ttbButtonCheckedHot: DrawToolItem(kticNormal, mtidsCheckedHot);
      // Drop down toolbar button
      ttbDropDownButtonNormal: DrawToolItem(kticDropDown, mtidsNormal);
      ttbDropDownButtonHot: DrawToolItem(kticDropDown, mtidsHot);
      ttbDropDownButtonPressed: DrawToolItem(kticDropDown, mtidsPressed);
      ttbDropDownButtonDisabled: DrawToolItem(kticDropDown, mtidsDisabled);
      ttbDropDownButtonChecked:  DrawToolItem(kticDropDown, mtidsChecked);
      ttbDropDownButtonCheckedHot: DrawToolItem(kticDropDown, mtidsCheckedHot);
      // Split toolbar button
      ttbSplitButtonNormal: DrawToolItem(kticComboButton, mtidsNormal);
      ttbSplitButtonHot: DrawToolItem(kticComboButton, mtidsHot);
      ttbSplitButtonPressed: DrawToolItem(kticComboButton, mtidsPressed);
      ttbSplitButtonDisabled: DrawToolItem(kticComboButton, mtidsDisabled);
      ttbSplitButtonChecked:  DrawToolItem(kticComboButton, mtidsChecked);
      ttbSplitButtonCheckedHot: DrawToolItem(kticComboButton, mtidsCheckedHot);
      // Split drop down toolbar button
      ttbSplitButtonDropDownNormal: DrawToolItem(kticComboDropDown, mtidsNormal);
      ttbSplitButtonDropDownHot: DrawToolItem(kticComboDropDown, mtidsHot);
      ttbSplitButtonDropDownPressed: DrawToolItem(kticComboDropDown, mtidsPressed);
      ttbSplitButtonDropDownDisabled: DrawToolItem(kticComboDropDown, mtidsDisabled);
      ttbSplitButtonDropDownChecked:  DrawToolItem(kticComboDropDown, mtidsChecked);
      ttbSplitButtonDropDownCheckedHot: DrawToolItem(kticComboDropDown, mtidsCheckedHot);
      // Toolbar separators
      ttbSeparatorNormal..ttbSeparatorCheckedHot,
      ttbSeparatorVertNormal..ttbSeparatorVertCheckedHot:
        LSource.ToolDrawItem(ktscToolbar, LFontRecall.Canvas,
          ToolItemInfo(R, kticSeparator, mtidsNormal), 'ToolBar');
      // Drop down button glyphs
      ttbDropDownButtonGlyphNormal..ttbDropDownButtonGlyphPressed:
        case TThemedToolBar(State) of
          ttbDropDownButtonGlyphNormal:
            DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
              'SpeedButton\Chevron', 'Glyph', ssNormal); // do not localize
          ttbDropDownButtonGlyphHot:
            DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
              'SpeedButton\Chevron', 'Glyph', ssHot); // do not localize
          ttbDropDownButtonGlyphPressed:
            DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
              'SpeedButton\Chevron', 'Glyph', ssPressed); // do not localize
        else
          Result := False;
        end;
    else
      LSource.ToolDraw(ktscToolbar, LFontRecall.Canvas, ToolInfo(R), 'ToolBar');
    end;
  finally
    LFontRecall.Free;
  end;
end;

class function TCustomStyleToolBarElements.DrawEdge(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean;
var
  LRect: TRect;
begin
  Result := True;
  LRect := R;
  if ContentRect <> nil then
    DrawStyleEdge(DC, ContentRect^, Edges, Flags)
  else
    DrawStyleEdge(DC, LRect, Edges, Flags);
end;

class function TCustomStyleToolBarElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
var
  LSource: TseStyle;
  LFontRecall: TGDIHandleRecall;
begin
  Result := True;
  LSource := TseStyle(TCustomStyle(Style).FSource);
  LFontRecall := GetFontFromDC(DC);
  try
    if stfTextColor in Options.Flags then
      LFontRecall.Canvas.Font.Color := Options.TextColor;
    LSource.DrawStyleText(LFontRecall.Canvas, TextInfo(R, S, TTextFormatFlags(Flags)));
  finally
    LFontRecall.Free;
  end;
end;

class function TCustomStyleToolBarElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
var
  LSource: TseStyle;
begin
  Result := True;
  LSource := TseStyle(TCustomStyle(Style).FSource);
  case ElementColor of
    ecTextColor:
      case TThemedToolBar(State) of
        ttbButtonNormal,
        ttbDropDownButtonNormal:
          Color := LSource.Fonts[ktfToolItemTextNormal].Color;

        ttbButtonHot,
        ttbDropDownButtonHot:
          Color := LSource.Fonts[ktfToolItemTextHot].Color;

        ttbButtonPressed,
        ttbDropDownButtonPressed,
        ttbButtonChecked,
        ttbDropDownButtonChecked,
        ttbButtonCheckedHot,
        ttbDropDownButtonCheckedHot:
          Color := LSource.Fonts[ktfToolItemTextSelected].Color;

        ttbButtonDisabled,
        ttbDropDownButtonDisabled:
          Color := LSource.Fonts[ktfToolItemTextDisabled].Color;
      else
        Color := LSource.Fonts[ktfToolItemTextNormal].Color;
      end;
  else
    Result := False;
  end;
end;

class function TCustomStyleToolBarElements.GetElementContentRect(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const BoundingRect: TRect; out ContentRect: TRect): Boolean;
begin
  Result := True;
  ContentRect := BoundingRect;
end;

class function TCustomStyleToolBarElements.HasTransparentParts(Style: TCustomStyleServices;
  Part, State: Integer): Boolean;
begin
  Result := True;
end;

{ TCustomStyleMenuElements }

class function TCustomStyleMenuElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
var
  LSource: TseStyle;
  LFontRecall: TGDIHandleRecall;

  procedure DrawMenuItem(AClass: TSeMenuSubclass; APart: TseMenuItemClass; AState: TSeMenuItemDrawState);
  var
    SaveIndex: Integer;
  begin
    SaveIndex := 0;
    if ClipRect <> nil then
    begin
      SaveIndex := SaveDC(DC);
      IntersectClipRect(DC, ClipRect^.Left, ClipRect^.Top,
        ClipRect^.Right, ClipRect^.Bottom);
    end;
    try
      LSource.MenuDrawItem(AClass, LFontRecall.Canvas,
        MenuItemInfo(R, APart, AState));
    finally
      if SaveIndex <> 0 then
        RestoreDC(DC, SaveIndex);
    end;
  end;

  procedure DrawMenuGlyph(AState: TSeMenuItemDrawState; AGlyph: TseMenuGlyph);
  begin
    LSource.MenuDrawItemGlyph(kmscPopupMenu, LFontRecall.Canvas,
      MenuItemInfo(R, kmicNormal, AState),
      MenuGlyphInfo(R, nil, kgfaCenter, AGlyph));
  end;

  procedure DrawMenu(AClass: TSeMenuSubclass);
  begin
    LSource.MenuDraw(AClass, LFontRecall.Canvas, MenuInfo(R));
  end;

begin
  Result := True;
  LSource := TseStyle(TCustomStyle(Style).FSource);
  LFontRecall := TGDIHandleRecall.Create(DC, OBJ_FONT);
  try
    case TThemedMenu(State) of
      tmMenuBarBackgroundActive,
      tmMenuBarBackgroundInactive: DrawMenu(kmscMenuBar);
      tmMenuBarItemNormal: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsNormal);
      tmMenuBarItemHot: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsHot);
      tmMenuBarItemPushed: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsSelected);
      tmMenuBarItemDisabled,
      tmMenuBarItemDisabledHot,
      tmMenuBarItemDisabledPushed: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsDisabled);
      tmPopupBackground:
        begin
          R.Inflate(2, 2);
          DrawMenu(kmscPopupMenu);
        end;
      tmPopupBorders:
        begin
          DrawMenu(kmscPopupMenu);
        end;
      tmPopupCheckNormal: DrawMenuGlyph(kmidsNormal, kmgCheckGlyph);
      tmPopupCheckDisabled: DrawMenuGlyph(kmidsDisabled, kmgCheckGlyph);
      tmPopupBulletNormal: DrawMenuGlyph(kmidsNormal, kmgRadioGlyph);
      tmPopupBulletDisabled: DrawMenuGlyph(kmidsDisabled, kmgRadioGlyph);
      tmPopupCheckBackgroundDisabled..tmPopupCheckBackgroundBitmap,
      tmPopupGutter: ; // Do nothing
      tmPopupItemNormal: DrawMenuItem(kmscPopupMenu, kmicNormal, kmidsNormal);
      tmPopupItemHot: DrawMenuItem(kmscPopupMenu, kmicNormal, kmidsHot);
      tmPopupItemDisabled,
      tmPopupItemDisabledHot: DrawMenuItem(kmscPopupMenu, kmicNormal, kmidsDisabled);
                                                
      tmPopupSeparator: DrawMenuItem(kmscPopupMenu, kmicSeparator, kmidsNormal);
      tmPopupSubMenuNormal: DrawMenuGlyph(kmidsNormal, kmgSubMenuGlyph);
      tmPopupSubMenuDisabled: DrawMenuGlyph(kmidsDisabled, kmgSubMenuGlyph);
      // Not implemented in engine
      tmSystemCloseNormal: DrawMenuGlyph(kmidsNormal, kmgClose);
      tmSystemCloseDisabled: DrawMenuGlyph(kmidsDisabled, kmgClose);
      tmSystemMaximizeNormal: DrawMenuGlyph(kmidsNormal, kmgMax);
      tmSystemMaximizeDisabled: DrawMenuGlyph(kmidsDisabled, kmgMax);
      tmSystemMinimizeNormal: DrawMenuGlyph(kmidsNormal, kmgMin);
      tmSystemMinimizeDisabled: DrawMenuGlyph(kmidsDisabled, kmgMin);
      tmSystemRestoreNormal: DrawMenuGlyph(kmidsNormal, kmgMaxRestore);
      tmSystemRestoreDisabled: DrawMenuGlyph(kmidsDisabled, kmgMaxRestore);
    else
      Result := False;
    end;
  finally
    LFontRecall.Free;
  end;
end;

class function TCustomStyleMenuElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
var
  LSource: TseStyle;
  LFontRecall: TGDIHandleRecall;

  procedure DrawMenuItem(AClass: TSeMenuSubclass; APart: TseMenuItemClass; AState: TSeMenuItemDrawState);
  begin
    if tfCalcRect in Flags then
      Winapi.Windows.DrawText(DC, PChar(S), Length(S), R, TTextFormatFlags(Flags))
    else
      LSource.MenuDrawItemText(AClass, LFontRecall.Canvas, MenuItemInfo(R, APart, AState),
        TextInfo(R, S, TTextFormatFlags(Flags)));
  end;

begin
  Result := True;
  LSource := TseStyle(TCustomStyle(Style).FSource);
  LFontRecall := TGDIHandleRecall.Create(DC, OBJ_FONT);
  try
    case TThemedMenu(State) of
      // Menu bar items
      tmMenuBarItemNormal: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsNormal);
      tmMenuBarItemHot: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsHot);
      tmMenuBarItemPushed: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsSelected);
      tmMenuBarItemDisabled,
      tmMenuBarItemDisabledHot,
      tmMenuBarItemDisabledPushed: DrawMenuItem(kmscMenuBar, kmicNormal, kmidsDisabled);
      // Popup menu items
      tmPopupItemNormal: DrawMenuItem(kmscPopupMenu, kmicNormal, kmidsNormal);
      tmPopupItemHot: DrawMenuItem(kmscPopupMenu, kmicNormal, kmidsHot);
      tmPopupItemDisabled,
      tmPopupItemDisabledHot: DrawMenuItem(kmscPopupMenu, kmicNormal, kmidsDisabled);
    else
      Result := False;
    end;
  finally
    LFontRecall.Free;
  end;
end;

class function TCustomStyleMenuElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
var
  LSource: TseStyle;
begin
  Result := True;
  LSource := TseStyle(TCustomStyle(Style).FSource);
                                                                    
  case TThemedMenu(State) of
    tmMenuBarBackgroundActive,
    tmMenuBarBackgroundInactive:
      case ElementColor of
        ecFillColor: Color := LSource.SysColors[clActiveCaption];
      else
        Result := False;
      end;
    tmMenuBarItemNormal:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfMenuItemTextNormal].Color;
      else
        Result := False;
      end;
    tmMenuBarItemHot:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfMenuItemTextHot].Color;
      else
        Result := False;
      end;
    tmMenuBarItemPushed:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfMenuItemTextSelected].Color;
      else
        Result := False;
      end;
    tmMenuBarItemDisabled,
    tmMenuBarItemDisabledHot,
    tmMenuBarItemDisabledPushed:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfMenuItemTextDisabled].Color;
      else
        Result := False;
      end;
    tmPopupBackground:
      case ElementColor of
        ecBorderColor: Color := LSource.Colors[ktcBorder];
        ecFillColor: Color := LSource.Colors[ktcWindow];
        ecEdgeHighLightColor: Color := LSource.Colors[ktcWindow];
        ecEdgeDkShadowColor: Color := LSource.Colors[ktcBorder];
      else
        Result := False;
      end;
    tmPopupItemNormal:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfPopupMenuItemTextNormal].Color;
      else
        Result := False;
      end;
    tmPopupItemHot:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfMenuItemTextSelected].Color;
      else
        Result := False;
      end;
    tmPopupItemDisabled,
    tmPopupItemDisabledHot:
      case ElementColor of
        ecTextColor: Color := LSource.Fonts[ktfMenuItemTextDisabled].Color;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

class function TCustomStyleMenuElements.GetElementMargins(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; Margin: TElementMargin; out ElementMargins: TElementMargins): Boolean;
var
  LObject: TseStyleObject;
begin
  Result := True;
  ElementMargins := TElementMargins.Create(0, 0, 0, 0);
  case TThemedMenu(State) of
    tmMenuBarBackgroundActive..tmMenuBarBackgroundInactive:
      case Margin of
        emSizing: ElementMargins := TElementMargins.Create(1, 9, 1, 15);
      else
        Result := False;
      end;
    tmMenuBarItemNormal..tmMenuBarItemDisabledPushed:
      case Margin of
        emSizing:
          begin
            LObject := GetElementObject(TCustomStyle(Style), 'MenuBar', 'Item'); // do not localize
            ElementMargins := TElementMargins.Create(LObject.MarginLeft,
              LObject.MarginTop, LObject.MarginRight, LObject.MarginBottom);
          end;
        emContent: ElementMargins := TElementMargins.Create(7, 3, 7, 3);
      else
        Result := False;
      end;
    tmPopupBackground:
      case Margin of
        emSizing: ; // Do nothing
      else
        Result := False;
      end;
    tmPopupBorders:
      case Margin of
        emSizing: ElementMargins := TElementMargins.Create(1, 1, 1, 1);
      else
        Result := False;
      end;
    tmPopupCheckNormal..tmPopupBulletDisabled:
      case Margin of
        emContent: ElementMargins := TElementMargins.Create(3, 3, 3, 3);
      else
        Result := False;
      end;
    tmPopupCheckBackgroundDisabled..tmPopupCheckBackgroundBitmap:
      case Margin of
        emContent: ElementMargins := TElementMargins.Create(3, 3, 3, 3);
        emSizing: ElementMargins := TElementMargins.Create(0, 0, 0, 6);
      else
        Result := False;
      end;
    tmPopupGutter:
      case Margin of
        emContent: ; // Do nothing
      else
        Result := False;
      end;
    tmPopupItemNormal..tmPopupItemDisabledHot:
      case Margin of
        emSizing:
          begin
            LObject := GetElementObject(TCustomStyle(Style), 'PopupMenu', 'Item'); // do not localize
            ElementMargins := TElementMargins.Create(LObject.MarginLeft,
              LObject.MarginTop, LObject.MarginRight, LObject.MarginBottom);
          end;
        emContent:
          ElementMargins := TElementMargins.Create(0, 1, 0, 1);
      else
        Result := False;
      end;
    tmPopupSeparator:
      case Margin of
        emSizing: ElementMargins := TElementMargins.Create(0, 3, 0, 1);
      else
        Result := False;
      end;
    tmPopupSubMenuNormal..tmPopupSubMenuDisabled:
      case Margin of
        emContent: ElementMargins := TElementMargins.Create(2, 3, 7, 3);
      else
        Result := False;
      end;
  else
    Result := False
  end;
end;

class function TCustomStyleMenuElements.GetElementSize(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean;
begin
  Result := True;
  Size := TSize.Create(0, 0);
  case TThemedMenu(State) of
    tmMenuItemNormal..tmSeparator:
      case ElementSize of
        esMinimum: Size := TSize.Create(2, 2);
        esActual: Size := TSize.Create(3, 3);
      else
        Result := False;
      end;
    tmMenuBarBackgroundActive..tmMenuBarBackgroundInactive:
      case ElementSize of
        esMinimum: Size := TSize.Create(2, 24);
        esActual: Size := TSize.Create(3, 25);
      end;
    tmMenuBarItemNormal..tmMenuBarItemDisabledPushed:
      case ElementSize of
        esMinimum: Size := TSize.Create(14, 6);
        esActual: Size := TSize.Create(9, 19);
      end;
    tmPopupBackground:
      case ElementSize of
        esMinimum,
        esActual: Size := TSize.Create(1, 1);
      end;
    tmPopupBorders:
      case ElementSize of
        esMinimum: Size := TSize.Create(2, 2);
        esActual: Size := TSize.Create(3, 3);
      end;
    tmPopupCheckNormal..tmPopupBulletDisabled:
      case ElementSize of
        esMinimum: Size := TSize.Create(6, 6);
      else
        Size := TSize.Create(16, 16);
      end;
    tmPopupCheckBackgroundDisabled..tmPopupCheckBackgroundBitmap:
      case ElementSize of
        esMinimum: Size := TSize.Create(6, 1);
        esActual: Size := TSize.Create(7, 7);
      end;
    tmPopupGutter:
      case ElementSize of
        esMinimum: Size := TSize.Create(2, 1);
        esActual: Size := TSize.Create(3, 1);
      end;
    tmPopupItemNormal..tmPopupItemDisabledHot:
      case ElementSize of
        esMinimum: Size := TSize.Create(1, 2);
        esActual: Size := TSize.Create(7, 21);
      end;
    tmPopupSeparator:
      case ElementSize of
        esMinimum: Size := TSize.Create(1, 4);
        esActual: Size := TSize.Create(1, 6);
      end;
    tmPopupSubMenuNormal..tmPopupSubMenuDisabled:
      Size := TSize.Create(16, 16);
    tmSystemCloseNormal..tmSystemRestoreDisabled:
      Size := TSize.Create(0, 0);
  else
    Result := False;
  end;
end;

{ TCustomStyleDataNavButtonElements }

class function TCustomStyleDataNavButtonElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;

  function GetState(I: Integer): TSeState;
  begin
    case I of
      0: Result := ssNormal;
      1: Result := ssHot;
      2: Result := ssPressed;
    else
      Result := ssDisabled;
    end;
  end;

const
  ControlName = 'DBNavigator';
begin
  Result := True;

  case TThemedDataNavButtons(State) of
    tdnbFirstNormal, tdnbFirstHot, tdnbFirstPressed, tdnbFirstDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnFirst', GetState(State - Integer(tdnbFirstNormal)));
    tdnbPriorNormal, tdnbPriorHot, tdnbPriorPressed, tdnbPriorDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnPrior', GetState(State - Integer(tdnbPriorNormal)));
    tdnbNextNormal, tdnbNextHot, tdnbNextPressed, tdnbNextDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnNext', GetState(State - Integer(tdnbNextNormal)));
    tdnbLastNormal, tdnbLastHot, tdnbLastPressed, tdnbLastDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnLast', GetState(State - Integer(tdnbLastNormal)));
    tdnbInsertNormal, tdnbInsertHot, tdnbInsertPressed, tdnbInsertDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnInsert', GetState(State - Integer(tdnbInsertNormal)));
    tdnbDeleteNormal, tdnbDeleteHot, tdnbDeletePressed, tdnbDeleteDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnDelete', GetState(State - Integer(tdnbDeleteNormal)));
    tdnbEditNormal, tdnbEditHot, tdnbEditPressed, tdnbEditDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnEdit', GetState(State - Integer(tdnbEditNormal)));
    tdnbPostNormal, tdnbPostHot, tdnbPostPressed, tdnbPostDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnPost', GetState(State - Integer(tdnbPostNormal)));
    tdnbCancelNormal, tdnbCancelHot, tdnbCancelPressed, tdnbCancelDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnCancel', GetState(State - Integer(tdnbCancelNormal)));
    tdnbRefreshNormal, tdnbRefreshHot, tdnbRefreshPressed, tdnbRefreshDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnRefresh', GetState(State - Integer(tdnbRefreshNormal)));
    tdnbApplyUpdatesNormal, tdnbApplyUpdatesHot, tdnbApplyUpdatesPressed, tdnbApplyUpdatesDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnApplyUpdates', GetState(State - Integer(tdnbApplyUpdatesNormal)));
    tdnbCancelUpdatesNormal, tdnbCancelUpdatesHot, tdnbCancelUpdatesPressed, tdnbCancelUpdatesDisabled:
      Result := DrawButtonElement(TCustomStyle(Style), DC, R, ClipRect,
        ControlName, 'btnCancelUpdates', GetState(State - Integer(tdnbCancelUpdatesNormal)));
  end;
end;

class function TCustomStyleDataNavButtonElements.GetElementContentRect(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const BoundingRect: TRect; out ContentRect: TRect): Boolean;
begin
  Result := True;
  ContentRect := TRect.Create(0, 0, 16, 16);
end;

{ TUxThemeStyleElements }

class function TUxThemeStyleElements.DrawEdge(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; Edges: TElementEdges;
  Flags: TElementEdgeFlags; ContentRect: PRect): Boolean;
var
  LRect: TRect;
begin
  Result := True;
  LRect := R;
  if ContentRect <> nil then
    DrawStyleEdge(DC, ContentRect^, Edges, Flags)
  else
    DrawStyleEdge(DC, LRect, Edges, Flags);
end;

class function TUxThemeStyleElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.DrawElement(DC, Details, R, ClipRect);
end;

class function TUxThemeStyleElements.DrawIcon(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.DrawIcon(DC, Details, R, himl, Index);
end;

class function TUxThemeStyleElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.DrawText(DC, Details, S, R, Flags, Options);
end;

class function TUxThemeStyleElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.GetElementColor(Details, ElementColor, Color);
end;

class function TUxThemeStyleElements.GetElementContentRect(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const BoundingRect: TRect; out ContentRect: TRect): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.GetElementContentRect(DC, Details, BoundingRect, ContentRect);
end;

class function TUxThemeStyleElements.GetElementMargins(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; Margin: TElementMargin; out ElementMargins: TElementMargins): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  if Rect <> nil then
    Result := TStyleManager.SystemStyle.GetElementMargins(DC, Details, Rect^, Margin, ElementMargins)
  else
    Result := TStyleManager.SystemStyle.GetElementMargins(DC, Details, Margin, ElementMargins);
end;

class function TUxThemeStyleElements.GetElementRegion(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const Rect: TRect; out Region: HRGN): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.GetElementRegion(DC, Details, Rect, Region);
end;

class function TUxThemeStyleElements.GetElementSize(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  if Rect <> nil then
    Result := TStyleManager.SystemStyle.GetElementSize(DC, Details, Rect^, ElementSize, Size)
  else
    Result := TStyleManager.SystemStyle.GetElementSize(DC, Details, ElementSize, Size);
end;

class function TUxThemeStyleElements.GetTextExtent(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const Text: string; Flags: TTextFormat;
  BoundingRect: PRect; out ExtentRect: TRect): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  if BoundingRect <> nil then
    Result := TStyleManager.SystemStyle.GetTextExtent(DC, Details, Text, Flags, BoundingRect^, ExtentRect)
  else
    Result := TStyleManager.SystemStyle.GetTextExtent(DC, Details, Text, Flags, ExtentRect);
end;

class function TUxThemeStyleElements.HasTransparentParts(Style: TCustomStyleServices;
  Part, State: Integer): Boolean;
var
  Details: TThemedElementDetails;
begin
  Details := TThemedElementDetails.Create(GetThemedElement, Part, State);
  Result := TStyleManager.SystemStyle.HasTransparentParts(Details);
end;

{ TCustomStyleTreeViewElements }

class function TCustomStyleTreeViewElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  if Part = TVP_TREEITEM then
    case State of
      TREIS_NORMAL: Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfTreeItemTextNormal].Color;
      TREIS_DISABLED: Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfTreeItemTextDisabled].Color;
    else
      Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
    end
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
end;

class function TCustomStyleTreeViewElements.GetThemedElement: TThemedElement;
begin
  Result := teTreeView;
end;

{ TCustomStyleListViewElements }

class function TCustomStyleListViewElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  if Part = LVP_LISTITEM then
    case State of
      LIS_NORMAL: Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfListItemTextNormal].Color;
      LIS_DISABLED: Color := TseStyle(TCustomStyle(Style).FSource).Fonts[ktfListItemTextDisabled].Color;
    else
      Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
    end
  else
    Result := inherited GetElementColor(Style, Part, State, ElementColor, Color);
end;

class function TCustomStyleListViewElements.GetThemedElement: TThemedElement;
begin
  Result := teListView;
end;

initialization
  TStyleManager.EngineClass := TStyleEngine;
  TStyleManager.RegisterStyleClass(TStyleEngine.FileExtension, SStyleFileDescription,
    TStyleEngine.ResourceTypeName, TCustomStyle);

  InitStyleAPI;
finalization
  TStyleManager.UnRegisterStyleEngine(TStyleEngine);
  TStyleManager.UnRegisterStyleClass(TCustomStyle);
  FinalizeStyleAPI;
end.
