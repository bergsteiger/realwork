{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonSilverStyleActnCtrls;

interface

uses
  Vcl.ActnMan, Vcl.RibbonStyleActnCtrls, Vcl.Ribbon;

type

{$IF NOT DEFINED(CLR)}
{$HPPEMIT ''}
{$HPPEMIT '/* automatically link to ribbonsilverstyleactnctrls.obj so that the property editors are registered */'}
{$HPPEMIT '#pragma link "Vcl.RibbonSilverStyleActnCtrls"'}
{$HPPEMIT ''}
{$ENDIF}

  TRibbonSilverStyleActionBars = class(TRibbonStyleActionBars)
  public
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetSkinClass: TCustomRibbonSkinClass; override;
    function GetStyleName: string; override;
  end;

  TRibbonSilverSkin = class(TCustomRibbonSkin)
  public
    function GetLoadTypeValue: string; override;
    function GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType; override;
  end;

var
  RibbonSilverStyle: TRibbonSilverStyleActionBars;

implementation

{$R RibbonSilverSkin.res}

uses
  Vcl.ActnMenus, System.SysUtils;

{ TRibbonSilverStyleActionBars }

function TRibbonSilverStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := TRibbonSilverColorMap;
end;

function TRibbonSilverStyleActionBars.GetSkinClass: TCustomRibbonSkinClass;
begin
  Result := TRibbonSilverSkin;
end;

function TRibbonSilverStyleActionBars.GetStyleName: string;
begin
  Result := 'Ribbon - Silver'; // do not localise
end;

{ TRibbonSilverSkin }

// The method of loading a skin.
//
// Override this method in your custom skin to allow the loading of a skin
// from a physical file on disk.
function TRibbonSilverSkin.GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType;
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
function TRibbonSilverSkin.GetLoadTypeValue: string;
begin
  case GetLoadType of
    ltResource: Result := 'RIBBON_SILVER';
    ltFile: Result := ExtractFilePath(ParamStr(0)) + 'silver.bmp';
  end;
end;

initialization
  RibbonSilverStyle := TRibbonSilverStyleActionBars.Create;
  RegisterActnBarStyle(RibbonSilverStyle);

finalization
  UnregisterActnBarStyle(RibbonSilverStyle);
  RibbonSilverStyle.Free;

end.
