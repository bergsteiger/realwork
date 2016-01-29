
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

unit ElThemes;

interface

{$ifdef MSWINDOWS}
uses
  Windows, SysUtils;

{$ifdef ELPACK_THEME_ENGINE}
function ActivateTheme(ThemeManager: THandle; ColorScheme: PWideChar): HResult;
procedure DeactivateTheme;
function LoadTheme(const FileName: PWideChar): THandle;
function UnloadTheme(ThemeManager: THandle): HResult;
function GetThemeDisplayName(ThemeManager: THandle; DisplayName: PWideChar;
  MaxNameChars: integer): HResult;
function EnumThemeColorSchemes(ThemeManager: THandle; Schemes: PWideChar;
  MaxSchemesChars: integer): HResult;
function GetThemeColorSchemeDisplayName(ThemeManager: THandle;
  SchemeName: PWideChar; DisplayName: PWideChar; MaxNameChars: integer): HResult;
function GetCurrentTheme: THandle;
{$endif}

{$endif} // MSWINDOWS

implementation

{$ifdef MSWINDOWS}

uses
  Messages, Controls, Forms,
  {$ifdef ELPACK_THEME_ENGINE}
  ElThemesMain,
  ElTmSchema,
  ElThemeSysColorHook,
  {$endif}
  ElTools,
  ElStrUtils,
  ElUxTheme;

{$ifdef ELPACK_THEME_ENGINE}
var
  CurrentSystemTheme: boolean;
  DontLoadSystemTheme: boolean;

  OldThemesAvailable: Boolean;

  OldIsThemeActive: IsThemeActiveProc = nil;
  OldEnableTheming: EnableThemingProc = nil;
  OldOpenThemeData: OpenThemeDataProc = nil;
  OldCloseThemeData: CloseThemeDataProc = nil;
  OldDrawThemeParentBackground: DrawThemeParentBackgroundProc = nil;
  OldDrawThemeBackground: DrawThemeBackgroundProc = nil;
  OldDrawThemeText: DrawThemeTextProc = nil;
  OldGetThemeBackgroundContentRect: GetThemeBackgroundContentRectProc = nil;
  OldGetThemeBackgroundExtent: GetThemeBackgroundExtentProc = nil;
  OldGetThemePartSize: GetThemePartSizeProc = nil;
  OldGetThemeTextExtent: GetThemeTextExtentProc = nil;
  OldGetThemeTextMetrics: GetThemeTextMetricsProc = nil;
  OldGetThemeBackgroundRegion: GetThemeBackgroundRegionProc = nil;
  OldHitTestThemeBackground: HitTestThemeBackgroundProc = nil;
  OldDrawThemeEdge: DrawThemeEdgeProc = nil;
  OldDrawThemeIcon: DrawThemeIconProc = nil;
  OldIsThemePartDefined: IsThemePartDefinedProc = nil;
  OldIsThemeBackgroundPartiallyTransparent: IsThemeBackgroundPartiallyTransparentProc = nil;
  OldGetThemeColor: GetThemeColorProc = nil;
  OldGetThemeMetric: GetThemeMetricProc = nil;
  OldGetThemeString: GetThemeStringProc = nil;
  OldGetThemeBool: GetThemeBoolProc = nil;
  OldGetThemeInt: GetThemeIntProc = nil;
  OldGetThemeEnumValue: GetThemeEnumValueProc = nil;
  OldGetThemePosition: GetThemePositionProc = nil;
  OldGetThemeFont: GetThemeFontProc = nil;
  OldGetThemeRect: GetThemeRectProc = nil;
  OldGetThemeMargins: GetThemeMarginsProc = nil;
  OldGetThemeIntList: GetThemeIntListProc = nil;
  OldGetThemePropertyOrigin: GetThemePropertyOriginProc = nil;
  OldSetWindowTheme: SetWindowThemeProc = nil;
  OldGetThemeFilename: GetThemeFilenameProc = nil;
  OldGetThemeSysColor: GetThemeSysColorProc = nil;
  OldGetThemeSysColorBrush: GetThemeSysColorBrushProc = nil;
  OldGetThemeSysSize: GetThemeSysSizeProc = nil;
  OldGetThemeSysBool: GetThemeSysBoolProc = nil;
  OldGetThemeSysFont: GetThemeSysFontProc = nil;
  OldGetThemeSysString: GetThemeSysStringProc = nil;
  OldGetThemeSysInt: GetThemeSysIntProc = nil;
  OldIsAppThemed: IsAppThemedProc = nil;
  OldGetWindowTheme: GetWindowThemeProc = nil;
  OldEnableThemeDialogTexture: EnableThemeDialogTextureProc = nil;
  OldIsThemeDialogTextureEnabled: IsThemeDialogTextureEnabledProc = nil;
  OldGetThemeAppProperties: GetThemeAppPropertiesProc = nil;
  OldSetThemeAppProperties: SetThemeAppPropertiesProc = nil;
  OldGetCurrentThemeName: GetCurrentThemeNameProc = nil;
  OldGetThemeDocumentationProperty: GetThemeDocumentationPropertyProc = nil;
{$endif}

type
  TElThemeWatcher = class
  private
    FHandle: THandle;
    procedure WMThemeChanged(var Msg: TMessage); message WM_THEMECHANGED;
  protected
    procedure WndProc(var Msg: TMessage); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

var
  ThemeWatcher: TElThemeWatcher;
  BroadcastMessageProps: TMessage;

function EnumChildWindowProc(Wnd: HWND; Param: LPARAM): BOOL; stdcall;
begin
  SendMessage(Wnd, BroadcastMessageProps.Msg,
    BroadcastMessageProps.WParam, BroadcastMessageProps.LParam);
  EnumChildWindows(Wnd, @EnumChildWindowProc, Param);
  Result := TRUE;
end;

function EnumWindowProc(Wnd: HWND; Param: LPARAM): BOOL; stdcall;
begin
  SendMessage(Wnd, BroadcastMessageProps.Msg,
    BroadcastMessageProps.WParam, BroadcastMessageProps.LParam);
  EnumChildWindows(Wnd, @EnumChildWindowProc, Param);
  Result := TRUE;
end;

procedure BroadcastMessage(Msg: cardinal; WParam: integer; LParam: integer);
var
  ThreadID: DWORD;
begin
  BroadcastMessageProps.Msg := Msg;
  BroadcastMessageProps.WParam := WParam;
  BroadcastMessageProps.LParam := LParam;
  ThreadID := GetCurrentThreadId;
  EnumThreadWindows(ThreadID, @EnumWindowProc, ThreadID);
end;

{function EnumTopWindowsProc(Wnd: HWND; Param: LPARAM): BOOL; stdcall;
begin
  SendMessage(Wnd, BroadcastMessageProps.Msg,
    BroadcastMessageProps.WParam, BroadcastMessageProps.LParam);
  Result := TRUE;
end;

procedure BroadcastTopMessage(Msg: cardinal; WParam: integer; LParam: integer);
var
  ThreadID: DWORD;
begin
  BroadcastMessageProps.Msg := Msg;
  BroadcastMessageProps.WParam := WParam;
  BroadcastMessageProps.LParam := LParam;
  ThreadID := GetCurrentThreadId;
  EnumThreadWindows(ThreadID, @EnumTopWindowsProc, ThreadID);
end;}

{$ifdef ELPACK_THEME_ENGINE}
procedure RestoreThemeAPI_ButCloseThemeData; forward;
procedure RestoreThemeAPI_CloseThemeData; forward;

procedure HookThemeAPI;
begin
  OldThemesAvailable := ThemesAvailable;

  OldIsThemeActive := ElUxTheme.IsThemeActive;
  ElUxTheme.IsThemeActive := ElThemesMain.IsThemeActive;

  OldEnableTheming := ElUxTheme.EnableTheming;
  ElUxTheme.EnableTheming := ElThemesMain.EnableTheming;

  OldOpenThemeData := ElUxTheme.OpenThemeData;
  ElUxTheme.OpenThemeData := ElThemesMain.OpenThemeData;

  OldCloseThemeData := ElUxTheme.CloseThemeData;
  ElUxTheme.CloseThemeData := ElThemesMain.CloseThemeData;

  OldDrawThemeParentBackground := ElUxTheme.DrawThemeParentBackground;
  ElUxTheme.DrawThemeParentBackground := ElThemesMain.DrawThemeParentBackground;

  OldDrawThemeBackground := ElUxTheme.DrawThemeBackground;
  ElUxTheme.DrawThemeBackground := ElThemesMain.DrawThemeBackground;

  OldDrawThemeText := ElUxTheme.DrawThemeText;
  ElUxTheme.DrawThemeText := ElThemesMain.DrawThemeText;

  OldGetThemeBackgroundContentRect := ElUxTheme.GetThemeBackgroundContentRect;
  ElUxTheme.GetThemeBackgroundContentRect := ElThemesMain.GetThemeBackgroundContentRect;

  OldGetThemeBackgroundExtent := ElUxTheme.GetThemeBackgroundExtent;
  ElUxTheme.GetThemeBackgroundExtent := ElThemesMain.GetThemeBackgroundExtent;

  OldGetThemePartSize := ElUxTheme.GetThemePartSize;
  ElUxTheme.GetThemePartSize := ElThemesMain.GetThemePartSize;

  OldGetThemeTextExtent := ElUxTheme.GetThemeTextExtent;
  ElUxTheme.GetThemeTextExtent := ElThemesMain.GetThemeTextExtent;

  OldGetThemeTextMetrics := ElUxTheme.GetThemeTextMetrics;
  ElUxTheme.GetThemeTextMetrics := ElThemesMain.GetThemeTextMetrics;

  OldGetThemeBackgroundRegion := ElUxTheme.GetThemeBackgroundRegion;
  ElUxTheme.GetThemeBackgroundRegion := ElThemesMain.GetThemeBackgroundRegion;

  OldHitTestThemeBackground := ElUxTheme.HitTestThemeBackground;
  ElUxTheme.HitTestThemeBackground := ElThemesMain.HitTestThemeBackground;

  OldDrawThemeEdge := ElUxTheme.DrawThemeEdge;
  ElUxTheme.DrawThemeEdge := ElThemesMain.DrawThemeEdge;

  OldDrawThemeIcon := ElUxTheme.DrawThemeIcon;
  ElUxTheme.DrawThemeIcon := ElThemesMain.DrawThemeIcon;

  OldIsThemePartDefined := ElUxTheme.IsThemePartDefined;
  ElUxTheme.IsThemePartDefined := ElThemesMain.IsThemePartDefined;

  OldIsThemeBackgroundPartiallyTransparent := ElUxTheme.IsThemeBackgroundPartiallyTransparent;
  ElUxTheme.IsThemeBackgroundPartiallyTransparent := IsThemeBackgroundPartiallyTransparent;

  OldGetThemeColor := ElUxTheme.GetThemeColor;
  ElUxTheme.GetThemeColor := ElThemesMain.GetThemeColor;

  OldGetThemeMetric := ElUxTheme.GetThemeMetric;
  ElUxTheme.GetThemeMetric := ElThemesMain.GetThemeMetric;

  OldGetThemeString := ElUxTheme.GetThemeString;
  ElUxTheme.GetThemeString := ElThemesMain.GetThemeString;

  OldGetThemeBool := ElUxTheme.GetThemeBool;
  ElUxTheme.GetThemeBool := ElThemesMain.GetThemeBool;

  OldGetThemeInt := ElUxTheme.GetThemeInt;
  ElUxTheme.GetThemeInt := ElThemesMain.GetThemeInt;

  OldGetThemeEnumValue := ElUxTheme.GetThemeEnumValue;
  ElUxTheme.GetThemeEnumValue := ElThemesMain.GetThemeEnumValue;

  OldGetThemePosition := ElUxTheme.GetThemePosition;
  ElUxTheme.GetThemePosition := ElThemesMain.GetThemePosition;

  OldGetThemeFont := ElUxTheme.GetThemeFont;
  ElUxTheme.GetThemeFont := ElThemesMain.GetThemeFont;

  OldGetThemeRect := ElUxTheme.GetThemeRect;
  ElUxTheme.GetThemeRect := ElThemesMain.GetThemeRect;

  OldGetThemeMargins := ElUxTheme.GetThemeMargins;
  ElUxTheme.GetThemeMargins := GetThemeMarginsProc(@ElThemesMain.GetThemeMargins);

  OldGetThemeIntList := ElUxTheme.GetThemeIntList;
  ElUxTheme.GetThemeIntList := GetThemeIntListProc(@ElThemesMain.GetThemeIntList);

  OldGetThemePropertyOrigin := ElUxTheme.GetThemePropertyOrigin;
  ElUxTheme.GetThemePropertyOrigin := GetThemePropertyOriginProc(@ElThemesMain.GetThemePropertyOrigin);

  OldSetWindowTheme := ElUxTheme.SetWindowTheme;
  ElUxTheme.SetWindowTheme := ElThemesMain.SetWindowTheme;

  OldGetThemeFilename := ElUxTheme.GetThemeFilename;
  ElUxTheme.GetThemeFilename := ElThemesMain.GetThemeFilename;

  OldGetThemeSysColor := ElUxTheme.GetThemeSysColor;
  ElUxTheme.GetThemeSysColor := ElThemesMain.GetThemeSysColor;

  OldGetThemeSysColorBrush := ElUxTheme.GetThemeSysColorBrush;
  ElUxTheme.GetThemeSysColorBrush := ElThemesMain.GetThemeSysColorBrush;

  OldGetThemeSysSize := ElUxTheme.GetThemeSysSize;
  ElUxTheme.GetThemeSysSize := ElThemesMain.GetThemeSysSize;

  OldGetThemeSysBool := ElUxTheme.GetThemeSysBool;
  ElUxTheme.GetThemeSysBool := ElThemesMain.GetThemeSysBool;

  OldGetThemeSysFont := ElUxTheme.GetThemeSysFont;
  ElUxTheme.GetThemeSysFont := GetThemeSysFontProc(@ElThemesMain.GetThemeSysFont);

  OldGetThemeSysString := ElUxTheme.GetThemeSysString;
  ElUxTheme.GetThemeSysString := ElThemesMain.GetThemeSysString;

  OldGetThemeSysInt := ElUxTheme.GetThemeSysInt;
  ElUxTheme.GetThemeSysInt := ElThemesMain.GetThemeSysInt;

  OldIsAppThemed := ElUxTheme.IsAppThemed;
  ElUxTheme.IsAppThemed := ElThemesMain.IsAppThemed;

  OldGetWindowTheme := ElUxTheme.GetWindowTheme;
  ElUxTheme.GetWindowTheme := ElThemesMain.GetWindowTheme;

  OldEnableThemeDialogTexture := ElUxTheme.EnableThemeDialogTexture;
  ElUxTheme.EnableThemeDialogTexture := ElThemesMain.EnableThemeDialogTexture;

  OldIsThemeDialogTextureEnabled := ElUxTheme.IsThemeDialogTextureEnabled;
  ElUxTheme.IsThemeDialogTextureEnabled := ElThemesMain.IsThemeDialogTextureEnabled;

  OldGetThemeAppProperties := ElUxTheme.GetThemeAppProperties;
  ElUxTheme.GetThemeAppProperties := ElThemesMain.GetThemeAppProperties;

  OldSetThemeAppProperties := ElUxTheme.SetThemeAppProperties;
  ElUxTheme.SetThemeAppProperties := ElThemesMain.SetThemeAppProperties;

  OldGetCurrentThemeName := ElUxTheme.GetCurrentThemeName;
  ElUxTheme.GetCurrentThemeName := ElThemesMain.GetCurrentThemeName;

  OldGetThemeDocumentationProperty := ElUxTheme.GetThemeDocumentationProperty;
  ElUxTheme.GetThemeDocumentationProperty := ElThemesMain.GetThemeDocumentationProperty;

  ThemesAvailable := True;
end;

const
  ColorIndexToThemeColorIndex: array [0..30] of integer = (
    TMT_SCROLLBAR, TMT_BACKGROUND, TMT_ACTIVECAPTION, TMT_INACTIVECAPTION,
    TMT_MENU, TMT_WINDOW, TMT_WINDOWFRAME, TMT_MENUTEXT, TMT_WINDOWTEXT,
    TMT_CAPTIONTEXT, TMT_ACTIVEBORDER, TMT_INACTIVEBORDER, TMT_APPWORKSPACE,
    TMT_HIGHLIGHT, TMT_HIGHLIGHTTEXT, TMT_BTNFACE, TMT_BTNSHADOW,
    TMT_GRAYTEXT, TMT_BTNTEXT, TMT_INACTIVECAPTIONTEXT, TMT_BTNHIGHLIGHT,
    TMT_DKSHADOW3D, TMT_LIGHT3D, TMT_INFOTEXT, TMT_INFOBK, 0,
    TMT_HOTTRACKING, TMT_GRADIENTACTIVECAPTION, TMT_GRADIENTINACTIVECAPTION,
    TMT_MENUHILIGHT, TMT_MENUBAR
  );

function LoadThemeSysColors: Boolean;
var
  Lock: THandle;
  Data: PSpecialColorData;
  I: integer;
begin
  Data := BeginWriteSpecialColors(Lock);
  try
    Result := (Data<>nil);
    if Result then
    begin
      for I := 0 to cSpecialColorArraySize do
      begin
        try
          Data.Map[I] := ElThemesMain.GetThemeSysColor(0, ColorIndexToThemeColorIndex[I]);
        except
          Data.Map[I] := $FFFFFFFF;
        end;
        try
          Data.BrushMap[I] := ElThemesMain.GetThemeSysColorBrush(0, ColorIndexToThemeColorIndex[I]);
        except
          Data.BrushMap[I] := 0;
        end;
      end;
    end;
  finally
    EndWriteSpecialColors(Lock);
  end;
end;

function UnloadThemeSysColors: Boolean;
var
  Lock: THandle;
  Data: PSpecialColorData;
begin
  Data := BeginWriteSpecialColors(Lock);
  try
    Result := (Data <> nil);
    if Result then
    begin
      FillChar(Data.Map, SizeOf(Data.Map), $FF);
      FillChar(Data.BrushMap, SizeOf(Data.BrushMap), 0);
    end;
  finally
    EndWriteSpecialColors(Lock);
  end;
end;

procedure LoadCurrentSystemTheme; forward;

procedure RestoreThemeAPI_ButCloseThemeData;
begin
  if @OldIsThemeActive <> nil then
  begin
    ElUxTheme.IsThemeActive := OldIsThemeActive;
    OldIsThemeActive := nil;
  end;
  if @OldEnableTheming <> nil then
  begin
    ElUxTheme.EnableTheming := OldEnableTheming;
    OldEnableTheming := nil;
  end;
  if @OldOpenThemeData <> nil then
  begin
    ElUxTheme.OpenThemeData := OldOpenThemeData;
    OldOpenThemeData := nil;
  end;
  if @OldDrawThemeParentBackground <> nil then
  begin
    ElUxTheme.DrawThemeParentBackground := OldDrawThemeParentBackground;
    OldDrawThemeParentBackground := nil;
  end;
  if @OldDrawThemeBackground <> nil then
  begin
    ElUxTheme.DrawThemeBackground := OldDrawThemeBackground;
    OldDrawThemeBackground := nil;
  end;
  if @OldDrawThemeText <> nil then
  begin
    ElUxTheme.DrawThemeText := OldDrawThemeText;
    OldDrawThemeText := nil;
  end;
  if @OldGetThemeBackgroundContentRect <> nil then
  begin
    ElUxTheme.GetThemeBackgroundContentRect := OldGetThemeBackgroundContentRect;
    OldGetThemeBackgroundContentRect := nil;
  end;
  if @OldGetThemeBackgroundExtent <> nil then
  begin
    ElUxTheme.GetThemeBackgroundExtent := OldGetThemeBackgroundExtent;
    OldGetThemeBackgroundExtent := nil;
  end;
  if @OldGetThemePartSize <> nil then
  begin
    ElUxTheme.GetThemePartSize := OldGetThemePartSize;
    OldGetThemePartSize := nil;
  end;
  if @OldGetThemeTextExtent <> nil then
  begin
    ElUxTheme.GetThemeTextExtent := OldGetThemeTextExtent;
    OldGetThemeTextExtent := nil;
  end;
  if @OldGetThemeTextMetrics <> nil then
  begin
    ElUxTheme.GetThemeTextMetrics := OldGetThemeTextMetrics;
    OldGetThemeTextMetrics := nil;
  end;
  if @OldGetThemeBackgroundRegion <> nil then
  begin
    ElUxTheme.GetThemeBackgroundRegion := OldGetThemeBackgroundRegion;
    OldGetThemeBackgroundRegion := nil;
  end;
  if @OldHitTestThemeBackground <> nil then
  begin
    ElUxTheme.HitTestThemeBackground := OldHitTestThemeBackground;
    OldHitTestThemeBackground := nil;
  end;
  if @OldDrawThemeEdge <> nil then
  begin
    ElUxTheme.DrawThemeEdge := OldDrawThemeEdge;
    OldDrawThemeEdge := nil;
  end;
  if @OldDrawThemeIcon <> nil then
  begin
    ElUxTheme.DrawThemeIcon := OldDrawThemeIcon;
    OldDrawThemeIcon := nil;
  end;
  if @OldIsThemePartDefined <> nil then
  begin
    ElUxTheme.IsThemePartDefined := OldIsThemePartDefined;
    OldIsThemePartDefined := nil;
  end;
  if @OldIsThemeBackgroundPartiallyTransparent <> nil then
  begin
    ElUxTheme.IsThemeBackgroundPartiallyTransparent := OldIsThemeBackgroundPartiallyTransparent;
    OldIsThemeBackgroundPartiallyTransparent := nil;
  end;
  if @OldGetThemeColor <> nil then
  begin
    ElUxTheme.GetThemeColor := OldGetThemeColor;
    OldGetThemeColor := nil;
  end;
  if @OldGetThemeMetric <> nil then
  begin
    ElUxTheme.GetThemeMetric := OldGetThemeMetric;
    OldGetThemeMetric := nil;
  end;
  if @OldGetThemeString <> nil then
  begin
    ElUxTheme.GetThemeString := OldGetThemeString;
    OldGetThemeString := nil;
  end;
  if @OldGetThemeBool <> nil then
  begin
    ElUxTheme.GetThemeBool := OldGetThemeBool;
    OldGetThemeBool := nil;
  end;
  if @OldGetThemeInt <> nil then
  begin
    ElUxTheme.GetThemeInt := OldGetThemeInt;
    OldGetThemeInt := nil;
  end;
  if @OldGetThemeEnumValue <> nil then
  begin
    ElUxTheme.GetThemeEnumValue := OldGetThemeEnumValue;
    OldGetThemeEnumValue := nil;
  end;
  if @OldGetThemePosition <> nil then
  begin
    ElUxTheme.GetThemePosition := OldGetThemePosition;
    OldGetThemePosition := nil;
  end;
  if @OldGetThemeFont <> nil then
  begin
    ElUxTheme.GetThemeFont := OldGetThemeFont;
    OldGetThemeFont := nil;
  end;
  if @OldGetThemeRect <> nil then
  begin
    ElUxTheme.GetThemeRect := OldGetThemeRect;
    OldGetThemeRect := nil;
  end;
  if @OldGetThemeMargins <> nil then
  begin
    ElUxTheme.GetThemeMargins := OldGetThemeMargins;
    OldGetThemeMargins := nil;
  end;
  if @OldGetThemeIntList <> nil then
  begin
    ElUxTheme.GetThemeIntList := OldGetThemeIntList;
    OldGetThemeIntList := nil;
  end;
  if @OldGetThemePropertyOrigin <> nil then
  begin
    ElUxTheme.GetThemePropertyOrigin := OldGetThemePropertyOrigin;
    OldGetThemePropertyOrigin := nil;
  end;
  if @OldSetWindowTheme <> nil then
  begin
    ElUxTheme.SetWindowTheme := OldSetWindowTheme;
    OldSetWindowTheme := nil;
  end;
  if @OldGetThemeFilename <> nil then
  begin
    ElUxTheme.GetThemeFilename := OldGetThemeFilename;
    OldGetThemeFilename := nil;
  end;
  if @OldGetThemeSysColor <> nil then
  begin
    ElUxTheme.GetThemeSysColor := OldGetThemeSysColor;
    OldGetThemeSysColor := nil;
  end;
  if @OldGetThemeSysColorBrush <> nil then
  begin
    ElUxTheme.GetThemeSysColorBrush := OldGetThemeSysColorBrush;
    OldGetThemeSysColorBrush := nil;
  end;
  if @OldGetThemeSysSize <> nil then
  begin
    ElUxTheme.GetThemeSysSize := OldGetThemeSysSize;
    OldGetThemeSysSize := nil;
  end;
  if @OldGetThemeSysBool <> nil then
  begin
    ElUxTheme.GetThemeSysBool := OldGetThemeSysBool;
    OldGetThemeSysBool := nil;
  end;
  if @OldGetThemeSysFont <> nil then
  begin
    ElUxTheme.GetThemeSysFont := OldGetThemeSysFont;
    OldGetThemeSysFont := nil;
  end;
  if @OldGetThemeSysString <> nil then
  begin
    ElUxTheme.GetThemeSysString := OldGetThemeSysString;
    OldGetThemeSysString := nil;
  end;
  if @OldGetThemeSysInt <> nil then
  begin
    ElUxTheme.GetThemeSysInt := OldGetThemeSysInt;
    OldGetThemeSysInt := nil;
  end;
  if @OldIsAppThemed <> nil then
  begin
    ElUxTheme.IsAppThemed := OldIsAppThemed;
    OldIsAppThemed := nil;
  end;
  if @OldGetWindowTheme <> nil then
  begin
    ElUxTheme.GetWindowTheme := OldGetWindowTheme;
    OldGetWindowTheme := nil;
  end;
  if @OldEnableThemeDialogTexture <> nil then
  begin
    ElUxTheme.EnableThemeDialogTexture := OldEnableThemeDialogTexture;
    OldEnableThemeDialogTexture := nil;
  end;
  if @OldIsThemeDialogTextureEnabled <> nil then
  begin
    ElUxTheme.IsThemeDialogTextureEnabled := OldIsThemeDialogTextureEnabled;
    OldIsThemeDialogTextureEnabled := nil;
  end;
  if @OldGetThemeAppProperties <> nil then
  begin
    ElUxTheme.GetThemeAppProperties := OldGetThemeAppProperties;
    OldGetThemeAppProperties := nil;
  end;
  if @OldSetThemeAppProperties <> nil then
  begin
    ElUxTheme.SetThemeAppProperties := OldSetThemeAppProperties;
    OldSetThemeAppProperties := nil;
  end;
  if @OldGetCurrentThemeName <> nil then
  begin
    ElUxTheme.GetCurrentThemeName := OldGetCurrentThemeName;
    OldGetCurrentThemeName := nil;
  end;
  if @OldGetThemeDocumentationProperty <> nil then
  begin
    ElUxTheme.GetThemeDocumentationProperty := OldGetThemeDocumentationProperty;
    OldGetThemeDocumentationProperty := nil;
  end;
end;

procedure RestoreThemeAPI_CloseThemeData;
begin
  if @OldCloseThemeData <> nil then
  begin
    ElUxTheme.CloseThemeData := OldCloseThemeData;
    OldCloseThemeData := nil;
  end;
  ThemesAvailable := OldThemesAvailable;
end;

function ActivateTheme(ThemeManager: THandle; ColorScheme: PWideChar): HResult;
var
  Current: THandle;
begin
  if ThemeManager = 0 then
  begin
    Result := E_FAIL;
    exit;
  end;
  Current := GetCurrentTheme;
  if (Current <> 0) then
  begin
    UnloadThemeSysColors;
  end;
  Result := ElThemesMain.ActivateTheme(ThemeManager, ColorScheme);
  if Succeeded(Result) then
  begin
    LoadThemeSysColors;
    if Current = 0 then
      HookThemeAPI;
    BroadcastMessage(EL_THEMECHANGED, 0, 0);
    BroadcastMessage(WM_SYSCOLORCHANGE, 0, 0);
    BroadcastMessage(WM_NCPAINT, NULLREGION, 0);
    BroadcastMessage(CM_COLORCHANGED, 0, 0);
    CurrentSystemTheme := False;
  end;
end;

procedure DeactivateTheme;
begin
  UnloadThemeSysColors;
  RestoreThemeAPI_ButCloseThemeData;
  ElThemesMain.DeactivateTheme;
  BroadcastMessage(EL_THEMECHANGED, 0, 0);
  BroadcastMessage(WM_SYSCOLORCHANGE, 0, 0);
  BroadcastMessage(WM_NCPAINT, NULLREGION, 0);
  BroadcastMessage(CM_COLORCHANGED, 0, 0);
  RestoreThemeAPI_CloseThemeData;
  if IsWinXPUp and not DontLoadSystemTheme then
    LoadCurrentSystemTheme;
end;

function LoadTheme(const FileName: PWideChar): THandle;
begin
  Result := ElThemesMain.LoadTheme(FileName);
end;

function UnloadTheme(ThemeManager: THandle): HResult;
begin
  try
    if ThemeManager <> 0 then
    begin
      if ThemeManager = GetCurrentTheme then
        DeactivateTheme;
      Result := ElThemesMain.UnloadTheme(ThemeManager);
    end
    else
      Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeDisplayName(ThemeManager: THandle; DisplayName: PWideChar;
  MaxNameChars: integer): HResult;
begin
  Result := ElThemesMain.GetThemeDisplayName(ThemeManager, DisplayName,
    MaxNameChars);
end;

function EnumThemeColorSchemes(ThemeManager: THandle; Schemes: PWideChar;
  MaxSchemesChars: integer): HResult;
begin
  Result := ElThemesMain.EnumThemeColorSchemes(ThemeManager, Schemes, MaxSchemesChars);
end;

function GetThemeColorSchemeDisplayName(ThemeManager: THandle;
  SchemeName: PWideChar; DisplayName: PWideChar; MaxNameChars: integer): HResult;
begin
  Result := ElThemesMain.GetThemeColorSchemeDisplayName(ThemeManager,
    SchemeName, DisplayName, MaxNameChars);
end;

function GetCurrentTheme: THandle;
begin
  Result := GetGlobalCurrentTheme; //ElThemesMain.GetCurrentTheme;
end;

procedure LoadCurrentSystemTheme;
var
  FileName, ColorScheme: WideString;
  Manager: THandle;
begin
  if not CurrentSystemTheme and ElUxTheme.IsThemeActive then
  begin
    SetLength(FileName, 1024);
    SetLength(ColorScheme, 100);
    if Succeeded(ElUxTheme.GetCurrentThemeName(PWideChar(FileName), 1024,
      PWideChar(ColorScheme), 100, nil, 0)) then
    begin
      SetLength(FileName, WideStrLen(PWideChar(FileName)));
      SetLength(ColorScheme, WideStrLen(PWideChar(ColorScheme)));
      Manager := LoadTheme(PWideChar(FileName));
      if Manager <> 0 then
      begin
        ActivateTheme(Manager, PWideChar(ColorScheme));
        CurrentSystemTheme := True;
      end;
    end;
  end;
end;

procedure UnloadCurrentSystemTheme;
var
  Manager: THandle;
begin
  if CurrentSystemTheme and (GetCurrentTheme <> 0) then
  begin
    Manager := GetCurrentTheme;
    DontLoadSystemTheme := True;
    DeactivateTheme;
    UnloadTheme(Manager);
  end;
end;
{$endif}

{ TElThemeWatcher }

constructor TElThemeWatcher.Create;
begin
  inherited;
  {$warnings off}
  FHandle := AllocateHWnd(WndProc);
  {$warnings on}
end;

destructor TElThemeWatcher.Destroy;
begin
  {$warnings off}
  DeallocateHWnd(FHandle);
  {$warnings on}
  inherited;
end;

procedure TElThemeWatcher.WMThemeChanged(var Msg: TMessage);
begin
  {$ifdef ELPACK_THEME_ENGINE}
  if CurrentSystemTheme then
  begin
    UnloadCurrentSystemTheme;
    LoadCurrentSystemTheme;
  end;
  {$endif}
  BroadcastMessage(EL_THEMECHANGED, 0, 0);
  {$ifdef ELPACK_THEME_ENGINE}
  BroadcastMessage(WM_SYSCOLORCHANGE, 0, 0);
  BroadcastMessage(WM_NCPAINT, NULLREGION, 0);
  BroadcastMessage(CM_COLORCHANGED, 0, 0);
  {$endif}
end;

procedure TElThemeWatcher.WndProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_ThemeChanged then
    WMThemeChanged(Msg)
  else
  if Msg.Msg = WM_QUERYENDSESSION then
    Msg.Result := 1
  else
    DefWindowProc(Self.FHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

{$endif} // MSWINDOWS

initialization
{$ifdef MSWINDOWS}
try
  InitializeUxTheme;
  ThemeWatcher := TElThemeWatcher.Create;
  {$ifdef ELPACK_THEME_ENGINE}
  CurrentSystemTheme := False;
  DontLoadSystemTheme := False;
  if IsWinXPUp then
    LoadCurrentSystemTheme;
  {$endif}
except
  on e:exception do
  begin
    OutputDebugString( PChar('ERROR (ElThemes.pas): '+e.Message) );
    raise;
  end;
end;
{$endif}

finalization
{$ifdef MSWINDOWS}
  {$ifdef ELPACK_THEME_ENGINE}
  if IsWinXPUp then
    UnloadCurrentSystemTheme;
  {$endif}
  ThemeWatcher.Free;
  FinalizeUxTheme;
{$endif}

end.
