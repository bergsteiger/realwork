{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonLunaStyleActnCtrls;

interface

uses
  Vcl.ActnMan, Vcl.RibbonStyleActnCtrls, Vcl.Ribbon;

type

{$IF NOT DEFINED(CLR)}
{$HPPEMIT ''}
{$HPPEMIT '/* automatically link to ribbonlunastyleactnctrls.obj so that the property editors are registered */'}
{$HPPEMIT '#pragma link "Vcl.RibbonLunaStyleActnCtrls"'}
{$HPPEMIT ''}
{$ENDIF}

  TRibbonLunaStyleActionBars = class(TRibbonStyleActionBars)
  public
    function GetColorMapClass(ActionBar: TCustomActionBar): TCustomColorMapClass; override;
    function GetSkinClass: TCustomRibbonSkinClass; override;
    function GetStyleName: string; override;
  end;

  TRibbonLunaSkin = class(TCustomRibbonSkin)
  public
    function GetLoadTypeValue: string; override;
    function GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType; override;
  end;

var
  RibbonLunaStyle: TRibbonLunaStyleActionBars;

implementation

{$R RibbonLunaSkin.res}

uses
  Vcl.ActnMenus, System.SysUtils;

{ TRibbonLunaStyleActionBars }

function TRibbonLunaStyleActionBars.GetColorMapClass(
  ActionBar: TCustomActionBar): TCustomColorMapClass;
begin
  Result := TRibbonLunaColorMap;
end;

function TRibbonLunaStyleActionBars.GetSkinClass: TCustomRibbonSkinClass;
begin
  Result := TRibbonLunaSkin;
end;

function TRibbonLunaStyleActionBars.GetStyleName: string;
begin
  Result := 'Ribbon - Luna'; // do not localise
end;

{ TRibbonLunaSkin }

// The method of loading a skin.
//
// Override this method in your custom skin to allow the loading of a skin
// from a physical file on disk.
function TRibbonLunaSkin.GetLoadType: TCustomRibbonSkin.TRibbonSkinLoadType;
begin
  if ActionBarDesigner <> nil then
    Exit(ltResource)
  else
    Result := ltResource//ltFile
end;

// The value specific to the selected load type for the Luna Skin
//
// When the load type is ltResource for a custom skin, GetLoadTypeValue should
// return the name of the resource.
// When the load type is ltFile, GetLoadTypeValue should return the name and
// location of the skin file to load.
function TRibbonLunaSkin.GetLoadTypeValue: string;
begin
  case GetLoadType of
    ltResource: Result := 'RIBBON_LUNA';
    ltFile: Result := ExtractFilePath(ParamStr(0)) + 'luna.bmp';
  end;
end;


initialization
  RibbonLunaStyle := TRibbonLunaStyleActionBars.Create;
  RegisterActnBarStyle(RibbonLunaStyle);

finalization
  UnregisterActnBarStyle(RibbonLunaStyle);
  RibbonLunaStyle.Free;

end.
