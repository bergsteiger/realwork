{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Controls.iOS;

interface

uses
  FMX.Types;

function GetSystemStyle: TFmxObject;
function GetSystemStyleHiRes: TFmxObject;

implementation

uses FMX.Styles, System.Types, System.Classes, System.SysUtils, Macapi.ObjectiveC, iOSapi.UIKit;

{$R *.res}

function GetModel: string;
begin
  Result := UTF8ToString(TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).model.UTF8String);
end;

function GetSystemStyle: TFmxObject;
var
  ResName: string;
begin
  if LowerCase(GetModel).Substring(0,4) = 'ipad' then
    ResName :='ipadstyle' // ipad
  else begin
    // other - iphone & ipod touch
    if not TOSVersion.Check(6, 0) then
      ResName := 'iphonestyle'
    else
     ResName := 'iphonestyle_6'
  end;
  if FindResource(HInstance, PChar(ResName), RT_RCDATA) <> 0 then
    Result := TStyleManager.LoadFromResource(HInstance, ResName, RT_RCDATA)
  else
    Result := nil;
end;

function GetSystemStyleHiRes: TFmxObject;
var
  ResName: string;
begin
  if LowerCase(GetModel).Substring(0,4) = 'ipad' then
    ResName := 'ipad2xstyle' // ipad
  else begin
    // other - iphone & ipod touch
    if not TOSVersion.Check(6, 0) then
      ResName := 'iphone2xstyle'
    else
      ResName := 'iphone2xstyle_6'
  end;
  if FindResource(HInstance, PChar(ResName), RT_RCDATA) <> 0 then
    Result := TStyleManager.LoadFromResource(HInstance, ResName, RT_RCDATA)
  else
    Result := nil;
end;

end.



