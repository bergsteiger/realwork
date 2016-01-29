
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

unit ElThemesMain;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows;

const
  CMaxIntListCount = 10;

  CThemeSizeMin = 0;
  CThemeSizeTrue = 1;
  CThemeSizeDraw = 2;

  CPropOriginState = 0;
  CPropOriginPart = 1;
  CPropOriginClass = 2;
  CPropOriginGlobal = 3;
  CPropOriginNotFound = 4;

type
  TThemeHandle = THandle;
  TThemeManagerHandle = THandle;

  TThemeIntList = packed record
    ValueCount: integer;
    Values: array[0..CMaxIntListCount - 1] of integer;
  end;
  PThemeIntList = ^TThemeIntList;

  TThemeMargins = packed record
    LeftWidth: integer;
    RightWidth: integer;
    TopHeight: integer;
    BottomHeight: integer;
  end;
  PThemeMargins = ^TThemeMargins;

  TThemeSize = cardinal;

  TSize = packed record
    X: longint;
    Y: longint;
  end;
  PSize = ^TSize;

  TPropertyOrigin = cardinal;

// Standard Visual Styles API

// For description on each function see MSDN at http://msdn.microsoft.com/

function CloseThemeData(Theme: TThemeHandle): HResult; stdcall;
function DrawThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const Rect: TRect; ClipRect: PRect): HResult; stdcall;
function DrawThemeEdge(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const DestRect: TRect; Edge: cardinal; Flags: cardinal;
  ContentRect: PRect): HResult; stdcall;
function DrawThemeIcon(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; ImageList: THandle;
  ImageIndex: integer): HResult; stdcall;
function DrawThemeParentBackground(Wnd: HWnd; DC: HDC; const Rect: TRect):
  HResult; stdcall;
function DrawThemeText(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
  integer;
  Text: PWideChar; CharCount: integer; TextFlags: cardinal; TextFlags2:
    cardinal;
  var Rect: TRect): HResult; stdcall;
function EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal): HResult; stdcall;
function EnableTheming(Enable: boolean): HResult; stdcall;
function GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
  ColorName: PWideChar; MaxColorChars: integer; FontSize: PWideChar;
  MaxSizeChars: integer): HResult; stdcall;
function GetThemeAppProperties: cardinal; stdcall;
function GetThemeBackgroundContentRect(Theme: TThemeHandle; DC: HDC; PartID:
  integer;
  StateID: integer; const BoundingRect: TRect; var ContentRect: TRect): HResult;
    stdcall;
function GetThemeBackgroundExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const ContentRect: PRect; var ExtentRect: TRect): HResult;
    stdcall;
function GetThemeBackgroundRegion(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; var Region: HRgn): HResult; stdcall;
function GetThemeBool(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: BOOL): HResult; stdcall;
function GetThemeColor(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Color: ColorRef): HResult; stdcall;
function GetThemeDocumentationProperty(ThemeName: PWideChar;
  PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer): HResult;
    stdcall;
function GetThemeEnumValue(Theme: TThemeHandle; PartID: integer; StateID:
  integer;
  PropID: integer; var Value: integer): HResult; stdcall;
function GetThemeFilename(Theme: TThemeHandle; PartID: integer; StateID:
  integer;
  PropID: integer; ThemeFileName: PWideChar; MaxNameChars: integer): HResult;
    stdcall;
function GetThemeFont(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
  integer;
  PropID: integer; var Font: TLogFontW): HResult; stdcall;
function GetThemeInt(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult; stdcall;
function GetThemeIntList(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; out List: TThemeIntList): HResult; stdcall;
function GetThemeMargins(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
  integer;
  PropID: integer; Rect: PRect; var Margins: TThemeMargins): HResult; stdcall;
function GetThemeMetric(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
  integer;
  PropID: integer; var Value: integer): HResult; stdcall;
function GetThemePartSize(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer;
  Rect: PRect; SizeType: integer; var Size: Windows.TSize): HResult; stdcall;
function GetThemePosition(Theme: TThemeHandle; PartID: integer; StateID:
  integer;
  PropID: integer; var Point: TPoint): HResult; stdcall;
function GetThemePropertyOrigin(Theme: TThemeHandle; PartID: integer; StateID:
  integer;
  PropID: integer; out Origin: TPropertyOrigin): HResult; stdcall;
function GetThemeRect(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Rect: TRect): HResult; stdcall;
function GetThemeString(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; Buffer: PWideChar; MaxBufferChars: integer): HResult;
    stdcall;
function GetThemeSysBool(Theme: TThemeHandle; BoolID: integer): BOOL; stdcall;
function GetThemeSysColor(Theme: TThemeHandle; ColorID: integer): ColorRef;
  stdcall;
function GetThemeSysColorBrush(Theme: TThemeHandle; ColorID: integer): HBrush;
  stdcall;
function GetThemeSysFont(Theme: TThemeHandle; FontID: integer;
  var Font: TLogFontW): HResult; stdcall;
function GetThemeSysInt(Theme: TThemeHandle; IntID: integer;
  var Value: integer): HResult; stdcall;
function GetThemeSysSize(Theme: TThemeHandle; SizeID: integer): integer;
  stdcall;
function GetThemeSysString(Theme: TThemeHandle; StringID: integer; Value:
  PWideChar;
  MaxStringChars: integer): HResult; stdcall;
function GetThemeTextExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Text: PWideChar; CharCount: integer; TextFlags: cardinal;
  BoundingRect: PRect; var ExtentRect: TRect): HResult; stdcall;
function GetThemeTextMetrics(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; var Metrics: TTextMetricW): HResult; stdcall;
function GetWindowTheme(Wnd: HWnd): TThemeHandle; stdcall;
function HitTestThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Options: cardinal; Rect: PRect; Region: HRgn;
  Test: TPoint; var HitTestCode: word): HResult; stdcall;
function IsAppThemed: boolean; stdcall;
function IsThemeActive: boolean; stdcall;
function IsThemeBackgroundPartiallyTransparent(Theme: TThemeHandle; PartID:
  integer;
  StateID: integer): boolean; stdcall;
function IsThemeDialogTextureEnabled: BOOL; stdcall;
function IsThemePartDefined(Theme: TThemeHandle; PartID: integer;
  StateID: integer): boolean; stdcall;
function OpenThemeData(Wnd: HWnd; ClassList: PWideChar): TThemeHandle; stdcall;
procedure SetThemeAppProperties(Flags: cardinal); stdcall;
function SetWindowTheme(Wnd: HWnd; SubAppName: PWideChar;
  SubIDList: PWideChar): HResult; stdcall;

// Advanced Visual Styles API

(*
    Loads Microsoft(r) WindowsXP(r) Visual Style from [*.msstyles] file
    and returns theme manager's handle if successfull or 0(NULL) otherwise.
    The loaded theme manager must be released by calling UnloadTheme routine.
*)
function LoadTheme(const FileName: PWideChar): TThemeManagerHandle; stdcall;
(*
    Unloads the given theme manager and returns S_OK if successfull or
    E_FAIL otherwise. If the given theme manager is active at the moment,
    it will be deactivated automatically.
*)
function UnloadTheme(ThemeManager: TThemeManagerHandle): HResult; stdcall;
(*
    Sets the given theme manager as active and loads the given color scheme.
    If color scheme is not specified, the routine loads a default color scheme
    for this theme manager. The activated theme manager must be deactivated
    by calling DeactivateTheme routine.
    The function returns S_OK if succeeded and E_FAIL otherwise.

    Note: if ActivateTheme is called while another theme manager is active,
    the previous theme manager will be deactivated automatically (but not
    unloaded!), so it's no need to call DeactivateTheme before calling
    ActivateTheme, but it's still needed to call UnloadTheme for each
    theme manager returned by LoadTheme functions.
*)
function ActivateTheme(ThemeManager: TThemeManagerHandle;
  ColorScheme: PWideChar): HResult; stdcall;
(*
    Deactivates currently active theme manager.
*)
procedure DeactivateTheme; stdcall;
(*
    This function retrives display name for the given theme manager.
    The function returns S_OK if succeeded or E_FAIL otherwise.
*)
function GetThemeDisplayName(ThemeManager: TThemeManagerHandle;
  DisplayName: PWideChar; MaxNameChars: integer): HResult; stdcall;
(*
    This function returns a list of all color schemes supported by
    the given theme manager. Color schemes' names in the list are
    separated by zero-char. The list is terminated by two zero-chars.
    The function returns S_OK if succeeded or E_FAIL otherwise.
*)
function EnumThemeColorSchemes(ThemeManager: TThemeManagerHandle;
  Schemes: PWideChar; MaxSchemesChars: integer): HResult; stdcall;
(*
    This function returns display name for the given theme manager
    and color scheme.
    The function returns S_OK if succeeded or E_FAIL otherwise.
*)
function GetThemeColorSchemeDisplayName(ThemeManager: TThemeManagerHandle;
  SchemeName: PWideChar; DisplayName: PWideChar;
  MaxNameChars: integer): HResult; stdcall;
(*
    This function returns the handle of currently active theme manager
    or 0(NULL) if there is no active theme manager.
*)
function GetCurrentTheme: TThemeManagerHandle; stdcall;

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElStrUtils,
  ElThemesGeneral,
  ElThemesWindowsXP,
  ElThemeSysColorHook;

{var
  CurrentTheme: TThemeManager = nil;}

// Standard Visual Styles API

function CloseThemeData(Theme: TThemeHandle): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  if Theme = 0 then
    Result := E_FAIL
  else
  try
    if IsValidTheme(Theme) then
    begin
      if (CurrentTheme = nil) or (TTheme(Theme).Manager <> CurrentTheme) then
        TTheme(Theme).Free
      else
        CurrentTheme.CloseThemeData(Theme);
      Result := S_OK;
    end
    else
      Result := E_FAIL;
  except
    Result := E_FAIL;
  end;
end;

function DrawThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const Rect: TRect; ClipRect: PRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeBackground(Theme, DC, PartID, StateID, Rect, ClipRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function DrawThemeEdge(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const DestRect: TRect; Edge: cardinal; Flags: cardinal;
  ContentRect: PRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeEdge(Theme, DC, PartID, StateID, DestRect, Edge,
      Flags, ContentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function DrawThemeIcon(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; ImageList: THandle;
  ImageIndex: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeIcon(Theme, DC, PartID, StateID, Rect^, ImageList,
      ImageIndex);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function DrawThemeParentBackground(Wnd: HWnd; DC: HDC; const Rect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeParentBackground(Wnd, DC, @Rect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function DrawThemeText(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  Text: PWideChar; CharCount: integer; TextFlags: cardinal; TextFlags2: cardinal;
  var Rect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeText(Theme, DC, PartID, StateID, Text, CharCount,
      TextFlags, TextFlags2, Rect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.EnableThemeDialogTexture(Wnd, Flags);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function EnableTheming(Enable: boolean): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.EnableTheming(Enable);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
  ColorName: PWideChar; MaxColorChars: integer; FontSize: PWideChar;
  MaxSizeChars: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetCurrentThemeName(ThemeFileName, MaxNameChars, ColorName,
      MaxColorChars, FontSize, MaxSizeChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeAppProperties: cardinal;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.GetThemeAppProperties;
  except
    Result := 0;
  end;
end;

function GetThemeBackgroundContentRect(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const BoundingRect: TRect; var ContentRect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeBackgroundContentRect(Theme, DC, PartID, StateID,
      BoundingRect, ContentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeBackgroundExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const ContentRect: PRect; var ExtentRect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeBackgroundExtent(Theme, DC, PartID, StateID,
      ContentRect^, ExtentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeBackgroundRegion(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; var Region: HRgn): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeBackgroundRegion(Theme, DC, PartID, StateID, Rect^,
      Region);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeBool(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: BOOL): HResult;
var
  V: boolean;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    V := Value;
    CurrentTheme.GetThemeBool(Theme, PartID, StateID, PropID, V);
    Value := V;
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeColor(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Color: ColorRef): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeColor(Theme, PartID, StateID, PropID, Color);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeDocumentationProperty(ThemeName: PWideChar;
  PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeDocumentationProperty(ThemeName, PropertyName, Value,
      MaxValueChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeEnumValue(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeEnumValue(Theme, PartID, StateID, PropID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeFilename(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; ThemeFileName: PWideChar; MaxNameChars: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeFilename(Theme, PartID, StateID, PropID, ThemeFileName,
      MaxNameChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeFont(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  PropID: integer; var Font: LogFontW): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeFont(Theme, DC, PartID, StateID, PropID, Font);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeInt(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeInt(Theme, PartID, StateID, PropID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeIntList(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; out List: TThemeIntList): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeIntList(Theme, PartID, StateID, PropID, List);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeMargins(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  PropID: integer; Rect: PRect; var Margins: TThemeMargins): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeMargins(Theme, DC, PartID, StateID, PropID, Rect,
      Margins);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeMetric(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeMetric(Theme, DC, PartID, StateID, PropID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemePartSize(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer;
  Rect: PRect; SizeType: integer; var Size: Windows.TSize): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemePartSize(Theme, DC, PartID, StateID, Rect, SizeType,
      TSize(Size));
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemePosition(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Point: TPoint): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemePosition(Theme, PartID, StateID, PropID, Point);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemePropertyOrigin(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; out Origin: TPropertyOrigin): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemePropertyOrigin(Theme, PartID, StateID, PropID, Origin);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeRect(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Rect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeRect(Theme, PartID, StateID, PropID, Rect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeString(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; Buffer: PWideChar; MaxBufferChars: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeString(Theme, PartID, StateID, PropID, Buffer,
      MaxBufferChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeSysBool(Theme: TThemeHandle; BoolID: integer): BOOL;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.GetThemeSysBool(Theme, BoolID);
  except
    Result := False;
  end;
end;

function GetThemeSysColor(Theme: TThemeHandle; ColorID: integer): ColorRef;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := $FFFFFFFF
  else
  try
    Result := CurrentTheme.GetThemeSysColor(Theme, ColorID);
  except
    Result := $FFFFFFFF;
  end;
end;

function GetThemeSysColorBrush(Theme: TThemeHandle; ColorID: integer): HBrush;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.GetThemeSysColorBrush(Theme, ColorID);
  except
    Result := 0;
  end;
end;

function GetThemeSysFont(Theme: TThemeHandle; FontID: integer;
  var Font: LogFontW): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeSysFont(Theme, FontID, Font);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeSysInt(Theme: TThemeHandle; IntID: integer;
  var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeSysInt(Theme, IntID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeSysSize(Theme: TThemeHandle; SizeID: integer): integer;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    Result := CurrentTheme.GetThemeSysSize(Theme, SizeID);
  except
    Result := 0;
  end;
end;

function GetThemeSysString(Theme: TThemeHandle; StringID: integer;
  Value: PWideChar; MaxStringChars: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeSysString(Theme, StringID, Value, MaxStringChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeTextExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Text: PWideChar; CharCount: integer; TextFlags: cardinal;
  BoundingRect: PRect; var ExtentRect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeTextExtent(Theme, DC, PartID, StateID, Text, CharCount,
      TextFlags, BoundingRect, ExtentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeTextMetrics(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; var Metrics: TTextMetricW): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeTextMetrics(Theme, DC, PartID, StateID, Metrics);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function GetWindowTheme(Wnd: HWnd): TThemeHandle;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.GetWindowTheme(Wnd);
  except
    Result := 0;
  end;
end;

function HitTestThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Options: cardinal; Rect: PRect; Region: HRgn;
  Test: TPoint; var HitTestCode: word): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.HitTestThemeBackground(Theme, DC, PartID, StateID, Options,
      Rect^, Region, Test, HitTestCode);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function IsAppThemed: boolean;
begin
  Result := True;
end;

function IsThemeActive: boolean;
begin
  //Result := (CurrentTheme <> nil);
  Result := (GetGlobalCurrentTheme <> 0);
end;

function IsThemeBackgroundPartiallyTransparent(Theme: TThemeHandle; PartID: integer;
  StateID: integer): boolean;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.IsThemeBackgroundPartiallyTransparent(Theme, PartID,
      StateID);
  except
    Result := False;
  end;
end;

function IsThemeDialogTextureEnabled: BOOL;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.IsThemeDialogTextureEnabled;
  except
    Result := False;
  end;
end;

function IsThemePartDefined(Theme: TThemeHandle; PartID: integer;
  StateID: integer): boolean;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.IsThemePartDefined(Theme, PartID, StateID);
  except
    Result := False;
  end;
end;

function OpenThemeData(Wnd: HWnd; ClassList: PWideChar): TThemeHandle;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.OpenThemeData(Wnd, ClassList);
  except
    Result := 0;
  end;
end;

procedure SetThemeAppProperties(Flags: cardinal);
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme <> nil then
  try
    CurrentTheme.SetThemeAppProperties(Flags);
  except
  end;
end;

function SetWindowTheme(Wnd: HWnd; SubAppName: PWideChar; SubIDList: PWideChar): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.SetWindowTheme(Wnd, SubAppName, SubIDList);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

// Advanced Visual Styles API

function LoadTheme(const FileName: PWideChar): TThemeManagerHandle;
var
  Manager: TWindowsXPThemeManager;
begin
  try
    Manager := TWindowsXPThemeManager.Create;
    try
      Manager.Open(FileName);
      Result := TThemeManagerHandle(Manager);
    except
      Manager.Free;
      Result := 0;
    end;
  except
    Result := 0;
  end;
end;

function UnloadTheme(ThemeManager: TThemeManagerHandle): HResult;
var
  Manager: TThemeManager;
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  try
    Manager := TThemeManager(ThemeManager);
    if Manager = CurrentTheme then
      DeactivateTheme;
    Manager.Free;
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function ActivateTheme(ThemeManager: TThemeManagerHandle; ColorScheme:
  PWideChar): HResult;
var
  Manager, OldManager: TThemeManager;
  Scheme: WideString;
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  try
    if ColorScheme = nil then
      Scheme := ''
    else
      Scheme := ColorScheme;
    Manager := TThemeManager(ThemeManager);
    if CurrentTheme <> nil then
    begin
      if Manager = CurrentTheme then
      begin
        Manager.ChangeColorScheme(Scheme);
      end
      else
      begin
        OldManager := CurrentTheme;
        Manager.Activate(Scheme);
        SetGlobalCurrentTheme(THandle(Manager));
        //CurrentTheme := Manager;
        OldManager.Deactivate;
      end;
    end
    else
    begin
      Manager.Activate(Scheme);
      SetGlobalCurrentTheme(THandle(Manager));
      //CurrentTheme := Manager;
    end;
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

procedure DeactivateTheme;
var
  OldManager: TThemeManager;
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  try
    if CurrentTheme <> nil then
    begin
      OldManager := CurrentTheme;
      SetGlobalCurrentTheme(0);
      //CurrentTheme := nil;
      OldManager.Deactivate;
    end;
  except
  end;
end;

function GetThemeDisplayName(ThemeManager: TThemeManagerHandle;
  DisplayName: PWideChar; MaxNameChars: integer): HResult;
var
  Manager: TThemeManager;
  Name: WideString;
begin
  if DisplayName = nil then
    Result := E_FAIL
  else
  try
    Manager := TThemeManager(ThemeManager);
    Name := Manager.DisplayName;
    WideStrLCopy(DisplayName, PWideChar(Name), MaxNameChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

function EnumThemeColorSchemes(ThemeManager: TThemeManagerHandle;
  Schemes: PWideChar; MaxSchemesChars: integer): HResult;
var
  Manager: TThemeManager;
  Names: WideString;
  I: integer;
begin
  if Schemes = nil then
    Result := E_FAIL
  else
  try
    Manager := TThemeManager(ThemeManager);
    Names := '';
    if Manager.ColorSchemeCount > 0 then
    begin
      for I := 0 to Manager.ColorSchemeCount - 1 do
        Names := Names + Manager.ColorSchemes[I] + WideChar(#0);
    end;
    Names := Names + WideChar(#0);
    if Length(Names) <= MaxSchemesChars then
    begin
      Move(Names[1], Schemes^, Length(Names) * 2);
      Result := S_OK;
    end
    else
      Result := E_FAIL;
  except
    Result := E_FAIL;
  end;
end;

function GetThemeColorSchemeDisplayName(ThemeManager: TThemeManagerHandle;
  SchemeName: PWideChar; DisplayName: PWideChar;
  MaxNameChars: integer): HResult;
var
  Manager: TThemeManager;
  Name: WideString;
begin
  if (SchemeName = nil) or (DisplayName = nil) then
    Result := E_FAIL
  else
  try
    Manager := TThemeManager(ThemeManager);
    Name := Manager.GetColorSchemeDisplayName(SchemeName);
    if Length(Name) = 0 then
      Result := E_FAIL
    else
    begin
      WideStrLCopy(DisplayName, PWideChar(Name), MaxNameChars);
      Result := S_OK;
    end;
  except
    Result := E_FAIL;
  end;
end;

function GetCurrentTheme: TThemeManagerHandle;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := TThemeManager(GetGlobalCurrentTheme);
  if CurrentTheme = nil then
    Result := 0
  else
    Result := TThemeManagerHandle(CurrentTheme);
end;

{$ENDIF}

end.
