{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonObsidianStyleActnCtrls;

interface

uses
  Vcl.ActnMan, Vcl.RibbonStyleActnCtrls, Vcl.Ribbon;

type

{$IF NOT DEFINED(CLR)}
{$HPPEMIT ''}
{$HPPEMIT '/* automatically link to ribbonobsidianstyleactnctrls.obj so that the property editors are registered */'}
{$HPPEMIT '#pragma link "Vcl.RibbonObsidianStyleActnCtrls"'}
{$HPPEMIT ''}
{$ENDIF}

  TRibbonObsidianStyleActionBars = class(TRibbonStyleActionBars)
  public
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetSkinClass: TCustomRibbonSkinClass; override;
    function GetStyleName: string; override;
  end;

  TRibbonObsidianSkin = class(TCustomRibbonSkin)
  public
    function GetLoadTypeValue: string; override;
    function GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType; override;
  end;

var
  RibbonObsidianStyle: TRibbonObsidianStyleActionBars;

implementation

{$R RibbonObsidianSkin.res}

uses
  Vcl.ActnMenus, System.SysUtils;

{ TRibbonObsidianStyleActionBars }

function TRibbonObsidianStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := TRibbonObsidianColorMap;
end;

function TRibbonObsidianStyleActionBars.GetSkinClass: TCustomRibbonSkinClass;
begin
  Result := TRibbonObsidianSkin;
end;

function TRibbonObsidianStyleActionBars.GetStyleName: string;
begin
  Result := 'Ribbon - Obsidian'; // do not localise
end;

{ TRibbonObsidianSkin }

// The method of loading a skin.
//
// Override this method in your custom skin to allow the loading of a skin
// from a physical file on disk.
function TRibbonObsidianSkin.GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType;
begin
  if ActionBarDesigner <> nil then
    Exit(ltResource)
  else
    Result := ltResource//ltFile
end;

// The value specific to the selected load type for the Obsidian Skin
//
// When the load type is ltResource for a custom skin, GetLoadTypeValue should
// return the name of the resource.
// When the load type is ltFile, GetLoadTypeValue should return the name and
// location of the skin file to load.
function TRibbonObsidianSkin.GetLoadTypeValue: string;
begin
  case GetLoadType of
    ltResource: Result := 'RIBBON_OBSIDIAN';
    ltFile: Result := ExtractFilePath(ParamStr(0)) + 'obsidian.bmp';
  end;
end;

initialization
  RibbonObsidianStyle := TRibbonObsidianStyleActionBars.Create;
  RegisterActnBarStyle(RibbonObsidianStyle);

finalization
  UnregisterActnBarStyle(RibbonObsidianStyle);
  RibbonObsidianStyle.Free;

end.
