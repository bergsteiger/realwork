{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.FontGlyphs;

interface

uses
  System.Types, System.Classes, System.SysUtils, System.Generics.Collections,
  System.Generics.Defaults, System.UITypes, FMX.Types, FMX.Surfaces;

{$SCOPEDENUMS ON}

type

  TFontGlyphStyle = (NoGlyph);
  TFontGlyphStyles = set of TFontGlyphStyle;

  TFontSettings = record
    Family: string;
    Style: TFontStyles;
    Size: Single;
    Scale: Single;
  end;

  TFontGlyph = class
  private
    FBitmap: TBitmapSurface;
    FOrigin: TPoint;
    FAdvance: Single;
    FVerticalAvance: Single;
    FStyle: TFontGlyphStyles;
  public
    constructor Create(const AOrigin: TPoint; const AAdvance, AVertAdvance: Single;
      const AStyle: TFontGlyphStyles);
    destructor Destroy; override;
    // Raster apperiance for glyph
    property Bitmap: TBitmapSurface read FBitmap;
    // Origin of raster in char rect
    property Origin: TPoint read FOrigin;
    // Space from current point to next char
    property Advance: Single read FAdvance;
    // Space from current point to line
    property VerticalAdvance: Single read FVerticalAvance;
    property Style: TFontGlyphStyles read FStyle;
  end;

  ETFontGlyphManagerException = class(Exception);

  TFontGlyphSetting = (gsBitmap, gsPremultipliedAlpha, gsPath);
  TFontGlyphSettings = set of TFontGlyphSetting;

  TFontGlyphManager = class abstract
  private class var
    FCurrentManager: TFontGlyphManager;
    class function InternalGetFontGlyphManager: TFontGlyphManager; static;
  private
    FCurrentSettings: TFontSettings;
  protected
    function HasGlyph(const Ch: UCS4Char): Boolean;
    procedure LoadResource; virtual; abstract;
    procedure FreeResource; virtual; abstract;
    function DoGetGlyph(const Char: UCS4Char; const Settings: TFontGlyphSettings): TFontGlyph; virtual; abstract;
    property CurrentSettings: TFontSettings read FCurrentSettings;
  public
    destructor Destroy; override;
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    function GetGlyph(const Char: UCS4Char; const Font: TFont; const Scale: Single;
      const Settings: TFontGlyphSettings): TFontGlyph;
    class property Current: TFontGlyphManager read InternalGetFontGlyphManager;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  FMX.FontGlyphs.Win,
{$ENDIF}
{$IFDEF MACOS}
{$IFNDEF NEXTGEN}
  FMX.FontGlyphs.Mac,
{$ENDIF}
{$ENDIF}
{$IFDEF IOS}
  FMX.FontGlyphs.iOS,
{$ENDIF}
  System.Math;

{ TFontGlyph }

constructor TFontGlyph.Create;
begin
  inherited Create;
  FBitmap := TBitmapSurface.Create;
  FOrigin := AOrigin;
  FAdvance := AAdvance;
  FVerticalAvance := AVertAdvance;
  FStyle := AStyle;
end;

destructor TFontGlyph.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

{ TFontGlyphManager }

destructor TFontGlyphManager.Destroy;
begin
  FreeResource;
  inherited;
end;

function TFontGlyphManager.GetGlyph(const Char: UCS4Char; const Font: TFont;
  const Scale: Single; const Settings: TFontGlyphSettings): TFontGlyph;
begin
  if not SameText(FCurrentSettings.Family, Font.Family) or
     not SameValue(FCurrentSettings.Size, Font.Size) or
     (FCurrentSettings.Style <> Font.Style) or
     not SameValue(FCurrentSettings.Scale, Scale) then
  begin
    FreeResource;
    FCurrentSettings.Family := Font.Family;
    FCurrentSettings.Size := Font.Size;
    FCurrentSettings.Style := Font.Style;
    FCurrentSettings.Scale := Scale;
    LoadResource;
  end;
  Result := DoGetGlyph(Char, Settings);
end;

function TFontGlyphManager.HasGlyph(const Ch: UCS4Char): Boolean;
begin
  if Ch = 32 then
    Result := False
  else
    Result := True;
end;

class function TFontGlyphManager.InternalGetFontGlyphManager: TFontGlyphManager;
begin
  if not Assigned(FCurrentManager) then
  begin
    {$IFDEF MSWINDOWS}
    FCurrentManager := TWinFontGlyphManager.Create;
    {$ENDIF}
    {$IFDEF IOS}
    FCurrentManager := TIOSFontGlyphManager.Create;
    {$ENDIF}
    {$IFDEF MACOS}
    {$IFNDEF NEXTGEN}
    FCurrentManager := TMacFontGlyphManager.Create;
    {$ENDIF}
    {$ENDIF}
    if not Assigned(FCurrentManager) then
      raise ETFontGlyphManagerException.Create('No TFontGlyphManager implementation found');
  end;
  Result := FCurrentManager;
end;

class procedure TFontGlyphManager.UnInitialize;
begin
  FreeAndNil(FCurrentManager);
end;

end.
