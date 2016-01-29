{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Controls.Mac;

interface

uses
  FMX.Types;

function GetSystemStyle: TFmxObject;
function GetSystemStyleHiRes: TFmxObject;

implementation

uses FMX.Styles, System.Types, System.Classes;

{$R *.res}

function GetSystemStyle: TFmxObject;
var
  ResName: string;
begin
  ResName := 'lionstyle';
  if FindResource(HInstance, PChar(ResName), RT_RCDATA) <> 0 then
    Result := TStyleManager.LoadFromResource(HInstance, ResName, RT_RCDATA)
  else
    Result := nil;
end;

function GetSystemStyleHiRes: TFmxObject;
var
  ResName: string;
begin
  ResName := 'lion2xstyle';
  if FindResource(HInstance, PChar(ResName), RT_RCDATA) <> 0 then
    Result := TStyleManager.LoadFromResource(HInstance, ResName, RT_RCDATA)
  else
    Result := nil;
end;

end.
