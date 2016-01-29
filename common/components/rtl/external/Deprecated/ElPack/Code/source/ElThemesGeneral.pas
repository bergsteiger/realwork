
{*****************************************************}
{                                                     }
{             EldoS Themes Support Library            }
{                                                     }
{           (C) 2002-2003 EldoS Corporation           }
{                http://www.eldos.com/                }
{                                                     }
{*****************************************************}

{$include elpack2.inc}

{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit ElThemesGeneral;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows, Classes, SysUtils, ElUnicodeStrings, ElThemesMain;

type
  EThemeError = class(Exception);

  TTheme = class;
  TThemeManager = class;

  TThemePart = class
  private
    FParent: TThemePart;
    FTheme: TTheme;
  public
    constructor Create(Theme: TTheme; Parent: TThemePart); virtual;
    destructor Destroy; override;

    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); virtual; abstract;
    procedure DrawThemeEdge(DC: HDC; StateID: integer; const DestRect: TRect;
      Edge: cardinal; Flags: cardinal; ContentRect: PRect); virtual; abstract;
    procedure DrawThemeIcon(DC: HDC; StateID: integer; const Rect: TRect;
      ImageList: THandle; ImageIndex: integer); virtual; abstract;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PWideChar;
      CharCount: integer; TextFlags: cardinal; TextFlags2: cardinal;
      var Rect: TRect); virtual; abstract;
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); virtual; abstract;
    procedure GetThemeBackgroundExtent(DC: HDC; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); virtual; abstract;
    procedure GetThemeBackgroundRegion(DC: HDC; StateID: integer;
      const Rect: TRect; out Region: HRgn); virtual; abstract;
    procedure GetThemeBool(StateID: integer; PropID: integer;
      out Value: boolean); virtual; abstract;
    procedure GetThemeColor(StateID: integer; PropID: integer;
      out Color: ColorRef); virtual; abstract;
    procedure GetThemeEnumValue(StateID: integer;
      PropID: integer; out Value: integer); virtual; abstract;
    procedure GetThemeFilename(StateID: integer; PropID: integer;
      ThemeFileName: PWideChar; MaxNameChars: integer); virtual; abstract;
    procedure GetThemeFont(DC: HDC; StateID: integer; PropID: integer;
      out Font: TLogFontW); virtual; abstract;
    procedure GetThemeInt(StateID: integer; PropID: integer;
      out Value: integer); virtual; abstract;
    procedure GetThemeIntList(StateID: integer; PropID: integer;
      out List: TThemeIntList); virtual; abstract;
    procedure GetThemeMargins(DC: HDC; StateID: integer;
      PropID: integer; Rect: PRect; Margins: TThemeMargins); virtual; abstract;
    procedure GetThemeMetric(DC: HDC; StateID: integer; PropID: integer;
      out Value: integer); virtual; abstract;
    procedure GetThemePartSize(DC: HDC; StateID: integer; Rect: PRect;
      SizeType: TThemeSize; out Size: TSize); virtual; abstract;
    procedure GetThemePosition(StateID: integer; PropID: integer;
      out Point: TPoint); virtual; abstract;
    procedure GetThemePropertyOrigin(StateID: integer; PropID: integer;
      out Origin: TPropertyOrigin); virtual; abstract;
    procedure GetThemeRect(StateID: integer; PropID: integer;
      out Rect: TRect); virtual; abstract;
    procedure GetThemeString(StateID: integer; PropID: integer;
      Buffer: PWideChar; MaxBufferChars: integer); virtual; abstract;
    procedure GetThemeTextExtent(DC: HDC; StateID: integer;
      Text: PWideChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); virtual; abstract;
    procedure GetThemeTextMetrics(DC: HDC; StateID: integer;
      out Metrics: TTextMetricW); virtual; abstract;
    procedure HitTestThemeBackground(DC: HDC; StateID: integer;
      Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
      out HitTestCode: word); virtual; abstract;
    function IsThemeBackgroundPartiallyTransparent(StateID: integer): boolean; virtual; abstract;
    function IsThemePartStateDefined(StateID: integer): boolean; virtual; abstract;

    property Parent: TThemePart read FParent;
    property Theme: TTheme read FTheme;
  end;

  TTheme = class
  private
    FManager: TThemeManager;
    FPartIndex: array of integer;
    FParts: TList;
    FOnDestroy: TNotifyEvent;
  protected
    procedure AddPart(PartID: integer; ThemePart: TThemePart); virtual;
    procedure ClearParts; virtual;
    function FindPart(PartID: integer): TThemePart; virtual;

    procedure DoDestroy; virtual;
  public
    constructor Create(Manager: TThemeManager); virtual;
    destructor Destroy; override;

    procedure DrawThemeBackground(DC: HDC; PartID: integer; StateID: integer;
      const Rect: TRect; ClipRect: PRect); virtual;
    procedure DrawThemeEdge(DC: HDC; PartID: integer; StateID: integer;
      const DestRect: TRect; Edge: cardinal; Flags: cardinal;
      ContentRect: PRect); virtual;
    procedure DrawThemeIcon(DC: HDC; PartID: integer; StateID: integer;
      const Rect: TRect; ImageList: THandle; ImageIndex: integer); virtual;
    procedure DrawThemeText(DC: HDC; PartID: integer; StateID: integer;
      Text: PWideChar; CharCount: integer;  TextFlags: cardinal;
      TextFlags2: cardinal; var Rect: TRect); virtual;
    procedure GetThemeBackgroundContentRect(DC: HDC; PartID: integer;
      StateID: integer; const BoundingRect: TRect;
      out ContentRect: TRect); virtual;
    procedure GetThemeBackgroundExtent(DC: HDC; PartID: integer; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); virtual;
    procedure GetThemeBackgroundRegion(DC: HDC; PartID: integer; StateID: integer;
      const Rect: TRect; out Region: HRgn); virtual;
    procedure GetThemeBool(PartID: integer; StateID: integer; PropID: integer;
      out Value: boolean); virtual;
    procedure GetThemeColor(PartID: integer; StateID: integer; PropID: integer;
      out Color: ColorRef); virtual;
    procedure GetThemeEnumValue(PartID: integer; StateID: integer;
      PropID: integer; out Value: integer); virtual;
    procedure GetThemeFilename(PartID: integer; StateID: integer; PropID: integer;
      ThemeFileName: PWideChar; MaxNameChars: integer); virtual;
    procedure GetThemeFont(DC: HDC; PartID: integer; StateID: integer;
      PropID: integer; out Font: TLogFontW); virtual;
    procedure GetThemeInt(PartID: integer; StateID: integer; PropID: integer;
      out Value: integer); virtual;
    procedure GetThemeIntList(PartID: integer; StateID: integer; PropID: integer;
      out List: TThemeIntList); virtual;
    procedure GetThemeMargins(DC: HDC; PartID: integer; StateID: integer;
      PropID: integer; Rect: PRect; Margins: TThemeMargins); virtual;
    procedure GetThemeMetric(DC: HDC; PartID: integer; StateID: integer;
      PropID: integer; out Value: integer); virtual;
    procedure GetThemePartSize(DC: HDC; PartID: integer; StateID: integer;
      Rect: PRect; SizeType: TThemeSize; out Size: TSize); virtual;
    procedure GetThemePosition(PartID: integer; StateID: integer;
      PropID: integer; out Point: TPoint); virtual;
    procedure GetThemePropertyOrigin(PartID: integer; StateID: integer;
      PropID: integer; out Origin: TPropertyOrigin); virtual;
    procedure GetThemeRect(PartID: integer; StateID: integer; PropID: integer;
      out Rect: TRect); virtual;
    procedure GetThemeString(PartID: integer; StateID: integer; PropID: integer;
      Buffer: PWideChar; MaxBufferChars: integer); virtual;
    function GetThemeSysBool(BoolID: integer): boolean; virtual;
    function GetThemeSysColor(ColorID: integer): ColorRef; virtual;
    function GetThemeSysColorBrush(ColorID: integer): HBrush; virtual;
    procedure GetThemeSysFont(FontID: integer; out Font: TLogFontW); virtual;
    procedure GetThemeSysInt(IntID: integer; out Value: integer); virtual;
    function GetThemeSysSize(SizeID: integer): integer; virtual;
    procedure GetThemeSysString(StringID: integer; Value: PWideChar;
      MaxStringChars: integer); virtual;
    procedure GetThemeTextExtent(DC: HDC; PartID: integer; StateID: integer;
      Text: PWideChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); virtual;
    procedure GetThemeTextMetrics(DC: HDC; PartID: integer; StateID: integer;
      out Metrics: TTextMetricW); virtual;
    procedure HitTestThemeBackground(DC: HDC; PartID: integer; StateID: integer;
      Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
      out HitTestCode: word); virtual;
    function IsThemeBackgroundPartiallyTransparent(PartID: integer;
      StateID: integer): boolean; virtual;
    function IsThemePartDefined(PartID: integer; StateID: integer): boolean; virtual;

    property Manager: TThemeManager read FManager;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
  end;

  TThemeManager = class
  private
    FThemes: TElWideStringList;
    procedure ThemeDestroyed(Sender: TObject);
  protected
    FColorScheme: WideString;
    FColorSchemes: TElWideStringList;
    FFileName: WideString;
    function GetColorScheme(Index: integer): WideString; virtual;
    function GetColorSchemeCount: integer; virtual;
    function GetDisplayName: WideString; virtual; abstract;

    procedure AddTheme(ThemeName: WideString; Theme: TTheme); virtual;
    procedure ClearThemes; virtual;
    function CreateTheme(ThemeName: WideString): TTheme; virtual; abstract;
    function FindTheme(ThemeName: WideString): TTheme; virtual;
    function IndexOfTheme(Theme: TTheme): integer; virtual;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;

    // Standard API

    procedure CloseThemeData(Theme: TThemeHandle); virtual;
    procedure DrawThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; const Rect: TRect; ClipRect: PRect); virtual;
    procedure DrawThemeEdge(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; const DestRect: TRect; Edge: cardinal; Flags: cardinal;
      ContentRect: PRect); virtual;
    procedure DrawThemeIcon(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; const Rect: TRect; ImageList: THandle;
      ImageIndex: integer); virtual;
    procedure DrawThemeParentBackground(Wnd: HWnd; DC: HDC; Rect: PRect); virtual;
    procedure DrawThemeText(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; Text: PWideChar; CharCount: integer;
      TextFlags: cardinal; TextFlags2: cardinal; var Rect: TRect); virtual;
    procedure EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal); virtual;
    procedure EnableTheming(Enable: boolean); virtual;
    procedure GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
      ColorName: PWideChar; MaxColorChars: integer; FontSize: PWideChar;
      MaxSizeChars: integer); virtual;
    function GetThemeAppProperties: cardinal; virtual;
    procedure GetThemeBackgroundContentRect(Theme: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; const BoundingRect: TRect;
      out ContentRect: TRect); virtual;
    procedure GetThemeBackgroundExtent(Theme: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; const ContentRect: TRect;
      out ExtentRect: TRect); virtual;
    procedure GetThemeBackgroundRegion(Theme: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; const Rect: TRect;
      out Region: HRgn); virtual;
    procedure GetThemeBool(Theme: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Value: boolean); virtual;
    procedure GetThemeColor(Theme: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Color: ColorRef); virtual;
    procedure GetThemeDocumentationProperty(ThemeName: PWideChar;
      PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer); virtual;
    procedure GetThemeEnumValue(Theme: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out Value: integer); virtual;
    procedure GetThemeFilename(Theme: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; ThemeFileName: PWideChar;
      MaxNameChars: integer); virtual;
    procedure GetThemeFont(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; PropID: integer; out Font: LogFontW); virtual;
    procedure GetThemeInt(Theme: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Value: integer); virtual;
    procedure GetThemeIntList(Theme: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out List: TThemeIntList); virtual;
    procedure GetThemeMargins(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; PropID: integer; Rect: PRect; Margins: TThemeMargins); virtual;
    procedure GetThemeMetric(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; PropID: integer; out Value: integer); virtual;
    procedure GetThemePartSize(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; Rect: PRect; SizeType: TThemeSize; out Size: TSize); virtual;
    procedure GetThemePosition(Theme: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out Point: TPoint); virtual;
    procedure GetThemePropertyOrigin(Theme: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out Origin: TPropertyOrigin); virtual;
    procedure GetThemeRect(Theme: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Rect: TRect); virtual;
    procedure GetThemeString(Theme: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; Buffer: PWideChar; MaxBufferChars: integer); virtual;
    function GetThemeSysBool(Theme: TThemeHandle; BoolID: integer): boolean; virtual;
    function GetThemeSysColor(Theme: TThemeHandle; ColorID: integer): ColorRef; virtual;
    function GetThemeSysColorBrush(Theme: TThemeHandle; ColorID: integer): HBrush; virtual;
    procedure GetThemeSysFont(Theme: TThemeHandle; FontID: integer; out Font: LogFontW); virtual;
    procedure GetThemeSysInt(Theme: TThemeHandle; IntID: integer; out Value: integer); virtual;
    function GetThemeSysSize(Theme: TThemeHandle; SizeID: integer): integer; virtual;
    procedure GetThemeSysString(Theme: TThemeHandle; StringID: integer;
      Value: PWideChar; MaxStringChars: integer); virtual;
    procedure GetThemeTextExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; Text: PWideChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); virtual;
    procedure GetThemeTextMetrics(Theme: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; out Metrics: TTextMetricW); virtual;
    function GetWindowTheme(Wnd: HWnd): TThemeHandle; virtual;
    procedure HitTestThemeBackground(Theme: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; Options: cardinal; const Rect: TRect;
      Region: HRgn; Test: TPoint; out HitTestCode: word); virtual;
    function IsThemeBackgroundPartiallyTransparent(Theme: TThemeHandle;
      PartID: integer; StateID: integer): boolean; virtual;
    function IsThemeDialogTextureEnabled: boolean; virtual;
    function IsThemePartDefined(Theme: TThemeHandle; PartID: integer;
      StateID: integer): boolean; virtual;
    function OpenThemeData(Wnd: HWnd; const ClassList: PWideChar): TThemeHandle; virtual;
    procedure SetThemeAppProperties(Flags: cardinal); virtual;
    procedure SetWindowTheme(Wnd: HWnd; SubAppName: PWideChar;
      SubIDList: PWideChar); virtual;

    // Advanced API

    procedure Open(FileName: WideString); virtual;
    procedure Close; virtual;

    procedure Activate(ColorScheme: WideString); virtual;
    procedure ChangeColorScheme(ColorScheme: WideString); virtual;
    procedure Deactivate; virtual;

    function GetColorSchemeDisplayName(SchemeName: WideString): WideString; virtual; abstract;

    property DisplayName: WideString read GetDisplayName;
    property ColorSchemeCount: integer read GetColorSchemeCount;
    property ColorSchemes[Index: integer]: WideString read GetColorScheme;
  end;

function IsValidTheme(Theme: TThemeHandle): boolean;

resourcestring
  SInvalidThemeFileName = 'Invalid theme file name [%s]';

  SUnknownTheme = 'Unknown theme [%s]';
  SUnknownThemePart = 'Unknown theme part [%d]';
  SUnknownThemeColorScheme = 'Unknown theme color scheme [%s]';

  SUnknownThemeBool = 'Unknown system metric boolean [%d]';
  SUnknownThemeColor = 'Unknown system metric color [%d]';
  SUnknownThemeFont = 'Unknown system metric font [%d]';
  SUnknownThemeInt = 'Unknown system metric int [%d]';
  SUnknownThemeSize = 'Unknown system metric size [%d]';
  SUnknownThemeString = 'Unknown system metric string [%d]';

  SInvalidRefCount = 'Invalid RefCount value in [%s]';

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Messages, ElStrUtils, ElUxTheme, ElTmSchema, ElVclUtils;

var
  ValidThemes: TList;

function IsValidTheme(Theme: TThemeHandle): boolean;
begin
  Result := (ValidThemes.IndexOf(Pointer(Theme)) >= 0);
end;

{ TThemePart }

constructor TThemePart.Create(Theme: TTheme; Parent: TThemePart);
begin
  inherited Create;
  FParent := Parent;
  FTheme := Theme;
end;

destructor TThemePart.Destroy;
begin
  inherited;
end;

{ TTheme }

procedure TTheme.AddPart(PartID: integer; ThemePart: TThemePart);
var
  Index: integer;
begin
  Index := Length(FPartIndex);
  SetLength(FPartIndex, Index + 1);
  FPartIndex[Index] := PartID;
  FParts.Add(ThemePart);
end;

procedure TTheme.ClearParts;
var
  I: integer;
begin
  for I := 0 to FParts.Count - 1 do
    TThemePart(FParts[I]).Free;
  FParts.Clear;
  SetLength(FPartIndex, 0);
end;

constructor TTheme.Create(Manager: TThemeManager);
begin
  inherited Create;
  FManager := Manager;
  SetLength(FPartIndex, 0);
  FParts := TList.Create;
  ValidThemes.Add(Self);
end;

destructor TTheme.Destroy;
begin
  DoDestroy;
  ClearParts;
  FreeAndNil(FParts);
  ValidThemes.Remove(Self);
  inherited;
end;

procedure TTheme.DoDestroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
end;

procedure TTheme.DrawThemeBackground(DC: HDC; PartID: integer; StateID: integer;
  const Rect: TRect; ClipRect: PRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.DrawThemeBackground(DC, StateID, Rect, ClipRect);
end;

procedure TTheme.DrawThemeEdge(DC: HDC; PartID, StateID: integer;
  const DestRect: TRect; Edge, Flags: cardinal; ContentRect: PRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.DrawThemeEdge(DC, StateID, DestRect, Edge, Flags, ContentRect);
end;

procedure TTheme.DrawThemeIcon(DC: HDC; PartID, StateID: integer;
  const Rect: TRect; ImageList: THandle; ImageIndex: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.DrawThemeIcon(DC, StateID, Rect, ImageList, ImageIndex);
end;

procedure TTheme.DrawThemeText(DC: HDC; PartID, StateID: integer;
  Text: PWideChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  var Rect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
end;

function TTheme.FindPart(PartID: integer): TThemePart;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to Length(FPartIndex) - 1 do
    if FPartIndex[I] = PartID then
    begin
      Result := TThemePart(FParts[I]);
      break;
    end;
end;

procedure TTheme.GetThemeBackgroundContentRect(DC: HDC; PartID,
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeBackgroundContentRect(DC, StateID, BoundingRect, ContentRect);
end;

procedure TTheme.GetThemeBackgroundExtent(DC: HDC; PartID, StateID: integer;
  const ContentRect: TRect; out ExtentRect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeBackgroundExtent(DC, StateID, ContentRect, ExtentRect);
end;

procedure TTheme.GetThemeBackgroundRegion(DC: HDC; PartID,
  StateID: integer; const Rect: TRect; out Region: HRgn);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeBackgroundRegion(DC, StateID, Rect, Region);
end;

procedure TTheme.GetThemeBool(PartID, StateID, PropID: integer;
  out Value: boolean);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeBool(StateID, PropID, Value);
end;

procedure TTheme.GetThemeColor(PartID, StateID, PropID: integer;
  out Color: ColorRef);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeColor(StateID, PropID, Color);
end;

procedure TTheme.GetThemeEnumValue(PartID, StateID, PropID: integer;
  out Value: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeEnumValue(StateID, PropID, Value);
end;

procedure TTheme.GetThemeFilename(PartID, StateID, PropID: integer;
  ThemeFileName: PWideChar; MaxNameChars: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeFilename(StateID, PropID, ThemeFileName, MaxNameChars);
end;

procedure TTheme.GetThemeFont(DC: HDC; PartID, StateID, PropID: integer;
  out Font: LogFontW);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeFont(DC, StateID, PropID, Font);
end;

procedure TTheme.GetThemeInt(PartID, StateID, PropID: integer;
  out Value: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeInt(StateID, PropID, Value);
end;

procedure TTheme.GetThemeIntList(PartID, StateID, PropID: integer;
  out List: TThemeIntList);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeIntList(StateID, PropID, List);
end;

procedure TTheme.GetThemeMargins(DC: HDC; PartID, StateID, PropID: integer;
  Rect: PRect; Margins: TThemeMargins);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeMargins(DC, StateID, PropID, Rect, Margins);
end;

procedure TTheme.GetThemeMetric(DC: HDC; PartID, StateID, PropID: integer;
  out Value: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeMetric(DC, StateID, PropID, Value);
end;

procedure TTheme.GetThemePartSize(DC: HDC; PartID, StateID: integer;
  Rect: PRect; SizeType: TThemeSize; out Size: TSize);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemePartSize(DC, StateID, Rect, SizeType, Size);
end;

procedure TTheme.GetThemePosition(PartID, StateID, PropID: integer;
  out Point: TPoint);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemePosition(StateID, PropID, Point);
end;

procedure TTheme.GetThemePropertyOrigin(PartID, StateID, PropID: integer;
  out Origin: TPropertyOrigin);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemePropertyOrigin(StateID, PropID, Origin);
end;

procedure TTheme.GetThemeRect(PartID, StateID, PropID: integer;
  out Rect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeRect(StateID, PropID, Rect);
end;

procedure TTheme.GetThemeString(PartID, StateID, PropID: integer;
  Buffer: PWideChar; MaxBufferChars: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeString(StateID, PropID, Buffer, MaxBufferChars);
end;

function TTheme.GetThemeSysBool(BoolID: integer): boolean;
const
  SPI_GETFLATMENU = $1022;
begin
  if BoolID = TMT_FLATMENUS then
  begin
    Result := False;
    SystemParametersInfo(SPI_GETFLATMENU, 0, @Result, 0);
  end
  else
    raise EThemeError.CreateFmt(SUnknownThemeBool, [BoolID]);
end;

const
  COLOR_MENUHILIGHT = 29;
  COLOR_MENUBAR = 30;
  ColorIndexes: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of integer = (
    COLOR_SCROLLBAR, COLOR_BACKGROUND, COLOR_ACTIVECAPTION, COLOR_INACTIVECAPTION,
    COLOR_MENU, COLOR_WINDOW, COLOR_WINDOWFRAME, COLOR_MENUTEXT, COLOR_WINDOWTEXT,
    COLOR_CAPTIONTEXT, COLOR_ACTIVEBORDER, COLOR_INACTIVEBORDER, COLOR_APPWORKSPACE,
    COLOR_HIGHLIGHT, COLOR_HIGHLIGHTTEXT, COLOR_BTNFACE, COLOR_BTNSHADOW,
    COLOR_GRAYTEXT, COLOR_BTNTEXT, COLOR_INACTIVECAPTIONTEXT, COLOR_BTNHIGHLIGHT,
    COLOR_3DDKSHADOW, COLOR_3DLIGHT, COLOR_INFOTEXT, COLOR_INFOBK,
    COLOR_3DFACE, COLOR_HOTLIGHT, COLOR_GRADIENTACTIVECAPTION,
    COLOR_GRADIENTINACTIVECAPTION, COLOR_MENUHILIGHT, COLOR_MENUBAR
  );

function TTheme.GetThemeSysColor(ColorID: integer): ColorRef;
begin
  Result := GetSysColor(ColorIndexes[ColorID]);
end;

function TTheme.GetThemeSysColorBrush(ColorID: integer): HBrush;
begin
  Result := GetSysColorBrush(ColorIndexes[ColorID]);
end;

procedure TTheme.GetThemeSysFont(FontID: integer; out Font: LogFontW);
var
  TempFont: LogFontA;
  W: WideString;
  Metrics: TNonClientMetrics;
begin
  Metrics.cbSize := SizeOf(Metrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, SizeOf(Metrics), @Metrics, 0);
  case FontID of
    TMT_CAPTIONFONT:
      TempFont := Metrics.lfCaptionFont;
    TMT_SMALLCAPTIONFONT:
      TempFont := Metrics.lfSmCaptionFont;
    TMT_MENUFONT:
      TempFont := Metrics.lfMenuFont;
    TMT_STATUSFONT:
      TempFont := Metrics.lfStatusFont;
    TMT_MSGBOXFONT:
      TempFont := Metrics.lfMessageFont;
    TMT_ICONTITLEFONT:
        SystemParametersInfo(SPI_GETICONTITLELOGFONT, Sizeof(TempFont), @TempFont, 0);
  else
    raise EThemeError.CreateFmt(SUnknownThemeFont, [FontID]);
  end;
  Move(TempFont, Font, SizeOf(TempFont));
  W := TempFont.lfFaceName;
  WideStrLCopy(Font.lfFaceName, PWideChar(W), 32);
end;

procedure TTheme.GetThemeSysInt(IntID: integer; out Value: integer);
var
  DC: HDC;
begin
  case IntID of
    TMT_DPIX:
      begin
        DC := GetDC(0);
        Value := GetDeviceCaps(DC, LOGPIXELSX);
        ReleaseDC(0, DC);
      end;
    TMT_DPIY:
      begin
        DC := GetDC(0);
        Value := GetDeviceCaps(DC, LOGPIXELSY);
        ReleaseDC(0, DC);
      end;
    TMT_MINCOLORDEPTH:
      begin
        DC := GetDC(0);
        Value := GetDeviceCaps(DC, BITSPIXEL);
        ReleaseDC(0, DC);
      end;
  else
    raise EThemeError.CreateFmt(SUnknownThemeInt, [IntID]);
  end;
end;

function TTheme.GetThemeSysSize(SizeID: integer): integer;
var
  Metrics: TNonClientMetrics;
begin
  Metrics.cbSize := SizeOf(Metrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, SizeOf(Metrics), @Metrics, 0);
  case SizeID of
    TMT_BORDERWIDTH       : Result := Metrics.iBorderWidth;
    TMT_SCROLLBARWIDTH    : Result := Metrics.iScrollWidth;
    TMT_SCROLLBARHEIGHT   : Result := Metrics.iScrollHeight;
    TMT_CAPTIONBARWIDTH   : Result := Metrics.iCaptionWidth;
    TMT_CAPTIONBARHEIGHT  : Result := Metrics.iCaptionHeight;
    TMT_SMCAPTIONBARWIDTH : Result := Metrics.iSmCaptionWidth;
    TMT_SMCAPTIONBARHEIGHT: Result := Metrics.iSmCaptionHeight;
    TMT_MENUBARWIDTH      : Result := Metrics.iMenuWidth;
    TMT_MENUBARHEIGHT     : Result := Metrics.iMenuHeight;
  else
    raise EThemeError.CreateFmt(SUnknownThemeSize, [SizeID]);
  end;
end;

procedure TTheme.GetThemeSysString(StringID: integer; Value: PWideChar;
  MaxStringChars: integer);
begin
  if (StringID >= TMT_FIRSTSTRING) and (StringID <= TMT_LASTSTRING) and
    (Value <> nil) and (MaxStringChars > 0) then
    WideStrLCopy(Value, PWideChar(WideString('')), MaxStringChars)
  else
    raise EThemeError.CreateFmt(SUnknownThemeString, [StringID]);
end;

procedure TTheme.GetThemeTextExtent(DC: HDC; PartID, StateID: integer;
  Text: PWideChar; CharCount: integer; TextFlags: cardinal;
  BoundingRect: PRect; out ExtentRect: TRect);
var
  Part: TThemePart;
begin
  if BoundingRect = nil then
    ExtentRect := Rect(0, 0, 0, 0)
  else
    ExtentRect := BoundingRect^;
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeTextExtent(DC, StateID, Text, CharCount, TextFlags,
      BoundingRect, ExtentRect);
end;

procedure TTheme.GetThemeTextMetrics(DC: HDC; PartID, StateID: integer;
  out Metrics: TTextMetricW);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.GetThemeTextMetrics(DC, StateID, Metrics);
end;

procedure TTheme.HitTestThemeBackground(DC: HDC; PartID, StateID: integer;
  Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
  out HitTestCode: word);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Part.HitTestThemeBackground(DC, StateID, Options, Rect, Region,
      Test, HitTestCode);
end;

function TTheme.IsThemeBackgroundPartiallyTransparent(PartID,
  StateID: integer): boolean;
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Result := Part.IsThemeBackgroundPartiallyTransparent(StateID);
end;

function TTheme.IsThemePartDefined(PartID, StateID: integer): boolean;
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    raise EThemeError.CreateFmt(SUnknownThemePart, [PartID])
  else
    Result := Part.IsThemePartStateDefined(StateID);
end;

{ TThemeManager }

procedure TThemeManager.Activate(ColorScheme: WideString);
begin
  ChangeColorScheme(ColorScheme);
end;

procedure TThemeManager.AddTheme(ThemeName: WideString; Theme: TTheme);
begin
  if Theme <> nil then
  begin
    Theme.OnDestroy := ThemeDestroyed;
    FThemes.AddObject(ThemeName, Theme);
  end;
end;

procedure TThemeManager.ChangeColorScheme(ColorScheme: WideString);
begin
  if (ColorScheme <> '') and (FColorSchemes.IndexOf(ColorScheme) < 0) then
    raise EThemeError.CreateFmt(SUnknownThemeColorScheme, [String(ColorScheme)]);
  FColorScheme := ColorScheme;
end;

procedure TThemeManager.ClearThemes;
var
  I: integer;
  Theme: TThemeHandle;
begin
  for I := 0 to FThemes.Count - 1 do
  begin
    Theme := TThemeHandle(FThemes.Objects[I]);
    if IsValidTheme(Theme) then
    begin
      TTheme(Theme).FManager := nil;
      TTheme(Theme).OnDestroy := nil;
      TTheme(Theme).Free;
    end;
    FThemes.Objects[I] := nil;
  end;
  FThemes.Clear;
end;

procedure TThemeManager.Close;
begin
  ClearThemes;
  FColorSchemes.Clear;
  FFileName := '';
end;

procedure TThemeManager.CloseThemeData(Theme: TThemeHandle);
begin
end;

constructor TThemeManager.Create;
begin
  inherited;
  FColorScheme := '';
  FColorSchemes := TElWideStringList.Create;
  FFileName := '';
  FThemes := TElWideStringList.Create;
  FThemes.Sorted := True;
end;

procedure TThemeManager.Deactivate;
begin
  ClearThemes;
  FColorScheme := '';
end;

destructor TThemeManager.Destroy;
begin
  Close;
  FColorSchemes.Free;
  FThemes.Free;
  inherited;
end;

procedure TThemeManager.DrawThemeBackground(Theme: TThemeHandle; DC: HDC;
  PartID, StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).DrawThemeBackground(DC, PartID, StateID, Rect, ClipRect);
end;

procedure TThemeManager.DrawThemeEdge(Theme: TThemeHandle; DC: HDC; PartID,
  StateID: integer; const DestRect: TRect; Edge, Flags: cardinal;
  ContentRect: PRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).DrawThemeEdge(DC, PartID, StateID, DestRect, Edge, Flags, ContentRect);
end;

procedure TThemeManager.DrawThemeIcon(Theme: TThemeHandle; DC: HDC; PartID,
  StateID: integer; const Rect: TRect; ImageList: THandle;
  ImageIndex: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).DrawThemeIcon(DC, PartID, StateID, Rect, ImageList, ImageIndex);
end;

procedure TThemeManager.DrawThemeParentBackground(Wnd: HWnd; DC: HDC;
  Rect: PRect);
var
  P: TPoint;
  OldP: TPoint;
  ParentWnd: HWnd;
begin
  if Rect = nil then
    P := Point(0, 0)
  else
    P := Rect.TopLeft;
  ParentWnd := GetParent(Wnd);
  ClientToScreen(Wnd, P);
  ScreenToClient(ParentWnd, P);
  GetViewportOrgEx(DC, OldP);
  P.x := -P.x + OldP.x;
  P.y := -P.y + OldP.y;
  SetViewportOrgEx(DC, P.x, P.y, nil);
  SendMessage(ParentWnd, WM_ERASEBKGND, DC, 0);
  SetViewportOrgEx(DC, OldP.x, OldP.y, nil);
end;

procedure TThemeManager.DrawThemeText(Theme: TThemeHandle; DC: HDC; PartID,
  StateID: integer; Text: PWideChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; var Rect: TRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).DrawThemeText(DC, PartID, StateID, Text, CharCount, TextFlags,
      TextFlags2, Rect);
end;

procedure TThemeManager.EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal);
begin
  // By default this method does nothing
end;

procedure TThemeManager.EnableTheming(Enable: boolean);
begin
  // By default this method does nothing
end;

function TThemeManager.FindTheme(ThemeName: WideString): TTheme;
var
  Index: integer;
begin
  Index := FThemes.IndexOf(ThemeName);
  if Index >= 0 then
    Result := TTheme(FThemes.Objects[Index])
  else begin
    Result := CreateTheme(ThemeName);
    if Result <> nil then
      AddTheme(ThemeName, Result);
  end;
end;

function TThemeManager.GetColorScheme(Index: integer): WideString;
begin
  Result := FColorSchemes[Index];
end;

function TThemeManager.GetColorSchemeCount: integer;
begin
  Result := FColorSchemes.Count;
end;

procedure TThemeManager.GetCurrentThemeName(ThemeFileName: PWideChar;
  MaxNameChars: integer; ColorName: PWideChar; MaxColorChars: integer;
  FontSize: PWideChar; MaxSizeChars: integer);
begin
  if (ThemeFileName <> nil) and (MaxNameChars > 0) then
    WideStrLCopy(ThemeFileName, PWideChar(FFileName), MaxNameChars);
  if (ColorName <> nil) and (MaxColorChars > 0) then
    WideStrLCopy(ColorName, PWideChar(FColorScheme), MaxColorChars);
  if (FontSize <> nil) and (MaxSizeChars > 0) then
    WideStrLCopy(FontSize, PWideChar(WideString('')), MaxSizeChars);
end;

function TThemeManager.GetThemeAppProperties: cardinal;
begin
  Result := STAP_ALLOW_NONCLIENT or STAP_ALLOW_CONTROLS;
end;

procedure TThemeManager.GetThemeBackgroundContentRect(Theme: TThemeHandle;
  DC: HDC; PartID, StateID: integer; const BoundingRect: TRect;
  out ContentRect: TRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeBackgroundContentRect(DC, PartID, StateID, BoundingRect,
      ContentRect);
end;

procedure TThemeManager.GetThemeBackgroundExtent(Theme: TThemeHandle;
  DC: HDC; PartID, StateID: integer; const ContentRect: TRect;
  out ExtentRect: TRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeBackgroundExtent(DC, PartID, StateID, ContentRect, ExtentRect);
end;

procedure TThemeManager.GetThemeBackgroundRegion(Theme: TThemeHandle;
  DC: HDC; PartID, StateID: integer; const Rect: TRect; out Region: HRgn);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeBackgroundRegion(DC, PartID, StateID, Rect, Region);
end;

procedure TThemeManager.GetThemeBool(Theme: TThemeHandle; PartID, StateID,
  PropID: integer; out Value: boolean);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeBool(PartID, StateID, PropID, Value);
end;

procedure TThemeManager.GetThemeColor(Theme: TThemeHandle; PartID, StateID,
  PropID: integer; out Color: ColorRef);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeColor(PartID, StateID, PropID, Color);
end;

procedure TThemeManager.GetThemeDocumentationProperty(ThemeName,
  PropertyName, Value: PWideChar; MaxValueChars: integer);
begin
  if (PropertyName <> nil) and (Value <> nil) and (MaxValueChars > 0) then
    WideStrLCopy(Value, PWideChar(WideString('')), MaxValueChars);
end;

procedure TThemeManager.GetThemeEnumValue(Theme: TThemeHandle; PartID,
  StateID, PropID: integer; out Value: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeEnumValue(PartID, StateID, PropID, Value);
end;

procedure TThemeManager.GetThemeFilename(Theme: TThemeHandle; PartID,
  StateID, PropID: integer; ThemeFileName: PWideChar;
  MaxNameChars: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeFilename(PartID, StateID, PropID, ThemeFileName, MaxNameChars);
end;

procedure TThemeManager.GetThemeFont(Theme: TThemeHandle; DC: HDC; PartID,
  StateID, PropID: integer; out Font: LogFontW);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeFont(DC, PartID, StateID, PropID, Font);
end;

procedure TThemeManager.GetThemeInt(Theme: TThemeHandle; PartID, StateID,
  PropID: integer; out Value: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeInt(PartID, StateID, PropID, Value);
end;

procedure TThemeManager.GetThemeIntList(Theme: TThemeHandle; PartID,
  StateID, PropID: integer; out List: TThemeIntList);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeIntList(PartID, StateID, PropID, List);
end;

procedure TThemeManager.GetThemeMargins(Theme: TThemeHandle; DC: HDC;
  PartID, StateID, PropID: integer; Rect: PRect; Margins: TThemeMargins);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeMargins(DC, PartID, StateID, PropID, Rect, Margins);
end;

procedure TThemeManager.GetThemeMetric(Theme: TThemeHandle; DC: HDC;
  PartID, StateID, PropID: integer; out Value: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeMetric(DC, PartID, StateID, PropID, Value);
end;

procedure TThemeManager.GetThemePartSize(Theme: TThemeHandle; DC: HDC;
  PartID, StateID: integer; Rect: PRect; SizeType: TThemeSize;
  out Size: TSize);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemePartSize(DC, PartID, StateID, Rect, SizeType, Size);
end;

procedure TThemeManager.GetThemePosition(Theme: TThemeHandle; PartID,
  StateID, PropID: integer; out Point: TPoint);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemePosition(PartID, StateID, PropID, Point);
end;

procedure TThemeManager.GetThemePropertyOrigin(Theme: TThemeHandle; PartID,
  StateID, PropID: integer; out Origin: TPropertyOrigin);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemePropertyOrigin(PartID, StateID, PropID, Origin);
end;

procedure TThemeManager.GetThemeRect(Theme: TThemeHandle; PartID, StateID,
  PropID: integer; out Rect: TRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeRect(PartID, StateID, PropID, Rect);
end;

procedure TThemeManager.GetThemeString(Theme: TThemeHandle; PartID,
  StateID, PropID: integer; Buffer: PWideChar; MaxBufferChars: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeString(PartID, StateID, PropID, Buffer, MaxBufferChars);
end;

function TThemeManager.GetThemeSysBool(Theme: TThemeHandle;
  BoolID: integer): boolean;
begin
  if IsValidTheme(Theme) then
    Result := TTheme(Theme).GetThemeSysBool(BoolID)
  else
    raise EThemeError.CreateFmt(SUnknownThemeBool, [BoolID]);
end;

function TThemeManager.GetThemeSysColor(Theme: TThemeHandle;
  ColorID: integer): ColorRef;
begin
  if IsValidTheme(Theme) then
    Result := TTheme(Theme).GetThemeSysColor(ColorID)
  else
    raise EThemeError.CreateFmt(SUnknownThemeColor, [ColorID]);
end;

function TThemeManager.GetThemeSysColorBrush(Theme: TThemeHandle;
  ColorID: integer): HBrush;
begin
  if IsValidTheme(Theme) then
    Result := TTheme(Theme).GetThemeSysColorBrush(ColorID)
  else
    raise EThemeError.CreateFmt(SUnknownThemeColor, [ColorID]);
end;

procedure TThemeManager.GetThemeSysFont(Theme: TThemeHandle;
  FontID: integer; out Font: LogFontW);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeSysFont(FontID, Font)
  else
    raise EThemeError.CreateFmt(SUnknownThemeFont, [FontID]);
end;

procedure TThemeManager.GetThemeSysInt(Theme: TThemeHandle; IntID: integer;
  out Value: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeSysInt(IntID, Value)
  else
    raise EThemeError.CreateFmt(SUnknownThemeInt, [IntID]);
end;

function TThemeManager.GetThemeSysSize(Theme: TThemeHandle;
  SizeID: integer): integer;
begin
  if IsValidTheme(Theme) then
    Result := TTheme(Theme).GetThemeSysSize(SizeID)
  else
    raise EThemeError.CreateFmt(SUnknownThemeSize, [SizeID]);
end;

procedure TThemeManager.GetThemeSysString(Theme: TThemeHandle;
  StringID: integer; Value: PWideChar; MaxStringChars: integer);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeSysString(StringID, Value, MaxStringChars)
  else
    raise EThemeError.CreateFmt(SUnknownThemeString, [StringID]);
end;

procedure TThemeManager.GetThemeTextExtent(Theme: TThemeHandle; DC: HDC;
  PartID, StateID: integer; Text: PWideChar; CharCount: integer;
  TextFlags: cardinal; BoundingRect: PRect; out ExtentRect: TRect);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeTextExtent(DC, PartID, StateID, Text, CharCount,
      TextFlags, BoundingRect, ExtentRect)
  else
    ExtentRect := BoundingRect^;
end;

procedure TThemeManager.GetThemeTextMetrics(Theme: TThemeHandle; DC: HDC;
  PartID: integer; StateID: integer; out Metrics: TTextMetricW);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).GetThemeTextMetrics(DC, PartID, StateID, Metrics);
end;

function TThemeManager.GetWindowTheme(Wnd: HWnd): TThemeHandle;
begin
  Result := 0;
end;

procedure TThemeManager.HitTestThemeBackground(Theme: TThemeHandle;
  DC: HDC; PartID, StateID: integer; Options: cardinal; const Rect: TRect;
  Region: HRgn; Test: TPoint; out HitTestCode: word);
begin
  if IsValidTheme(Theme) then
    TTheme(Theme).HitTestThemeBackground(DC, PartID, StateID, Options, Rect,
      Region, Test, HitTestCode);
end;

function TThemeManager.IndexOfTheme(Theme: TTheme): integer;
begin
  Result := FThemes.IndexOfObject(Theme);
end;

function TThemeManager.IsThemeBackgroundPartiallyTransparent(
  Theme: TThemeHandle; PartID, StateID: integer): boolean;
begin
  if IsValidTheme(Theme) then
    Result := TTheme(Theme).IsThemeBackgroundPartiallyTransparent(PartID, StateID)
  else
    Result := False;
end;

function TThemeManager.IsThemeDialogTextureEnabled: boolean;
begin
  Result := False;
end;

function TThemeManager.IsThemePartDefined(Theme: TThemeHandle; PartID,
  StateID: integer): boolean;
begin
  if IsValidTheme(Theme) then
    Result := TTheme(Theme).IsThemePartDefined(PartID, StateID)
  else
    Result := False;
end;

procedure TThemeManager.Open(FileName: WideString);
begin
  FFileName := FileName;
end;

function TThemeManager.OpenThemeData(Wnd: HWnd; const ClassList: PWideChar): TThemeHandle;
var
  Theme: TTheme;
begin
  Theme := FindTheme(ClassList);
  Result := TThemeHandle(Theme);
end;

procedure TThemeManager.SetThemeAppProperties(Flags: cardinal);
begin
  // By default this method does nothing
end;

procedure TThemeManager.SetWindowTheme(Wnd: HWnd; SubAppName,
  SubIDList: PWideChar);
begin
  // By default this method does nothing
end;

procedure TThemeManager.ThemeDestroyed(Sender: TObject);
var
  I: integer;
begin
  I := FThemes.IndexOfObject(Sender);
  if I >= 0 then
    FThemes.Delete(I);
end;

initialization
  ValidThemes := TList.Create;

finalization
  {$IFDEF D_5_UP}
  FreeAndNil(ValidThemes);
  {$ELSE}
  ValidThemes.Free;
  ValidThemes := nil;
  {$ENDIF}

{$ENDIF ELPACK_THEME_ENGINE}

end.
